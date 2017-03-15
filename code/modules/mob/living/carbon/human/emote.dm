/mob/living/carbon/human/emote(act,m_type=1,message = null)
	var/param = null

	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	var/muzzled = is_muzzled()
	//var/m_type = 1

	for (var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)


	var/miming=0
	if(mind)
		miming=mind.miming

	if(src.stat == 2 && (act != "deathgasp"))
		return
	switch(act) //Please keep this alphabetically ordered when adding or changing emotes.
		if ("aflap") //Any emote on human that uses miming must be left in, oh well.
			if (!src.restrained())
				message = "<B>[src]</B> flaps \his wings ANGRILY!"
				m_type = 2

		if ("choke","chokes")
			if (miming)
				message = "<B>[src]</B> clutches \his throat desperately!"
			else
				..(act)

		if ("chuckle","chuckles")
			if(miming)
				message = "<B>[src]</B> appears to chuckle."
			else
				..(act)

		if ("clap","claps")
			if (!src.restrained())
				message = "<B>[src]</B> claps."
				m_type = 2

		if ("collapse","collapses")
			Paralyse(2)
			adjustStaminaLoss(100) // Hampers abuse against simple mobs, but still leaves it a viable option.
			message = "<B>[src]</B> collapses!"
			m_type = 2

		if ("cough","coughs")
			if (miming)
				message = "<B>[src]</B> appears to cough!"
			else
				if (!muzzled)
					message = "<B>[src]</B> coughs!"
					m_type = 2
				else
					message = "<B>[src]</B> makes a strong noise."
					m_type = 2

		if ("cry","crys","cries") //I feel bad if people put s at the end of cry. -Sum99
			if (miming)
				message = "<B>[src]</B> cries."
			else
				if (!muzzled)
					message = "<B>[src]</B> cries."
					m_type = 2
				else
					message = "<B>[src]</B> makes a weak noise. \He frowns."
					m_type = 2

		if ("custom")
			if(jobban_isbanned(src, "emote"))
				src << "You cannot send custom emotes (banned)"
				return
			if(src.client)
				if(client.prefs.muted & MUTE_IC)
					src << "You cannot send IC messages (muted)."
					return
			var/input = copytext(sanitize(input("Choose an emote to display.") as text|null),1,MAX_MESSAGE_LEN)
			if (!input)
				return
			if(copytext(input,1,5) == "says")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(input,1,9) == "exclaims")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(input,1,6) == "yells")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(input,1,5) == "asks")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else
				var/input2 = input("Is this a visible or hearable emote?") in list("Visible","Hearable")
				if (input2 == "Visible")
					m_type = 1
				else if (input2 == "Hearable")
					if(miming)
						return
					m_type = 2
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
				message = "<B>[src]</B> [input]"

		if ("dap","daps")
			m_type = 1
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (M)
					message = "<B>[src]</B> gives daps to [M]."
				else
					message = "<B>[src]</B> sadly can't find anybody to give daps to, and daps \himself. Shameful."

		if ("eyebrow")
			message = "<B>[src]</B> raises an eyebrow."
			m_type = 1

		if ("flap","flaps")
			if (!src.restrained())
				message = "<B>[src]</B> flaps \his wings."
				m_type = 2

		if ("gasp","gasps")
			if (miming)
				message = "<B>[src]</B> appears to be gasping!"
			else
				..(act)

		if ("giggle","giggles")
			if (miming)
				message = "<B>[src]</B> giggles silently!"
			else
				..(act)

		if ("groan","groans")
			if (miming)
				message = "<B>[src]</B> appears to groan!"
			else
				if (!muzzled)
					message = "<B>[src]</B> groans!"
					m_type = 2
				else
					message = "<B>[src]</B> makes a loud noise."
					m_type = 2

		if ("grumble","grumbles")
			if (!muzzled)
				message = "<B>[src]</B> grumbles!"
			else
				message = "<B>[src]</B> makes a noise."
				m_type = 2

		if ("handshake")
			m_type = 1
			if (!src.restrained() && !src.r_hand)
				var/mob/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null
				if (M)
					if (M.canmove && !M.r_hand && !M.restrained())
						message = "<B>[src]</B> shakes hands with [M]."
					else
						message = "<B>[src]</B> holds out \his hand to [M]."

		if ("hug","hugs")
			m_type = 1
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null
				if (M)
					message = "<B>[src]</B> hugs [M]."
				else
					message = "<B>[src]</B> hugs \himself."

		if ("me")
			if(silent)
				return
			if(jobban_isbanned(src, "emote"))
				src << "You cannot send custom emotes (banned)"
				return
			if (src.client)
				if (client.prefs.muted & MUTE_IC)
					src << "<span class='danger'>You cannot send IC messages (muted).</span>"
					return
				if (src.client.handle_spam_prevention(message,MUTE_IC))
					return
			if (stat)
				return
			if(!(message))
				return
			if(copytext(message,1,5) == "says")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(message,1,9) == "exclaims")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(message,1,6) == "yells")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else if(copytext(message,1,5) == "asks")
				src << "<span class='danger'>Invalid emote.</span>"
				return
			else
				message = "<B>[src]</B> [message]"

		if ("moan","moans")
			if(miming)
				message = "<B>[src]</B> appears to moan!"
			else
				message = "<B>[src]</B> moans!"
				m_type = 2

		if ("mumble","mumbles")
			message = "<B>[src]</B> mumbles!"
			m_type = 2

		if ("pale")
			message = "<B>[src]</B> goes pale for a second."
			m_type = 1

		if ("raise")
			if (!src.restrained())
				message = "<B>[src]</B> raises a hand."
			m_type = 1

		if ("salute","salutes")
			if (!src.buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(1, src))
						if (param == A.name)
							M = A
							break
				if (!M)
					param = null
				if (param)
					message = "<B>[src]</B> salutes to [param]."
				else
					message = "<B>[src]</b> salutes."
			m_type = 1

		if ("scream","screams")
			if(oxyloss > 50)
				src << "You're out of breath!"
				return
			if (miming)
				message = "<B>[src]</B> acts out a scream!"
			else
