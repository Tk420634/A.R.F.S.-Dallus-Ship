// Gotta make some exercise things as people might get fat!
// Idea: Mat allows you to do a selected list of exercise methods upon clicking
//       on it, you can roll it up and roll it out, similar to how bodybags work.

/mob/proc/setClickCooldown(var/timeout)
	next_move = max(world.time + timeout, next_move)

/obj/machinery/exercise/mat
	name = "exercising mat"
	desc = "Used to exercise! You know, that thing which no one is assed to do?"
	icon = 'code/hybi/icons/exercise.dmi'
	icon_state = "mat_1"


/obj/machinery/exercise/mat/attack_hand(var/mob/living/user)
	if ( get_dist(src, user) > 0 )
		if ( !issilicon(user) )
			user << "<span class='notice'>You are too far away from the mat!</span>"
		return

	var/limit = 80
	var/pain = 20
	var/burn = 30
	var/nextperform = user.staminaloss + pain

	// DESIGN A SYSTEM TO BURN NUTRIENTS

	if(user.nutrition <= 70)
		user << "You're too hungry to work out!"
		return



	if(nextperform >= limit)
		user << "You're too tired to work out!"
		return
	else
		visible_message("<span class='notice'>[user] starts to excersize vigorously!</span>")
		user.setClickCooldown(40)
		user.nutrition -= burn
		user.staminaloss += pain
		user.dir = src.dir

	return

/obj/machinery/exercise/lifting
	name = "lifting machine"
	desc = "Yo do you even lift bro?"
	icon = 'code/hybi/icons/exercise.dmi'
	icon_state = "fitnesslifter"
	anchored = 1


/obj/machinery/exercise/lifting/attackby(obj/item/W, var/mob/living/user)
	if(istype(W, /obj/item/weapon/wrench))
		src.add_fingerprint(user)
		user.visible_message("<span class='warning'>[user] has [anchored ? "un" : ""]secured \the [src].</span>", "<span class='notice'>You [anchored ? "un" : ""]secure \the [src].</span>")
		anchored = !anchored
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		return

/obj/machinery/exercise/lifting/attack_hand(var/mob/living/user)
	if(!anchored)
		user << "<span class='notice'>For safety reasons, you are required to have this equipment wrenched down before using it!</span>"
		return
	else if(user.loc != src.loc)
		user << "<span class='notice'>For safety reasons, you need to be sitting in the fitness lifter for it to work!</span>"
		return
	else if(user.nutrition <= 70)
		user << "You're too hungry to work out!"
		return

	var/limit = 80
	var/pain = 20
	var/burn = 30
	var/nextperform = user.staminaloss + pain

	if(nextperform >= limit)
		user << "You're too tired to work out!"
		return
	else
		visible_message("<span class='notice'>[user] starts to excersize vigorously!</span>")
		user.setClickCooldown(50)
		user.nutrition -= burn
		user.staminaloss += pain
		user.dir = src.dir
		flick("fitnesslifter2",src)
		return