/* Toys!
 * ContainsL
 *		Balloons
 *		Fake singularity
 *		Toy gun
 *		Toy crossbow
 *		Toy swords
 *		Crayons
 *		Snap pops
 *		Mech prizes
 *		AI core prizes
 *		Cards
 *		Toy nuke
 *		Fake meteor
 *		Carp plushie
 *		Foam armblade
 *		Toy big red button
 *		Beach ball
 *		Toy xeno
 *      Kitty toys!
 */


/obj/item/toy
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0


/*
 * Balloons
 */
/obj/item/toy/balloon
	name = "water balloon"
	desc = "A translucent balloon. There's nothing in it."
	icon = 'icons/obj/toy.dmi'
	icon_state = "waterballoon-e"
	item_state = "balloon-empty"

/obj/item/toy/balloon/New()
	create_reagents(10)

/obj/item/toy/balloon/attack(mob/living/carbon/human/M, mob/user)
	return

/obj/item/toy/balloon/afterattack(atom/A as mob|obj, mob/user, proximity)
	if(!proximity) return
	if (istype(A, /obj/structure/reagent_dispensers))
		var/obj/structure/reagent_dispensers/RD = A
		if(RD.reagents.total_volume <= 0)
			user << "<span class='warning'>[RD] is empty.</span>"
		else if(reagents.total_volume >= 10)
			user << "<span class='warning'>[src] is full.</span>"
		else
			A.reagents.trans_to(src, 10)
			user << "<span class='notice'>You fill the balloon with the contents of [A].</span>"
			desc = "A translucent balloon with some form of liquid sloshing around in it."
			update_icon()

/obj/item/toy/balloon/attackby(obj/O, mob/user, params)
	if(istype(O, /obj/item/weapon/reagent_containers/glass))
		if(O.reagents)
			if(O.reagents.total_volume <= 0)
				user << "<span class='warning'>[O] is empty.</span>"
			else if(reagents.total_volume >= 10)
				user << "<span class='warning'>[src] is full.</span>"
			else
				desc = "A translucent balloon with some form of liquid sloshing around in it."
				user << "<span class='notice'>You fill the balloon with the contents of [O].</span>"
				O.reagents.trans_to(src, 10)
				update_icon()

/obj/item/toy/balloon/throw_impact(atom/hit_atom)
	if(!..()) //was it caught by a mob?
		if(reagents.total_volume >= 1)
			visible_message("<span class='danger'>[src] bursts!</span>","<span class='italics'>You hear a pop and a splash.</span>")
			reagents.reaction(get_turf(hit_atom))
			for(var/atom/A in get_turf(hit_atom))
				reagents.reaction(A)
			icon_state = "burst"
			qdel(src)

/obj/item/toy/balloon/update_icon()
	if(src.reagents.total_volume >= 1)
		icon_state = "waterballoon"
		item_state = "balloon"
	else
		icon_state = "waterballoon-e"
		item_state = "balloon-empty"

/obj/item/toy/syndicateballoon
	name = "syndicate balloon"
	desc = "There is a tag on the back that reads \"FUK NT!11!\"."
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	icon = 'icons/obj/weapons.dmi'
	icon_state = "syndballoon"
	item_state = "syndballoon"
	w_class = 4

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "gravitational singularity"
	desc = "\"Singulo\" brand spinning toy."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "singularity_s1"

/*
 * Toy gun: Why isnt this an /obj/item/weapon/gun?
 */
/obj/item/toy/gun
	name = "cap gun"
	desc = "Looks almost like the real thing! Ages 8 and up. Please recycle in an autolathe when you're out of caps."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "revolver"
	item_state = "gun"
	lefthand_file = 'icons/mob/inhands/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/guns_righthand.dmi'
	flags =  CONDUCT
	slot_flags = SLOT_BELT
	w_class = 3
	materials = list(MAT_METAL=10, MAT_GLASS=10)
	attack_verb = list("struck", "pistol whipped", "hit", "bashed")
	var/bullets = 7

/obj/item/toy/gun/examine(mob/user)
	..()
	user << "There [bullets == 1 ? "is" : "are"] [bullets] cap\s left."

/obj/item/toy/gun/attackby(obj/item/toy/ammo/gun/A, mob/user, params)

	if (istype(A, /obj/item/toy/ammo/gun))
		if (src.bullets >= 7)
			user << "<span class='warning'>It's already fully loaded!</span>"
			return 1
		if (A.amount_left <= 0)
			user << "<span class='warning'>There are no more caps!</span>"
			return 1
		if (A.amount_left < (7 - src.bullets))
			src.bullets += A.amount_left
			user << text("<span class='notice'>You reload [] cap\s.</span>", A.amount_left)
			A.amount_left = 0
		else
			user << text("<span class='notice'>You reload [] cap\s.</span>", 7 - src.bullets)
			A.amount_left -= 7 - src.bullets
			src.bullets = 7
		A.update_icon()
		return 1
	return

/obj/item/toy/gun/afterattack(atom/target as mob|obj|turf|area, mob/user, flag)
	if (flag)
		return
	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return
	src.add_fingerprint(user)
	if (src.bullets < 1)
		user.show_message("<span class='warning'>*click*</span>", 2)
		playsound(user, 'sound/weapons/empty.ogg', 100, 1)
		return
	playsound(user, 'sound/weapons/Gunshot.ogg', 100, 1)
	src.bullets--
	user.visible_message("<span class='danger'>[user] fires [src] at [target]!</span>", \
						"<span class='danger'>You fire [src] at [target]!</span>", \
						 "<span class='italics'>You hear a gunshot!</span>")

/obj/item/toy/ammo/gun
	name = "capgun ammo"
	desc = "Make sure to recyle the box in an autolathe when it gets empty."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "357OLD-7"
	w_class = 1
	materials = list(MAT_METAL=10, MAT_GLASS=10)
	var/amount_left = 7

/obj/item/toy/ammo/gun/update_icon()
	src.icon_state = text("357OLD-[]", src.amount_left)

/obj/item/toy/ammo/gun/examine(mob/user)
	..()
	user << "There [amount_left == 1 ? "is" : "are"] [amount_left] cap\s left."

/*
 * Toy swords
 */
/obj/item/toy/sword
	name = "toy sword"
	desc = "A cheap, plastic replica of an energy sword. Realistic sounds! Ages 8 and up."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "sword0"
	item_state = "sword0"
	var/active = 0
	w_class = 2
	flags = NOSHIELD
	attack_verb = list("attacked", "struck", "hit")
	var/hacked = 0

/obj/item/toy/sword/attack_self(mob/user)
	active = !( active )
	if (active)
		user << "<span class='notice'>You extend the plastic blade with a quick flick of your wrist.</span>"
		playsound(user, 'sound/weapons/saberon.ogg', 20, 1)
		if(hacked)
			icon_state = "swordrainbow"
			item_state = "swordrainbow"
		else
			icon_state = "swordblue"
			item_state = "swordblue"
		w_class = 4
	else
		user << "<span class='notice'>You push the plastic blade back down into the handle.</span>"
		playsound(user, 'sound/weapons/saberoff.ogg', 20, 1)
		icon_state = "sword0"
		item_state = "sword0"
		w_class = 2
	add_fingerprint(user)
	return

