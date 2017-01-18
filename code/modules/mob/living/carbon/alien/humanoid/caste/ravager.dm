/mob/living/carbon/alien/humanoid/ravager
	name = "alien ravager"
	caste = "rav"
	maxHealth = 250
	health = 250
	icon = 'icons/mob/alienqueen.dmi'
	icon_state = "alienrav"
	heat_protection = 2 //the only fire resistant caste
	ventcrawler = 0
	pixel_x = -16
	mob_size = MOB_SIZE_LARGE
	butcher_results = list(/obj/item/weapon/xeno_skull/r = 1,
	/obj/item/weapon/reagent_containers/food/snacks/meat/slab/xeno = 5,
	/obj/item/stack/sheet/animalhide/xeno = 3,
	/obj/item/weapon/xenos_tail = 1,
	/obj/item/weapon/xenos_claw = 2)
	pressure_resistance = 200
	layer = 6
	unique_name = 0
	var/alt_inhands_file = 'icons/mob/alienqueen.dmi'
	var/charging = 0
/mob/living/carbon/alien/humanoid/ravager/movement_delay()
	. = ..()

/mob/living/carbon/alien/humanoid/ravager/New()
	real_name = name
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/ravager
	..()

/mob/living/carbon/alien/humanoid/ravager/handle_hud_icons_health()
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

#define MAX_ALIEN_CHARGE_DIST 5

/mob/living/carbon/alien/humanoid/ravager/proc/charge_at(atom/A)
	var/plasma_cost = 45
	if(charge_cooldown)
		src << "<span class='alertalien'>You are too fatigued to charge right now!</span>"
		return
	if(!has_gravity(src) || !has_gravity(A))
		src << "<span class='alertalien'>It is unsafe to charge without gravity!</span>"
		return
	if(getPlasma() < plasma_cost)
		if(!silent)
			src << "<span class='noticealien'>Not enough plasma stored.</span>"
		return
	else
		adjustPlasma(-plasma_cost)
		charging = 1
		src.say("*screech")
		src.visible_message(
			"<span class ='danger'>[src] charges at [A]!</span>",\
			"<span class ='danger'>You charge at [A]</span>",\
			"<span class ='italics'>You hear running...</span>")
		throw_at(A,MAX_ALIEN_CHARGE_DIST,1, spin=0, diagonals_first = 1)
		update_icons()
		charging = 0
		charge_cooldown = !charge_cooldown
		spawn(charge_cooldown_time) //15s by default
			src << "<span class='noticealien'>You're ready to charge again.</span>"
			charge_cooldown = !charge_cooldown

/mob/living/carbon/alien/humanoid/ravager/throw_impact(atom/A, params)
	if(!charging)
		return ..()
	if(A)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			if(weakened)
				return
			L.visible_message(
				"<span class ='danger'>[src] charges into [L]!</span>",\
				"<span class ='userdanger'>[src] charges into you!</span>",\
				"<span class ='italics'>You hear a thud...</span>")
			L.Weaken(3)
			playsound(L.loc, 'sound/weapons/punch3.ogg', 100, 0, 7)
			var/chargeDamage = rand(15,30)
			L.adjustBruteLoss(chargeDamage)
			step_away(L,src)
			step_away(L,src)
		if(istype(A, /obj/mecha))
			var/obj/mecha/M = A
			M.visible_message(
				"<span class ='danger'>[src] charges into [M]!</span>",\
				"<span class ='userdanger'>[src] charges into [M]!</span>",\
				"<span class ='italics'>You hear a thud...</span>")
			playsound(src, pick('sound/alien/Effects/bang1.ogg', 'sound/alien/Effects/bang2.ogg', 'sound/alien/Effects/bang3.ogg', 'sound/alien/Effects/bang4.ogg', 'sound/alien/Effects/bang5.ogg', 'sound/alien/Effects/bang6.ogg', 'sound/alien/Effects/bang7.ogg', 'sound/alien/Effects/bang8.ogg'), 100, 0, 0)
			M.attack_alien(src)
			step_away(M,src)
		if(istype(A, /obj/structure))
			var/obj/structure/S = A
			if(!S.anchored)
				S.visible_message(
					"<span class ='danger'>[src] charges into [S]!</span>",\
					"<span class ='userdanger'>[src] charges into [S]!</span>",\
					"<span class ='italics'>You hear a thud...</span>")
				playsound(src, pick('sound/alien/Effects/bang1.ogg', 'sound/alien/Effects/bang2.ogg', 'sound/alien/Effects/bang3.ogg', 'sound/alien/Effects/bang4.ogg', 'sound/alien/Effects/bang5.ogg', 'sound/alien/Effects/bang6.ogg', 'sound/alien/Effects/bang7.ogg', 'sound/alien/Effects/bang8.ogg'), 100, 0, 0)
				step_away(S,src)
				step_away(S,src)
		else if(A.density && !A.CanPass(src) && (!istype(A, /obj/structure) || !istype(A, /obj/mecha)))
			visible_message("<span class ='danger'>[src] smashes into [A]!</span>", "<span class ='alertalien'>[src] smashes into [A]!</span>")
			playsound(A, pick('sound/alien/Effects/bang1.ogg', 'sound/alien/Effects/bang2.ogg', 'sound/alien/Effects/bang3.ogg', 'sound/alien/Effects/bang4.ogg', 'sound/alien/Effects/bang5.ogg', 'sound/alien/Effects/bang6.ogg', 'sound/alien/Effects/bang7.ogg', 'sound/alien/Effects/bang8.ogg'), 100, 0, 0)
			weakened = 2
		if(charging)
			charging = 0
			update_icons()
			update_canmove()
/mob/living/carbon/alien/humanoid/ravager/MiddleClickOn(atom/A, params,)
	face_atom(A)
	charge_at(A)