/obj/item/weapon/banhammer
	desc = "A banhammer"
	name = "banhammer"
	icon = 'icons/obj/items.dmi'
	icon_state = "toyhammer"
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 1
	throw_speed = 3
	throw_range = 7
	attack_verb = list("banned")

/obj/item/weapon/banhammer/suicide_act(mob/user)
		user.visible_message("<span class='suicide'>[user] is hitting \himself with the [src.name]! It looks like \he's trying to ban \himself from life.</span>")
		return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)

/obj/item/weapon/banhammer/attack(mob/M, mob/user)
	M << "<font color='red'><b> You have been banned FOR NO REISIN by [user]<b></font>"
	user << "<font color='red'>You have <b>BANNED</b> [M]</font>"
	playsound(loc, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much


/obj/item/weapon/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian, its very presence disrupts and dampens the powers of Nar-Sie's followers."
	icon_state = "nullrod"
	item_state = "nullrod"
	slot_flags = SLOT_BELT
	force = 15
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	w_class = 1

/obj/item/weapon/nullrod/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return (BRUTELOSS|FIRELOSS)

/obj/item/weapon/sord
	name = "\improper SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	slot_flags = SLOT_BELT
	force = 2
	throwforce = 1
	w_class = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/sord/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return(BRUTELOSS)

/obj/item/weapon/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 40
	throwforce = 10
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/claymore/IsShield()
	return 1

/obj/item/weapon/claymore/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return(BRUTELOSS)

/obj/item/weapon/katana
	name = "katana"
	desc = "Woefully underpowered in D20"
	icon_state = "katana"
	item_state = "katana"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 40
	throwforce = 10
	w_class = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/katana/cursed
	slot_flags = null

/obj/item/weapon/katana/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</span>")
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.getorgan(/obj/item/organ/internal/body_egg/alien_embryo))
			sleep(10)
			H.visible_message("<span class='suicide'>[H] reaches into \his stomach...</span>")
			sleep(10)
			var/burstedoverlay = image('icons/mob/alien.dmi', loc = H, icon_state = "bursted_stand")
			var/obj/item/organ/internal/body_egg/alien_embryo/alien = H.getorgan(/obj/item/organ/internal/body_egg/alien_embryo)
			H.say("*scream")
			H.visible_message("<span class='suicide'>[H] rips [alien] out of \his stomach!</span>")
			H.overlays += burstedoverlay
			alien.loc = H.loc
			alien.owner = null
			H.internal_organs -= alien
			alien.visible_message("<span class='name'>[alien]</span> lets out a waning guttural screech, green blood bubbling from its maw...")
			playsound(alien.loc, 'sound/voice/hiss6.ogg', 30, 1, 1)
	return (BRUTELOSS)

/obj/item/weapon/katana/IsShield()
		return 1

/obj/item/weapon/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "rods"
	flags = CONDUCT
	force = 9
	throwforce = 10
	w_class = 3
	materials = list(MAT_METAL=1000)
	attack_verb = list("hit", "bludgeoned", "whacked", "bonked")

/obj/item/weapon/wirerod/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/weapon/shard))
		var/obj/item/weapon/twohanded/spear/S = new /obj/item/weapon/twohanded/spear

		if(!remove_item_from_storage(user))
			user.unEquip(src)
		user.unEquip(I)

		user.put_in_hands(S)
		user << "<span class='notice'>You fasten the glass shard to the top of the rod with the cable.</span>"
		qdel(I)
		qdel(src)

	if(istype(I, /obj/item/weapon/xenos_tail))
		var/obj/item/weapon/twohanded/spear/xeno/S = new /obj/item/weapon/twohanded/spear/xeno

		if(!remove_item_from_storage(user))
			user.unEquip(src)
		user.unEquip(I)

		user.put_in_hands(S)
		user << "<span class='notice'>You fasten the alien tail barb to the top of the rod with the cable.</span>"
		qdel(I)
		qdel(src)

	else if(istype(I, /obj/item/weapon/wirecutters) && !(I.flags & NODROP))
		var/obj/item/weapon/melee/baton/cattleprod/P = new /obj/item/weapon/melee/baton/cattleprod

		if(!remove_item_from_storage(user))
			user.unEquip(src)
		user.unEquip(I)

		user.put_in_hands(P)
		user << "<span class='notice'>You fasten the wirecutters to the top of the rod with the cable, prongs outward.</span>"
		qdel(I)
		qdel(src)


