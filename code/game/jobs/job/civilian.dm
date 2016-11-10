/*
Clown
*/
/datum/job/clown/
	title = "Clown"
	flag = CLOWN
	department_head = list("Chief of Personnel")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief of Personnel"
	selection_color = "#dddddd"

	outfit = /datum/outfit/job/clown

	access = list(access_theatre)
	minimal_access = list(access_theatre)

/datum/outfit/job/clown
	name = "Clown"

	belt = /obj/item/device/pda/clown
	uniform = /obj/item/clothing/under/rank/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	mask = /obj/item/clothing/mask/gas/clown_hat
	l_pocket = /obj/item/weapon/bikehorn
	r_pocket = /obj/item/toy/crayon/rainbow
	backpack_contents = list(/obj/item/weapon/stamp/clown=1,/obj/item/weapon/reagent_containers/spray/waterflower=1)

	backpack = /obj/item/weapon/storage/backpack/clown
	satchel = /obj/item/weapon/storage/backpack/clown

/datum/outfit/job/clown/pre_equip(mob/living/carbon/human/H)
	..()
	H.fully_replace_character_name(H.real_name, pick(clown_names))

/datum/outfit/job/clown/post_equip(mob/living/carbon/human/H)
	..()
	new /obj/item/weapon/reagent_containers/food/snacks/grown/banana(H.back, 50)

	H.dna.add_mutation(CLOWNMUT)
	H.rename_self("clown")

/*
Mime
*/
/datum/job/mime
	title = "Mime"
	flag = MIME
	department_head = list("Chief of Personnel")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief of Personnel"
	selection_color = "#dddddd"

	outfit = /datum/outfit/job/mime

	access = list(access_theatre)
	minimal_access = list(access_theatre)

/datum/outfit/job/mime
	name = "Mime"

	belt = /obj/item/device/pda/mime
	uniform = /obj/item/clothing/under/rank/mime
	mask = /obj/item/clothing/mask/gas/mime
	gloves = /obj/item/clothing/gloves/color/white
	head = /obj/item/clothing/head/beret
	suit = /obj/item/clothing/suit/suspenders
	backpack_contents = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/bottleofnothing=1,\
		/obj/item/toy/crayon/mime=1)

	backpack = /obj/item/weapon/storage/backpack/mime
	satchel = /obj/item/weapon/storage/backpack/mime

/datum/outfit/job/mime/post_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall(null))
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/mime/speak(null))
		H.mind.miming = 1

	H.rename_self("mime")

/*
Librarian
*/
/datum/job/librarian
	title = "Librarian"
	flag = LIBRARIAN
	department_head = list("Chief of Personnel")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief of Personnel"
	selection_color = "#dddddd"

	outfit = /datum/outfit/job/librarian

	access = list(access_library)
	minimal_access = list(access_library)

/datum/outfit/job/librarian
	name = "Librarian"

	belt = /obj/item/device/pda
	uniform = /obj/item/clothing/under/rank/librarian
	l_hand = /obj/item/weapon/storage/bag/books
	r_pocket = /obj/item/weapon/barcodescanner
	l_pocket = /obj/item/device/laser_pointer

/*
Bridge Officer
*/
/datum/job/bridgeofficer
	title = "Bridge Officer"
	flag = BRIDGE_OFFICER
	department_head = list("Captain")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Command Staff.  You are also NOT A MEMBER OF COMMAND STAFF, YOU ARE NOT IN THE CHAIN OF COMMAND.  You are a glorified console watcher."
	selection_color = "#DAA520"

	outfit = /datum/outfit/job/bridgeofficer

	access = list(access_heads)
	minimal_access = list(access_heads, access_medical)

/datum/outfit/job/bridgeofficer
	name = "Bridge Officer"

	belt = /obj/item/device/pda/librarian
	head = /obj/item/clothing/head/beret
	ears = /obj/item/device/radio/headset/heads/captain
	uniform = /obj/item/clothing/under/color/lightbrown
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	backpack_contents = list(/obj/item/clothing/head/collectable/rabbitears)
	backpack = /obj/item/weapon/storage/backpack/security
	satchel = /obj/item/weapon/storage/backpack/satchel_sec
	l_hand = /obj/item/weapon/clipboard

/*
Passenger
*/
/datum/job/passenger
	title = "Passenger"
	flag = PASSENGER
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Heads of Staff"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/passenger

/datum/outfit/job/passenger
	name = "Assistant"

/datum/outfit/job/assistant/pre_equip(mob/living/carbon/human/H)
	..()
	if (config.grey_assistants)
		uniform = /obj/item/clothing/under/color/grey
	else
		uniform = /obj/item/clothing/under/color/random

/*
Lawyer
*/

/datum/job/Defense_Attorney
	title = "Defense Attorney"
	flag = DEFAT
	department_head = list("Head of Security")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Head of Security"
	selection_color = "#D12D2D"
	var/defat = 0 //Counts lawyer amount

	outfit = /datum/outfit/job/defenseattorney

	access = list(access_security, access_sec_doors, access_brig, access_court, access_maint_tunnels, access_morgue, access_forensics_lockers)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_court)

/datum/outfit/job/defenseattorney
	name = "Defense Attorney"

	belt = /obj/item/device/pda/lawyer
	ears = /obj/item/device/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/toggle/lawyer
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/weapon/storage/briefcase
	l_pocket = /obj/item/device/laser_pointer

/*
Prisoner
*/
/*
/datum/job/prisoner
	title = "Prisoner"
	flag = PRISONER
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Security"
	selection_color = "#D8900C"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/prisoner

/datum/outfit/job/Prisoner
	name = "Prisoner"

/datum/outfit/job/prisoner
	name = "Prisoner"


	uniform = /obj/item/clothing/under/color/orange
	shoes = /obj/item/clothing/shoes/sneakers/orange
*/


