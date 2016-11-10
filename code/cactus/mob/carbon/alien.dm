/mob/living/carbon/alien/proc/deathNotice()
	src.deathNotified = 1
	if (src.z != 2) //so admins can fuck around in the thunderdome
		var/mob/living/carbon/alien/A
		for(A in world)
			A << "<span class='userdanger'>[src.name] has died at [src.loc.loc.name]! </span>"

/obj/machinery/door/airlock/attack_alien(mob/user) //PRYING OPEN AIRLOCKS AS AN ALIEN
	user.changeNext_move(CLICK_CD_MELEE)
	if(isalienadult(user))

		if(secondsElectrified != 0 && src.shock(user, 100))
			return
		if(locked && welded)
			user << text("<span class='notice'>The airlock is bolted and welded, no way you're getting through that!</span>")
			return
		else if(locked)
			user << text("<span class='notice'>The airlock is bolted, it won't budge!</span>")
			return
		else if(welded)
			user << text("<span class='notice'>The airlock is welded, you can't get a good grip!</span>")
			return
		else if(!locked && !welded && density && !operating)
			visible_message(
				"<span class='notice'>[user] begins prying open [src].</span>", \
				"<span class='notice'>You begin prying open [src].</span>", \
				"<span class='italics'>You hear prying...</span>")
			playsound(src, 'sound/machines/airlockforced_alien.ogg', 100, 1)
			if(do_after(user, 40,5,1, target = src))
				if(!locked && !welded && density && in_range(src, user) && user.stat < 1)
					open(2)
		return

	return

/obj/machinery/door/firedoor/attack_alien(mob/user) //PRYING OPEN FIREDOORS
	user.changeNext_move(CLICK_CD_MELEE)
	if(isalienadult(user))
		if(!blocked && density)
			visible_message(
				"<span class='notice'>[user] begins prying open [src].</span>", \
				"<span class='notice'>You begin prying open [src].</span>", \
				"<span class='italics'>You hear prying...</span>")
			playsound(src, 'sound/machines/airlockforced_alien.ogg', 100, 1)
			if(do_after(user, 40,5,1, target = src))
				if(!blocked)
					open(2)
	return

/obj/machinery/door/poddoor/shutters/attack_alien(mob/user) // PRYING OPEN SHUTTERS
	user.changeNext_move(CLICK_CD_MELEE)
	if(isalienadult(user))
		if(density)
			visible_message(
				"<span class='notice'>[user] begins prying open [src].</span>", \
				"<span class='notice'>You begin prying open [src].</span>", \
				"<span class='italics'>You hear prying...</span>")
			playsound(src, 'sound/machines/airlockforced_alien.ogg', 100, 1)
			if(do_after(user, 40,5,1, target = src))
				if(density)
					open(2)
	return

/turf/simulated/wall/attack_alien(mob/user) //FLUFF
	if(isalienadult(user))
		user.do_attack_animation(src)
		visible_message("<span class='notice'>[user] smashes against [src]!</span>")
		playsound(src, pick('sound/alien/Effects/bang1.ogg', 'sound/alien/Effects/bang2.ogg', 'sound/alien/Effects/bang3.ogg', 'sound/alien/Effects/bang4.ogg', 'sound/alien/Effects/bang5.ogg', 'sound/alien/Effects/bang6.ogg', 'sound/alien/Effects/bang7.ogg', 'sound/alien/Effects/bang8.ogg'), 100, 0, 0)
		user.changeNext_move(CLICK_CD_MELEE)
		return
	else
		return

/obj/structure/falsewall/attack_alien(mob/user) //FLUFF
	if(isalienadult(user))
		user.do_attack_animation(src)
		visible_message("<span class='notice'>[user] smashes against [src]!</span>")
		playsound(src, pick('sound/alien/Effects/bang1.ogg', 'sound/alien/Effects/bang2.ogg', 'sound/alien/Effects/bang3.ogg', 'sound/alien/Effects/bang4.ogg', 'sound/alien/Effects/bang5.ogg', 'sound/alien/Effects/bang6.ogg', 'sound/alien/Effects/bang7.ogg', 'sound/alien/Effects/bang8.ogg'), 100, 0, 0)
		user.changeNext_move(CLICK_CD_MELEE)
		return
	else
		return

/obj/structure/girder/attack_alien(mob/user) //FLUFF
	if(isalienadult(user))
		user.do_attack_animation(src)
		visible_message("<span class='notice'>[user] smashes against [src]!</span>")
		playsound(src, pick('sound/alien/Effects/bang1.ogg', 'sound/alien/Effects/bang2.ogg', 'sound/alien/Effects/bang3.ogg', 'sound/alien/Effects/bang4.ogg', 'sound/alien/Effects/bang5.ogg', 'sound/alien/Effects/bang6.ogg', 'sound/alien/Effects/bang7.ogg', 'sound/alien/Effects/bang8.ogg'), 100, 0, 0)
		user.changeNext_move(CLICK_CD_MELEE)
		return
	else
		return
