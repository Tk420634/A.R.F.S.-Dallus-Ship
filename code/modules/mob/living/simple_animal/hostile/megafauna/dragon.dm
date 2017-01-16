/mob/living/simple_animal/hostile/megafauna/dragon
	name = "ash drake"
	desc = "Guardians of the necropolis."
	health = 2500
	maxHealth = 2500
	attacktext = "chomps"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	icon_state = "dragon"
	icon_living = "dragon"
	icon_dead = "dragon_dead"
	friendly = "stares down"
	icon = 'icons/mob/lavaland/dragon.dmi'
	faction = list("mining")
	speak_emote = list("roars")
	luminosity = 3
	armour_penetration = 40
	melee_damage_lower = 40
	melee_damage_upper = 40
	speed = 1
	move_to_delay = 10
	ranged = 1
	flying = 1
	mob_size = MOB_SIZE_LARGE
	pixel_x = -16
	aggro_vision_range = 18
	idle_vision_range = 5
	var/swooping = 0
	var/swoop_cooldown = 0

/mob/living/simple_animal/hostile/megafauna/dragon/New()
	..()
	internal = new/obj/item/device/gps/internal/dragon(src)

/mob/living/simple_animal/hostile/megafauna/dragon/Destroy()
	qdel(internal)
	. = ..()

/mob/living/simple_animal/hostile/megafauna/dragon/ex_act(severity, target)
	if(severity == 3)
		return
	..()


/mob/living/simple_animal/hostile/megafauna/dragon/AttackingTarget()
	if(swooping)
		return

/mob/living/simple_animal/hostile/megafauna/dragon/Process_Spacemove(movement_dir = 0)
	return 1

/obj/effect/overlay/temp/fireball
	icon = 'icons/obj/wizard.dmi'
	icon_state = "fireball"
	name = "fireball"
	desc = "Get out of the way!"
	layer = FLY_LAYER
	randomdir = 0
	duration = 12
	pixel_z = 500

/obj/effect/overlay/temp/fireball/New(loc)
	..()
	animate(src, pixel_z = 0, time = 12)

/obj/effect/overlay/temp/target
	icon = 'icons/mob/actions.dmi'
	icon_state = "sniper_zoom"
	luminosity = 2
	duration = 12

/obj/effect/overlay/temp/dragon_swoop
	name = "certain death"
	desc = "Don't just stand there, move!"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "landing"
	pixel_x = -32
	pixel_y = -32
	color = "#FF0000"
	duration = 10

/obj/effect/overlay/temp/target/ex_act()
	return

/obj/effect/overlay/temp/target/New(loc)
	..()
	addtimer(src, "fall", 0)

/obj/effect/overlay/temp/target/proc/fall()
	var/turf/T = get_turf(src)
	playsound(T,'sound/magic/Fireball.ogg', 200, 1)
	PoolOrNew(/obj/effect/overlay/temp/fireball,T)
	sleep(12)
	explosion(T, 0, 0, 1, 0, 0, 0, 1)

/mob/living/simple_animal/hostile/megafauna/dragon/OpenFire()
	anger_modifier = Clamp(((maxHealth - health)/50),0,20)
	ranged_cooldown = world.time + ranged_cooldown_time

	if(prob(15 + anger_modifier) && !client)
		if(health < maxHealth/2)
			swoop_attack(1)
		else
			fire_rain()

	else if(prob(10+anger_modifier) && !client && !swooping)
		if(health > maxHealth/2)
			swoop_attack()
		else
			swoop_attack()
			swoop_attack()
			swoop_attack()
	else
		fire_walls()

/mob/living/simple_animal/hostile/megafauna/dragon/proc/fire_rain()
	visible_message("<span class='boldwarning'>Fire rains from the sky!</span>")
	for(var/turf/turf in range(12,get_turf(src)))
		if(prob(10))
			PoolOrNew(/obj/effect/overlay/temp/target, turf)