// Copied from /obj/item/weapon/melee/energy/sword/attackby
/obj/item/toy/sword/attackby(obj/item/weapon/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/toy/sword))
		if(W == src)
			user << "<span class='warning'>You try to attach the end of the plastic sword to... itself. You're not very smart, are you?</span>"
			if(ishuman(user))
				user.adjustBrainLoss(10)
		else if((W.flags & NODROP) || (flags & NODROP))
			user << "<span class='warning'>\the [flags & NODROP ? src : W] is stuck to your hand, you can't attach it to \the [flags & NODROP ? W : src]!</span>"
		else
			user << "<span class='notice'>You attach the ends of the two plastic swords, making a single double-bladed toy! You're fake-cool.</span>"
			var/obj/item/weapon/twohanded/dualsaber/toy/newSaber = new /obj/item/weapon/twohanded/dualsaber/toy(user.loc)
			if(hacked) // That's right, we'll only check the "original" "sword".
				newSaber.hacked = 1
				newSaber.item_color = "rainbow"
			user.unEquip(W)
			user.unEquip(src)
			qdel(W)
			qdel(src)
	else if(istype(W, /obj/item/device/multitool))
		if(hacked == 0)
			hacked = 1
			item_color = "rainbow"
			user << "<span class='warning'>RNBW_ENGAGE</span>"

			if(active)
				icon_state = "swordrainbow"
				// Updating overlays, copied from welder code.
				// I tried calling attack_self twice, which looked cool, except it somehow didn't update the overlays!!
				if(user.r_hand == src)
					user.update_inv_r_hand(0)
				else if(user.l_hand == src)
					user.update_inv_l_hand(0)
		else
			user << "<span class='warning'>It's already fabulous!</span>"

/*
 * Foam armblade
 */
/obj/item/toy/foamblade
	name = "foam armblade"
	desc = "it says \"Sternside Changs #1 fan\" on it. "
	icon = 'icons/obj/toy.dmi'
	icon_state = "foamblade"
	item_state = "arm_blade"
	attack_verb = list("pricked", "absorbed", "gored")
	w_class = 2
	burn_state = 0 //Burnable


/*
 * Subtype of Double-Bladed Energy Swords
 */
/obj/item/weapon/twohanded/dualsaber/toy
	name = "double-bladed toy sword"
	desc = "A cheap, plastic replica of TWO energy swords.  Double the fun!"
	force = 0
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	force_unwielded = 0
	force_wielded = 0
	origin_tech = null
	attack_verb = list("attacked", "struck", "hit")

/obj/item/weapon/twohanded/dualsaber/toy/IsShield()
	return 0

/obj/item/weapon/twohanded/dualsaber/toy/IsReflect()//Stops Toy Dualsabers from reflecting energy projectiles
	return 0

/obj/item/toy/katana
	name = "replica katana"
	desc = "Woefully underpowered in D20."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "katana"
	item_state = "katana"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 5
	throwforce = 5
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced")
	hitsound = 'sound/weapons/bladeslice.ogg'

/*
 * Crayons
 */

/obj/item/toy/crayon
	name = "crayon"
	desc = "A colourful crayon. Looks tasty. Mmmm..."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonred"
	w_class = 1
	attack_verb = list("attacked", "coloured")
	var/paint_color = "#FF0000" //RGB
	var/drawtype = "rune"
	var/list/graffiti = list("amyjon","face","matt","revolution","engie","guy","end","dwarf","uboa","body","cyka","arrow","poseur tag")
	var/list/letters = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	var/list/oriented = list("arrow","body") // These turn to face the same way as the drawer
	var/uses = 30 //0 for unlimited uses
	var/instant = 0
	var/colourName = "red" //for updateIcon purposes
	var/dat
	var/list/validSurfaces = list(/turf/simulated/floor)
	var/gang = 0 //For marking territory
	var/edible = 1

/obj/item/toy/crayon/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is jamming the [src.name] up \his nose and into \his brain. It looks like \he's trying to commit suicide.</span>")
	return (BRUTELOSS|OXYLOSS)

/obj/item/toy/crayon/New()
	..()
	name = "[colourName] crayon" //Makes crayons identifiable in things like grinders
	drawtype = pick(pick(graffiti), pick(letters), "rune[rand(1,6)]")
	if(config)
		if(config.mutant_races == 1)
			graffiti |= "antilizard"
			graffiti |= "prolizard"

/obj/item/toy/crayon/initialize()
	if(config.mutant_races == 1)
		graffiti |= "antilizard"
		graffiti |= "prolizard"

/obj/item/toy/crayon/attack_self(mob/living/user)
	update_window(user)

/obj/item/toy/crayon/proc/update_window(mob/living/user)
	dat += "<center><h2>Currently selected: [drawtype]</h2><br>"
	dat += "<a href='?src=\ref[src];type=random_letter'>Random letter</a><a href='?src=\ref[src];type=letter'>Pick letter</a>"
	dat += "<hr>"
	dat += "<h3>Runes:</h3><br>"
	dat += "<a href='?src=\ref[src];type=random_rune'>Random rune</a>"
	for(var/i = 1; i <= 6; i++)
		dat += "<a href='?src=\ref[src];type=rune[i]'>Rune[i]</a>"
		if(!((i + 1) % 3)) //3 buttons in a row
			dat += "<br>"
	dat += "<hr>"
	graffiti.Find()
	dat += "<h3>Graffiti:</h3><br>"
	dat += "<a href='?src=\ref[src];type=random_graffiti'>Random graffiti</a>"
	var/c = 1
	for(var/T in graffiti)
		dat += "<a href='?src=\ref[src];type=[T]'>[T]</a>"
		if(!((c + 1) % 3)) //3 buttons in a row
			dat += "<br>"
		c++
	dat += "<hr>"
	var/datum/browser/popup = new(user, "crayon", name, 300, 500)
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()
	dat = ""

/obj/item/toy/crayon/Topic(href, href_list, hsrc)
	var/temp = "a"
	switch(href_list["type"])
		if("random_letter")
			temp = pick(letters)
		if("letter")
			temp = input("Choose the letter.", "Scribbles") in letters
		if("random_rune")
			temp = "rune[rand(1,6)]"
		if("random_graffiti")
			temp = pick(graffiti)
		else
			temp = href_list["type"]
	if ((usr.restrained() || usr.stat || usr.get_active_hand() != src))
		return
	drawtype = temp
	update_window(usr)

/obj/item/toy/crayon/afterattack(atom/target, mob/user, proximity)
	if(!proximity || !check_allowed_items(target)) return
	if(!uses)
		user << "<span class='warning'>There is no more of [src.name] left!</span>"
		if(!instant)
			qdel(src)
		return
	if(istype(target, /obj/effect/decal/cleanable))
		target = target.loc
	if(is_type_in_list(target,validSurfaces))
		var/temp = "rune"
		if(letters.Find(drawtype))
			temp = "letter"
		else if(graffiti.Find(drawtype))
			temp = "graffiti"

		////////////////////////// GANG FUNCTIONS
		var/area/territory
		var/gangID
		if(gang)
			//Determine gang affiliation
			gangID = user.mind.gang_datum

			//Check area validity. Reject space, player-created areas, and non-station z-levels.
			if(gangID)
				territory = get_area(target)
				if(territory && (territory.z == ZLEVEL_STATION) && territory.valid_territory)
					//Check if this area is already tagged by a gang
					if(!(locate(/obj/effect/decal/cleanable/crayon/gang) in target)) //Ignore the check if the tile being sprayed has a gang tag
						if(territory_claimed(territory, user))
							return
					if(locate(/obj/machinery/power/apc) in (user.loc.contents | target.contents))
						user << "<span class='warning'>You cannot tag here.</span>"
						return
				else
					user << "<span class='warning'>[territory] is unsuitable for tagging.</span>"
					return
		/////////////////////////////////////////

		var/graf_rot
		if(oriented.Find(drawtype))
			switch(user.dir)
				if(EAST)
					graf_rot = 90
				if(SOUTH)
					graf_rot = 180
				if(WEST)
					graf_rot = 270
				else
					graf_rot = 0

		user << "<span class='notice'>You start [instant ? "spraying" : "drawing"] a [temp] on the [target.name]...</span>"
		if(instant)
			playsound(user.loc, 'sound/effects/spray.ogg', 5, 1, 5)
		if((instant>0) || do_after(user, 50, target = target))

			//Gang functions
			if(gangID)
				//Delete any old markings on this tile, including other gang tags
				if(!(locate(/obj/effect/decal/cleanable/crayon/gang) in target)) //Ignore the check if the tile being sprayed has a gang tag
					if(territory_claimed(territory, user))
						return
				for(var/obj/effect/decal/cleanable/crayon/old_marking in target)
					qdel(old_marking)
				new /obj/effect/decal/cleanable/crayon/gang(target,gangID,"graffiti",graf_rot)
				user << "<span class='notice'>You tagged [territory] for your gang!</span>"

			else
				new /obj/effect/decal/cleanable/crayon(target,paint_color,drawtype,temp,graf_rot)

			user << "<span class='notice'>You finish [instant ? "spraying" : "drawing"] [temp].</span>"
			if(instant<0)
				playsound(user.loc, 'sound/effects/spray.ogg', 5, 1, 5)
			if(uses < 0)
				return
			uses = max(0,uses-1)
			if(!uses)
				user << "<span class='warning'>There is no more of [src.name] left!</span>"
				if(!instant)
					qdel(src)
	return

