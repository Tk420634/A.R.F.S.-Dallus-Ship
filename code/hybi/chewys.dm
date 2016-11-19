
/obj/item/clothing/mask/chewy
	name = "chewing gum"
	desc = "A stick'o'gum."
	icon_state = "gum" // NEEDS SPRITES
	throw_speed = 0.5
	item_state = "gum"
	w_class = 1
	body_parts_covered = null
	var/chem_volume = 30
	reagents = null

/obj/item/clothing/mask/chewy/trippy/New()
	..()
	reagents.add_reagent("mushroomhallucinogen", 30)

/obj/item/clothing/mask/chewy/verb/chew(mob/user)
	set name = "Chew Gum"
	set category = "Object"
	icon_state = "gum_chewed" // NEEDS SPRITES
	item_state = "gum_chewed"
	handle_reagents()
	user.visible_message("<span class='notice'>[user] starts to chew some gum.</span>")
	// playsound(src.loc, 'sound.ogg', 50, 1) TO ADD IN CHEWING SOUNDS

/obj/item/clothing/mask/chewy/proc/handle_reagents(mob/user, /mob/living/carbon/)
	while(reagents.total_volume)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				if(prob(15)) // so it's not an instarape in case of acid
					var/fraction = min(REAGENTS_METABOLISM/reagents.total_volume, 1)
					reagents.reaction(C, INGEST, fraction)
				reagents.trans_to(C, REAGENTS_METABOLISM)
				return
		reagents.remove_any(REAGENTS_METABOLISM)
		if(reagents && reagents.total_volume)	//	check if it has any reagents at all
			handle_reagents()