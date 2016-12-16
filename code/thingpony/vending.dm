// INCLUDES TOY VENDOR AND OTHER MISC ITEMS JESS HAS CREATED


/obj/machinery/vending/thingpony/toy
	name = "Toy Vendor"
	desc = "A cute teddy bear! It can give you toys!"
	product_ads = "Action figures!"
	icon_state = "toy"
	vend_reply = "Get to donk-ing!"
	products = list(/obj/item/toy/balloon = 5, /obj/item/toy/spinningtoy = 5, // 2
	/obj/item/toy/sword = 5, /obj/item/toy/foamblade = 5, // 4
	/obj/item/toy/carpplushie = 5, /obj/item/toy/beach_ball = 5, //6
	/obj/item/toy/toy_xeno = 5, /obj/item/toy/cattoy = 5, /obj/item/toy/plushie/corgi = 5, // 9
	/obj/item/toy/plushie/girly_corgi = 5, /obj/item/toy/plushie/robo_corgi, // 11
	/obj/item/toy/plushie/octopus = 5, /obj/item/toy/plushie/octopus = 5, // 13
	/obj/item/toy/plushie/face_hugger = 5, /obj/item/toy/plushie/red_fox = 5, // 15
	/obj/item/toy/plushie/black_fox = 5, /obj/item/toy/plushie/marble_fox = 5, // 17
	/obj/item/toy/plushie/blue_fox = 5, /obj/item/toy/plushie/orange_fox = 5, // 19
	/obj/item/toy/plushie/coffee_fox = 5, /obj/item/toy/plushie/pink_fox = 5, // 21
	/obj/item/toy/plushie/purple_fox = 5, /obj/item/toy/plushie/crimson_fox = 5, // 23
	/obj/item/toy/plushie/deer = 5, /obj/item/toy/plushie/black_cat = 5, // 25
	/obj/item/toy/plushie/grey_cat = 5, /obj/item/toy/plushie/white_cat = 5, // 27
	/obj/item/toy/plushie/orange_cat = 5, /obj/item/toy/plushie/siamese_cat = 5, // 29
	/obj/item/toy/plushie/tabby_cat = 5, /obj/item/toy/plushie/tuxedo_cat = 5, // 31
	/obj/item/toy/carpplushie/ice = 5, /obj/item/toy/carpplushie/silent = 5, // 33
	/obj/item/toy/carpplushie/electric = 5, /obj/item/toy/carpplushie/gold = 5, // 35
	/obj/item/toy/carpplushie/toxin = 5, /obj/item/toy/carpplushie/dragon = 5, // 37
	/obj/item/toy/carpplushie/pink = 5, /obj/item/toy/carpplushie/candy = 5, // 39
	/obj/item/toy/carpplushie/nebula = 5, /obj/item/toy/carpplushie/void = 5, // 41
	/obj/item/toy/eight_ball = 5, /obj/item/toy/eight_ball/conch = 5, // 43
	/obj/item/toy/character/alien = 5, /obj/item/toy/character/cleric = 5, // 45
	/obj/item/toy/character/warrior = 5, /obj/item/toy/character/thief = 5, // 47
	/obj/item/toy/character/wizard = 5, /obj/item/toy/character/cthulhu = 5, // 49
	/obj/item/toy/character/lich = 5) // 50 charges!! times by 5 which equals 250!! 250 TOYS!!
	contraband = list(/obj/item/toy/syndicateballoon = 1)
	premium = list(/obj/item/weapon/twohanded/dualsaber/toy = 1)

	refill_canister = /obj/item/weapon/vending_refill/toy

// IMPORTANT!!!!!!!!!!
// If you are adding ANYTHING onto this vending machine, remember to update the charges, if you added 1 to this machine, add 1 to the charges below.


/obj/item/weapon/vending_refill/toy
	machine_name = "Toy Vendor"
	charges = list(250, 1, 1)// of 250 standard, 1 contraband, 1 premium
	init_charges = list(50, 1, 1)