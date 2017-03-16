/turf/simulated/floor/plating/planet
	planetary_atmos = TRUE
	initial_gas_mix = /datum/gas_mixture/normal
	name = "sand"
	baseturf = /turf/simulated/floor/plating/planet
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	icon_plating = "asteroid"
	var/soil_type = /obj/item/weapon/ore/glass//sand
	var/icon_variations = 12 //not including 0
	var/dug = 0       //0 = has not yet been dug, 1 = has already been dug

/turf/simulated/floor/plating/planet/New()
	var/proper_name = name
	..()
	name = proper_name
	if(prob(20))
		icon_state = "asteroid[rand(0,icon_variations)]"

/turf/simulated/floor/plating/planet/burn_tile()
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
	return


/turf/simulated/floor/plating/planet/ullr
	initial_gas_mix = /datum/gas_mixture/ullr