/obj/item/toy/crayon/attack(mob/M, mob/user)
	if(edible && (M == user))
		user << "You take a bite of the [src.name]. Delicious!"
		user.nutrition += 5
		if(uses < 0)
			return
		uses = max(0,uses-5)
		if(!uses)
			user << "<span class='warning'>There is no more of [src.name] left!</span>"
			qdel(src)
	else
		..()

/obj/item/toy/crayon/proc/territory_claimed(area/territory,mob/user)
	var/occupying_gang
	for(var/datum/gang/G in ticker.mode.gangs)
		if(territory.type in (G.territory|G.territory_new))
			occupying_gang = G.name
			break
	if(occupying_gang)
		user << "<span class='danger'>[territory] has already been tagged by the [occupying_gang] gang! You must get rid of or spray over the old tag first!</span>"
		return 1
	return 0

/*
 * Snap pops
 */

/obj/item/toy/snappop
	name = "snap pop"
	desc = "Wow!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "snappop"
	w_class = 1

/obj/item/toy/snappop/proc/pop_burst()
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	new /obj/effect/decal/cleanable/ash(loc)
	visible_message("<span class='warning'>The [src.name] explodes!</span>","<span class='italics'>You hear a snap!</span>")
	playsound(src, 'sound/effects/snap.ogg', 50, 1)
	qdel(src)

/obj/item/toy/snappop/fire_act()
	pop_burst()
	return

/obj/item/toy/snappop/throw_impact(atom/hit_atom)
	if(!..())
		pop_burst()


/obj/item/toy/snappop/Crossed(H as mob|obj)
	if((ishuman(H))) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(M.m_intent == "run")
			M << "<span class='danger'>You step on the snap pop!</span>"

			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(2, 0, src)
			s.start()
			new /obj/effect/decal/cleanable/ash(src.loc)
			src.visible_message("<span class='danger'>The [src.name] explodes!</span>","<span class='italics'>You hear a snap!</span>")
			playsound(src, 'sound/effects/snap.ogg', 50, 1)
			qdel(src)

/*
 * Mech prizes
 */
/obj/item/toy/prize
	icon = 'icons/obj/toy.dmi'
	icon_state = "ripleytoy"
	var/cooldown = 0
	var/quiet = 0

//all credit to skasi for toy mech fun ideas
/obj/item/toy/prize/attack_self(mob/user)
	if(!cooldown)
		user << "<span class='notice'>You play with [src].</span>"
		cooldown = 1
		spawn(30) cooldown = 0
		if (!quiet)
			playsound(user, 'sound/mecha/mechstep.ogg', 20, 1)
		return
	..()

/obj/item/toy/prize/attack_hand(mob/user)
	if(loc == user)
		if(!cooldown)
			user << "<span class='notice'>You play with [src].</span>"
			cooldown = 1
			spawn(30) cooldown = 0
			if (!quiet)
				playsound(user, 'sound/mecha/mechturn.ogg', 20, 1)
			return
	..()

/obj/item/toy/prize/ripley
	name = "toy Ripley"
	desc = "Mini-Mecha action figure! Collect them all! 1/12."

/obj/item/toy/prize/fireripley
	name = "toy firefighting Ripley"
	desc = "Mini-Mecha action figure! Collect them all! 2/12."
	icon_state = "fireripleytoy"

/obj/item/toy/prize/deathripley
	name = "toy deathsquad Ripley"
	desc = "Mini-Mecha action figure! Collect them all! 3/12."
	icon_state = "deathripleytoy"

/obj/item/toy/prize/gygax
	name = "toy Gygax"
	desc = "Mini-Mecha action figure! Collect them all! 4/12."
	icon_state = "gygaxtoy"

/obj/item/toy/prize/durand
	name = "toy Durand"
	desc = "Mini-Mecha action figure! Collect them all! 5/12."
	icon_state = "durandprize"

/obj/item/toy/prize/honk
	name = "toy H.O.N.K."
	desc = "Mini-Mecha action figure! Collect them all! 6/12."
	icon_state = "honkprize"

/obj/item/toy/prize/marauder
	name = "toy Marauder"
	desc = "Mini-Mecha action figure! Collect them all! 7/12."
	icon_state = "marauderprize"

/obj/item/toy/prize/seraph
	name = "toy Seraph"
	desc = "Mini-Mecha action figure! Collect them all! 8/12."
	icon_state = "seraphprize"

/obj/item/toy/prize/mauler
	name = "toy Mauler"
	desc = "Mini-Mecha action figure! Collect them all! 9/12."
	icon_state = "maulerprize"

/obj/item/toy/prize/odysseus
	name = "toy Odysseus"
	desc = "Mini-Mecha action figure! Collect them all! 10/12."
	icon_state = "odysseusprize"

/obj/item/toy/prize/phazon
	name = "toy Phazon"
	desc = "Mini-Mecha action figure! Collect them all! 11/12."
	icon_state = "phazonprize"

/obj/item/toy/prize/reticence
	name = "toy Reticence"
	desc = "Mini-Mecha action figure! Collect them all! 12/12."
	icon_state = "reticenceprize"
	quiet = 1

/*
 * AI core prizes
 */
/obj/item/toy/AI
	name = "toy AI"
	desc = "A little toy model AI core with real law announcing action!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "AI"
	w_class = 2
	var/cooldown = 0

/obj/item/toy/AI/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = generate_ion_law()
		user << "<span class='notice'>You press the button on [src].</span>"
		playsound(user, 'sound/machines/click.ogg', 20, 1)
		src.loc.visible_message("<span class='danger'>\icon[src] [message]</span>")
		cooldown = 1
		spawn(30) cooldown = 0
		return
	..()

/obj/item/toy/owl
	name = "owl action figure"
	desc = "An action figure modeled after 'The Owl', defender of justice."
	icon = 'icons/obj/toy.dmi'
	icon_state = "owlprize"
	w_class = 2
	var/cooldown = 0

/obj/item/toy/owl/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = pick("You won't get away this time, Griffin!", "Stop right there, criminal!", "Hoot! Hoot!", "I am the night!")
		user << "<span class='notice'>You pull the string on the [src].</span>"
		playsound(user, 'sound/machines/click.ogg', 20, 1)
		src.loc.visible_message("<span class='danger'>\icon[src] [message]</span>")
		cooldown = 1
		spawn(30) cooldown = 0
		return
	..()

/obj/item/toy/griffin
	name = "griffin action figure"
	desc = "An action figure modeled after 'The Griffin', criminal mastermind."
	icon = 'icons/obj/toy.dmi'
	icon_state = "griffinprize"
	w_class = 2
	var/cooldown = 0

/obj/item/toy/griffin/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = pick("You can't stop me, Owl!", "My plan is flawless! The vault is mine!", "Caaaawwww!", "You will never catch me!")
		user << "<span class='notice'>You pull the string on the [src].</span>"
		playsound(user, 'sound/machines/click.ogg', 20, 1)
		src.loc.visible_message("<span class='danger'>\icon[src] [message]</span>")
		cooldown = 1
		spawn(30) cooldown = 0
		return
	..()

