//OBJECT SUPPORT COMING SOON.
/mob/proc/subtle_emote(var/m_type=1,var/message = null)
	if(stat)
		return

	var/emote
	if(!message)
		emote = sanitize(input(src,"Subtle emote") as text|null)
	else
		emote = message

	if(emote)
		message = "<I><B>[src]</B> [emote]</I>"
	else
		return

	if(message)
		log_emote("[name]/[key] : [emote]")


		for(var/mob/M in player_list)
			if(!M.client)
				continue // Ignores any braindeads/simple_animals with no client.
			if(M.stat)
				continue
			if(!istype(M,/mob/new_player) && M.stat == DEAD && M.client && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(src,null)))
				M.show_message(message, m_type)

		var/list/subtle = get_mobs_or_objects_in_view(1,src)
		for(var/I in subtle)
			if(ismob(I))
				spawn(0)
					if(I)
						var/mob/M = I
						M.show_message(message,2)


/*
	for(var/mob/M in view(1,usr.loc))
		M.show_message("<b>[attach_spans(usr, spans)]</b> [attach_spans(rendered_emote, spans)]",1)

*/
//this is to define the proc for anyone to access while being a mob.
/mob/verb/sme(message as text)
	set name = "Subtle"
	set category = "IC"
	set desc = "Make a very subtle emote to people next to you."
	message = sanitize(message)
	if (client.prefs.muted & MUTE_IC)
		src << "<span class='danger'>You cannot send IC messages (muted).</span>"
		return
	if (src.client.handle_spam_prevention(message,MUTE_IC))
		return

	usr.send_emote("me",4,message)



/mob/proc/send_emote(var/act, var/type, var/message) //This would normally go in say.dm
	if(act == "me")
		return subtle_emote(type, message)
