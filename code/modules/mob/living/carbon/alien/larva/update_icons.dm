
/mob/living/carbon/alien/larva/regenerate_icons()
	overlays = list()
	update_icons()

/mob/living/carbon/alien/larva/update_icons()
	var/state
	switch(amount_grown)
		if(0 to 25)
			state = 0
		if(25 to 75)
			state = 1
		if(75 to 150)
			state = 2
		if(150 to 200)
			state = 3
	if(isnull(state))
		state = 1


	if(stat == DEAD)
		icon_state = "larva[state]_dead"
	else if (handcuffed || legcuffed) //This should be an overlay. Who made this an icon_state?
		icon_state = "larva[state]_cuff"
	else if(stat == UNCONSCIOUS || lying || resting)
		icon_state = "larva[state]_sleep"
	else if (stunned)
		icon_state = "larva[state]_stun"
	else
		icon_state = "larva[state]"

/mob/living/carbon/alien/larva/update_transform() //All this is handled in update_icons()
	..()
	return update_icons()

/mob/living/carbon/alien/larva/update_inv_handcuffed()
	return