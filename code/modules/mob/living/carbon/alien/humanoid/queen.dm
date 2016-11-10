/mob/living/carbon/alien/humanoid/royal
	//Common stuffs for Praetorian and Queen
	icon = 'icons/mob/alienqueen.dmi'
	status_flags = 0
	ventcrawler = 0 //pull over that ass too fat
	unique_name = 0
	pixel_x = -16
	mob_size = MOB_SIZE_LARGE
	layer = 6
	pressure_resistance = 200 //Because big, stompy xenos should not be blown around like paper.
	butcher_results = list(/obj/item/weapon/xeno_skull/q = 1,
	/obj/item/weapon/reagent_containers/food/snacks/meat/slab/xeno = 20,
	/obj/item/stack/sheet/animalhide/xeno = 5,
	/obj/item/weapon/xenos_tail = 1,
	/obj/item/weapon/xenos_claw = 2)
	var/alt_inhands_file = 'icons/mob/alienqueen.dmi'

/mob/living/carbon/alien/humanoid/royal/queen
	name = "alien queen"
	caste = "q"
	maxHealth = 325
	health = 325
	icon_state = "alienq"

/mob/living/carbon/alien/humanoid/royal/queen/New()
	//there should only be one queen
	for(var/mob/living/carbon/alien/humanoid/royal/queen/Q in living_mob_list)
		if(Q == src)		continue
		if(Q.stat == DEAD)	continue
		if(Q.client)
			name = "alien princess ([rand(1, 999)])"	//if this is too cutesy feel free to change it/remove it.
			break

	real_name = src.name

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/large/queen
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin
	internal_organs += new /obj/item/organ/internal/alien/eggsac
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))
	AddAbility(new/obj/effect/proc_holder/alien/royal/queen/promote())
	AddAbility(new/obj/effect/proc_holder/alien/royal/queen/screech())
	..()

/mob/living/carbon/alien/humanoid/royal/queen/handle_hud_icons_health()
	if (src.healths)
		if (src.stat != 2)
			switch(health)
				if(325 to INFINITY)
					src.healths.icon_state = "health0"
				if(275 to 325)
					src.healths.icon_state = "health1"
				if(200 to 275)
					src.healths.icon_state = "health2"
				if(160 to 200)
					src.healths.icon_state = "health3"
				if(80 to 160)
					src.healths.icon_state = "health4"
				if(0 to 80)
					src.healths.icon_state = "health5"
				else
					src.healths.icon_state = "health6"
		else
			src.healths.icon_state = "health7"

/mob/living/carbon/alien/humanoid/royal/queen/movement_delay()
	. = ..()
	. += 3
	if(locate(/obj/structure/alien/weeds) in src.loc)
		. += -1

//Queen verbs
/obj/effect/proc_holder/alien/lay_egg
	name = "Lay Egg"
	desc = "Lay an egg to produce huggers to impregnate prey with."
	plasma_cost = 75
	check_turf = 1
	action_icon_state = "alien_egg"

/obj/effect/proc_holder/alien/lay_egg/fire(mob/living/carbon/user)
	if(locate(/obj/structure/alien/egg) in get_turf(user))
		user << "There's already an egg here."
		return 0
	user.visible_message("<span class='alertalien'>[user] has laid an egg!</span>")
	playsound(user.loc, pick('sound/alien/Effects/resin1.ogg', 'sound/alien/Effects/resin2.ogg', 'sound/alien/Effects/resin3.ogg', 'sound/alien/Effects/resin4.ogg'), 100, 1)
	new /obj/structure/alien/egg(user.loc)
	return 1

//Button to let queen choose her praetorian.
/obj/effect/proc_holder/alien/royal/queen/promote
	name = "Create Royal Parasite"
	desc = "Produce a royal parasite to grant one of your children the honor of being your Praetorian."
	plasma_cost = 500 //Plasma cost used on promotion, not spawning the parasite.

	action_icon_state = "alien_queen_promote"



/obj/effect/proc_holder/alien/royal/queen/promote/fire(mob/living/carbon/alien/user)
	var/obj/item/queenpromote/prom
	if(alien_type_present(/mob/living/carbon/alien/humanoid/royal/praetorian/))
		user << "<span class='noticealien'>You already have a Praetorian!</span>"
		return 0
	else
		for(prom in user)
			user << "<span class='noticealien'>You discard [prom].</span>"
			qdel(prom)
			return 0

		prom = new (user.loc)
		if(!user.put_in_active_hand(prom, 1))
			user << "<span class='warning'>You must empty your hands before preparing the parasite.</span>"
			return 0
		else //Just in case telling the player only once is not enough!
			user << "<span class='noticealien'>Use the royal parasite on one of your children to promote her to Praetorian!</span>"
	return 0


