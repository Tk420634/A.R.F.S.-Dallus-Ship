/mob/living/carbon/alien/humanoid/hunter
	name = "alien hunter"
	caste = "h"
	maxHealth = 150
	health = 150
	icon_state = "alienh_s"
	butcher_results = list(/obj/item/weapon/xeno_skull/h = 1,
	/obj/item/weapon/reagent_containers/food/snacks/meat/slab/xeno = 5,
	/obj/item/stack/sheet/animalhide/xeno = 1,
	/obj/item/weapon/xenos_tail = 1,
	/obj/item/weapon/xenos_claw = 1)

/mob/living/carbon/alien/humanoid/hunter/New()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/small/tiny
	AddAbility(new /obj/effect/proc_holder/alien/sneak)

	..()

/mob/living/carbon/alien/humanoid/hunter/handle_hud_icons_health()
	if (healths)
		if (stat != 2)
			switch(health)
				if(150 to INFINITY)
					healths.icon_state = "health0"
				if(120 to 150)
					healths.icon_state = "health1"
				if(90 to 120)
					healths.icon_state = "health2"
				if(60 to 90)
					healths.icon_state = "health3"
				if(30 to 60)
					healths.icon_state = "health4"
				if(0 to 30)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

/mob/living/carbon/alien/humanoid/hunter/movement_delay()
	. += ..()

//Hunter verbs


/mob/living/carbon/alien/humanoid/hunter/proc/toggle_leap(message = 1)
	leap_on_click = !leap_on_click
	leap_icon.icon_state = "leap_[leap_on_click ? "on":"off"]"
	update_icons()
	if(message)
		src << "<span class='noticealien'>You will now [leap_on_click ? "leap at":"slash at"] enemies!</span>"
	else
		return


/mob/living/carbon/alien/humanoid/hunter/ClickOn(atom/A, params)
	face_atom(A)
	if(leap_on_click)
		leap_at(A)
	else
		..()

/mob/living/carbon/alien/humanoid/hunter/MiddleClickOn(atom/A, params,)
	face_atom(A)
	leap_at(A)

#define MAX_ALIEN_LEAP_DIST 7

/mob/living/carbon/alien/humanoid/hunter/proc/leap_at(atom/A)
	var/plasma_cost = 25
	if(istype(A, /mob/living))
		var/mob/living/L = A
		if(L.stat > 0 || L.weakened || L.paralysis)
			src << "<span class='alertalien'>[A.name] is already knocked down!</span>"
			return
	if(pounce_cooldown)
		src << "<span class='alertalien'>You are too fatigued to pounce right now!</span>"
		return

	if(leaping) //Leap while you leap, so you can leap while you leap
		return

	if(!has_gravity(src) || !has_gravity(A))
		src << "<span class='alertalien'>It is unsafe to leap without gravity!</span>"
		//It's also extremely buggy visually, so it's balance+bugfix
		return
	if(lying)
		return

	if(getPlasma() < plasma_cost)
		if(!silent)
			src << "<span class='noticealien'>Not enough plasma stored.</span>"
		return

	else
		adjustPlasma(-plasma_cost)
		src.visible_message(
			"<span class ='danger'>[src] pounces at [A]!</span>",\
			"<span class ='danger'>You pounce at [A]</span>")
		leaping = 1
		update_icons()
		throw_at(A,MAX_ALIEN_LEAP_DIST,1, spin=0, diagonals_first = 1)
		playsound(src, pick('sound/alien/Effects/step1.ogg', 'sound/alien/Effects/step2.ogg', 'sound/alien/Effects/step3.ogg', 'sound/alien/Effects/step4.ogg', 'sound/alien/Effects/step5.ogg', 'sound/alien/Effects/step6.ogg', 'sound/alien/Effects/step7.ogg'), 300, 0, 4)
		leaping = 0
		update_icons()
		leap_on_click = 0
		pounce_cooldown = !pounce_cooldown
		spawn(pounce_cooldown_time) //5s by default
			src << "<span class='noticealien'>You're ready to pounce again.</span>"
			pounce_cooldown = !pounce_cooldown

/mob/living/carbon/alien/humanoid/hunter/throw_impact(atom/A, params)

	if(!leaping)
		return ..()

	if(A)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			var/blocked = 0
			if(ishuman(A))
				var/mob/living/carbon/human/H = A
				if(H.check_shields(90, "the [name]", src, 1))
					blocked = 1
				if(weakened)
					return
			if(!blocked)
				L.visible_message(
					"<span class ='danger'>[src] pounces on [L]!</span>",\
					"<span class ='userdanger'>[src] pounces on you!</span>",\
					"<span class ='italics'>You hear a thud...</span>")
				L.Weaken(3)
				src.canmove = 0
				sleep(2)//Runtime prevention (infinite bump() calls on hulks)
				step_towards(src,L)
				sleep(200)
				src.canmove = 1

		else if(A.density && !A.CanPass(src))
			visible_message("<span class ='danger'>[src] smashes into [A]!</span>", "<span class ='alertalien'>[src] smashes into [A]!</span>")
			weakened = 2

		if(leaping)
			leaping = 0
			update_icons()
			update_canmove()


/mob/living/carbon/alien/humanoid/float(on)
	if(leaping)
		return
	..()


/mob/living/carbon/alien/humanoid/hunter/lusty
	name = "xenomorph maid"
	caste = "lusty"
	maxHealth = 150
	health = 150
	icon_state = "alienlusty_s"
	unique_name = 0
	languages = -1
	has_fine_manipulation = 1

/mob/living/carbon/alien/humanoid/hunter/lusty/IsAdvancedToolUser()
	return 1


/mob/living/carbon/alien/humanoid/hunter/admin
	languages = -1
	has_fine_manipulation = 1

/mob/living/carbon/alien/humanoid/hunter/admin/IsAdvancedToolUser()
	return 1
