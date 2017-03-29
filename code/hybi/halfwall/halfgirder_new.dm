#define HALF_GIRDER_NORMAL 0
#define HALF_GIRDER_REINF_STRUTS 1
#define HALF_GIRDER_REINF 2
#define HALF_GIRDER_DISPLACED 3
#define HALF_GIRDER_DISASSEMBLED 4
#define HALF_GIRDER_HALVED 5
#define HALF_GIRDER_DISPLACED 6

/obj/structure/halfgirder
	name = "half-girder"
	icon_state = "girder"
	icon = 'code/hybi/icons/halfwall.dmi'
	anchored = 1
	flags = ON_BORDER
	density = 1
	layer = 2
	var/state = HALF_GIRDER_NORMAL
	var/girderpasschance = 20 // percentage chance that a projectile passes through the girder.
	can_be_unanchored = 1

/obj/structure/halfgirder/displaced
	name = "displaced half-girder"
	icon_state = "displaced"
	anchored = 0
	state = HALF_GIRDER_DISPLACED
	girderpasschance = 25
	layer = 2.45

/obj/structure/halfgirder/reinforced
	name = "reinforced half-girder"
	icon_state = "reinforced"
	state = HALF_GIRDER_REINF
	girderpasschance = 0

/obj/structure/girder/reinforced/ex_act(severity, target)
	switch(severity)
		if(1)
			qdel(src)
		if(2)
			if (prob(30))
				var/remains = pick(/obj/item/stack/rods,/obj/item/stack/sheet/metal)
				new remains(loc)
				qdel(src)
		if(3)
			if (prob(5))
				var/remains = pick(/obj/item/stack/rods,/obj/item/stack/sheet/metal)
				new remains(loc)
				qdel(src)



// PART 1 DONE

/obj/structure/halfgirder/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover) && mover.checkpass(PASSGRILLE))
		return 1
	if(dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		mover << "Error with girder, please contact admin. Likely created because of mapping error."
		return 0
	if(get_dir(loc, target) == dir)
		return !density
	else
		return 1
	if(istype(mover, /obj/item/projectile))
		return prob(girderpasschance)
	else
		return 0

// PART 2 DONE

/obj/structure/halfgirder/CheckExit(atom/movable/O as mob|obj, target)
	if(istype(O) && O.checkpass(PASSGRILLE))
		return 1
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1

// PART 3, DONE

/obj/structure/halfgirder/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/weapon/screwdriver))
		if(state == HALF_GIRDER_DISPLACED)
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 100, 1)
			user.visible_message("<span class='warning'>[user] disassembles the girder.</span>", \
								"<span class='notice'>You start to disassemble the girder...</span>", "You hear clanking and banging noises.")
			if(do_after(user, 20, target = src))
				if(state != HALF_GIRDER_DISPLACED)
					return
				state = HALF_GIRDER_DISASSEMBLED
				user << "<span class='notice'>You disassemble the girder.</span>"
				var/obj/item/stack/sheet/metal/M = new (loc, 1)
				M.add_fingerprint(user)
				qdel(src)
// PART 4, DONE
		else if(state == HALF_GIRDER_REINF)
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 100, 1)
			user << "<span class='notice'>You start unsecuring support struts...</span>"
			if(do_after(user, 20, target = src))
				if(state != HALF_GIRDER_REINF)
					return
				user << "<span class='notice'>You unsecure the support struts.</span>"
				state = HALF_GIRDER_REINF_STRUTS
// PART 5, NOT DONE --------------------------------------------------------------------------------------

	else if(istype(W, /obj/item/weapon/wrench))
		if(state == HALF_GIRDER_DISPLACED)
			if(!istype(loc, /turf/simulated/floor)) // add rotation check heeere
				user << "<span class='warning'>A floor must be present to secure the girder!</span>"
				return
			if (istype(src.loc, /obj/structure/halfwall))
				var/obj/structure/halfwall/HW
				if (HW.dir == src.dir)
					return
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "<span class='notice'>You start securing the girder...</span>"
			if(do_after(user, 20, target = src))
				user << "<span class='notice'>You secure the girder.</span>"
				var/obj/structure/halfgirder/G = new (loc)
				transfer_fingerprints_to(G)
				qdel(src)
		else if(state == HALF_GIRDER_NORMAL)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "<span class='notice'>You start unsecuring the girder...</span>"
			if(do_after(user, 20, target = src))
				user << "<span class='notice'>You unsecure the girder.</span>"
				var/obj/structure/halfgirder/displaced/D = new (loc)
				transfer_fingerprints_to(D)
				qdel(src)

	else if(istype(W, /obj/item/weapon/gun/energy/plasmacutter))
		user << "<span class='notice'>You start slicing apart the girder...</span>"
		playsound(src, 'sound/items/Welder.ogg', 100, 1)
		if(do_after(user, 15, target = src))
			user << "<span class='notice'>You slice apart the girder.</span>"
			var/obj/item/stack/sheet/metal/M = new (loc, 1)
			M.add_fingerprint(user)
			qdel(src)

	else if(istype(W, /obj/item/weapon/pickaxe/drill/jackhammer))
		var/obj/item/weapon/pickaxe/drill/jackhammer/D = W
		user << "<span class='notice'>You smash through the girder!</span>"
		new /obj/item/stack/sheet/metal(get_turf(src))
		D.playDigSound()
		qdel(src)

	else if(istype(W, /obj/item/weapon/wirecutters) && state == HALF_GIRDER_REINF_STRUTS)
		playsound(src.loc, 'sound/items/Wirecutter.ogg', 100, 1)
		user << "<span class='notice'>You start removing support struts...</span>"
		if(do_after(user, 20, target = src))
			user << "<span class='notice'>You remove the support struts.</span>"
			new /obj/item/stack/sheet/plasteel(get_turf(src))
			var/obj/structure/halfgirder/G = new (loc)
			transfer_fingerprints_to(G)
			qdel(src)


	else if(istype(W, /obj/item/stack))
		if (istype(src.loc, /obj/structure/halfwall))
			var/obj/structure/halfwall/HW
			if (HW.dir == src.dir)
				user << "<span class='warning'>There is already a wall present!</span>"
				return
