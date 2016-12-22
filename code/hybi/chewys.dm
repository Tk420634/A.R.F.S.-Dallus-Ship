// TO DO:
// MAKE SPRITES FOR THIS STUFF
// MAKE DIFFERENT VARIETIES W/ DIFFERENT COLORS
// APHRO GUM
// DRUG GUM
// COOL GUM
// FUCK EVERYTHING GUM
// FLIP GUM

/obj/item/clothing/mask/chewies
	name = "chewing gum"
	desc = "A stick of gum! Now you can be super obnoxious!"
	icon_state = "chewon" // THIS ICON IS LOCATED IN icons\obj\clothing\masks\masks.dmi IF YOU WANT TO EDIT IT
	throw_speed = 0.5
	item_state = "chewoff" // THIS ICON IS LOCATED IN icons\mob\mask.dmi AND masks.dmi IF YOU WANT TO EDIT IT
	w_class = 1
	body_parts_covered = null
	var/chewing = 0
	var/icon_on = "chewon"  //Note - these are in masks.dmi not in cigarette.dmi
	var/icon_off = "chewoff"
	var/finishedgum = /obj/item/clothing/mask/finishedgum
	var/lastHolder = null
	var/chewtime = 300
	var/chem_volume = 30

/obj/item/clothing/mask/finishedgum
	name = "used chewing gum"
	desc = "Eeeewww it's all chewed on. There's no way you're going to chew it!"

/obj/item/clothing/mask/chewies/verb/chewgum()
	set category = "Object"
	set name = "Chew Gum"
	chew(usr)
	throw_speed = 0.5
	icon_state = "usedgum"
	item_state = "chewon"
	w_class = 1
	body_parts_covered = null

/obj/item/clothing/mask/chewies/New()
	..()
	flags |= NOREACT // so it doesn't react until you light it
	create_reagents(chem_volume) // making the cigarette a chemical holder with a maximum volume of 15
	reagents.add_reagent("nicotine", 15)


/obj/item/clothing/mask/chewies/proc/chew(mob/user)
	if(user.incapacitated())
		return
	flags &= ~NOREACT // allowing reagents to react after being lit
	reagents.handle_reactions()
	icon_state = icon_on
	item_state = icon_on
	SSobj.processing |= src
	usr.visible_message("[usr] [pick("starts to obnoxiously chew the [src]","begins to chew the [src]","chews the [src]")]")



/obj/item/clothing/mask/chewies/proc/handle_reagents()
	if(reagents.total_volume)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				if(prob(15)) // so it's not an instarape in case of acid
					var/fraction = min(REAGENTS_METABOLISM/reagents.total_volume, 1)
					reagents.reaction(C, INGEST, fraction)
				reagents.trans_to(C, REAGENTS_METABOLISM)
				return
		reagents.remove_any(REAGENTS_METABOLISM)


/obj/item/clothing/mask/chewies/process()
	var/turf/location = get_turf(src)
	var/mob/living/M = loc
	chewtime--
	if(chewtime < 1)
		new finishedgum(location)
		SSobj.processing.Remove(src)
		if(ismob(loc))
			M << "<span class='notice'>Your [name] becomes flavorless, there's no point chewing it anymore.</span>"
			M.unEquip(src, 1)	//un-equip it so the overlays can update //Force the un-equip so the overlays update
		qdel(src)
		return
	if(reagents && reagents.total_volume)	//	check if it has any reagents at all
		handle_reagents()
	return


/obj/item/clothing/mask/chewies/attack_self(mob/user)
	if(chewing == 1)
		user.visible_message("<span class='notice'>[user] squishes \the [src] and puts it onto the floor.</span>")
		new finishedgum(user.loc)
		SSobj.processing.Remove(src)
		qdel(src)
	return ..()