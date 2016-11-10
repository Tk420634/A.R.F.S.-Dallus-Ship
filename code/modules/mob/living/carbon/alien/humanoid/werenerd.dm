/mob/living/carbon/alien/humanoid/hunter/royale
	icon = 'icons/mob/werenerd.dmi' //Add your own ones too if you feel like. Likely gonna be me doing it for you anyway.
	desc = "WHY IS SHE SO BIG AND SCARY???" //examining gives nothing tho and that sucks
	status_flags = 0
	ventcrawler = 0 //pull over that ass too fat <- very yes
	unique_name = 0
	pixel_x = -16
	mob_size = MOB_SIZE_LARGE
	layer = 6
	pressure_resistance = 200 //Because big, stompy xe... puppies should not be blown around like paper.
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab/corgi = 5, /obj/item/clothing/glasses/science = 1, /obj/item/clothing/suit/toggle/labcoat = 1)

	var/alt_inhands_file = 'icons/mob/alienqueen.dmi'

/mob/living/carbon/alien/humanoid/hunter/royale/megaegg

	name = "Cameron Eggbert"
	desc = "WHY IS SHE SO BIG AND SCARY???" //I wish I could be big and scary
	caste = "egg"
	alt_icon = 'icons/mob/werenerdleap.dmi'
	maxHealth = 500
	health = 500
	icon_state = "alienegg" //Spook that Iska~
	faction = list("human")
	languages = 35
	dna = null
	gender = FEMALE
	has_fine_manipulation = 1
	verb_say = "ARFS"


/mob/living/carbon/alien/humanoid/hunter/royale/megaegg/New()

	create_dna(src)
	dna.initialize_dna()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/large/queen
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))

	..()

/mob/living/carbonalien/humanoid/hunter/royale/megaegg/getTrail()
	if(getBruteLoss() < 300)
		if(prob(50))
			return "ltrails_1"
		return "ltrails_2"
	else if(prob(50))
		return "trails_1"
	return "trails_2"

/mob/living/carbon/alien/humanoid/hunter/royale/megaegg/handle_hud_icons_health()
	if (src.healths)
		if (src.stat != 2)
			switch(health)
				if(500 to INFINITY)
					src.healths.icon_state = "health0"
				if(400 to 500)
					src.healths.icon_state = "health1"
				if(300 to 400)
					src.healths.icon_state = "health2"
				if(200 to 300)
					src.healths.icon_state = "health3"
				if(100 to 200)
					src.healths.icon_state = "health4"
				if(0 to 100)
					src.healths.icon_state = "health5"
				else
					src.healths.icon_state = "health6"
		else
			src.healths.icon_state = "health7"

/mob/living/carbon/alien/humanoid/hunter/royale/megaegg/movement_delay()
	. = ..()
	. += 5


//Queen verbs

/mob/living/carbon/alien/humanoid/hunter/royale/megaegg/attackby(atom/movable/A, mob/user) //I AM TERRIBLY BIASED SORRY imeanthismobcanbarfoncommandanywaysoitfineiguess
	if(istype(user, /mob/living/carbon/alien/humanoid/hunter/royale/megaegg))
		if(istype(A, /obj/item/weapon/grab))
			..()
		else
			src.visible_message("<span class='warning'>[src] dangles the [A] above her maw, soon dropping it in and swallowing it whole!</span>")
			playsound(src.loc, 'sound/magic/enter_blood.ogg', 30, 1)
			src.reagents.add_reagent("nutriment", 1)
			if(istype(A, /obj/item/weapon/disk/nuclear || /obj/item/weapon/reagent_containers/food/snacks || /obj/item/trash))
				unEquip(A)
				qdel(A)
				..()
			unEquip(A)
			A.layer = initial(A.layer)
			A.loc = src.loc
			contents.Add(A)
			src.stomach_contents.Add(A)
