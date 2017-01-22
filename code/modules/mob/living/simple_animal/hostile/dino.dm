/mob/living/simple_animal/hostile/dino
	name = "dinosaur"
	desc = "Some sort of Dinosaur."
	icon_state = "dino"
	icon_living = "dino"
	icon_dead = "dino-dead"
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat = 4, /obj/item/stack/sheet/animalhide/lizard = 2)
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	emote_taunt = list("flicks its tail")
	taunt_chance = 30
	speed = 0
	maxHealth = 30
	health = 30
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_emote = list("growls")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500

	faction = list("dino")
	flying = 1
	gold_core_spawnable = 1

/mob/living/simple_animal/hostile/dino/Process_Spacemove(movement_dir = 0)
	return 1

/mob/living/simple_animal/hostile/resomi
	name = "resomi"
	desc = "A mistake"
	icon_state = "resomi"
	icon_living = "resomi"
	icon_dead = "resomi_d"
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat = 4, /obj/item/stack/sheet/animalhide/lizard = 2)
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	emote_taunt = list("glares at")
	taunt_chance = 30
	speed = 0
	maxHealth = 30
	health = 30
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "makes a mistake out of"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_emote = list("growls")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
/mob/living/simple_animal/hostile/dino/Process_Spacemove(movement_dir = 0)
	return 1

