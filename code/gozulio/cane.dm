//Gozulios white cane. There are two entries here using the telescopic baton code.
//White Cane for head of staff use
/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane
	name = "white cane"
	desc = "A telescoping white cane. They are commonly used by the blind or visually impaired as a mobility tool or as a courtesy to others."
	icon_state = "goz_whitecane_0"
	item_state = null
	..()

/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane/suicide_act(mob/user)
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/internal/brain/B = H.getorgan(/obj/item/organ/internal/brain)

	user.visible_message("<span class='suicide'>[user] stuffs the [src] up their nose and presses the 'extend' button! It looks like they're trying to clear their mind.</span>")
	if(!on)
		src.attack_self(user)
	else
		playsound(loc, 'sound/weapons/batonextend.ogg', 50, 1)
		add_fingerprint(user)
	sleep(3)
	if (H && !qdeleted(H))
		if (B && !qdeleted(B))
			H.internal_organs -= B
			qdel(B)
		gibs(H.loc, H.viruses, H.dna)
		return (BRUTELOSS)
	return

/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane/attack_self(mob/user)
	on = !on
	if(on)
		user << "<span class ='notice'>You extend the white cane.</span>"
		icon_state = "goz_whitecane_1"
		item_state = "goz_whitecane"
		w_class = 4 //doesnt fit in backpack when its on for balance
		force = 10 //stunbaton damage
		attack_verb = list("smacked", "struck", "cracked", "beaten", "tripped")
	else
		user << "<span class ='notice'>You collapse the white cane.</span>"
		icon_state = "goz_whitecane_0"
		item_state = null //no sprite for concealment even when in hand
		slot_flags = SLOT_BELT
		w_class = 2
		force = 0 //not so robust now
		attack_verb = list("hit", "poked")

	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	add_fingerprint(user)

//Same code from th classib baton just attack text changed
/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane/attack(mob/target, mob/living/user)
	if(on)
		add_fingerprint(user)
		if((CLUMSY in user.disabilities) && prob(50))
			user << "<span class ='danger'>You club yourself over the head.</span>"
			user.Weaken(3 * force)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.apply_damage(2*force, BRUTE, "head")
			else
				user.take_organ_damage(2*force)
			return
		if(isrobot(target))
			..()
			return
		if(!isliving(target))
			return
		if (user.a_intent == "harm")
			if(!..()) return
			if(!isrobot(target)) return
		else
			if(cooldown <= 0)
				playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
				target.Weaken(3)
				add_logs(user, target, "stunned", src)
				src.add_fingerprint(user)
				target.visible_message("<span class ='danger'>[user] has tripped [target] with \the [src]!</span>", \
					"<span class ='userdanger'>[user] has tripped [target] with \the [src]!</span>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
				cooldown = 1
				spawn(40)
					cooldown = 0
		return
	else
		return ..()

//white cane for non head of staff use
/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane/safe
	name = "white cane"
	desc = "A telescoping white cane. They are commonly used by the blind or visually impaired as a mobility tool or as a courtesy to others."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "goz_whitecane_0"
	item_state = null
	slot_flags = SLOT_BELT
	w_class = 2
	needs_permit = 0
	force = 0
	on = 0

/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane/safe/suicide_act(mob/user)
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/internal/brain/B = H.getorgan(/obj/item/organ/internal/brain)

	user.visible_message("<span class='suicide'>[user] stuffs the [src] up their nose and presses the 'extend' button! It looks like they're trying to clear their mind.</span>")
	if(!on)
		src.attack_self(user)
	else
		playsound(loc, 'sound/weapons/batonextend.ogg', 50, 1)
		add_fingerprint(user)
	sleep(3)
	if (H && !qdeleted(H))
		if (B && !qdeleted(B))
			H.internal_organs -= B
			qdel(B)
		gibs(H.loc, H.viruses, H.dna)
		return (BRUTELOSS)
	return

/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane/safe/attack_self(mob/user)
	on = !on
	if(on)
		user << "<span class ='notice'>You extend the white cane.</span>"
		icon_state = "goz_whitecane_1"
		item_state = "goz_whitecane"
		w_class = 4 //doesnt fit in backpack when its on for balance
		force = 0 //no damage for non had of staff variant
		attack_verb = list("smacked", "struck", "tried to trip")
	else
		user << "<span class ='notice'>You collapse the white cane.</span>"
		icon_state = "goz_whitecane_0"
		item_state = null //no sprite for concealment even when in hand
		slot_flags = SLOT_BELT
		w_class = 2
		force = 0
		attack_verb = list("hit", "poked")

	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	add_fingerprint(user)

//attack text changed and stun removed.
/obj/item/weapon/melee/classic_baton/telescopic/goz/whitecane/safe/attack(mob/target, mob/living/user)
	if(on)
		add_fingerprint(user)
		if((CLUMSY in user.disabilities) && prob(50))
			user << "<span class ='danger'>You club yourself over the head.</span>"
			user.Weaken(3 * force)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.apply_damage(2*force, BRUTE, "head")
			else
				user.take_organ_damage(2*force)
			return
		if(isrobot(target))
			..()
			return
		if(!isliving(target))
			return
		if (user.a_intent == "harm")
			if(!..()) return
			if(!isrobot(target)) return
		else
			if(cooldown <= 0)
				playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
				src.add_fingerprint(user)
				target.visible_message("<span class ='danger'>[user] has swatted at [target] with \the [src]!</span>", \
					"<span class ='userdanger'>[user] has swatted at [target] with \the [src]!</span>")
				if(!iscarbon(user))
					target.LAssailant = null
				else
					target.LAssailant = user
				cooldown = 1
				spawn(40)
					cooldown = 0
		return
	else
		return ..()