// My attempt at a half wall - Jonathan
// Copy pasta'd window procs cause I'm lazy.

/obj/structure/halfwall
	name = "halfwall"
	desc = "A halfwall."
	icon = 'code/hybi/icons/halfwall.dmi'
	icon_state = "halfwall"
	density = 1
	layer = 3.2//Just above doors
	pressure_resistance = 4*ONE_ATMOSPHERE
	anchored = 1
	flags = ON_BORDER
	var/maxhealth = 25
	var/health = 0
	var/ini_dir = null
	var/state = 0
	var/reinf = 0
	var/disassembled = 0
	var/list/storeditems = list() // insert girder
	var/silicate = 5 // number of units of silicate
	can_be_unanchored = 1


/obj/structure/halfwall/reinforced
	name = "reinforced halfwall"
	desc = "A reinforced halfwall."
	icon = 'code/hybi/icons/halfwall.dmi'
	icon_state = "rein_halfwall"

/obj/structure/halfwall/New()
	air_update_turf(1)
	ini_dir = dir
	return

/obj/structure/halfwall/attackby(obj/item/weapon/W, mob/user, params)
	user.setClickCooldown(10)
	if(!istype(user.loc, /turf))	return	//can't do this stuff whilst inside objects and such
	if (!user.IsAdvancedToolUser())
		user << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return
	if(W)
		try_decon(W, user)
	add_fingerprint(user)
	return



/obj/structure/halfwall/proc/dismantle_wall(var/devastated = 0)
	if(devastated)
		playsound(src, 'sound/items/Welder.ogg', 100, 1)
		var/obj/item/stack/sheet/metal/M = new (loc)
		M.amount = 1
	else
		playsound(src, 'sound/items/Screwdriver.ogg', 100, 1)
		var/obj/item/stack/sheet/metal/M = new (loc)
		M.amount = 1
		var/obj/structure/halfgirder/G = new (loc)
		G.dir = dir
		transfer_fingerprints_to(G)
		qdel()

/obj/structure/halfwall/proc/devastate_wall()
	var/obj/item/stack/sheet/metal/M
	M.amount = 1
	M.loc = src
	qdel(src)
	return

/obj/structure/halfwall/proc/break_wall()
	var/obj/item/stack/sheet/metal/M
	M.amount = 1
	M.loc = src
	var/obj/structure/halfgirder/G = new (loc)
	G.dir = dir
	transfer_fingerprints_to(G)
	qdel(src)

/obj/structure/halfwall/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover) && checkpass(PASSGLASS))
		return 1
	if(dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		mover << "Error with wall, please contact admin. Likely created because of mapping error."
		return 0
	if(get_dir(loc, target) == dir)
		return !density
	else
		return 1


/obj/structure/halfwall/CheckExit(atom/movable/O as mob|obj, target)
	if(istype(O) && O.checkpass(PASSGLASS))
		return 1
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1

/obj/structure/halfwall/proc/can_be_reached(mob/user)
	if(get_dir(user,src) & dir)
		for(var/obj/O in loc)
			if(!O.CanPass(user, user.loc, 1))
				return 0
	return 1


/obj/structure/halfwall/CanAtmosPass(turf/T)
	if(get_dir(loc, T) == dir)
		return !density
	if(dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		return !density
	return 1

// NORMAL WALL DECONSTRUCTION

/obj/structure/halfwall/proc/try_decon(obj/item/weapon/W, mob/user, turf/T)
	if(istype(W, /obj/item/weapon/screwdriver))
		user << "<span class='notice'>You begin unscrewing the outer plating...</span>"
		playsound(src, 'sound/items/Screwdriver.ogg', 100, 1)
		if(do_after(user, 15, target = src))
			if(!user || !W)
				return 1
			if( user.loc == T && user.get_active_hand() == W )
				user << "<span class='notice'>You remove the outer plating.</span>"
				var/obj/item/stack/sheet/metal/M = new (loc)
				M.amount = 1
				var/obj/structure/halfgirder/G = new (loc)
				G.dir = dir
				transfer_fingerprints_to(G)
				qdel()
				return 1
	else if( istype(W, /obj/item/weapon/gun/energy/plasmacutter) )
		user << "<span class='notice'>You begin cutting through the outer plating...</span>"
		playsound(src, 'sound/items/Welder.ogg', 100, 1)
		if(do_after(user, 7, target = src))  // plasma cutter is faster than welding tool
			if(!user || !W || !T )
				return 1
			if( user.loc == T && user.get_active_hand() == W )
				user << "<span class='notice'>You slice through the outer plating, destroying the girder along with it!</span>"
				playsound(src, 'sound/items/Welder.ogg', 100, 1)
				var/obj/item/stack/sheet/metal/M = new (loc)
				M.amount = 1
				qdel()
				visible_message("The wall was sliced apart by [user]!", "<span class='italics'>You hear metal being sliced apart.</span>")
				return 1
	return 0

// REINFORCED WALL DECONSTRUCTION


/obj/structure/halfwall/reinforced/try_decon(obj/item/weapon/W, mob/user, turf/T)
	if( istype(W, /obj/item/weapon/weldingtool) )
		var/obj/item/weapon/weldingtool/WT = W
		if( WT.remove_fuel(0,user) )
			user << "<span class='notice'>You begin slicing through the outer plating...</span>"
			playsound(src, 'sound/items/Welder.ogg', 100, 1)
			if(do_after(user, 20, target = src))
				if(!user || !WT || !WT.isOn() || !T )
					return 1
				if( user.loc == T && user.get_active_hand() == WT )
					user << "<span class='notice'>You remove the outer plating.</span>"
					var/obj/item/stack/sheet/plasteel/M = new (loc)
					M.amount = 1
					var/obj/structure/halfgirder/reinforced/G = new (loc)
					G.dir = dir
					transfer_fingerprints_to(G)
					qdel()
					return 1
	else if( istype(W, /obj/item/weapon/gun/energy/plasmacutter) )
		user << "<span class='notice'>You begin slicing through the outer plating...</span>"
		playsound(src, 'sound/items/Welder.ogg', 100, 1)
		if(do_after(user, 12.5, target = src))  // plasma cutter is faster than welding tool
			if(!user || !W || !T )
				return 1
			if( user.loc == T && user.get_active_hand() == W )
				playsound(src, 'sound/items/Welder.ogg', 100, 1)
				user << "<span class='notice'>You remove the outer plating.</span>"
				var/obj/structure/halfgirder/reinforced/G = new (loc)
				G.dir = dir
				transfer_fingerprints_to(G)
				visible_message("The wall was sliced apart by [user]!", "<span class='italics'>You hear metal being sliced apart.</span>")
				qdel()
				return 1
	return 0

/turf/simulated/wall/ex_act(severity, target)
	if(target == src)
		dismantle_wall(1,1)
		return
	switch(severity)
		if(1)
			return
		if(2)
			if (prob(50))
				dismantle_wall(0,1)
			else
				dismantle_wall(1,1)
		if(3)
			if (prob(hardness))
				dismantle_wall(0,1)
			else
	if(!density)
		..()
	return

// False wall!
/*
/obj/structure/halfwall/false/

/obj/structure/halfwall/false/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return 1
	if(dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		mover << "Error with wall, please contact admin. Likely created because of mapping error."
		return 0
	if(get_dir(loc, target) == dir)
		if(!open)
			return(!density)
	else
		return 1
*/