/obj/item/weapon/throwing_star
	name = "throwing star"
	desc = "An ancient weapon still used to this day due to it's ease of lodging itself into victim's body parts"
	icon_state = "throwingstar"
	item_state = "eshield0"
	force = 2
	throwforce = 20 //This is never used on mobs since this has a 100% embed chance.
	throw_speed = 4
	embedded_pain_multiplier = 4
	w_class = 2
	embed_chance = 100
	embedded_fall_chance = 0 //Hahaha!
	sharpness = IS_SHARP

//5*(2*4) = 5*8 = 45, 45 damage if you hit one person with all 5 stars.
//Not counting the damage it will do while embedded (2*4 = 8, at 15% chance)
/obj/item/weapon/storage/box/throwing_stars/New()
	..()
	contents = list()
	new /obj/item/weapon/throwing_star(src)
	new /obj/item/weapon/throwing_star(src)
	new /obj/item/weapon/throwing_star(src)
	new /obj/item/weapon/throwing_star(src)
	new /obj/item/weapon/throwing_star(src)



/obj/item/weapon/switchblade
	name = "switchblade"
	icon_state = "switchblade"
	desc = "A sharp, concealable, spring-loaded knife."
	flags = CONDUCT
	force = 3
	w_class = 2
	throwforce = 5
	throw_speed = 3
	throw_range = 6
	materials = list(MAT_METAL=12000)
	origin_tech = "materials=1"
	hitsound = 'sound/weapons/Genhit.ogg'
	attack_verb = list("stubbed", "poked")
	var/extended = 0

/obj/item/weapon/switchblade/attack_self(mob/user)
	extended = !extended
	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	if(extended)
		force = 20
		w_class = 3
		throwforce = 23
		icon_state = "switchblade_ext"
		attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
		hitsound = 'sound/weapons/bladeslice.ogg'
	else
		force = 3
		w_class = 2
		throwforce = 5
		icon_state = "switchblade"
		attack_verb = list("stubbed", "poked")
		hitsound = 'sound/weapons/Genhit.ogg'

/obj/item/weapon/switchblade/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is slitting \his own throat with the [src.name]! It looks like \he's trying to commit suicide.</span>")
	return (BRUTELOSS)

/obj/item/weapon/phone
	name = "red phone"
	desc = "Should anything ever go wrong..."
	icon = 'icons/obj/items.dmi'
	icon_state = "red_phone"
	force = 3
	throwforce = 2
	throw_speed = 3
	throw_range = 4
	w_class = 2
	attack_verb = list("called", "rang")
	hitsound = 'sound/weapons/ring.ogg'

/obj/item/weapon/phone/suicide_act(mob/user)
	if(locate(/obj/structure/bed/stool) in user.loc)
		user.visible_message("<span class='notice'>[user] begins to tie a noose with the [src.name]'s cord! It looks like \he's trying to commit suicide.</span>")
	else
		user.visible_message("<span class='notice'>[user] is strangling \himself with the [src.name]'s cord! It looks like \he's trying to commit suicide.</span>")
	return(OXYLOSS)

/obj/item/weapon/cane
	name = "cane"
	desc = "A cane used by a true gentleman. Or a clown."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "cane"
	item_state = "stick"
	force = 5
	throwforce = 5
	w_class = 2
	materials = list(MAT_METAL=50)
	attack_verb = list("bludgeoned", "whacked", "disciplined", "thrashed")

/obj/item/weapon/staff
	name = "wizard staff"
	desc = "Apparently a staff used by the wizard."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "staff"
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = 2
	flags = NOSHIELD
	attack_verb = list("bludgeoned", "whacked", "disciplined")
	burn_state = 0 //Burnable

/obj/item/weapon/staff/broom
	name = "broom"
	desc = "Used for sweeping, and flying into the night while cackling. Black cat not included."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "broom"

/obj/item/weapon/staff/stick
	name = "stick"
	desc = "A great tool to drag someone else's drinks across the bar."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "stick"
	item_state = "stick"
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = 2
	flags = NOSHIELD

/obj/item/weapon/ectoplasm
	name = "ectoplasm"
	desc = "spooky"
	gender = PLURAL
	icon = 'icons/obj/wizard.dmi'
	icon_state = "ectoplasm"

/obj/item/weapon/ectoplasm/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is inhaling the [src.name]! It looks like \he's trying to visit the astral plane.</span>")
	return (OXYLOSS)