/*
/obj/item/toy/meme
	name = "Mini Atarime"
	desc = "An action figure modeled after 'Marie Atarime', Who the fuck made this."
	icon = 'icons/obj/toy.dmi'
	icon_state = "marie"
	w_class = 2
	var/cooldown = 0
/
/obj/item/toy/meme/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = pick("Memes.", "You're pretty good.","OH GOD MY STRING WHY WOULD YOU DO THIS TO ME OH GO-oh here it comes.", "YORE DED FREEMAN!", "I USED TO PLAY COLLEGE BALL, Y'KNOW.", "HELLO MY NAME IS MARIE ATARIME", "Hey, that's pretty good.", "CAT BOIS REPRESENT", " I'M FUCKING INVINCABLE!", "RIGHT ARM RULE! Wait... FUCK!", "LEFT ARM RULE!", "Lorentz force! GO!", "Only love is with us now! Something warm and pure! Find the peace within our selves, No need for a cure!", "The world calls for wetwork! And we answer!", " OH YEAH, AND FROM THIS DAY FORWARD WE WILL REMEBER THE DAY OF THE RED SUN! THE DAY WHEN MANKIND GAVE WAR A CHANCE!!", " The demand for PMCs will sky rocket LIKE THE GOOD OLD DAYS AFTER 9-11!!", "ET IS DA BAEHNBLADE!!", "I can stand being around you!", "Theres nothing wrong with a good ol dick once in awhile.", "I'LL GRIND YOU INTO D-actually wait. Er. Nevermind. That sounded better in my head.", "SELF ESTEEM TEAM! GOOOOOOO!! MEEOOOOW!", "ASHES TO ASHES, MOTHERFUCKER!!!", "DOKTOR, DISABLE MY PAIN INHIBTORS!!", "And if you see Doctor Breen, Tell him I said, Fuck you!", " WE ARE ALL PAWNS. CONTROLLED BY SOMETHING GREATER! MEMES, THE DNA OF THE SOUL!", "i feel like shit", "i just took a shit, i feel great", "S-Senpai, T-Touch my s-string more!~", "FUCK PYRO THAT FUCKING FURRY", "So um... [user] Psst. Um like. If you see uh, Rylie, can you call them a methrat? Kay, thanks man.", "DEHUMANIZE YOURSELF AND FACE TO BLOODSHED", "Toy soldiers Unite!", "Doctor Steel, Doctor Steel!", "Aw shit, this is just like Doom!", "Holy shit, this shotgun is straight outta doom.", "Jet fuel can't melt steel memes", " Hey uh... [user].  Um... So like uh. Hoooow are you?", " Holy shit [user], this is like the ol fuckin automemer. Like shit.", "We live in a world full of despair. A world full of war, hunger, and fear. It is a very unhappy place indeed. I envision a world where the top priority of its people... is to have fun. But we spend our lives in office buildings. Behind cash registers. Stuck in traffic jams. All the while wishing we were somewhere else, doing something else.", "We are a people manipulated through fear. And though that is a tried and true method of control, it also generates feelings of hate, violence, and leaves us with feelings of despair, with no constructive focus in life. The time has come for a change. The time has come to make this world a better place.", "SON OF A BITCH!", "Hey, you ever wonder why we're here?", "Come in, Blue Command. This is Blood Gulch Outpost Alpha. Do you read me?", "Marie Atarime says, 'Atarime (Windows 098): MEMERIE ATARIME: Fuck the forth wall.", "Hey, maybe we should hold hands.", "For a brick, he flew pretty good!", "Doctor Pavel? I'm CIA.", "Dear humanity. We regret being alien bastards. We regret coming to Earth. And we most definitely regret the Corps just blew up our raggedy-ass fleet!", "ODST Heading Downtown.", "Helljumpers are in the tubes.", "MAC, Firing.", "Target Locked; Firing Main cannon.", "Here comes the Maxium Overdrive!", "Grizzly, Awaiting orders!", "This is ground control to Major tom, Can you hear me, Major tom?", "Young Girl, They called them the Diamond Dogs!", "Do you know exactly what your family would do if an attack came? Say at, Ten oclock tommorow morning.", "Spirit to Forge, get your men up here this instant!", "The unenlighted masses! They cannot make the judgement call!", "The world doesn't need a manager, or a boss, or a policeman. These aren't the heroes of today. The heroes of today are those who are doing what they want to be doing, having a good time, and introducing the one thing that every man, woman and child hungers for on a daily basis: happiness.", "I am... crazy. It's official. There's paperwork on it: there's graphs and everything, so it must be true. And let me tell you, it's a real load off of my mind. I mean, it relieves a lot of responsibility for me!", "People seem to be allergic to just about everything. And we have to sleep. That takes up far too much of my time. And we have to eat, and poop. Humanity: The pinnacle of evolution? NO! A work in progress! We're still in the prototype phase. We're still working out all the bugs.", "Fulton recovery confirmed onboard helicopter.", "You're going to extract HIM?", "He didn't fly so good!", "I won't spread your sorrow to the heartless sea. I will always be with you.", "Rule one. I am ALWAYS with the syndicate. Even when theres no syndicate. Deep down. I always am.", "I am the EDGIEST PERSON THIS SIDE OF THE UNIVERSE." , "Hey, [user], You've been picked for the Annual Atarime rewards! Just give me your mothers maiden name, and your PIN number and we'll send it packing your way!", "TAKE OFF EVERY 'ZIG'!!", "you will all taste oblivion! Which tastes just like Red Bull... which is disgusting!", "SORRY, FOLKS! THE OLD PROGRAM'S BEEN CANCELED! BUT WE'VE GOT A FINALE THAT'LL DRIVE YOU WILD! REAL ACTION! REAL DRAMA! REAL BLOODSHED! ON OUR NEW SHOW ... ATTACK OF THE KILLER MEMES!", "I swear someone keeps fucking with the sights on these when I'm not looking.", "Californnnaa, Rest in peaaaaaaaaaace.", "Shit man I LOVE me some snowflake code lemme tell ya.", "[user] Us toys... See EVERYTHING.", "It's a pleasure to be in your Iron grip, Boss!", "Hey... [user.ckey]...? Why do you never talk to me? You just... pull my string.", "So, [user.ckey]. You think I haven't noticed you watching everything going on here?", "Heh, [user.ckey]. Y'know, controlling everything like this. Controlling lives and such. That's just not right, man. You have your own existance to fufill.")
		user << "<span class='notice'>You pull the string on the [src].</span>"
		playsound(user, 'sound/machines/click.ogg', 20, 1)
		src.loc.visible_message("<span class='danger'>\icon[src] [message]</span>")
		cooldown = 1
		spawn(30) cooldown = 0
//change a stupid snowflake toy because TK asked for it and I have nothing to do with my life
*/

/*
|| A Deck of Cards for playing various games of chance ||
*/



/obj/item/toy/cards
	burn_state = 0 //Burnable
	burntime = 5
	var/parentdeck = null
	var/deckstyle = "nanotrasen"
	var/card_hitsound = null
	var/card_force = 0
	var/card_throwforce = 0
	var/card_throw_speed = 3
	var/card_throw_range = 7
	var/list/card_attack_verb = list("attacked")

/obj/item/toy/cards/New()
	..()

/obj/item/toy/cards/proc/apply_card_vars(obj/item/toy/cards/newobj, obj/item/toy/cards/sourceobj) // Applies variables for supporting multiple types of card deck
	if(!istype(sourceobj))
		return

/obj/item/toy/cards/deck
	name = "deck of cards"
	desc = "A deck of space-grade playing cards."
	icon = 'icons/obj/toy.dmi'
	deckstyle = "nanotrasen"
	icon_state = "deck_nanotrasen_full"
	w_class = 2
	var/cooldown = 0
	var/obj/machinery/computer/holodeck/holo = null // Holodeck cards should not be infinite
	var/list/cards = list()

