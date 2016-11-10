/mob/living/carbon/alien/humanoid/Login()
	..()
	update_hud()
	if(!isturf(loc))
		client.eye = loc
		client.perspective = EYE_PERSPECTIVE
	if(isalienhunter(src))
		src << "<span class='notice'>You can pounce! Middle mouse click anywhere to pounce to that location! Alternatively you can left mouse click after toggling pouncing on with the HUD button.</span>"
		return
	if(isaliendrone(src))
		return
	if(isaliensentinel(src))
		if(src.getorgan(/obj/item/organ/internal/alien/neurotoxin))
			src << "<span class='notice'>You can spit neurotoxin! Middle mouse click anywhere to spit towards that location!</span>"
		return
	if(isalienravager(src))
		src << "<span class='notice'>You can charge! Middle mouse click anywhere to charge in that direction!</span>"
		return
	if(isalienpraetorian(src))
		if(src.getorgan(/obj/item/organ/internal/alien/neurotoxin))
			src << "<span class='notice'>You can spit neurotoxin! Middle mouse click anywhere to spit towards that location!</span>"
		return
	if(isalienqueen(src))
		if(src.getorgan(/obj/item/organ/internal/alien/neurotoxin))
			src << "<span class='notice'>You can spit neurotoxin! Middle mouse click anywhere to spit towards that location!</span>"
		return