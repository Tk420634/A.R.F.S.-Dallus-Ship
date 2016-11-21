/mob/living/carbon/human/sme(emote as text)
	var/critical = InCritical()

	// so no subtle emotes while down.
	if(stat == UNCONSCIOUS && !critical)
		return

	if(!emote)
		return

	if(stat == DEAD)
		return

	//listing the "hearers", it's a proc which detects mobs who i can see.
	var/list/e_watching  = hearers(1, src.loc)

	//Lising another set of hearers but removing the ones who are next to me.
	var/list/e_nearby = get_hearers_in_view(2, src.loc)
	e_nearby -= e_watching

	//Putting the emote into an emote.
	emote = "<b>[src.name]</b> quietly [emote]"

	// for every person who is right next to me, play the message
	for(var/mob/M in e_watching)
		M.show_message(emote, 2)

/*  //This can be toggled back on later, if need be.  It allows ghosts to see subtle emotes from a distance.  With it off, it lets people ERP without worrying that every ghost will see them.
	var/list/listening_dead = list()
	for(var/mob/M in player_list)
		if(M.stat == DEAD && M.client && ((M.client.prefs.chat_toggles & CHAT_GHOSTWHISPER) || (get_dist(M, src) <= 7)))
			listening_dead |= M
*/

	// for everyone who is close by to me, play this message instead.
	for(var/mob/M in e_nearby)
		M.show_message("You can notice <b>[src.name]</b> do something, but you can't quite see what they're up to.", 3)



//this is to define the proc for anyone to access while being a mob.

/mob/verb/sme(emote as text)
	set name = "sme"
	set category = "IC"
	return



// dab, finished. Hybi :>