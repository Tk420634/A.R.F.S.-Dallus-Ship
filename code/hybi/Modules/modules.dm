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

/mob/living/proc/thundersmite()
	var/image/img = image(icon = 'icons/effects/224x224.dmi', icon_state = "lightning")
	img.pixel_x = -world.icon_size*3
	img.pixel_y = -world.icon_size
	flick_overlay_static(img, src, 10)
	playsound(src,'sound/effects/thunder.ogg', 90, 1)
	spawn(10)
	gib()

//copied from vorestation, so useful.
/proc/hear(var/range, var/atom/source)

	var/lum = source.luminosity
	source.luminosity = 6

	var/list/heard = view(range, source)
	source.luminosity = lum

	return heard


/proc/recursive_content_check(var/atom/O,  var/list/L = list(), var/recursion_limit = 3, var/client_check = 1, var/sight_check = 1, var/include_mobs = 1, var/include_objects = 1, var/ignore_show_messages = 0)

	if(!recursion_limit)
		return L

	for(var/I in O.contents)

		if(ismob(I))
			if(!sight_check || isInSight(I, O))
				L |= recursive_content_check(I, L, recursion_limit - 1, client_check, sight_check, include_mobs, include_objects)
				if(include_mobs)
					if(client_check)
						var/mob/M = I
						if(M.client)
							L |= M
					else
						L |= I

/*		else if(istype(I,/obj/))
			var/obj/check_obj = I
			if(ignore_show_messages || check_obj.show_messages)
				if(!sight_check || isInSight(I, O))
					L |= recursive_content_check(I, L, recursion_limit - 1, client_check, sight_check, include_mobs, include_objects)
					if(include_objects)
						L |= I*/

	return L


/proc/get_mobs_or_objects_in_view(var/R, var/atom/source, var/include_mobs = 1, var/include_objects = 1)

	var/turf/T = get_turf(source)
	var/list/hear = list()

	if(!T)
		return hear

	var/list/range = hear(R, T)

	for(var/I in range)
		if(ismob(I))
			hear |= recursive_content_check(I, hear, 3, 1, 0, include_mobs, include_objects)
			if(include_mobs)
				var/mob/M = I
				if(M.client)
					hear += M
	//	else if(istype(I,/obj/))
//			hear |= recursive_content_check(I, hear, 3, 1, 0, include_mobs, include_objects)
//			var/obj/O = I
//			if(O.show_messages && include_objects)
//				hear += I

	return hear
