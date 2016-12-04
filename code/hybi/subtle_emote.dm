/mob/living/carbon/human/sme(emote as text, mob/user = usr)
	var/critical = InCritical()

	// so no subtle emotes while down.
	if(stat == UNCONSCIOUS && !critical)
		return

	if(!emote)
		return

	if(stat == DEAD)
		return

	//preparing to clean the emote and make sure no html is applied
	var/rendered_emote = emote
	// doing what i said above
	rendered_emote = trim(copytext(sanitize(rendered_emote), 1, MAX_MESSAGE_LEN))


	// For every mob in view 1 tile around the player, show the emote message for "eyes" to see.
	// that's why "1" on the end of show_message, because it handles the rest for me.
	for(var/mob/M in view(1,usr.loc))
		M.show_message("<b>[usr]</b> [rendered_emote]",1)


	/* future work
	var/list/e_nearby
	var/list/e_distant

	for(var/mob/M in view(1,usr.loc))
		e_nearby += M

	for(var/mob/M in view(6,usr.loc))
		e_distant += M

	for(var/list/e_distant/M in e_nearby)
		M -= e_nearby

	*/


//this is to define the proc for anyone to access while being a mob.
/mob/verb/sme(emote as text)
	set name = "sme"
	set category = "IC"
	return



// dab, finished. Hybi :>