/*
/obj/structure/closet/attack_alien(mob/user)
	if(isalienadult(user))
		playsound(src, pick('sound/alien/Effects/bang1.ogg', 'sound/alien/Effects/bang2.ogg', 'sound/alien/Effects/bang3.ogg', 'sound/alien/Effects/bang4.ogg', 'sound/alien/Effects/bang5.ogg', 'sound/alien/Effects/bang6.ogg', 'sound/alien/Effects/bang7.ogg', 'sound/alien/Effects/bang8.ogg'), 100, 0, 0)
		health -= 15
		user.do_attack_animation(src)
		user.changeNext_move(CLICK_CD_MELEE)
		if(health <= 0)
			visible_message("<span class='warning'>[user] destroys [src]!</span>")
			qdel(src)
		else
			visible_message("<span class='notice'>[user] smashes against [src]!</span>")

	else
		return
*/
/obj/structure/barricade/wooden/attack_alien(mob/user)
	if(isalienadult(user))
		playsound(src, 'sound/weapons/bladeslice.ogg', 100, 0, 0)
		health -= 15
		user.do_attack_animation(src)
		user.changeNext_move(CLICK_CD_MELEE)
	if(health <= 0)
		visible_message("<span class='warning'>[user] destroys [src]!</span>")
		qdel(src)
	else
		visible_message("<span class='notice'>[user] smashes against [src]!</span>")
	return

//XENO CRAFTING STUFF//

/obj/item/weapon/xeno_skull
	name = "alien skull"
	desc = "The skull from some unfortunate alien. It's been hollowed out."
	icon = 'icons/mob/alien.dmi'
	icon_state = "skull_h"
	origin_tech = "materials=3"
	w_class = 4
	unacidable = 1

/obj/item/weapon/xeno_skull/h
	name = "alien hunter skull"
	icon_state = "skull_h"
/obj/item/weapon/xeno_skull/run
	name = "alien runner skull"
	icon_state = "skull_run"
/obj/item/weapon/xeno_skull/d
	name = "alien drone skull"
	icon_state = "skull_d"
/obj/item/weapon/xeno_skull/s
	name = "alien sentinel skull"
	icon_state = "skull_s"
/obj/item/weapon/xeno_skull/r
	name = "alien ravager skull"
	icon_state = "skull_r"
/obj/item/weapon/xeno_skull/p
	name = "alien praetorian skull"
	icon_state = "skull_p"
/obj/item/weapon/xeno_skull/q
	name = "alien queen skull"
	icon_state = "skull_q"
	w_class = 5

/obj/item/weapon/xenos_claw
	name = "alien claws"
	desc = "The claws of a terrible creature."
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"
	origin_tech = "materials=3"
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 7
	throwforce = 7
	w_class = 2
	unacidable = 1

/obj/item/weapon/xenos_tail
	name = "alien tail barb"
	desc = "The sharp end of a xenomorph's tail."
	icon = 'icons/mob/alien.dmi'
	icon_state = "tail"
	origin_tech = "materials=3"
	embed_chance = 60
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 7
	throwforce = 14
	w_class = 2
	unacidable = 1

/obj/item/stack/sheet/animalhide/xeno
	name = "alien hide"
	icon = 'icons/mob/alien.dmi'
	desc = "The skin of a terrible creature."
	singular_name = "alien hide piece"
	icon_state = "hide"
	origin_tech = "materials=3"
	w_class = 3
	unacidable = 1

//CRAFTABLES//

//SPEAR
/obj/item/weapon/twohanded/spear/xeno
	name = "alien spear"
	desc = "A simple metal rod with the sharp end of a xenomorph tail tied on the end of it. Give em' a taste of their own medicine!"
	force = 15
	throwforce = 22
	force_wielded = 22
	embed_chance = 80
	embedded_impact_pain_multiplier = 4
	icon = 'icons/mob/alien.dmi'
	icon_state = "spearxeno0"
	unacidable = 1

/obj/item/weapon/twohanded/spear/xeno/update_icon()
	if(explosive)
		icon_state = "spearxeno_bomb[wielded]"
	else
		icon_state = "spearxeno[wielded]"

//SHIELD
/obj/item/weapon/shield/xeno
	name = "alien shield"
	desc = "The skull of an alien, hollowed out and fashioned into an arm-length piece of chitin which effectively blocks melee attacks. Acid-resistant!"
	unacidable = 1
	icon = 'icons/mob/alien.dmi'
	icon_state = "xeno_shield"
	item_state = "xeno_shield"
	force = 10
	origin_tech = "materials=3"
	attack_verb = list("shoved", "bashed")

//ARMOR
/obj/item/clothing/suit/xeno_armor
	name = "alien armor"
	desc = "A suit of armor made out of chitinous alien hide."
	unacidable = 1
	icon_state = "xenos"
	item_state = "alien_helm"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/clothing/mask/facehugger)
	armor = list(melee = 35, bullet = 10, laser = -25, energy = 0, bomb = 10, bio = 10, rad = 30)
//HELMET
/obj/item/clothing/head/xeno_helm
	name = "alien helmet"
	icon_state = "xenos"
	unacidable = 1
	item_state = "alien_helm"
	desc = "An armored helmet made out of chitinous alien hide."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	armor = list(melee = 35, bullet = 10, laser = -25, energy = 0, bomb = 10, bio = 10, rad = 30)
//CRAFTING RECIPES//
/datum/table_recipe/xenoshield
	name = "alien shield"
	result = /obj/item/weapon/shield/xeno
	reqs = list(/obj/item/weapon/xeno_skull)
	tools = list(/obj/item/weapon/kitchen/knife)
	time = 50
	category = CAT_MISC

/datum/table_recipe/xeno_armor
	name = "alien armor"
	result = /obj/item/clothing/suit/xeno_armor
	reqs = list(/obj/item/stack/sheet/animalhide/xeno = 2)
	tools = list(/obj/item/weapon/kitchen/knife)
	time = 100
	category = CAT_MISC

/datum/table_recipe/xeno_helm
	name = "alien helmet"
	result = /obj/item/clothing/head/xeno_helm
	reqs = list(/obj/item/weapon/xeno_skull)
	tools = list(/obj/item/weapon/kitchen/knife)
	time = 50
	category = CAT_MISC