/obj/item/weapon/mounted_chainsaw
        name = "mounted chainsaw"
        desc = "A chainsaw that has replaced your arm."
        icon_state = "chainsaw_on"
        flags = ABSTRACT | NODROP
        w_class = 5.0
        force = 21
        throwforce = 0
        throw_range = 0
        throw_speed = 0
        sharpness = IS_SHARP
        attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
        hitsound = "sound/weapons/chainsawhit.ogg"

/obj/item/weapon/dildo
	name = "dildo"
	desc = "Floppy!"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "dildo"
	force = 0
	throwforce = 0
	attack_verb = list("penetrated", "probed", "slapped", "poked")

/obj/item/weapon/dildo/New()
	icon_state = "[icon_state][item_color]"
	if(item_color == null)
		item_color = pick("r", "bl", "gr", "pr", "p", "yw", "or", "b")
		icon_state = "[icon_state][item_color]"

/obj/item/weapon/dildo/psych
	name = "psychedelic dildo"
	desc = "Now with 20% more seizures!"
	item_color = "psych"

/obj/item/weapon/dildo/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is shoving the [src.name] up \his ass! It looks like \he's trying to commit suicide!</span>")
	return(BRUTELOSS)

/obj/item/weapon/surgicaldrill/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/weapon/dildo))
		var/obj/item/weapon/drilldo/S = new /obj/item/weapon/drilldo

		if(!remove_item_from_storage(user))
			user.unEquip(src)
		user.unEquip(I)

		user.put_in_hands(S)
		user << "<span class='notice'>You impale the dildo onto the surgical drill.</span>"
		qdel(I)
		qdel(src)

/obj/item/weapon/drilldo
	name = "drilldo"
	desc = "Because a dildo just isn't enough."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "drilldo_0"
	force = 0
	throwforce = 0
	w_class = 3
	attack_verb = list("penetrated", "probed", "poked", "drilled")
	var/on = 0

/obj/item/weapon/drilldo/attack_self(mob/user)
	on = !on
	if(on)
		force = 0
		throwforce = 0
		icon_state = "drilldo_1"
		user << "<span class='notice'>You turn on the drilldo.</span>"
	else
		force = 0
		throwforce = 0
		icon_state = "drilldo_0"
		user << "<span class='notice'>You turn off the drilldo.</span>"

/obj/item/weapon/drilldo/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is shoving the [src.name] up \his ass! It looks like \he's trying to commit suicide!</span>")
	return(BRUTELOSS)

obj/item/weapon/fleshlight
	name = "fleshlight"
	desc = "Somehow, it seems to be the perfect fit for any length. Very cool."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "fleshlight"
	item_state = "fleshlight"
	attack_verb = list("cuntslapped", "violated", "teased", "prodded")

/obj/item/weapon/bulletvibe
	name = "bullet vibrator"
	desc = "A discreet, versatile vibrator, and don't you let its size fool you. Still one of the most popular vibes on the market."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "bulletvibe"
	item_state = "bulletvibe"
	attack_verb = list("pleasured", "vibrated", "violated", "teased", "poked")


/obj/item/weapon/dildos/canine
	name = "canine dildo"
	desc = "It has a bulbous knot."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "canine"
	item_state = "canine"
	attack_verb = list("fucked", "probed", "violated", "teased", "prodded")

/obj/item/weapon/dildos/purpledong
	name = "purple dildo"
	desc = "It's a playful shade of purple."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "purple-dong"
	item_state = "purple-dong"
	attack_verb = list("fucked", "probed", "violated", "teased", "prodded")

/obj/item/weapon/dildos/bigblackdick
	name = "big black dick"
	desc = "Bigger. Blacker. For when the real thing just doesn't cut it."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "bigblackdick"
	item_state = "bigblackdick"
	attack_verb = list("fucked", "probed", "violated", "teased", "prodded")

/obj/item/weapon/dildos/floppydick
	name = "floppy dick"
	desc = "The silicone on this toy is particularly soft and, well, kind of flaccid."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "floppydick"
	item_state = "floppydick"
	attack_verb = list("fucked", "probed", "violated", "teased", "prodded")

/obj/item/weapon/killbowstaff
	name = "staff of arroganaza"
	desc = "A red glare is in its eyes, it seems to be a staff made in the shape of a cobra and it looks alive."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "killbow_staff"
	attack_verb = list("mesmerizes")

/obj/item/weapon/dildos/analbeads
	name = "Anal Beads"
	desc = "A set up pink beads on a small, light pink string. It seems perfect for all your anal bead needs!"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "anal_beads"
	item_state = "anal_beads"
	attack_verb = list("beadwhips", "beads")