//				if(prob(5))
//					playsound(src.loc, 'sound/misc/scream_wilhelm.ogg', 50, 1, 5) //do i need to explain this
//					..(act)
//				else
				if(src.dna)
					var/DNA = src.dna.species.id

					switch(DNA)

						if("alien")
							playsound(src.loc, pick('sound/alien/Voice/screech1.ogg', 'sound/alien/Voice/screech2.ogg', 'sound/alien/Voice/screech3.ogg', 'sound/alien/Voice/screech4.ogg'), 50, 0, 5)
							if(prob(33))
								..(act)

						if("moth")
							playsound(src.loc, 'sound/misc/moth.ogg', 50, 1, 5)

						if("ailurus")
							playsound(src.loc, 'sound/misc/redpanda1.ogg', 50, 1, 5)

						if("anubis")
							playsound(src.loc, 'sound/misc/anubis1.ogg', 50, 1, 5)

						if("bat")
							playsound(src.loc, 'sound/misc/bat1.ogg', 50, 1, 5)

						if("beaver")
							playsound(src.loc, 'sound/misc/beaver1.ogg', 50, 1, 5)

						if("bee")
							playsound(src.loc, 'sound/misc/moth.ogg', 50, 1, 5)

					/*	if("boar")
							playsound(src.loc, 'sound/misc/boar1.ogg', 50, 1, 5) */

						if("capra")
							playsound(src.loc, 'sound/misc/capra1.ogg', 50, 1, 5)

						if("carp")
							playsound(src.loc, 'sound/misc/carp1.ogg', 50, 1, 5)

						if("corgi")
							if(prob(50))
								playsound(src.loc, 'sound/misc/corgi2.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/corgi1.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/corgi2.ogg', 35, 1, 5)
									..(act)

						if("cow")
							playsound(src.loc, 'sound/misc/cow1.ogg', 50, 1, 5)

						if("coyote")
							if(prob(50))
								playsound(src.loc, 'sound/misc/coyote2.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/coyote1.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/coyote2.ogg', 35, 1, 5)
									..(act)

						if("croc")
							playsound(src.loc, 'sound/misc/croc1.ogg', 50, 1, 5)

						if("deer")
							playsound(src.loc, 'sound/misc/deer1.ogg', 50, 1, 5)

						if("drider")
							playsound(src.loc, 'sound/misc/drider1.ogg', 50, 1, 5)

						if("coyote")
							if(prob(50))
								playsound(src.loc, 'sound/misc/coyote2.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/coyote1.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/coyote2.ogg', 35, 1, 5)
									..(act)

						if("drake")
							if(prob(50))
								playsound(src.loc, 'sound/misc/drake_1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/drake_2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/drake_1.ogg', 35, 1, 5)
									..(act)

						if("dalmatian")
							if(prob(50))
								playsound(src.loc, 'sound/misc/dalmation1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/dalmation2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/dalmation1.ogg', 35, 1, 5)
									..(act)

						if("eevee")
							playsound(src.loc, 'sound/misc/eevee1.ogg', 50, 1, 5)

						if("ceratotaur")
							playsound(src.loc, 'sound/misc/theropod_1.ogg', 50, 1, 5)

						if("carno")
							playsound(src.loc, 'sound/misc/theropod_1.ogg', 50, 1, 5)


						if("fennec")
							if(prob(50))
								playsound(src.loc, 'sound/misc/fennic1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/fennic2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/fennic1.ogg', 35, 1, 5)
									..(act)

						if("fox")
							playsound(src.loc, 'sound/misc/fox1.ogg', 50, 1, 5)

						if("kitsune")
							playsound(src.loc, 'sound/misc/kitsune1.ogg', 50, 1, 5)

						if("ming")
							playsound(src.loc, 'sound/misc/kitsune1.ogg', 50, 1, 5)

						if("glowfen")
							playsound(src.loc, 'sound/misc/fox1.ogg', 50, 1, 5)

						if("corvid")
							if(prob(50))
								playsound(src.loc, 'sound/misc/bird_1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/bird_2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/bird_1.ogg', 35, 1, 5)
									..(act)

					/*	if("hippo")
							playsound(src.loc, 'sound/misc/hippo1.ogg', 50, 1, 5) */

						if("hummingbird")
							playsound(src.loc, 'sound/misc/hummingbird1.ogg', 50, 1, 5)


						if("hawk")
							if(prob(50))
								playsound(src.loc, 'sound/misc/bird_1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/bird_2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/bird_1.ogg', 35, 1, 5)
									..(act)

						if("husky")
							if(prob(50))
								playsound(src.loc, 'sound/misc/husky1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/husky2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/husky1.ogg', 35, 1, 5)
									..(act)

						if("robot")
							if(prob(50))
								playsound(src.loc, 'sound/misc/robot_1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/robot_6.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/robot_2.ogg', 35, 1, 5)
									..(act)

						if("hyena")
							playsound(src.loc, 'sound/misc/hyena1.ogg', 50, 1, 5)

						if("elephant")
							playsound(src.loc, 'sound/misc/elephant_1.ogg', 50, 1, 5)

						if("shihtzu")
							playsound(src.loc, 'sound/misc/shihtzu_1.ogg', 50, 1, 5)

						if("orca")
							playsound(src.loc, 'sound/misc/orca_1.ogg', 50, 1, 5)

						if("jackalope")
							playsound(src.loc, 'sound/misc/rabbit1.ogg', 50, 1, 5)

						if("kangaroo")
							playsound(src.loc, 'sound/misc/kangaroo1.ogg', 50, 1, 5)

						if("lab")
							if(prob(50))
								playsound(src.loc, 'sound/misc/lab1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/lab2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/lab1.ogg', 35, 1, 5)
									..(act)

						if("lopunny")
							if(prob(50))
								playsound(src.loc, 'sound/misc/Lopunny1.ogg', 50, 1, 5)
							else
								if(prob(5))
									playsound(src.loc, 'sound/misc/Lopunny1.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/Lopunny2.ogg', 35, 1, 5)
									..(act)


						if("lucky")
							playsound(src.loc, 'sound/misc/kitsune1.ogg', 50, 1, 5)


						if("leporid")
							playsound(src.loc, 'sound/misc/rabbit1.ogg', 50, 1, 5)

						if("lizard")
							playsound(src.loc, 'sound/misc/lizard1.ogg', 50, 1, 5)

						if("murid")
							playsound(src.loc, 'sound/misc/murid1.ogg', 50, 1, 5)

						if("monkey")
							playsound(src.loc, 'sound/misc/monkey1.ogg', 50, 1, 5)

						if("panda")
							playsound(src.loc, 'sound/misc/panda1.ogg', 50, 1, 5)

						if("pig")
							if(prob(50))
								playsound(src.loc, 'sound/misc/pig1.ogg', 50, 1, 5)
							else
								if(prob(25))
									playsound(src.loc, 'sound/misc/pig2.ogg', 50, 1, 5)
								else
									playsound(src.loc, 'sound/misc/pig1.ogg', 35, 1, 5)
									..(act)

						if("porcupine")
							playsound(src.loc, 'sound/misc/porcupine1.ogg', 50, 1, 5)

						if("possum")
							playsound(src.loc, 'sound/misc/possum1.ogg', 50, 1, 5)

					/*	if("pug")
							playsound(src.loc, 'sound/misc/pug1.ogg', 50, 1, 5) */

						if("penguin")
							playsound(src.loc, 'sound/misc/penguin1.ogg', 50, 1, 5)

						if("otie")
							playsound(src.loc, 'sound/misc/ottie1.ogg', 50, 1, 5)


						if("raccoon")
							playsound(src.loc, 'sound/misc/raccoon1.ogg', 50, 1, 5)

						if("roorat")
							playsound(src.loc, 'sound/misc/murid1.ogg', 50, 1, 5)

						if("shepherd")
							playsound(src.loc, 'sound/misc/shepherd1.ogg', 50, 1, 5)

						if("skunk")
							playsound(src.loc, 'sound/misc/skunk1.ogg', 50, 1, 5)

						if("smilodon")
							playsound(src.loc, 'sound/misc/tiger1.ogg', 50, 1, 5)

						if("panther")
							playsound(src.loc, 'sound/misc/cougar1.ogg', 50, 1, 5)

						if("squirrel")
							playsound(src.loc, 'sound/misc/squirrel1.ogg', 50, 1, 5)

						if("tajaran")
							playsound(src.loc, 'sound/misc/tiger1.ogg', 50, 1, 5)

						if("tiger")
							playsound(src.loc, 'sound/misc/tiger1.ogg', 50, 1, 5)

						if("ursine")
							playsound(src.loc, 'sound/misc/bear1.ogg', 50, 1, 5)

						if("stitch")
							playsound(src.loc, 'sound/misc/bear1.ogg', 50, 1, 5)

						if("vulture")
							playsound(src.loc, 'sound/misc/vulture1.ogg', 50, 1, 5)

						if("wolf")
							playsound(src.loc, 'sound/misc/wolf1.ogg', 50, 1, 5)

						if("zigzagoon")
							playsound(src.loc, 'sound/misc/zig1.ogg', 50, 1, 5)

						if("grovyle")
							playsound(src.loc, 'sound/misc/Grov1.ogg', 50, 1, 5)

						if("glaceons")
							playsound(src.loc, 'sound/misc/Glaceon1.ogg', 50, 1, 5)

						if("glaceon")
							playsound(src.loc, 'sound/misc/Glaceon1.ogg', 50, 1, 5)

						if("flareon")
							playsound(src.loc, 'sound/misc/Flareon1.ogg', 50, 1, 5)


						else


							if(src.gender == MALE)
								if(prob(50))
									playsound(src.loc, 'sound/misc/scream_m1.ogg', 50, 1, 5)
								else
									if(prob(25))
										playsound(src.loc, 'sound/misc/scream_m2.ogg', 50, 1, 5)
									else
										playsound(src.loc, 'sound/misc/scream_m.ogg', 35, 1, 5)
										..(act)
							else

								if(src.gender == FEMALE)
									if(prob(50))
										playsound(src.loc, 'sound/misc/scream_f1.ogg', 50, 1, 5)
									else
										if(prob(25))
											playsound(src.loc, 'sound/misc/scream_f2.ogg', 50, 1, 5)
										else
											playsound(src.loc, 'sound/misc/scream_f.ogg', 35, 1, 5)

							// add whatever other race here

			message = "<B>[src]</B> screams!"
			m_type = 2
			src.adjustOxyLoss(5)




		if ("shiver","shivers")
			message = "<B>[src]</B> shivers."
			m_type = 1

		if ("shrug","shrugs")
			message = "<B>[src]</B> shrugs."
			m_type = 1

		if ("sigh","sighs")
			if(miming)
				message = "<B>[src]</B> sighs."
			else
				..(act)

		if ("signal","signals")
			if (!src.restrained())
				var/t1 = round(text2num(param))
				if (isnum(t1))
					if (t1 <= 5 && (!src.r_hand || !src.l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
					else if (t1 <= 10 && (!src.r_hand && !src.l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
			m_type = 1

		if ("sneeze","sneezes")
			if (miming)
				message = "<B>[src]</B> sneezes."
			else
				..(act)

		if ("sniff","sniffs")
			message = "<B>[src]</B> sniffs."
			m_type = 2

		if ("snore","snores")
			if (miming)
				message = "<B>[src]</B> sleeps soundly."
			else
				..(act)

		if ("whimper","whimpers")
			if (miming)
				message = "<B>[src]</B> appears hurt."
			else
				..(act)

		if ("yawn","yawns")
			if (!muzzled)
				message = "<B>[src]</B> yawns."
				m_type = 2

		if("wag","wags")
			if(dna && dna.species && (("tail_lizard" in dna.species.mutant_bodyparts) || (dna.features["tail_human"] != "None")))
				message = "<B>[src]</B> wags \his tail."
				startTailWag()
			else
				src << "<span class='notice'>Unusable emote '[act]'. Say *help for a list.</span>"

		if("stopwag")
			if(dna && dna.species && (("waggingtail_lizard" in dna.species.mutant_bodyparts) || ("waggingtail_human" in dna.species.mutant_bodyparts)))
				message = "<B>[src]</B> stops wagging \his tail."
				endTailWag()
			else
				src << "<span class='notice'>Unusable emote '[act]'. Say *help for a list.</span>"

		if ("fart")
			var/obj/item/organ/internal/butt/B = getorgan(/obj/item/organ/internal/butt)
			if(!B)
				src << "<span class='danger'>You don't have a butt!</span>"
				return
			var/lose_butt = prob(6)
			if(!message)
				message = "<B>[src]</B> [pick(
					"rears up and lets loose a fart of tremendous magnitude!",
					"farts!",
					"toots.",
					"harvests methane from uranus at mach 3!",
					"assists global warming!",
					"farts and waves their hand dismissively.",
					"farts and pretends nothing happened.",
					"is a <b>farting</b> motherfucker!",
					"<B><font color='red'>f</font><font color='blue'>a</font><font color='red'>r</font><font color='blue'>t</font><font color='red'>s</font></B>")]"
				playsound(src, 'sound/effects/fart.ogg', 50, 1, 5)
			spawn(0)

				var/obj/item/weapon/storage/book/bible/Y = locate() in get_turf(src)
				if(Y)
					var/image/img = image(icon = 'icons/effects/224x224.dmi', icon_state = "lightning")
					img.pixel_x = -world.icon_size*3
					img.pixel_y = -world.icon_size
					flick_overlay_static(img, Y, 10)
					playsound(Y,'sound/effects/thunder.ogg', 90, 1)
					spawn(10)
					gib()

			if(lose_butt)
				B.loc = get_turf(src)
				B.Remove(src)
				new /obj/effect/decal/cleanable/blood(get_turf(src))
				nutrition -= rand(15, 30)
				visible_message("\red <b>[src]</b> blows their ass off!", "\red Holy butt, your butt flies off in an arc!")
			else
				nutrition -= rand(5, 25)


		if ("help") //This can stay at the bottom.
			src << "Help for human emotes. You can use these emotes with say \"*emote\":\n\naflap, airguitar, blink, blink_r, blush, bow-(none)/mob, burp, choke, chuckle, clap, collapse, cough, cry, custom, dance, dap, deathgasp, drool, eyebrow, faint, flap, frown, gasp, giggle, glare-(none)/mob, grin, groan, grumble, handshake, hug-(none)/mob, jump, laugh, look-(none)/mob, me, moan, mumble, nod, pale, point-(atom), raise, salute, scream, shake, shiver, shrug, sigh, signal-#1-10, sit, smile, sneeze, sniff, snore, stare-(none)/mob, sulk, sway, stopwag, tremble, twitch, twitch_s, wave, whimper, wink, wag, yawn"

		else
			..(act)

	if(miming)
		m_type = 1



	if (message)
		log_emote("[name]/[key] : [message]")

 //Hearing gasp and such every five seconds is not good emotes were not global for a reason.
 // Maybe some people are okay with that.

		for(var/mob/M in dead_mob_list)
			if(!M.client || istype(M, /mob/new_player))
				continue //skip monkeys, leavers and new players
			if(M.stat == DEAD && M.client && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(src,null)))
				M.show_message(message)


		if (m_type & 1)
			visible_message(message)
		else if (m_type & 2)
			audible_message(message)



//Don't know where else to put this, it's basically an emote
/mob/living/carbon/human/proc/startTailWag()
	if(!dna || !dna.species)
		return
	if("tail_lizard" in dna.species.mutant_bodyparts)
		dna.species.mutant_bodyparts -= "tail_lizard"
		dna.species.mutant_bodyparts -= "spines"
		dna.species.mutant_bodyparts |= "waggingtail_lizard"
		dna.species.mutant_bodyparts |= "waggingspines"
	if("tail_human" in dna.species.mutant_bodyparts)
		dna.species.mutant_bodyparts -= "tail_human"
		dna.species.mutant_bodyparts |= "waggingtail_human"
	update_body()


/mob/living/carbon/human/proc/endTailWag()
	if(!dna || !dna.species)
		return
	if("waggingtail_lizard" in dna.species.mutant_bodyparts)
		dna.species.mutant_bodyparts -= "waggingtail_lizard"
		dna.species.mutant_bodyparts -= "waggingspines"
		dna.species.mutant_bodyparts |= "tail_lizard"
		dna.species.mutant_bodyparts |= "spines"
	if("waggingtail_human" in dna.species.mutant_bodyparts)
		dna.species.mutant_bodyparts -= "waggingtail_human"
		dna.species.mutant_bodyparts |= "tail_human"
	update_body()

/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavor Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	flavor_text =  copytext(sanitize(input(usr, "Please enter your new flavor text.", "Flavor text", null)  as text), 1)
