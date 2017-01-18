/mob/living/carbon/alien/humanoid/emote(act,m_type=1,message = null)

	var/param = null
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	var/muzzled = is_muzzled()

	switch(act) //Alphabetical please
		if ("deathgasp","deathgasps")
			message = "<span class='name'>[src]</span> lets out a waning guttural screech, green blood bubbling from its maw..."
			m_type = 2

		if ("gnarl","gnarls","Gnarl","Gnarls")
			if (!muzzled)
				message = "<span class='name'>[src]</span> gnarls and shows its teeth.."
				m_type = 2

		if ("hiss","hisses","Hiss","Hisses")
			if(!muzzled)
				message = "<span class='name'>[src]</span> hisses."
				m_type = 2
		if ("hurt","Hurt")
			message = "<span class='name'>[src]</span> screeches and recoils in pain!"
			m_type = 2

		if ("me")
			..()
			return

		if ("moan","moans")
			message = "<span class='name'>[src]</span> moans!"
			m_type = 2

		if ("roar","roars","Roar","Roars")
			if (!muzzled)
				message = "<span class='name'>[src]</span> roars!"
				m_type = 2

		if ("roll","rolls")
			if (!src.restrained())
				message = "<span class='name'>[src]</span> rolls."
				m_type = 1

		if ("scratch","scratches")
			if (!src.restrained())
				message = "<span class='name'>[src]</span> scratches."
				m_type = 1

		if ("screech","screeches","Screech","Screeches")
			if (!muzzled)
				message = "<span class='name'>[src]</span> screeches!"
				m_type = 2

		if ("shiver","shivers")
			message = "<span class='name'>[src]</span> shivers."
			m_type = 2

		if ("sign","signs")
			if (!src.restrained())
				message = text("<span class='name'>[src]</span> signs[].", (text2num(param) ? text(" the number []", text2num(param)) : null))
				m_type = 1
		if ("growl","growls","Growl","Growls")
			if (!muzzled)
				message = "<span class='name'>[src]</span> growls!"
				m_type = 2

		if ("tail")
			message = "<span class='name'>[src]</span> waves its tail."
			m_type = 1

		if ("help") //This is an exception
			src << "Help for xenomorph emotes. You can use these emotes with say \"*emote\":\n\naflap, airguitar, blink, blink_r, blush, bow, burp, choke, chucke, clap, collapse, cough, dance, deathgasp, drool, flap, frown, gasp, giggle, glare-(none)/mob, gnarl, growl, hiss, jump, laugh, look-atom, me, moan, nod, point-atom, roar, roll, scream, scratch, screech, shake, shiver, sign-#, sit, smile, sneeze, sniff, snore, stare-(none)/mob, sulk, sway, tail, tremble, twitch, twitch_s, wave, whimper, wink, yawn"

		else
			..(act)

	if ((message && src.stat == 0))
		log_emote("[name]/[key] : [message]")
		if (act == "deathgasp")
			playsound(src.loc, 'sound/voice/hiss6.ogg', 80, 0, 16)

		if (act == "screech" || act == "roar")
			playsound(src.loc, pick('sound/alien/Voice/screech1.ogg', 'sound/alien/Voice/screech2.ogg', 'sound/alien/Voice/screech3.ogg', 'sound/alien/Voice/screech4.ogg'), 100, 0, 16)

		if (act == "hiss")
			playsound(src.loc, pick('sound/alien/Voice/hiss1.ogg', 'sound/alien/Voice/hiss2.ogg', 'sound/alien/Voice/hiss3.ogg', 'sound/alien/Voice/hiss4.ogg', 'sound/alien/Voice/hiss5.ogg'), 100, 0, 16)

		if (act == "growl")
			playsound(src.loc, pick('sound/alien/Voice/growl1.ogg', 'sound/alien/Voice/growl2.ogg', 'sound/alien/Voice/growl3.ogg', 'sound/alien/Voice/growl4.ogg', 'sound/alien/Voice/growl5.ogg', 'sound/alien/Voice/growl6.ogg', 'sound/alien/Voice/growl7.ogg', 'sound/alien/Voice/growl8.ogg', 'sound/alien/Voice/growl9.ogg', 'sound/alien/Voice/growl10.ogg'), 100, 0, 4)

		if (act == "gnarl")
			playsound(src.loc, 'sound/alien/Voice/gnarl1.ogg', 100, 0, 6)

		if (act == "hurt")
			playsound(src.loc, pick('sound/alien/Voice/hurt1.ogg', 'sound/alien/Voice/hurt2.ogg'), 200, 0, 10)

		if (m_type & 1)
			visible_message(message)
		else
			audible_message(message)
