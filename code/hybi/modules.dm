// Cause I need a way to get everything sorted.
// You have to have this ACTIVATED for some stuff to work.
// Jons too good for us. :U ~TK

/mob/proc/setClickCooldown(var/timeout)
	next_move = max(world.time + timeout, next_move)

/proc/buttificate(phrase)
	var/params = replacetext(phrase, " ", "&")
	var/list/buttphrase = params2list(params)
	var/finalphrase = ""
	for(var/p in buttphrase)
		if(prob(20))
			p="butt"
		finalphrase = finalphrase+p+" "
	finalphrase = replacetext(finalphrase, " #39 ","'")
	finalphrase = replacetext(finalphrase, " s "," ") //this is really dumb and hacky, gets rid of trailing 's' character on the off chance that '#39' gets swapped
	if(findtext(finalphrase,"butt"))
		return finalphrase
	return

/proc/flick_overlay_static(image/I, atom/A, duration)
	set waitfor = 0
	if(!A || !I)
		return
	A.overlays += I
	sleep(duration)
	A.overlays -= I

/proc/mobs_in_area(var/area/A)
	var/list/mobs = new
	for(var/mob/living/M in mob_list)
		if(get_area(M) == A)
			mobs += M
	return mobs
