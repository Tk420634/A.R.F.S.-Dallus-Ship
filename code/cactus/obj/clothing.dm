//CONTENTS:

//HAZMAT SUIT



////////////////
//HAZMAT SUIT//
////////////////

/obj/item/clothing/head/hazmat
	name = "hazmat hood"
	desc = "A hood and mask combo worn by scientists working in extremely hazardous environments. Offers basic protection to workplace hazards in the form of padding and fire-retardant materials."
	icon = 'code/cactus/icons/clothing.dmi'
	icon_state = "hazmatHood"
	permeability_coefficient = 0.01
	flags = BLOCKHAIR|THICKMATERIAL
	armor = list(melee = 25, bullet = 5, laser = 25,energy = 0, bomb = 0, bio = 100, rad = 75)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	strip_delay = 90
	put_on_delay = 90
	unacidable = 1
	burn_state = -1
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/suit/hazmat
	name = "hazmat suit"
	desc = "A suit worn by scientists working in extremely hazardous environments. Offers basic protection to workplace hazards in the form of knee and elbow padding and fire-retardant materials."
	icon = 'code/cactus/icons/clothing.dmi'
	icon_state = "hazmatSuit"
	item_state = "hazmatSuit"
	w_class = 4
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 1
	allowed = list(/obj/item/weapon/tank/internals/emergency_oxygen,/obj/item/weapon/pen,/obj/item/device/flashlight/pen, /obj/item/weapon/reagent_containers/dropper, /obj/item/weapon/reagent_containers/syringe, /obj/item/weapon/reagent_containers/hypospray)
	armor = list(melee = 25, bullet = 5, laser = 25,energy = 0, bomb = 0, bio = 100, rad = 75)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	strip_delay = 90
	put_on_delay = 90
	unacidable = 1
	burn_state = -1


/obj/structure/closet/hazmat
	name = "level-6 biohazard gear closet"
	icon_state = "hazmat"
/obj/structure/closet/hazmat/New()
	..()
	contents = list()
	new /obj/item/clothing/suit/hazmat(src)
	new /obj/item/clothing/head/hazmat(src)