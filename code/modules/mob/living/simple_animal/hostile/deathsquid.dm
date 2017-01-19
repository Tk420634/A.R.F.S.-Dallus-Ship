/mob/living/simple_animal/hostile/deathsquid
	name = "Death Squid"
	desc = "A evil creature from the depths of space. Approch with caution."
	icon_state = "deathsquid"
	icon_living = "deathsquid"
	icon_dead = "deathsquid_d"
	icon = 'icons/mob/alienqueen.dmi'
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat = 6)
	response_help = "pets"
	response_disarm = "pushes it away"
	response_harm = "hits"
	emote_taunt = list("clicks its beak")
	taunt_chance = 30
	speed = -1
	maxHealth = 400
	health = 400
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 25
	attacktext = "whips"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_emote = list("clicks")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	speed = 2
	aggro_vision_range = 9
	idle_vision_range = 5

	faction = list("mining")