/mob/living/simple_animal/hostile/megafauna/dragon/proc/fire_walls()
	var/list/attack_dirs = list(NORTH,EAST,SOUTH,WEST)
	if(prob(50))
		attack_dirs = list(NORTH,WEST,SOUTH,EAST)
	playsound(get_turf(src),'sound/magic/Fireball.ogg', 200, 1)

	for(var/d in attack_dirs)
		addtimer(src, "fire_wall", 0, FALSE, d)

/mob/living/simple_animal/hostile/megafauna/dragon/proc/fire_wall(d)
	var/turf/E = get_edge_target_turf(src, d)
		if(!range)
			break
		PoolOrNew(/obj/effect/hotspot,J)
		J.hotspot_expose(700,50,1)
		for(var/mob/living/L in J)
			if(L != src)
		L.adjustFireLoss(20)
		L << "<span class='userdanger'>You're hit by the drake's fire breath!</span>"
		sleep(1)

/mob/living/simple_animal/hostile/megafauna/dragon/proc/swoop_attack(fire_rain = 0, atom/movable/manual_target)
	if(stat || swooping)
		return
	swoop_cooldown = world.time + 200
	var/swoop_target
	if(manual_target)
		swoop_target = manual_target
	else
		swoop_target = target
	stop_automated_movement = TRUE
	swooping = 1
	density = 0
	icon_state = "swoop"
	visible_message("<span class='boldwarning'>[src] swoops up high!</span>")
	if(prob(50))
		animate(src, pixel_x = 500, pixel_z = 500, time = 10)
	else
		animate(src, pixel_x = -500, pixel_z = 500, time = 10)
	sleep(30)

	var/turf/tturf
	if(fire_rain)
		fire_rain()

	icon_state = "dragon"
	if(swoop_target && !qdeleted(swoop_target))
		tturf = get_turf(swoop_target)
	else
		tturf = get_turf(src)
	forceMove(tturf)
	PoolOrNew(/obj/effect/overlay/temp/dragon_swoop, tturf)
	animate(src, pixel_x = 0, pixel_z = 0, time = 10)
	sleep(10)
	playsound(src.loc, 'sound/effects/meteorimpact.ogg', 200, 1)
	for(var/mob/living/L in orange(1, src))
		if(L.stat)
			visible_message("<span class='warning'>[src] slams down on [L], crushing them!</span>")
			L.gib()
		else
			L.adjustBruteLoss(75)
			if(L && !qdeleted(L)) // Some mobs are deleted on death
				visible_message("<span class='warning'>[L] is thrown clear of [src]!</span>")

	for(var/mob/M in range(7, src))
		shake_camera(M, 15, 1)

	stop_automated_movement = FALSE
	swooping = 0
	density = 1

/mob/living/simple_animal/hostile/megafauna/dragon/AltClickOn(atom/movable/A)
	if(!istype(A))
		return
	if(swoop_cooldown >= world.time)
		src << "<span class='warning'>You need to wait 20 seconds between swoop attacks!M/span>"
		return
	swoop_attack(1, A)


/mob/living/simple_animal/hostile/megafauna/dragon/death()
	..(1)
	new /obj/effect/decal/cleanable/blood (get_turf(src))
	playsound(get_turf(src),'sound/magic/demon_dies.ogg', 200, 1)
	visible_message("<span class='danger'>[src] screams in anger as it collapses into a puddle of viscera, its most recent meals spilling out of it.</span>")
	ghostize()
	qdel(src)
	return

/obj/item/device/gps/internal/dragon
	icon_state = null
	gpstag = "Fiery Signal"
	desc = "Here there be dragons."
	invisibility = 100

/mob/living/simple_animal/hostile/megafauna/dragon/lesser
	name = "lesser ash drake"
	maxHealth = 300
	health = 300
	melee_damage_upper = 30
	melee_damage_lower = 30

