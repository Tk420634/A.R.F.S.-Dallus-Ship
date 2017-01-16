/obj/item/weapon/twohanded/fireaxe/sawcleaver  //Cecily code! Harder to read then regular code
	icon_state = "cleaver"
	name = "Saw Cleaver"
	desc = "Is this just real life, or is this just a hunters dream"
	force = 5
	throwforce = 15
	w_class = 4
	slot_flags = SLOT_BACK
	force_unwielded = 10
	force_wielded = 30
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP

/obj/item/weapon/twohanded/fireaxe/sawcleaver/update_icon()  //Currently only here to fuck with the on-mob icons.
	icon_state = "cleaver[wielded]"
	return

