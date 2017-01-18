/*
Captain
*/
/datum/job/captain
	title = "Captain"
	flag = CAPTAIN
	department_head = list("Centcom")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "A.R.F. officials and Space law.  Your job specific rules can be found at http://arfsdallusstation.createaforum.com/rules/rules-for-heads-of-staff/msg12/#msg12"
	selection_color = "#ccccff"
	req_admin_notify = 1
	//minimal_player_age = 0

	outfit = /datum/outfit/job/captain

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

/datum/job/captain/get_access()
	return get_all_accesses()


/datum/outfit/job/captain
	name = "Captain"

	id = /obj/item/weapon/card/id/gold
	belt = /obj/item/device/pda/captain
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/device/radio/headset/heads/captain/alt
	gloves = /obj/item/clothing/gloves/color/captain
	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/caphat
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack/captain
	satchel = /obj/item/weapon/storage/backpack/satchel_cap

/datum/outfit/job/captain/post_equip(mob/living/carbon/human/H)
	..()

	var/obj/item/clothing/under/U = H.w_uniform
	U.attachTie(new /obj/item/clothing/tie/medal/gold/captain())

	var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()

	minor_announce("Captain [H.real_name] on deck!")

/*
Lieutenant
*/
/datum/job/lieutenant
	title = "Lieutenant"
	flag = LIEUTENANT
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain. Your job specific rules can be found at http://arfsdallusstation.createaforum.com/rules/rules-for-heads-of-staff/msg12/#msg12"
	selection_color = "#ddddff"
	req_admin_notify = 1
	//minimal_player_age = 0

	outfit = /datum/outfit/job/lieutenant

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

/datum/job/lieutenant/get_access()
	return get_all_accesses()

/datum/outfit/job/lieutenant
	name = "Lieutenant"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/device/pda/lieutenant
	glasses = /obj/item/clothing/glasses/red/sunglasses
	ears = /obj/item/device/radio/headset/heads/lieutenant
	gloves = /obj/item/clothing/gloves/color/grey/hop
	uniform =  /obj/item/clothing/under/rank/lieutenant
	suit = /obj/item/clothing/suit/armor/vest/lieutenant
	shoes = /obj/item/clothing/shoes/sneakers/brown/hop
	head = /obj/item/clothing/head/caphat/lieutenant
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

/datum/outfit/job/lieutenant/post_equip(mob/living/carbon/human/H)
	..()

	var/obj/item/clothing/under/U = H.w_uniform
	U.attachTie(new /obj/item/clothing/tie/medal/silver())

	var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
	L.imp_in = H
	L.implanted = 1
	H.sec_hud_set_implants()

	minor_announce("Lieutenant [H.real_name] has arrived.")

/*
Chief of Personnel
*/
/datum/job/cop
	title = "Chief of Personnel"
	flag = COP
	department_head = list("Captain")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain. Your job specific rules can be found at http://arfsdallusstation.createaforum.com/rules/rules-for-heads-of-staff/msg12/#msg12"
	selection_color = "#d7b088"
	req_admin_notify = 1
	//minimal_player_age = 0

	outfit = /datum/outfit/job/cop

	access = list(access_all_personal_lockers, access_RC_announce, access_keycard_auth, access_sec_doors, access_cop, access_heads, access_theatre, access_library, access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station, access_mineral_storeroom, access_hydroponics, access_bar, access_kitchen, access_morgue, access_weapons, access_janitor, access_chapel_office, access_crematorium)
	minimal_access = list(access_all_personal_lockers, access_RC_announce, access_keycard_auth, access_sec_doors, access_cop, access_heads, access_theatre, access_library, access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station, access_mineral_storeroom, access_hydroponics, access_bar, access_kitchen, access_morgue, access_weapons, access_janitor, access_chapel_office, access_crematorium)

/datum/outfit/job/cop
	name = "Chief of Personnel"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/device/pda/cop
	uniform = /obj/item/clothing/under/rank/head_of_personnel/cop
	ears = /obj/item/device/radio/headset/heads/cop
	shoes = /obj/item/clothing/shoes/sneakers/brown/hop
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

	backpack = /obj/item/weapon/storage/backpack
	satchel = /obj/item/weapon/storage/backpack

/datum/outfit/job/cop/post_equip(mob/living/carbon/human/H)
	..()

	var/obj/item/clothing/under/U = H.w_uniform
	U.attachTie(new /obj/item/clothing/tie/red())


	announce_head(H, list("Supply", "Service"))


/*
Head of Personnel
// REPLACED WITH LIEUTENANT

/datum/job/hop
	title = "Head of Personnel"
	flag = HOP
	department_head = list("Captain")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 10

	outfit = /datum/outfit/job/hop

	access = list(access_security, access_sec_doors, access_court, access_weapons,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_theatre, access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway, access_mineral_storeroom)
	minimal_access = list(access_security, access_sec_doors, access_court, access_weapons,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_theatre, access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway, access_mineral_storeroom)


/datum/outfit/job/hop
	name = "Head of Personnel"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/device/pda/heads/hop
	ears = /obj/item/device/radio/headset/heads/hop
	uniform = /obj/item/clothing/under/rank/head_of_personnel
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hopcap
	backpack_contents = list(/obj/item/weapon/storage/box/ids=1,\
		/obj/item/weapon/melee/classic_baton/telescopic=1)

/datum/outfit/job/hop/post_equip(mob/living/carbon/human/H)
	..()

	announce_head(H, list("Supply", "Service"))
*/
