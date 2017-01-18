/*
Research Director
*/
/datum/job/rd
	title = "Research Director"
	flag = RD
	department_head = list("Captain")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain.  Your job specific guide can be found here https://tgstation13.org/wiki/Guides  Your job specific rules can be found here, http://arfsdallusstation.createaforum.com/rules/rules-for-heads-of-staff/msg12/#msg12 and http://arfsdallusstation.createaforum.com/rules/rules-for-science/"
	selection_color = "#AC3CC3"
	req_admin_notify = 1
	//minimal_player_age = 0

	outfit = /datum/outfit/job/rd

	access = list(access_rd, access_heads, access_tox, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_research, access_robotics, access_xenobiology, access_ai_upload,
			            access_RC_announce, access_keycard_auth, access_gateway, access_mineral_storeroom,
			            access_tech_storage, access_minisat)
	minimal_access = list(access_rd, access_heads, access_tox, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_research, access_robotics, access_xenobiology, access_ai_upload,
			            access_RC_announce, access_keycard_auth, access_gateway, access_mineral_storeroom,
			            access_tech_storage, access_minisat)

/datum/outfit/job/rd
	name = "Research Director"

	id = /obj/item/weapon/card/id/silver
	belt = /obj/item/device/pda/heads/rd
	ears = /obj/item/device/radio/headset/heads/rd
	uniform = /obj/item/clothing/under/rank/research_director
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/labcoat
	l_hand = /obj/item/weapon/clipboard
	l_pocket = /obj/item/device/laser_pointer
	backpack_contents = list(/obj/item/weapon/melee/classic_baton/telescopic=1)

/datum/outfit/job/rd/post_equip(mob/living/carbon/human/H)
	..()
	announce_head(H, list("Science")) //tell underlings (science radio) they have a head

/*
Scientist
*/
/datum/job/scientist
	title = "Scientist"
	flag = SCIENTIST
	department_head = list("Research Director")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the research director.  Your job specific guide can be found here, https://tgstation13.org/wiki/Guides and your job specific rules can be found here http://arfsdallusstation.createaforum.com/rules/rules-for-science/"
	selection_color = "#AC3CC3"

	outfit = /datum/outfit/job/scientist

	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_mineral_storeroom, access_tech_storage, access_genetics)
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenobiology, access_mineral_storeroom)

/datum/outfit/job/scientist
	name = "Scientist"

	belt = /obj/item/device/pda/toxins
	ears = /obj/item/device/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science

/*
Roboticist
*/
/datum/job/roboticist
	title = "Roboticist"
	flag = ROBOTICIST
	department_head = list("Research Director")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "research director. Your job specific guide can be found here, https://tgstation13.org/wiki/Guides and your job specific rules can be found here http://arfsdallusstation.createaforum.com/rules/rules-for-science/"
	selection_color = "#AC3CC3"

	outfit = /datum/outfit/job/roboticist

	access = list(access_robotics, access_tox, access_tox_storage, access_tech_storage, access_morgue, access_research, access_mineral_storeroom, access_xenobiology, access_genetics)
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research, access_mineral_storeroom)

/datum/outfit/job/roboticist
	name = "Roboticist"

	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/pda/roboticist
	ears = /obj/item/device/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/roboticist
	suit = /obj/item/clothing/suit/toggle/labcoat

	pda_slot = slot_l_store


/*
Laboratory Assistant
*/

/datum/job/labass
	title = "Laboratory Assistant"
	flag = LABASS
	department_head = list("Research Director")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the research director, scientists, roboticists, and xenobiologists. Your job specific guide can be found here, https://tgstation13.org/wiki/Guides and your job specific rules can be found here http://arfsdallusstation.createaforum.com/rules/rules-for-science/"
	selection_color = "#AC3CC3"

	outfit = /datum/outfit/job/labass

	access = list(access_robotics, access_research, access_xenobiology, access_mineral_storeroom, access_genetics)
	minimal_access = list(access_robotics, access_research, access_xenobiology, access_mineral_storeroom, access_genetics)

/datum/outfit/job/labass
	name = "Laboratory Assistant"

	belt = /obj/item/device/pda/toxins
	ears = /obj/item/device/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science


/*
Xenobiologist
*/
/datum/job/xenobio
	title = "Xenobiologist"
	flag = XENOBIO
	department_head = list("Research Director")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the research director. Your job specific guide can be found here, https://tgstation13.org/wiki/Guides and your job specific rules can be found here http://arfsdallusstation.createaforum.com/rules/rules-for-science/"
	selection_color = "#AC3CC3"

	outfit = /datum/outfit/job/xenobio

	access = list(access_research, access_xenobiology, access_mineral_storeroom, access_tech_storage, access_genetics)
	minimal_access = list(access_research, access_xenobiology, access_mineral_storeroom)

/datum/outfit/job/xenobio
	name = "Xenobiologist"

	belt = /obj/item/device/pda/toxins
	ears = /obj/item/device/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	l_pocket = /obj/item/device/slime_scanner