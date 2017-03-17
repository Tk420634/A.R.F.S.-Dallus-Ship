/turf/simulated/floor/plating/planet
	planetary_atmos = TRUE
	initial_gas_mix = /datum/gas_mixture/normal
	name = "\proper sand"
	baseturf = /turf/simulated/floor/plating/planet
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	icon_plating = "asteroid"
	var/soil_type = /obj/item/weapon/ore/glass//sand
	var/icon_variations = 12 //not including 0
	var/dug = 0
	luminosity = 2

/turf/simulated/floor/plating/planet/New()
	var/proper_name = name
	..()
	name = proper_name
	if(prob(20) && icon_variations)
		icon_state = "[icon_state][rand(0,icon_variations)]"

/turf/simulated/floor/plating/planet/burn_tile()
	return

/turf/simulated/floor/plating/planet/ex_act(severity, target)
	return

/turf/simulated/floor/plating/planet/singularity_act()
	return

/turf/simulated/floor/plating/planet/singularity_pull(S, current_size)
	return

/turf/simulated/floor/plating/planet/proc/gets_dug()
	if(dug)
		return
	if(istype(soil_type, /obj/item))
		new soil_type(src)
		new soil_type(src)
		new soil_type(src)
		new soil_type(src)
		new soil_type(src)
	dug = 1
	icon_plating = "[icon_state]_dug"
	icon_state = "[icon_state]_dug"


/turf/simulated/floor/plating/planet/ullr
	name = "\proper snow"
	baseturf = /turf/simulated/floor/plating/planet/ullr
	icon = 'code/hybi/icons/snow.dmi'
	icon_state = "snow"
	icon_plating = "snow"
	initial_gas_mix = /datum/gas_mixture/ullr

/turf/simulated/floor/plating/planet/ullr_gravel
	name = "\proper gravel"
	baseturf = /turf/simulated/floor/plating/planet/ullr_gravel
	icon = 'code/hybi/icons/snow.dmi'
	icon_state = "gravsnow"
	icon_plating = "gravsnow"
	icon_variations = 0

/turf/simulated/floor/plating/planet/ullr/New()
	..()
	apply_edge_overlays()

/turf/simulated/floor/plating/planet/ullr/proc/apply_edge_overlays()
	if(!snowTurfEdgeCache || !snowTurfEdgeCache.len)
		snowTurfEdgeCache = list()
		snowTurfEdgeCache.len = 4
		snowTurfEdgeCache[NORTH_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_n")
		snowTurfEdgeCache[SOUTH_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_s")
		snowTurfEdgeCache[EAST_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_e")
		snowTurfEdgeCache[WEST_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_w")
	spawn(1)
		var/turf/T
		if((istype(get_step(src, NORTH), /turf/simulated/floor/plating/planet/ullr_gravel))) //to do: replace space with path.
			T = get_step(src, NORTH)
			if (T)
				T.overlays += snowTurfEdgeCache[SOUTH_EDGING]
		if((istype(get_step(src, SOUTH), /turf/simulated/floor/plating/planet/ullr_gravel)))
			T = get_step(src, SOUTH)
			if (T)
				T.overlays += snowTurfEdgeCache[NORTH_EDGING]
		if((istype(get_step(src, EAST), /turf/simulated/floor/plating/planet/ullr_gravel)))
			T = get_step(src, EAST)
			if (T)
				T.overlays += snowTurfEdgeCache[WEST_EDGING]
		if((istype(get_step(src, WEST), /turf/simulated/floor/plating/planet/ullr_gravel)))
			T = get_step(src, WEST)
			if (T)
				T.overlays += snowTurfEdgeCache[EAST_EDGING]

/turf/simulated/floor/plating/planet/ullr/ex_act(severity, target)
	contents_explosion(severity, target)
	switch(severity)
		if(3)
			return
		if(2)
			if(prob(33))
				ChangeTurf(src,/turf/simulated/floor/plating/planet/ullr_gravel)
		if(1)
			ChangeTurf(src,/turf/simulated/floor/plating/planet/ullr_gravel)
	return

/turf/simulated/floor/plating/planet/ullr_gravel/ex_act()
	return

//Ullr Walls

/turf/simulated/wall/ullr
	baseturf = /turf/simulated/floor/plating/planet/ullr

/turf/simulated/wall/r_wall/ullr
	baseturf = /turf/simulated/floor/plating/planet/ullr

/turf/simulated/wall/mineral/wood/ullr
	baseturf = /turf/simulated/floor/plating/planet/ullr