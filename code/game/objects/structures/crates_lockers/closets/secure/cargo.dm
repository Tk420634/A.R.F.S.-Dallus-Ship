/obj/structure/closet/secure_closet/quartermaster
	name = "\proper quartermaster's locker"
	req_access = list(access_qm)
	icon_state = "qm"

/obj/structure/closet/secure_closet/quartermaster/New()
	..()
	new /obj/item/clothing/cloak/qm(src)
	new /obj/item/clothing/under/rank/cargo(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/device/radio/headset/headset_cargo(src)
	new /obj/item/clothing/suit/fire/firefighter(src)
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/weapon/mining_voucher(src)
	new /obj/item/device/megaphone/cargo(src)
	new /obj/item/weapon/tank/internals/emergency_oxygen(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/clothing/head/soft(src)

/obj/structure/closet/secure_closet/cop
	name = "\proper chief of personnel's locker"
	req_access = list(access_cop)
	icon_state = "hop"

/obj/structure/closet/secure_closet/cop/New()
	..()
	new /obj/item/clothing/under/rank/head_of_personnel/cop(src)
	new /obj/item/clothing/under/rank/cargo(src)
	new /obj/item/clothing/cloak/qm(src)
	new /obj/item/weapon/cartridge/hop(src)
	new /obj/item/device/radio/headset/heads/cop(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/device/megaphone/command(src)
	new /obj/item/device/assembly/flash/handheld(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/weapon/mining_voucher(src)
	new /obj/item/weapon/mining_voucher(src)
	new /obj/item/clothing/tie/red(src)
	new /obj/item/clothing/head/soft(src)
	new /obj/item/clothing/tie/petcollar(src)
	new /obj/item/weapon/folder/documents(src)
	new /obj/item/device/portacargo(src)