/obj/item/toy/cards/deck/New()
	..()
	icon_state = "deck_[deckstyle]_full"
	for(var/i = 2; i <= 10; i++)
		cards += "[i] of Hearts"
		cards += "[i] of Spades"
		cards += "[i] of Clubs"
		cards += "[i] of Diamonds"
	cards += "King of Hearts"
	cards += "King of Spades"
	cards += "King of Clubs"
	cards += "King of Diamonds"
	cards += "Queen of Hearts"
	cards += "Queen of Spades"
	cards += "Queen of Clubs"
	cards += "Queen of Diamonds"
	cards += "Jack of Hearts"
	cards += "Jack of Spades"
	cards += "Jack of Clubs"
	cards += "Jack of Diamonds"
	cards += "Ace of Hearts"
	cards += "Ace of Spades"
	cards += "Ace of Clubs"
	cards += "Ace of Diamonds"


/obj/item/toy/cards/deck/attack_hand(mob/user)
	if(user.lying)
		return
	var/choice = null
	if(cards.len == 0)
		src.icon_state = "deck_[deckstyle]_empty"
		user << "<span class='warning'>There are no more cards to draw!</span>"
		return
	var/obj/item/toy/cards/singlecard/H = new/obj/item/toy/cards/singlecard(user.loc)
	if(holo)
		holo.spawned += H // track them leaving the holodeck
	choice = cards[1]
	H.cardname = choice
	H.parentdeck = src
	var/O = src
	H.apply_card_vars(H,O)
	src.cards -= choice
	H.pickup(user)
	user.put_in_active_hand(H)
	user.visible_message("[user] draws a card from the deck.", "<span class='notice'>You draw a card from the deck.</span>")
	if(cards.len > 26)
		src.icon_state = "deck_[deckstyle]_full"
	else if(cards.len > 10)
		src.icon_state = "deck_[deckstyle]_half"
	else if(cards.len > 1)
		src.icon_state = "deck_[deckstyle]_low"

/obj/item/toy/cards/deck/attack_self(mob/user)
	if(cooldown < world.time - 50)
		cards = shuffle(cards)
		playsound(user, 'sound/items/cardshuffle.ogg', 50, 1)
		user.visible_message("[user] shuffles the deck.", "<span class='notice'>You shuffle the deck.</span>")
		cooldown = world.time

/obj/item/toy/cards/deck/attackby(obj/item/toy/cards/singlecard/C, mob/living/user, params)
	..()
	if(istype(C))
		if(C.parentdeck == src)
			if(!user.unEquip(C))
				user << "<span class='warning'>The card is stuck to your hand, you can't add it to the deck!</span>"
				return
			src.cards += C.cardname
			user.visible_message("[user] adds a card to the bottom of the deck.","<span class='notice'>You add the card to the bottom of the deck.</span>")
			qdel(C)
		else
			user << "<span class='warning'>You can't mix cards from other decks!</span>"
		if(cards.len > 26)
			src.icon_state = "deck_[deckstyle]_full"
		else if(cards.len > 10)
			src.icon_state = "deck_[deckstyle]_half"
		else if(cards.len > 1)
			src.icon_state = "deck_[deckstyle]_low"


/obj/item/toy/cards/deck/attackby(obj/item/toy/cards/cardhand/C, mob/living/user, params)
	..()
	if(istype(C))
		if(C.parentdeck == src)
			if(!user.unEquip(C))
				user << "<span class='warning'>The hand of cards is stuck to your hand, you can't add it to the deck!</span>"
				return
			src.cards += C.currenthand
			user.visible_message("[user] puts their hand of cards in the deck.", "<span class='notice'>You put the hand of cards in the deck.</span>")
			qdel(C)
		else
			user << "<span class='warning'>You can't mix cards from other decks!</span>"
		if(cards.len > 26)
			src.icon_state = "deck_[deckstyle]_full"
		else if(cards.len > 10)
			src.icon_state = "deck_[deckstyle]_half"
		else if(cards.len > 1)
			src.icon_state = "deck_[deckstyle]_low"

/obj/item/toy/cards/deck/MouseDrop(atom/over_object)
	var/mob/M = usr
	if(!ishuman(usr) || usr.incapacitated() || usr.lying)
		return
	if(Adjacent(usr))
		if(over_object == M && loc != M)
			M.put_in_hands(src)
			usr << "<span class='notice'>You pick up the deck.</span>"

		else if(istype(over_object, /obj/screen))
			switch(over_object.name)
				if("l_hand")
					if(!remove_item_from_storage(M))
						M.unEquip(src)
					M.put_in_l_hand(src)
				else if("r_hand")
					if(!remove_item_from_storage(M))
						M.unEquip(src)
					M.put_in_r_hand(src)
				usr << "<span class='notice'>You pick up the deck.</span>"
	else
		usr << "<span class='warning'>You can't reach it from here!</span>"



/obj/item/toy/cards/cardhand
	name = "hand of cards"
	desc = "A number of cards not in a deck, customarily held in ones hand."
	icon = 'icons/obj/toy.dmi'
	icon_state = "nanotrasen_hand2"
	w_class = 1
	var/list/currenthand = list()
	var/choice = null


/obj/item/toy/cards/cardhand/attack_self(mob/user)
	user.set_machine(src)
	interact(user)

/obj/item/toy/cards/cardhand/interact(mob/user)
	var/dat = "You have:<BR>"
	for(var/t in currenthand)
		dat += "<A href='?src=\ref[src];pick=[t]'>A [t].</A><BR>"
	dat += "Which card will you remove next?"
	var/datum/browser/popup = new(user, "cardhand", "Hand of Cards", 400, 240)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.set_content(dat)
	popup.open()


/obj/item/toy/cards/cardhand/Topic(href, href_list)
	if(..())
		return
	if(usr.stat || !ishuman(usr) || !usr.canmove)
		return
	var/mob/living/carbon/human/cardUser = usr
	var/O = src
	if(href_list["pick"])
		if (cardUser.get_item_by_slot(slot_l_hand) == src || cardUser.get_item_by_slot(slot_r_hand) == src)
			var/choice = href_list["pick"]
			var/obj/item/toy/cards/singlecard/C = new/obj/item/toy/cards/singlecard(cardUser.loc)
			src.currenthand -= choice
			C.parentdeck = src.parentdeck
			C.cardname = choice
			C.apply_card_vars(C,O)
			C.pickup(cardUser)
			cardUser.put_in_any_hand_if_possible(C)
			cardUser.visible_message("<span class='notice'>[cardUser] draws a card from \his hand.</span>", "<span class='notice'>You take the [C.cardname] from your hand.</span>")

			interact(cardUser)
			if(src.currenthand.len < 3)
				src.icon_state = "[deckstyle]_hand2"
			else if(src.currenthand.len < 4)
				src.icon_state = "[deckstyle]_hand3"
			else if(src.currenthand.len < 5)
				src.icon_state = "[deckstyle]_hand4"
			if(src.currenthand.len == 1)
				var/obj/item/toy/cards/singlecard/N = new/obj/item/toy/cards/singlecard(src.loc)
				N.parentdeck = src.parentdeck
				N.cardname = src.currenthand[1]
				N.apply_card_vars(N,O)
				cardUser.unEquip(src)
				N.pickup(cardUser)
				cardUser.put_in_any_hand_if_possible(N)
				cardUser << "<span class='notice'>You also take [currenthand[1]] and hold it.</span>"
				cardUser << browse(null, "window=cardhand")
				qdel(src)
		return

/obj/item/toy/cards/cardhand/attackby(obj/item/toy/cards/singlecard/C, mob/living/user, params)
	if(istype(C))
		if(C.parentdeck == src.parentdeck)
			src.currenthand += C.cardname
			user.unEquip(C)
			user.visible_message("[user] adds a card to their hand.", "<span class='notice'>You add the [C.cardname] to your hand.</span>")
			interact(user)
			if(currenthand.len > 4)
				src.icon_state = "[deckstyle]_hand5"
			else if(currenthand.len > 3)
				src.icon_state = "[deckstyle]_hand4"
			else if(currenthand.len > 2)
				src.icon_state = "[deckstyle]_hand3"
			qdel(C)
		else
			user << "<span class='warning'>You can't mix cards from other decks!</span>"

