
//Eyeball migration
/datum/round_event_control/carp_migration/meatbats
	name = "Meatbat Migration"
	typepath = /datum/round_event/carp_migration/eyeballs
	holidayID = VALENTINES
	weight = 25
	earliest_start = 0

/datum/round_event/carp_migration/meatbats/start()
	for(var/obj/effect/landmark/C in landmarks_list)
		if(C.name == "carpspawn")
			new /mob/living/simple_animal/hostile/carp/meatbat(C.loc)
