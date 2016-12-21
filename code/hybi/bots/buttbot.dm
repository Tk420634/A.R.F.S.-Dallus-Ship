// BUTTS - JONATHANHYBRID
// Straight up port from Hippie


/obj/item/organ/internal/butt //nvm i need to make it internal for surgery fuck
	name = "butt"
	desc = "extremely treasured body part"
	icon_state = "butt"
	item_state = "butt"
	zone = "groin"
	slot = "butt"
	throwforce = 0
	throw_speed = 4
	force = 0
	hitsound = 'sound/effects/fart.ogg'
	body_parts_covered = HEAD
	slot_flags = SLOT_HEAD
	var/loose = 0

/obj/item/organ/internal/butt/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] shoves their face into the ass, motorboating it! They aren't stopping, they as if they're going to commit suicide!")
	user.say(";HONK HONK BUTT BUTT!!")
	return (OXYLOSS)

/obj/item/organ/internal/butt/prepare_eat()
	return // Stops the literal definition of "eat my ass"

/obj/item/organ/internal/butt/xeno //XENOMORPH BUTTS ARE BEST BUTTS yes i agree
	name = "alien butt"
	desc = "best trophy ever"
	icon_state = "xenobutt"
	item_state = "xenobutt"

/obj/item/organ/internal/butt/bluebutt // bluespace butts, science
	name = "butt of holding"
	desc = "This butt has bluespace properties, letting you store more items in it. Four tiny items, or two small ones, or one normal one can fit."
	icon_state = "bluebutt"
	item_state = "bluebutt"
	origin_tech = "bluespace=5;biotech=4"

/obj/item/organ/internal/butt/attackby(var/obj/item/W, mob/user as mob, params) // copypasting bot manufucturing process, im a lazy fuck

	if(istype(W, /obj/item/robot_parts/l_arm) || istype(W, /obj/item/robot_parts/r_arm))
		user.drop_item()
		qdel(W)
		var/turf/T = get_turf(src.loc)
		var/obj/machinery/bot/buttbot/B = new /obj/machinery/bot/buttbot(T)
		if(istype(src, /obj/item/organ/internal/butt/xeno))
			B.xeno = 1
			B.icon_state = "buttbot_xeno"
			B.speech_list = list("hissing butts", "hiss hiss motherfucker", "nice trophy nerd", "butt", "woop get an alien inspection")
		user << "<span class='notice'>You add the robot arm to the butt and... What?</span>"
		user.drop_item(src)
		qdel(src)

/obj/item/organ/internal/butt/throw_impact(atom/hit_atom)
	..()
	var/mob/living/carbon/M = hit_atom
	playsound(src, 'sound/effects/fart.ogg', 50, 1, 5)
	if((ishuman(hit_atom)))
		M.apply_damage(5, STAMINA)
		if(prob(5))
			M.Weaken(3)
			visible_message("<span class='danger'>The [src.name] smacks [M] right in the face!</span>", 3)







// ------------------------------------------ BUTT BOT -----------------------------------

/obj/machinery/bot/buttbot
	name = "buttbot"
	desc = "It's a robotic butt. Are you dense or something??"
	icon = 'icons/obj/aibots.dmi'
	icon_state = "buttbot"
	layer = 5.0
	density = 0
	anchored = 0
	flags = HEAR
	health = 25
	var/xeno = 0 //Do we hiss when buttspeech?
	var/cooldown = 0
	var/list/speech_buffer = list()
	var/list/speech_list = list("butt.", "butts.", "ass.", "fart.", "assblast usa", "woop get an ass inspection", "woop") //Hilarious.
	var/fartsound = 'sound/effects/fart.ogg'
/obj/machinery/bot/buttbot/New()
	..()
	if(xeno)
		icon_state = "buttbot_xeno"
		speech_list = list("hissing butts", "hiss hiss motherfucker", "nice trophy nerd", "butt", "woop get an alien inspection")

/obj/machinery/bot/buttbot/explode()
	visible_message("<span class='userdanger'>[src] blows apart!</span>")
	var/turf/T = get_turf(src)

	if(prob(50))
		new /obj/item/robot_parts/l_arm(T)
	if(xeno)
		new /obj/item/organ/internal/butt/xeno(T)
	else
		new /obj/item/organ/internal/butt(T)

	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()

	// new /obj/effect/decal/cleanable/blood/oil(loc)
	..() //qdels us and removes us from processing objects


/obj/machinery/bot/buttbot/bot_process()
	if (!..())
		return

	if(isturf(src.loc))
		var/anydir = pick(cardinal)
		if(Process_Spacemove(anydir))
			if(prob(30))
				Move(get_step(src, anydir), anydir)

	if(prob(50) && cooldown < world.time)
		cooldown = world.time + 200 //20 seconds
		if(prob(50) && speech_buffer.len)
			speak(buttificate(pick(speech_buffer)))
			if(prob(5))
				speech_buffer.Remove(pick(speech_buffer)) //so they're not magic wizard guru buttbots that hold arcane information collected during an entire round.
		else
			if(prob(20))
				speak(pick(speech_list))

	if(prob(20))
		if(xeno)
			playsound(src, "hiss", 15, 1, 1)
		else
			playsound(src, fartsound, 15, 1, 1)

/obj/machinery/bot/buttbot/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq)
	if(speaker != src && prob(40))
		if(speech_buffer.len >= 20)
			speech_buffer -= pick(speech_buffer)
		speech_buffer += html_decode(raw_message)
	..()