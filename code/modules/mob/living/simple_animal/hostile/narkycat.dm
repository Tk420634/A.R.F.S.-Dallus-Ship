/mob/living/simple_animal/hostile/narky
	name = "Narwal Cat Man"
	desc = "OH GOD RUN!"
	icon_state = "narky"
	icon_living = "narky"
	icon_dead = "narky_d"
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/candy/candybar/toffee = 3, /obj/effect/decal/cleanable/sex/semen = 1)
	response_help = "pets"
	response_disarm = "pushes it away"
	response_harm = "hits"
	emote_taunt = list("waggles its dicks")
	taunt_chance = 30
	speed = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 10
	melee_damage_lower = 5
	melee_damage_upper = 10
	attacktext = "nipple whacks"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_emote = list("nYaRs")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	speed = 2
	aggro_vision_range = 9
	idle_vision_range = 5

	faction = list("mining")