/obj/item/queenpromote
	name = "\improper royal parasite"
	desc = "Inject this into one of your grown children to promote her to a Praetorian!"
	icon_state = "alien_medal"
	flags = ABSTRACT|NODROP
	icon = 'icons/mob/alien.dmi'

/obj/item/queenpromote/attack(mob/living/M, mob/living/carbon/alien/humanoid/user)
	if(!isalienadult(M) || istype(M, /mob/living/carbon/alien/humanoid/royal))
		user << "<span class='noticealien'>You may only use this with your adult, non-royal children!</span>"
		return
	if(alien_type_present(/mob/living/carbon/alien/humanoid/royal/praetorian/))
		user << "<span class='noticealien'>You already have a Praetorian!</span>"
		return

	var/mob/living/carbon/alien/humanoid/A = M
	if(A.stat == CONSCIOUS && A.mind && A.key)
		if(!user.usePlasma(500))
			user << "<span class='noticealien'>You must have 500 plasma stored to use this!</span>"
			return

		A << "<span class='noticealien'>The queen has granted you a promotion to Praetorian!</span>"
		user.visible_message("<span class='alertalien'>[A] begins to expand, twist and contort!</span>")
		var/mob/living/carbon/alien/humanoid/royal/praetorian/new_prae = new (A.loc)
		A.mind.transfer_to(new_prae)
		qdel(A)
		qdel(src)
		return
	else
		user << "<span class='warning'>This child must be alert and responsive to become a Praetorian!</span>"

/obj/item/queenpromote/attack_self(mob/user)
	user << "<span class='noticealien'>You discard [src].</span>"
	qdel(src)

/obj/effect/proc_holder/alien/royal/queen/screech
	name = "Screech"
	desc = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
	action_icon_state = "alien_screech"
	plasma_cost = 350

/obj/effect/proc_holder/alien/royal/queen/screech/fire(mob/living/carbon/alien/humanoid/royal/queen/user)
	user.visible_message("<span class='alertalien'>[user] emits an ear-splitting screech!!</span>")
	playsound(user.loc, 'sound/voice/screech.ogg', 200, 0, 64)
	for(var/mob/living/M in get_hearers_in_view(4, user))
		if(ishuman(M))
			M.confused += 6
			M.Jitter(rand(5,10))
			M.Weaken(rand(2,3))
			shake_camera(M, 3, strength=2)
		else if(issilicon(M))
			M << sound('sound/weapons/flash.ogg')
			M.Weaken(rand(2,5))
	for(var/obj/machinery/light/L in range(7, user))
		L.on = 1
		L.broken()
	return 1

/mob/living/carbon/alien/humanoid/royal/queen/proc/spit_at(atom/A)
	var/plasma_cost = 75
	if(paralysis || stat || weakened)
		src << "<span class ='noticetalien'>You can't spit right now!</span>"
		return

	if(!src.getorgan(/obj/item/organ/internal/alien/neurotoxin))
		src << "<span class ='alertalien'>You don't have a neurotoxin gland!</span>"
		return

	if(spit_cooldown)
		src << "<span class='noticealien'>You can't spit yet!</span>"
		return

	if(getPlasma() < plasma_cost)
		if(!silent)
			src << "<span class='noticealien'>Not enough plasma stored.</span>"
		return
	else
		adjustPlasma(-plasma_cost)
		src.visible_message(
			"<span class ='danger'>[src] spits neurotoxin at [A]!</span>",\
			"<span class ='danger'>You spit neurotoxin at [A]</span>",\
			"<span class ='italics'>You hear squelching...</span>")
		playsound(src.loc, 'sound/alien/Effects/spit1.ogg', 100, 1)
		var/obj/item/projectile/bullet/neurotoxin/N = new /obj/item/projectile/bullet/neurotoxin(src.loc)
		N.yo = A.y - src.y
		N.xo = A.x - src.x
		N.fire()
		spit_cooldown = !spit_cooldown
		spawn(spit_cooldown_time) //15s by default
			src << "<span class='alertalien'>You're ready to spit again.</span>"
			spit_cooldown = !spit_cooldown

/mob/living/carbon/alien/humanoid/royal/queen/MiddleClickOn(atom/A, params, mob/user)
	face_atom(A)
	spit_at(A)