/*		if (istype(src.loc, /obj/structure/falsehalfwall))
			var/obj/structure/falsehalfwall/FHW
			if (FHW.dir == src.dir)
				user << "<span class='warning'>There is already a false wall present!</span>"
				return*/
		if (istype(src.loc, /turf/simulated/wall))
			user << "<span class='warning'>There is already a wall present!</span>"
			return
		if (!istype(src.loc, /turf/simulated/floor))
			user << "<span class='warning'>A floor must be present to build a false wall!</span>"
			return
		if (locate(/obj/structure/falsewall) in src.loc.contents)
			user << "<span class='warning'>There is already a false wall present!</span>"
			return

		if(!istype(W,/obj/item/stack/sheet))
			return

		var/obj/item/stack/sheet/S = W
		switch(S.type)
// NORM - FIN
			if(/obj/item/stack/sheet/metal, /obj/item/stack/sheet/metal/cyborg)
			/*	if(state == HALF_GIRDER_DISPLACED) // HALF WALL
					if(S.get_amount() < 2)
						user << "<span class='warning'>You need two sheets of metal to create a false wall!</span>"
						return
					user << "<span class='notice'>You start building a false wall...</span>"
					if(do_after(user, 20, target = src))
						if(!src.loc || !S || S.get_amount() < 2)
							return
						S.use(2)
						user << "<span class='notice'>You create a false wall. Push on it to open or close the passage.</span>"
						var/obj/structure/falsehalfwall/FHW = new (loc)
						transfer_fingerprints_to(FHW)
						F.dir = src.dir
						qdel(src)
				else*/
				if(S.get_amount() < 2)
					user << "<span class='warning'>You need two sheets of metal to finish a wall!</span>"
					return
				user << "<span class='notice'>You start adding plating...</span>"
				if (do_after(user, 40, target = src))
					if(loc == null || S.get_amount() < 2)
						return
					S.use(2)
					user << "<span class='notice'>You add the plating.</span>"
					var/obj/structure/halfwall/T = new (loc)
					T.dir = src.dir
					transfer_fingerprints_to(T)
					qdel(src)
					return
// REIN
			if(/obj/item/stack/sheet/plasteel)
				/*if(state == HALF_GIRDER_DISPLACED)
					if(S.amount < 2)
						user << "<span class='warning'>You need at least two sheets to create a false wall!</span>"
						return
					user << "<span class='notice'>You start building a reinforced false wall...</span>"
					if(do_after(user, 20, target = src))
						if(!src.loc || !S || S.amount < 2)
							return
						S.use(2)
						user << "<span class='notice'>You create a reinforced false wall. Push on it to open or close the passage.</span>"
						var/obj/structure/falsehalfwall/reinforced/RFHF = new (loc)
						RFHF.dir = src.dir
						transfer_fingerprints_to(RFHF)
						qdel(src)
				else*/
				if(state == HALF_GIRDER_REINF)
					if(S.amount < 1)
						return
					user << "<span class='notice'>You start finalizing the reinforced wall...</span>"
					if(do_after(user, 25, target = src))
						if(!src.loc || !S || S.amount < 1)
							return
						S.use(1)
						user << "<span class='notice'>You fully reinforce the wall.</span>"
						var/obj/structure/halfwall/reinforced/RHF = new (loc)
						RHF.dir = src.dir
						transfer_fingerprints_to(RHF)
						qdel(src)
						return
					else
						if(S.amount < 1)
							return
						user << "<span class='notice'>You start reinforcing the girder...</span>"
						if (do_after(user, 30, target = src))
							if(!src.loc || !S || S.amount < 1)
								return
							S.use(1)
							user << "<span class='notice'>You reinforce the girder.</span>"
							var/obj/structure/halfgirder/reinforced/R = new (loc)
							transfer_fingerprints_to(R)
							qdel(src)
						return
	else
		..()
