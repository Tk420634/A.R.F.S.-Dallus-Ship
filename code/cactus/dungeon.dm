/////////////////
//DUNGEON AREAS//
/////////////////
/area/dungeon
	name = "Dungeon"
	icon_state = "dungeon"
	always_unpowered = 1
	has_gravity = 1
	lightswitch = 0
	valid_territory = 0

/////////////////
//DUNGEON TURFS//
/////////////////

/turf/indestructible/dungeon
	name = "dungeon wall"
	desc = "A wall. It seems ancient."
	icon_state = ""
	canSmoothWith = list(/turf/indestructible/dungeon)
//	smooth = SMOOTH_TRUE
/*
/turf/indestructible/dungeon/New()
	..()
	if(smooth)
		smooth_icon(src)
*/
/turf/indestructible/dungeon/iron
	name = "iron dungeon wall"
	icon = 'icons/turf/walls/iron_wall.dmi'
	icon_state = "iron"
//	canSmoothWith = list(/turf/indestructible/dungeon/iron)
/turf/indestructible/dungeon/gold

/turf/indestructible/dungeon/silver

/turf/indestructible/dungeon/uranium

/turf/indestructible/dungeon/plasma

/turf/indestructible/dungeon/diamond

/turf/indestructible/bedrock
	name = "bedrock"
	desc = "This looks too tough to dig through."
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock"
