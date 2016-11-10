/*
Bridge Officer

/datum/job/warden
	title = "Bridge Officer"
	flag = BRIDGE_OFFICER
	department_head = list("Captain")
	department_flag = N
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Command Staff"
	selection_color = "#ffeeee"
	minimal_player_age = 7

	outfit = /datum/outfit/job/warden

	access = list(access_heads)
	minimal_access = list(access_heads)

/datum/job/warden/get_access()
	var/list/L = list()
	L = ..() | check_config_for_sec_maint()
	return L

/datum/outfit/job/warden
	name = "Bridge Officer"

	belt = /obj/item/device/pda/assistant
	ears = /obj/item/device/radio/headset/heads/captain
	uniform = /obj/item/clothing/under/color/lightbrown
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	backpack_contents = list(/obj/item/clothing/head/collectable/rabbitears)
	backpack = /obj/item/weapon/storage/backpack/security
	satchel = /obj/item/weapon/storage/backpack/satchel_sec

	minor_announce("Bridge Officer [H.real_name] on deck!")
	*/