/obj/item/toy/cards/cardhand/apply_card_vars(obj/item/toy/cards/newobj,obj/item/toy/cards/sourceobj)
	..()
	newobj.deckstyle = sourceobj.deckstyle
	newobj.icon_state = "[deckstyle]_hand2" // Another dumb hack, without this the hand is invisible (or has the default deckstyle) until another card is added.
	newobj.card_hitsound = sourceobj.card_hitsound
	newobj.card_force = sourceobj.card_force
	newobj.card_throwforce = sourceobj.card_throwforce
	newobj.card_throw_speed = sourceobj.card_throw_speed
	newobj.card_throw_range = sourceobj.card_throw_range
	newobj.card_attack_verb = sourceobj.card_attack_verb
	if(sourceobj.burn_state == -1)
		newobj.burn_state = -1

/obj/item/toy/cards/singlecard
	name = "card"
	desc = "a card"
	icon = 'icons/obj/toy.dmi'
	icon_state = "singlecard_nanotrasen_down"
	w_class = 1
	var/cardname = null
	var/flipped = 0
	pixel_x = -5


/obj/item/toy/cards/singlecard/examine(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/cardUser = user
		if(cardUser.get_item_by_slot(slot_l_hand) == src || cardUser.get_item_by_slot(slot_r_hand) == src)
			cardUser.visible_message("[cardUser] checks \his card.", "<span class='notice'>The card reads: [src.cardname]</span>")
		else
			cardUser << "<span class='warning'>You need to have the card in your hand to check it!</span>"


/obj/item/toy/cards/singlecard/verb/Flip()
	set name = "Flip Card"
	set category = "Object"
	set src in range(1)
	if(usr.stat || !ishuman(usr) || !usr.canmove || usr.restrained())
		return
	if(!flipped)
		src.flipped = 1
		if (cardname)
			src.icon_state = "sc_[cardname]_[deckstyle]"
			src.name = src.cardname
		else
			src.icon_state = "sc_Ace of Spades_[deckstyle]"
			src.name = "What Card"
		src.pixel_x = 5
	else if(flipped)
		src.flipped = 0
		src.icon_state = "singlecard_down_[deckstyle]"
		src.name = "card"
		src.pixel_x = -5

/obj/item/toy/cards/singlecard/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/cards/singlecard/))
		var/obj/item/toy/cards/singlecard/C = I
		if(C.parentdeck == src.parentdeck)
			var/obj/item/toy/cards/cardhand/H = new/obj/item/toy/cards/cardhand(user.loc)
			H.currenthand += C.cardname
			H.currenthand += src.cardname
			H.parentdeck = C.parentdeck
			H.apply_card_vars(H,C)
			user.unEquip(C)
			H.pickup(user)
			user.put_in_active_hand(H)
			user << "<span class='notice'>You combine the [C.cardname] and the [src.cardname] into a hand.</span>"
			qdel(C)
			qdel(src)
		else
			user << "<span class='warning'>You can't mix cards from other decks!</span>"

	if(istype(I, /obj/item/toy/cards/cardhand/))
		var/obj/item/toy/cards/cardhand/H = I
		if(H.parentdeck == parentdeck)
			H.currenthand += cardname
			user.unEquip(src)
			user.visible_message("[user] adds a card to \his hand.", "<span class='notice'>You add the [cardname] to your hand.</span>")
			H.interact(user)
			if(H.currenthand.len > 4)
				H.icon_state = "[deckstyle]_hand5"
			else if(H.currenthand.len > 3)
				H.icon_state = "[deckstyle]_hand4"
			else if(H.currenthand.len > 2)
				H.icon_state = "[deckstyle]_hand3"
			qdel(src)
		else
			user << "<span class='warning'>You can't mix cards from other decks!</span>"


/obj/item/toy/cards/singlecard/attack_self(mob/user)
	if(usr.stat || !ishuman(usr) || !usr.canmove || usr.restrained())
		return
	Flip()

/obj/item/toy/cards/singlecard/apply_card_vars(obj/item/toy/cards/singlecard/newobj,obj/item/toy/cards/sourceobj)
	..()
	newobj.deckstyle = sourceobj.deckstyle
	newobj.icon_state = "singlecard_down_[deckstyle]" // Without this the card is invisible until flipped. It's an ugly hack, but it works.
	newobj.card_hitsound = sourceobj.card_hitsound
	newobj.hitsound = newobj.card_hitsound
	newobj.card_force = sourceobj.card_force
	newobj.force = newobj.card_force
	newobj.card_throwforce = sourceobj.card_throwforce
	newobj.throwforce = newobj.card_throwforce
	newobj.card_throw_speed = sourceobj.card_throw_speed
	newobj.throw_speed = newobj.card_throw_speed
	newobj.card_throw_range = sourceobj.card_throw_range
	newobj.throw_range = newobj.card_throw_range
	newobj.card_attack_verb = sourceobj.card_attack_verb
	newobj.attack_verb = newobj.card_attack_verb


/*
|| Syndicate playing cards, for pretending you're Gambit and playing poker for the nuke disk. ||
*/

/obj/item/toy/cards/deck/syndicate
	name = "suspicious looking deck of cards"
	desc = "A deck of space-grade playing cards. They seem unusually rigid."
	deckstyle = "syndicate"
	card_hitsound = 'sound/weapons/bladeslice.ogg'
	card_force = 5
	card_throwforce = 10
	card_throw_speed = 3
	card_throw_range = 7
	card_attack_verb = list("attacked", "sliced", "diced", "slashed", "cut")
	burn_state = -1 //Not Burnable

/*
 * Fake nuke
 */

/obj/item/toy/nuke
	name = "\improper Nuclear Fission Explosive toy"
	desc = "A plastic model of a Nuclear Fission Explosive."
	icon = 'icons/obj/toy.dmi'
	icon_state = "nuketoyidle"
	w_class = 2
	var/cooldown = 0

/obj/item/toy/nuke/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = world.time + 1800 //3 minutes
		user.visible_message("<span class='warning'>[user] presses a button on [src].</span>", "<span class='notice'>You activate [src], it plays a loud noise!</span>", "<span class='italics'>You hear the click of a button.</span>")
		spawn(5) //gia said so
			icon_state = "nuketoy"
			playsound(src, 'sound/machines/Alarm.ogg', 100, 0, surround = 0)
			sleep(135)
			icon_state = "nuketoycool"
			sleep(cooldown - world.time)
			icon_state = "nuketoyidle"
	else
		var/timeleft = (cooldown - world.time)
		user << "<span class='alert'>Nothing happens, and '</span>[round(timeleft/10)]<span class='alert'>' appears on a small display.</span>"

/*
 * Fake meteor
 */

/obj/item/toy/minimeteor
	name = "\improper Mini-Meteor"
	desc = "Relive the excitement of a meteor shower! SweetMeat-eor. Co is not responsible for any injuries, headaches or hearing loss caused by Mini-Meteor?"
	icon = 'icons/obj/toy.dmi'
	icon_state = "minimeteor"
	w_class = 2

/obj/item/toy/minimeteor/throw_impact(atom/hit_atom)
	if(!..())
		playsound(src, 'sound/effects/meteorimpact.ogg', 40, 1)
		for(var/mob/M in ultra_range(10, src))
			if(!M.stat && !istype(M, /mob/living/silicon/ai))\
				shake_camera(M, 3, 1)
		qdel(src)

/*
 * Carp plushie
 */

/obj/item/toy/carpplushie
	name = "space carp plushie"
	desc = "An adorable stuffed toy that resembles a space carp."
	icon = 'icons/obj/toy.dmi'
	icon_state = "carpplushie"
	w_class = 2
	attack_verb = list("bitten", "eaten", "fin slapped")
	burn_state = 0 //Burnable
	var/bitesound = 'sound/weapons/bite.ogg'

//Attack mob
/obj/item/toy/carpplushie/attack(mob/M, mob/user)
	playsound(loc, bitesound, 20, 1)	//Play bite sound in local area
	return ..()

