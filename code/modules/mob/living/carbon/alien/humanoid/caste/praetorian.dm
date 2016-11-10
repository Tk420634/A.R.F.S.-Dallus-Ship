/mob/living/carbon/alien/humanoid/royal/praetorian
	name = "alien praetorian"
	caste = "p"
	maxHealth = 250
	health = 250
	icon_state = "alienp"
	butcher_results = list(/obj/item/weapon/xeno_skull/p = 1,
	/obj/item/weapon/reagent_containers/food/snacks/meat/slab/xeno = 5,
	/obj/item/stack/sheet/animalhide/xeno = 3,
	/obj/item/weapon/xenos_tail = 1,
	/obj/item/weapon/xenos_claw = 1)

/mob/living/carbon/alien/humanoid/royal/praetorian/New()

	real_name = name

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/large
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))
	AddAbility(new /obj/effect/proc_holder/alien/royal/praetorian/evolve())
	AddAbility(new /obj/effect/proc_holder/alien/royal/praetorian/evolveravager())
	..()

/mob/living/carbon/alien/humanoid/royal/praetorian/handle_hud_icons_health()
	if (healths)
		if(stat != DEAD)
			switch(health)
				if(250 to INFINITY)
					healths.icon_state = "health0"
				if(200 to 250)
					healths.icon_state = "health1"
				if(150 to 200)
					healths.icon_state = "health2"
				if(100 to 150)
					healths.icon_state = "health3"
				if(50 to 100)
					healths.icon_state = "health4"
				if(0 to 50)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"


/mob/living/carbon/alien/humanoid/royal/praetorian/movement_delay()
	. = ..()
	. += 1

/obj/effect/proc_holder/alien/royal/praetorian/evolve
	name = "Evolve into Queen"
	desc = "Produce an interal egg sac capable of spawning children. Only one queen can exist at a time."
	plasma_cost = 500

	action_icon_state = "alien_evolve_praetorian"

/obj/effect/proc_holder/alien/royal/praetorian/evolve/fire(mob/living/carbon/alien/user)
	if(!alien_type_present(/mob/living/carbon/alien/humanoid/royal/queen))
		user << "<span class='noticealien'>You begin to evolve!</span>"
		user.visible_message("<span class='alertalien'>[user] begins to twist and contort!</span>")
		var/mob/living/carbon/alien/humanoid/royal/queen/new_xeno = new (user.loc)
		user.mind.transfer_to(new_xeno)
		qdel(user)
		return 1
	else
		user << "<span class='notice'>We already have an alive queen.</span>"
		return 0

/obj/effect/proc_holder/alien/royal/praetorian/evolveravager
	name = "Evolve into Ravager"
	desc = "Sacrafice many of your unique abilities to become the ultimate killing machine."
	plasma_cost = 500
	action_icon_state = "alien_evolve_praetorian_ravager"

/obj/effect/proc_holder/alien/royal/praetorian/evolveravager/fire(mob/living/carbon/alien/user)
	if(alien_type_present(/mob/living/carbon/alien/humanoid/ravager))
		user << "<span class='noticealien'>You cannot evolve into a ravager because there is already an alive ravager.</span>"
		return 0
	if(!alien_type_present(/mob/living/carbon/alien/humanoid/royal/queen))
		user << "<span class='notice'>You cannot evolve into a ravager unless there is already an alive queen.</span>"
		return 0
	else
		user << "<span class='noticealien'>You begin to evolve!</span>"
		user.visible_message("<span class='alertalien'>[user] begins to twist and contort!</span>")
		var/mob/living/carbon/alien/humanoid/ravager/new_xeno = new (user.loc)
		user.mind.transfer_to(new_xeno)
		qdel(user)
		new_xeno << "<span class='userdanger'>As a ravager you boast increased health, strength, and your thick exoskeleton rends you resistant to burns; However you lack the ability to lay weeds and pick up facehuggers.</span>"
		return 1


/mob/living/carbon/alien/humanoid/royal/praetorian/proc/spit_at(atom/A)
	var/plasma_cost = 75
	if(paralysis || stat || weakened)
		src << "<span class ='alertalien'>You can't spit right now!</span>"
		return

	if(!src.getorgan(/obj/item/organ/internal/alien/neurotoxin))
		src << "<span class ='alertalien'>You don't have a neurotoxin gland!</span>"
		return

	if(spit_cooldown)
		src << "<span class='alertalien'>You can't spit yet!</span>"
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
			src << "<span class='noticealien'>You're ready to spit again.</span>"
			spit_cooldown = !spit_cooldown

/mob/living/carbon/alien/humanoid/royal/praetorian/MiddleClickOn(atom/A, params, mob/user)
	face_atom(A)
	spit_at(A)