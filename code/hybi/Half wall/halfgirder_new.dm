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

/obj/structure/halfgirder/CheckExit(atom/movable/O as mob|obj, target)
	if(istype(O) && O.checkpass(PASSGRILLE))
		return 1
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1