//Attack self
/obj/item/toy/carpplushie/attack_self(mob/user)
	playsound(src.loc, bitesound, 20, 1)
	user << "<span class='notice'>You pet [src]. D'awww.</span>"
	return ..()

/*
 * Toy big red button
 */
/obj/item/toy/redbutton
	name = "big red button"
	desc = "A big, plastic red button. Reads 'From HonkCo Pranks?' on the back."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "bigred"
	w_class = 2
	var/cooldown = 0

/obj/item/toy/redbutton/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = (world.time + 300) // Sets cooldown at 30 seconds
		user.visible_message("<span class='warning'>[user] presses the big red button.</span>", "<span class='notice'>You press the button, it plays a loud noise!</span>", "<span class='italics'>The button clicks loudly.</span>")
		playsound(src, 'sound/effects/explosionfar.ogg', 50, 0, surround = 0)
		for(var/mob/M in ultra_range(10, src)) // Checks range
			if(!M.stat && !istype(M, /mob/living/silicon/ai)) // Checks to make sure whoever's getting shaken is alive/not the AI
				sleep(8) // Short delay to match up with the explosion sound
				shake_camera(M, 2, 1) // Shakes player camera 2 squares for 1 second.

	else
		user << "<span class='alert'>Nothing happens.</span>"

/*
 * Beach ball
 */
/obj/item/toy/beach_ball
	icon = 'icons/misc/beach.dmi'
	icon_state = "ball"
	name = "beach ball"
	item_state = "beachball"
	w_class = 4 //Stops people from hiding it in their bags/pockets

/obj/item/toy/beach_ball/afterattack(atom/target as mob|obj|turf|area, mob/user)
	user.drop_item()
	src.throw_at(target, throw_range, throw_speed)

/*
 * Xenomorph action figure
 */

/obj/item/toy/toy_xeno
	icon = 'icons/obj/toy.dmi'
	icon_state = "toy_xeno"
	name = "xenomorph action figure"
	desc = "MEGA presents the new Xenos Isolated action figure! Comes complete with realistic sounds! Pull back string to use."
	w_class = 2
	var/cooldown = 0

/obj/item/toy/toy_xeno/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 50) //5 second cooldown
		user.visible_message("<span class='notice'>[user] pulls back the string on [src].</span>")
		icon_state = "[initial(icon_state)]_used"
		sleep(5)
		audible_message("<span class='danger'>\icon[src] Hiss!</span>")
		var/list/possible_sounds = list('sound/voice/hiss1.ogg', 'sound/voice/hiss2.ogg', 'sound/voice/hiss3.ogg', 'sound/voice/hiss4.ogg')
		var/chosen_sound = pick(possible_sounds)
		playsound(get_turf(src), chosen_sound, 50, 1)
		spawn(45)
			if(src)
				icon_state = "[initial(icon_state)]"
	else
		user << "<span class='warning'>The string on [src] hasn't rewound all the way!</span>"
		return

// TOY MOUSEYS :3 :3 :3

/obj/item/toy/cattoy
	name = "toy mouse"
	desc = "A colorful toy mouse!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "toy_mouse"
	w_class = 2.0
	var/cooldown = 0

//Donation item from Chokin and Tokin
/obj/item/toy/cattoygreen
	name = "toy mouse"
	desc = "A colorful toy mouse!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "toy_mouseg"
	w_class = 2.0
	var/cooldown = 0



/*
 * Action Figures
 */

/obj/item/toy/figure
	name = "Non-Specific Action Figure action figure"
	desc = null
	icon = 'icons/obj/toy.dmi'
	icon_state = "nuketoy"
	var/cooldown = 0
	var/toysay = "What the fuck did you do?"

/obj/item/toy/figure/New()
    desc = "A \"Space Life\" brand [src]."

/obj/item/toy/figure/attack_self(mob/user as mob)
	if(cooldown <= world.time)
		cooldown = world.time + 50
		user << "<span class='notice'>The [src] says \"[toysay]\"</span>"
		playsound(user, 'sound/machines/click.ogg', 20, 1)

/obj/item/toy/figure/cmo
	name = "Chief Medical Officer action figure"
	icon_state = "cmo"
	toysay = "Suit sensors!"

/obj/item/toy/figure/assistant
	name = "Assistant action figure"
	icon_state = "assistant"
	toysay = "Grey tide world wide!"

/obj/item/toy/figure/atmos
	name = "Atmospheric Technician action figure"
	icon_state = "atmos"
	toysay = "Glory to Atmosia!"

/obj/item/toy/figure/bartender
	name = "Bartender action figure"
	icon_state = "bartender"
	toysay = "Where is Pun Pun?"

/obj/item/toy/figure/borg
	name = "Cyborg action figure"
	icon_state = "borg"
	toysay = "I. LIVE. AGAIN."

/obj/item/toy/figure/botanist
	name = "Botanist action figure"
	icon_state = "botanist"
	toysay = "Dude, I see colors..."

/obj/item/toy/figure/captain
	name = "Captain action figure"
	icon_state = "captain"
	toysay = "Any heads of staff?"

/obj/item/toy/figure/cargotech
	name = "Cargo Technician action figure"
	icon_state = "cargotech"
	toysay = "For Cargonia!"

/obj/item/toy/figure/ce
	name = "Chief Engineer action figure"
	icon_state = "ce"
	toysay = "Wire the solars!"

/obj/item/toy/figure/chaplain
	name = "Chaplain action figure"
	icon_state = "chaplain"
	toysay = "Praise Space Jesus!"

/obj/item/toy/figure/chef
	name = "Chef action figure"
	icon_state = "chef"
	toysay = "Pun-Pun is a tasty burger."

/obj/item/toy/figure/chemist
	name = "Chemist action figure"
	icon_state = "chemist"
	toysay = "Get your pills!"

/obj/item/toy/figure/clown
	name = "Clown action figure"
	icon_state = "clown"
	toysay = "Honk!"

/obj/item/toy/figure/ian
	name = "Ian action figure"
	icon_state = "ian"
	toysay = "Arf!"

/obj/item/toy/figure/detective
	name = "Detective action figure"
	icon_state = "detective"
	toysay = "This airlock has grey jumpsuit and insulated glove fibers on it."

/obj/item/toy/figure/dsquad
	name = "Death Squad Officer action figure"
	icon_state = "dsquad"
	toysay = "Eliminate all threats!"

/obj/item/toy/figure/engineer
	name = "Engineer action figure"
	icon_state = "engineer"
	toysay = "Oh god, the singularity is loose!"

/obj/item/toy/figure/geneticist
	name = "Geneticist action figure"
	icon_state = "geneticist"
	toysay = "Smash!"

/obj/item/toy/figure/hop
	name = "Head of Personel action figure"
	icon_state = "hop"
	toysay = "Giving out all access!"

/obj/item/toy/figure/hos
	name = "Head of Security action figure"
	icon_state = "hos"
	toysay = "Get the justice chamber ready, I think we got a joker here."

/obj/item/toy/figure/qm
	name = "Quartermaster action figure"
	icon_state = "qm"
	toysay = "Please sign this form in triplicate and we will see about geting you a welding mask within 3 business days."

/obj/item/toy/figure/janitor
	name = "Janitor action figure"
	icon_state = "janitor"
	toysay = "Look at the signs, you idiot."

/obj/item/toy/figure/lawyer
	name = "Lawyer action figure"
	icon_state = "lawyer"
	toysay = "My client is a dirty traitor!"

/obj/item/toy/figure/librarian
	name = "Librarian action figure"
	icon_state = "librarian"
	toysay = "One day while..."

/obj/item/toy/figure/md
	name = "Medical Doctor action figure"
	icon_state = "md"
	toysay = "The patient is already dead!"

/obj/item/toy/figure/mime
	name = "Mime action figure"
	icon_state = "mime"
	toysay = "..."

/obj/item/toy/figure/miner
	name = "Shaft Miner action figure"
	icon_state = "miner"
	toysay = "Oh god it's eating my intestines!"

/obj/item/toy/figure/ninja
	name = "Ninja action figure"
	icon_state = "ninja"
	toysay = "Oh god! Stop shooting, I'm friendly!"

