/mob/living/carbon/alien/humanoid/sentinel
	name = "alien sentinel"
	caste = "s"
	maxHealth = 200
	health = 200
	icon_state = "aliens_s"
	butcher_results = list(/obj/item/weapon/xeno_skull/s = 1,
	/obj/item/weapon/reagent_containers/food/snacks/meat/slab/xeno = 5,
	/obj/item/stack/sheet/animalhide/xeno = 1,
	/obj/item/weapon/xenos_tail = 1,
	/obj/item/weapon/xenos_claw = 1)

/mob/living/carbon/alien/humanoid/sentinel/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/sentinel
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin

	AddAbility(new /obj/effect/proc_holder/alien/sneak)
	..()

/mob/living/carbon/alien/humanoid/sentinel/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(200 to INFINITY)
					healths.icon_state = "health0"
				if(150 to 200)
					healths.icon_state = "health1"
				if(100 to 150)
					healths.icon_state = "health2"
				if(75 to 100)
					healths.icon_state = "health3"
				if(50 to 75)
					healths.icon_state = "health4"
				if(0 to 50)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

/mob/living/carbon/alien/humanoid/sentinel/movement_delay()
	. = ..()
	. += 1

/mob/living/carbon/alien/humanoid/sentinel/proc/spit_at(atom/A)
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

/mob/living/carbon/alien/humanoid/sentinel/MiddleClickOn(atom/A, params, mob/user)
	face_atom(A)
	spit_at(A)
