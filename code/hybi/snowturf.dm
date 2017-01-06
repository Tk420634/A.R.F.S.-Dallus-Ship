
var/global/list/snowTurfEdgeCache
#define NORTH_EDGING	"north"
#define SOUTH_EDGING	"south"
#define EAST_EDGING		"east"
#define WEST_EDGING		"west"

/turf/simulated/floor/plating/snow
	name = "Snow"
	baseturf = /turf/simulated/floor/plating/snow
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	icon_plating = "asteroid"

/turf/simulated/floor/plating/snow/airless
	oxygen = 0.01
	nitrogen = 0.01
	temperature = TCMB

/turf/simulated/floor/plating/snow/New()
	var/proper_name = name
	..()
	name = proper_name
	if(prob(20))
		icon_state = "asteroid[rand(0,12)]"
	if(!snowTurfEdgeCache || !snowTurfEdgeCache.len)
		snowTurfEdgeCache = list()
		snowTurfEdgeCache.len = 4
		snowTurfEdgeCache[NORTH_EDGING] = image('icons/turf/mining.dmi', "rock_side_n", layer = 6)
		snowTurfEdgeCache[SOUTH_EDGING] = image('icons/turf/mining.dmi', "rock_side_s")
		snowTurfEdgeCache[EAST_EDGING] = image('icons/turf/mining.dmi', "rock_side_e", layer = 6)
		snowTurfEdgeCache[WEST_EDGING] = image('icons/turf/mining.dmi', "rock_side_w", layer = 6)
	spawn(1)
		var/turf/T
		if((istype(get_step(src, NORTH), /turf/space))) //to do: replace space with path.
			T = get_step(src, NORTH)
			if (T)
				T.overlays += snowTurfEdgeCache[SOUTH_EDGING]
		if((istype(get_step(src, SOUTH), /turf/space)))
			T = get_step(src, SOUTH)
			if (T)
				T.overlays += snowTurfEdgeCache[NORTH_EDGING]
		if((istype(get_step(src, EAST), /turf/space)))
			T = get_step(src, EAST)
			if (T)
				T.overlays += snowTurfEdgeCache[WEST_EDGING]
		if((istype(get_step(src, WEST), /turf/space)))
			T = get_step(src, WEST)
			if (T)
				T.overlays += snowTurfEdgeCache[EAST_EDGING]


/turf/simulated/floor/plating/snow/burn_tile()
	return

/turf/simulated/floor/plating/snow/ex_act()
	return
