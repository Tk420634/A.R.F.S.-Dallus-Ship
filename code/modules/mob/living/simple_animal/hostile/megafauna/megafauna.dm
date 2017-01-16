#define MEDAL_PREFIX "Boss"


/mob/living/simple_animal/hostile/megafauna
	name = "boss of this gym"
	desc = "Attack the weak point for massive damage."
	health = 1000
	maxHealth = 1000
	a_intent = "harm"
	environment_smash = 3
	obj_damage = 400
	luminosity = 3
	faction = list("mining", "boss")
	weather_immunities = list("lava","ash")
	movement_type = FLYING
	robust_searching = 1
	ranged_ignores_vision = TRUE
	stat_attack = 2
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	damage_coeff = list(BRUTE = 1, BURN = 0.5, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1)
	minbodytemp = 0
	maxbodytemp = INFINITY
	aggro_vision_range = 18
	idle_vision_range = 5
	environment_target_typecache = list(
	/obj/machinery/door/window,
	/obj/structure/window,
	/obj/structure/closet,
	/obj/structure/table,
	/obj/structure/grille,
	/obj/structure/girder,
	/obj/structure/rack,
	/obj/structure/barricade,
	/obj/machinery/field,
	/obj/machinery/power/emitter)
	anchored = TRUE
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //Looks weird with them slipping under mineral walls and cameras and shit otherwise
	mouse_opacity = 2 // Easier to click on in melee, they're giant targets anyway
	var/obj/item/device/gps/internal

/mob/living/simple_animal/hostile/megafauna/Destroy()
	qdel(internal)
	. = ..()

/mob/living/simple_animal/hostile/megafauna/death(gibbed)
	if(health > 0)
		return
		..()

/mob/living/simple_animal/hostile/megafauna/gib()
	if(health > 0)
		return
	else
		..()

/mob/living/simple_animal/hostile/megafauna/dust()
	if(health > 0)
		return
	else
		..()

/mob/living/simple_animal/hostile/megafauna/AttackingTarget()
	..()
	if(isliving(target))
		var/mob/living/L = target
		if(L.stat != DEAD)
			if(!client && ranged && ranged_cooldown <= world.time)
				OpenFire()
		else
			devour(L)

/mob/living/simple_animal/hostile/megafauna/onShuttleMove()
	var/turf/oldloc = loc
	. = ..()
	if(!.)
		return
	var/turf/newloc = loc
	message_admins("Megafauna [src] \
		(<A HREF='?_src_=holder;adminplayerobservefollow=\ref[src]'>FLW</A>) \
		moved via shuttle from ([oldloc.x],[oldloc.y],[oldloc.z]) to \
		([newloc.x],[newloc.y],[newloc.z])")

/mob/living/simple_animal/hostile/megafauna/proc/devour(mob/living/L)
	if(!L)
		return
	visible_message(
		"<span class='danger'>[src] devours [L]!</span>",
		"<span class='userdanger'>You feast on [L], restoring your health!</span>")
	adjustBruteLoss(-L.maxHealth/2)
	L.gib()

/mob/living/simple_animal/hostile/megafauna/ex_act(severity, target)
	switch (severity)
		if (1)
			adjustBruteLoss(250)

		if (2)
			adjustBruteLoss(100)

		if(3)
			adjustBruteLoss(50)

