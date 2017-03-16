// My attempt at a half wall - Jonathan
// Copy pasta'd window procs cause I'm lazy.

/obj/structure/halfwall
	name = "halfwall"
	desc = "A halfwall."
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

/obj/structure/halfwall/New()
	air_update_turf(1)
	return

/obj/structure/halfwall/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover) && mover.checkpass(PASSGLASS))
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

