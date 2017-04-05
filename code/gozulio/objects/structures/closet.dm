//Weapons and equipment lockers for aft security checkpoint
/obj/structure/closet/secure_closet/armory4
	name = "Security Checkpoint Arms Locker"
	req_access = list(access_security)
	icon_state = "armory"

/obj/structure/closet/secure_closet/armory4/New()
	..()
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/weapon/gun/energy/gun(src)
	new /obj/item/weapon/gun/energy/gun(src)
	new /obj/item/weapon/gun/energy/gun(src)
	return

/obj/structure/closet/secure_closet/armory5
	name = "Security Checkpoint Weapons Locker"
	req_access = list(access_armory)
	icon_state = "armory"

/obj/structure/closet/secure_closet/armory5/New()
	..()
	new /obj/item/weapon/gun/energy/gun(src)
	new /obj/item/weapon/gun/energy/gun(src)
	new /obj/item/weapon/gun/energy/gun(src)
	return
	
/obj/structure/closet/secure_closet/armory6
	name = "Armory Grenadier locker"
	req_access = list(access_armory)
	icon_state = "armory"

/obj/structure/closet/secure_closet/armory6/New()
	..()
	new /obj/item/weapon/gun/grenadelauncher(src)
	new /obj/item/weapon/storage/box/flashbangs(src)
	new /obj/item/weapon/storage/box/teargas(src)
	return