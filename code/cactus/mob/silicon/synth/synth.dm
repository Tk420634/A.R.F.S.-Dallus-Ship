//SYNTHETICS//

/mob/living/silicon/synth
	name = "synthetic"
	real_name = "synthetic"
	icon = 'code/cactus/icons/synth.dmi'
	icon_state = "synth"
	var/eyes_state = "eyes_synth"
	maxHealth = 150
	health = 150
	var/custom_name = ""
	designation = "Default"
	has_limbs = 1
	var/charge = 10000
	var/speed = 0
	var/obj/item/weapon/stock_parts/cell/cell = null

/mob/living/silicon/synth/movement_delay()
	. = ..()
	. += speed