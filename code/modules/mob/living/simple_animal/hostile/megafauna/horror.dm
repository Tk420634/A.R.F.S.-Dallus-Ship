/mob/living/simple_animal/hostile/megafauna/horror
	name = "Horror Ghost"
	desc = "Oh no, that guy again.."
	health = 1000
	maxHealth = 1000
	attacktext = "tears the soul out of"
	attack_sound = 'sound/magic/horror.ogg'
	icon_state = "horror"
	icon_living = "horror"
	icon_dead = "horror_dead"
	friendly = "stares down"
	icon = 'icons/mob/lavaland/96x96megafauna.dmi'
	faction = list("mining")
	speak_emote = list("roars")
	luminosity = 20
	armour_penetration = 40
	melee_damage_lower = 400
	melee_damage_upper = 400
	speed = 30
	move_to_delay = 10
	ranged = 1
	flying = 1
	mob_size = MOB_SIZE_LARGE
	pixel_x = -32
	aggro_vision_range = 30
	idle_vision_range = 20
	incorporeal_move = 1



	var/anger_modifier = 0
	var/obj/item/device/gps/internal


/obj/item/device/gps/internal/horror
	icon_state = null
	gpstag = "Angelic Signal"
	desc = "Get in the fucking robot."
	invisibility = 100