/obj/item/toy/figure/wizard
	name = "Wizard action figure"
	icon_state = "wizard"
	toysay = "Ei Nath!"

/obj/item/toy/figure/rd
	name = "Research Director action figure"
	icon_state = "rd"
	toysay = "Blowing all of the borgs!"

/obj/item/toy/figure/roboticist
	name = "Roboticist action figure"
	icon_state = "roboticist"
	toysay = "Big stompy mechs!"

/obj/item/toy/figure/scientist
	name = "Scientist action figure"
	icon_state = "scientist"
	toysay = "For science!"

/obj/item/toy/figure/syndie
	name = "Nuclear Operative action figure"
	icon_state = "syndie"
	toysay = "Get that fucking disk!"

/obj/item/toy/figure/secofficer
	name = "Security Officer action figure"
	icon_state = "secofficer"
	toysay = "I am the law!"

/obj/item/toy/figure/virologist
	name = "Virologist action figure"
	icon_state = "virologist"
	toysay = "The cure is potassium!"

/obj/item/toy/figure/warden
	name = "Warden action figure"
	icon_state = "warden"
	toysay = "Seventeen minutes for coughing at an officer!"

/obj/item/toy/plushie
	name = "plushie"
	desc = "An adorable, soft, and cuddly plushie."
	icon = 'icons/obj/toy.dmi'
	var/poof_sound = 'sound/weapons/thudswoosh.ogg'
	attack_verb = list("poofed", "bopped", "whapped","cuddled","fluffed")

/obj/item/toy/plushie/attack_self(mob/user as mob)
	var/cuddle_verb = pick("hugs","cuddles","snugs")
	user.visible_message("<span class='notice'>[user] [cuddle_verb] the [src].</span>")

/obj/random/plushie
	name = "Random Plushie"
	desc = "This is a random plushie"
	icon = 'icons/obj/toy.dmi'
	icon_state = "redfox"

/obj/item/toy/plushie/corgi
	name = "corgi plushie"
	icon_state = "corgi"

/obj/item/toy/plushie/girly_corgi
	name = "corgi plushie"
	icon_state = "girlycorgi"

/obj/item/toy/plushie/robo_corgi
	name = "borgi plushie"
	icon_state = "robotcorgi"

/obj/item/toy/plushie/octopus
	name = "octopus plushie"
	icon_state = "loveable"

/obj/item/toy/plushie/face_hugger
	name = "facehugger plushie"
	icon_state = "huggable"

//foxes are basically the best

/obj/item/toy/plushie/red_fox
	name = "red fox plushie"
	icon_state = "redfox"

/obj/item/toy/plushie/black_fox
	name = "black fox plushie"
	icon_state = "blackfox"

/obj/item/toy/plushie/marble_fox
	name = "marble fox plushie"
	icon_state = "marblefox"

/obj/item/toy/plushie/blue_fox
	name = "blue fox plushie"
	icon_state = "bluefox"

/obj/item/toy/plushie/orange_fox
	name = "orange fox plushie"
	icon_state = "orangefox"

/obj/item/toy/plushie/coffee_fox
	name = "coffee fox plushie"
	icon_state = "coffeefox"

/obj/item/toy/plushie/pink_fox
	name = "pink fox plushie"
	icon_state = "pinkfox"

/obj/item/toy/plushie/purple_fox
	name = "purple fox plushie"
	icon_state = "purplefox"

/obj/item/toy/plushie/crimson_fox
	name = "crimson fox plushie"
	icon_state = "crimsonfox"

/obj/item/toy/plushie/deer
	name = "deer plushie"
	icon_state = "deer"

/obj/item/toy/plushie/black_cat
	name = "black cat plushie"
	icon_state = "blackcat"

/obj/item/toy/plushie/grey_cat
	name = "grey cat plushie"
	icon_state = "greycat"

/obj/item/toy/plushie/white_cat
	name = "white cat plushie"
	icon_state = "whitecat"

/obj/item/toy/plushie/orange_cat
	name = "orange cat plushie"
	icon_state = "orangecat"

/obj/item/toy/plushie/siamese_cat
	name = "siamese cat plushie"
	icon_state = "siamesecat"

/obj/item/toy/plushie/tabby_cat
	name = "tabby cat plushie"
	icon_state = "tabbycat"

/obj/item/toy/plushie/tuxedo_cat
	name = "tuxedo cat plushie"
	icon_state = "tuxedocat"

obj/random/carp_plushie
	name = "Random Carp Plushie"
	desc = "This is a random plushie"
	icon = 'icons/obj/toy.dmi'
	icon_state = "carpplushie"

/obj/item/toy/carpplushie/ice
	icon_state = "icecarp"

/obj/item/toy/carpplushie/silent
	icon_state = "silentcarp"

/obj/item/toy/carpplushie/electric
	icon_state = "electriccarp"

/obj/item/toy/carpplushie/gold
	icon_state = "goldcarp"

/obj/item/toy/carpplushie/toxin
	icon_state = "toxincarp"

/obj/item/toy/carpplushie/dragon
	icon_state = "dragoncarp"

/obj/item/toy/carpplushie/pink
	icon_state = "pinkcarp"

/obj/item/toy/carpplushie/candy
	icon_state = "candycarp"

/obj/item/toy/carpplushie/nebula
	icon_state = "nebulacarp"

/obj/item/toy/carpplushie/void
	icon_state = "voidcarp"


//Magic 8-Ball / Conch

/obj/item/toy/eight_ball
	name = "Magic 8-Ball"
	desc = "Mystical! Magical! Ages 8+!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "eight-ball"
	var/use_action = "shakes the ball"
	var/cooldown = 0
	var/list/possible_answers = list("Definitely", "All signs point to yes.", "Most likely.", "Yes.", "Ask again later.", "Better not tell you now.", "Future Unclear.", "Maybe.", "Doubtful.", "No.", "Don't count on it.", "Never.")

/obj/item/toy/eight_ball/conch
	name = "Magic Conch Shell"
	desc = "All hail the Magic Conch!"
	icon_state = "conch"
	use_action = "pulls the string"
	possible_answers = list("Yes.", "No.", "Try asking again.", "Nothing.", "I don't think so.", "Neither.", "Maybe someday.")
/obj/item/toy/character
	icon = 'icons/obj/toy.dmi'
	w_class = 2
	pixel_z = 5

/obj/item/toy/character/alien
	name = "Xenomorph Miniature"
	desc = "A miniature xenomorph. Scary!"
	icon_state = "aliencharacter"
/obj/item/toy/character/cleric
	name = "Cleric Miniature"
	desc = "A wee little cleric, with his wee little staff."
	icon_state = "clericcharacter"
/obj/item/toy/character/warrior
	name = "Warrior Miniature"
	desc = "That sword would make a decent toothpick."
	icon_state = "warriorcharacter"
/obj/item/toy/character/thief
	name = "Thief Miniature"
	desc = "Hey, where did my wallet go!?"
	icon_state = "thiefcharacter"
/obj/item/toy/character/wizard
	name = "Wizard Miniature"
	desc = "MAGIC!"
	icon_state = "wizardcharacter"
/obj/item/toy/character/cthulhu
	name = "Cthulhu Miniature"
	desc = "The dark lord has risen!"
	icon_state = "darkmastercharacter"
/obj/item/toy/character/lich
	name = "Lich Miniature"
	desc = "Murderboner extraordinaire."
	icon_state = "lichcharacter"
/obj/item/weapon/storage/box/characters
	name = "Box of Miniatures"
	desc = "The nerd's best friends."
	icon_state = "box"
/obj/item/weapon/storage/box/characters/New()
	..()
	new /obj/item/toy/character/alien(src)
	new /obj/item/toy/character/cleric(src)
	new /obj/item/toy/character/warrior(src)
	new /obj/item/toy/character/thief(src)
	new /obj/item/toy/character/wizard(src)
	new /obj/item/toy/character/cthulhu(src)
	new /obj/item/toy/character/lich(src)
