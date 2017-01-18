/mob/living/carbon/alien/humanoid/death(gibbed)
	if(stat == DEAD)	return
	if(healths)			healths.icon_state = "health6"
	stat = DEAD
	if(!deathNotified)
		deathNotice()
	if(!gibbed)
		playsound(loc, 'sound/voice/hiss6.ogg', 80, 1, 1)
		visible_message("<span class='name'>[src]</span> lets out a waning guttural screech, green blood bubbling from its maw...")
		update_canmove()
		if(client)	blind.layer = 0
		update_icons()
		status_flags |=CANPUSH
		if(fireloss >= (maxHealth/2))
			spawn(10)
			visible_message("<span class='warning'>[src] starts shaking...</span>")
			spawn(30)
				src.gib()

	tod = worldtime2text() //weasellos time of death patch
	if(mind) 	mind.store_memory("Time of death: [tod]", 0)

	return ..(gibbed)

/mob/living/carbon/alien/humanoid/gib()
	visible_message("<span class='danger'>[src] explodes in a shower of acid blood and gibs!</span>")
	for(var/mob/living/M in viewers(2, src))
		if(ishuman(M))
			M << "<span class='userdanger'>You're sprayed with acid blood!</span>"
			M.adjustFireLoss(15)
			M.reagents.add_reagent("sacid",5)
		else if(ismonkey(M))
			M << "<span class='userdanger'>You're sprayed with acid blood!</span>"
			M.adjustFireLoss(15)
			M.reagents.add_reagent("sacid",5)
		else if(!isalien(M))
			M << "<span class='userdanger'>You're sprayed with acid blood!</span>"
			M.adjustFireLoss(20)
	..()
