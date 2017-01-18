/datum/symptom/meme

	name = "Memeitis"
	stealth = -1
	resistance = -1
	stage_speed = -1
	transmittable = -1
	level = 2
	severity = 2

/datum/symptom/meme/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(1, 2, 3, 4)
				if(prob(SYMPTOM_ACTIVATION_PROB * 10))
					M << "<span class='warning'>[pick("You feel like John Madden.", "aeiou", "You realise there is no reason to be upset.")]</span>"

			else
				if(prob(SYMPTOM_ACTIVATION_PROB * 10))
					M.say(pick("AEIOU", "John Madden!", "AND HIS NAME IS JOHN CENA!!", "You're a big guy.", "Get out of here, stalker!", "BENIS!", "Raw toast.", "Don't let your memes be dreams!", "JUST DO IT!!", "We got a badass over here.", "I use to be an adventurer like you. Then I took an arrow in the knee.", "There is no reason to be upset." ))
				if(prob(SYMPTOM_ACTIVATION_PROB * 50))
					M.adjustBrainLoss(5)

	return
