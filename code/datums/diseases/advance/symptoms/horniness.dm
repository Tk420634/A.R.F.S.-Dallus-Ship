/*
//////////////////////////////////////

Horniness // gotta lewd it all

	Noticable.
	Lowers resistance significantly.
	Decreases stage speed moderately..
	Increases transmittablity
	Moderate Level.

Bonus
	The body generates Aphrodisiacs.

//////////////////////////////////////
*/

/datum/symptom/horniness

	name = "Horniness"
	stealth = -3
	resistance = -1
	stage_speed = 0
	transmittable = 2
	level = 1

/datum/symptom/horniness/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB * 10))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(5)
				if (M.reagents.get_reagent_amount("hornychem") < 15)
					M.reagents.add_reagent("hornychem", 15)
			else
				if(prob(SYMPTOM_ACTIVATION_PROB * 5))
					M << "<span class='notice'>[pick("You feel horny.", "You want to fuck everyone on the station...", "Your sexual desires are overwhelming!", "You want to relieve your sexual tension...", "You feel aroused.", "Your groin feels nice and warm.")]</span>"

	return