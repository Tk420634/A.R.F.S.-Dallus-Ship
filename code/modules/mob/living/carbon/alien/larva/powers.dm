/obj/effect/proc_holder/alien/hide
	name = "Hide"
	desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	plasma_cost = 0

	action_icon_state = "alien_hide"

/obj/effect/proc_holder/alien/hide/fire(mob/living/carbon/alien/user)
	if(user.stat != CONSCIOUS)
		return

	if (user.layer != TURF_LAYER+0.2)
		user.layer = TURF_LAYER+0.2
		user.visible_message("<span class='name'>[user] scurries to the ground!</span>", \
						"<span class='noticealien'>You are now hiding.</span>")
	else
		user.layer = MOB_LAYER
		user.visible_message("[user.] slowly peaks up from the ground...", \
					"<span class='noticealien'>You stop hiding.</span>")
	return 1


/obj/effect/proc_holder/alien/larva_evolve
	name = "Evolve"
	desc = "Evolve into a basic alien caste."
	plasma_cost = 0

	action_icon_state = "alien_evolve_larva"

/obj/effect/proc_holder/alien/larva_evolve/fire(mob/living/carbon/alien/user)
	if(!islarva(user))
		return
	var/mob/living/carbon/alien/larva/L = user

	if(L.stat != CONSCIOUS)
		return
	if(L.handcuffed || L.legcuffed) // Cuffing larvas ? Eh ?
		user << "<span class='danger'>You cannot evolve when you are cuffed.</span>"
	switch(L.hulk)
		if(0)//not a hulk larva
			if(L.amount_grown >= L.max_grown)	//TODO ~Carn
				L << "<span class='name'>You are growing into a beautiful alien! It is time to choose a caste.</span>"
				L << "<span class='info'>There are three to choose from:"
				L << "<span class='name'>Hunters</span> <span class='info'>are the most agile caste and can pounce on enemies to stun them for a short time. They boast moderate health but have no other special abilities.</span>"
				L << "<span class='name'>Sentinels</span> <span class='info'>are slower than hunters and can spit neurotoxin on incoming attackers to stun them for a long period of time. Sentinels are tasked with keeping the nest safe and the nested hosts safe.</span>"
				L << "<span class='name'>Drones</span> <span class='info'>are the weakest and slowest of the three basic castes. However, the hive needs drones to survive as they're the only one of the three castes that can plant weeds and shape resin. Spreading weeds far and wide will ensure your sisters have plenty of places to heal and retreat to.</span>"
				var/alien_caste = alert(L, "Please choose which alien caste you shall belong to.",,"Hunter","Sentinel","Drone")

				var/mob/living/carbon/alien/humanoid/new_xeno
				switch(alien_caste)
					if("Hunter")
						new_xeno = new /mob/living/carbon/alien/humanoid/hunter(L.loc)
					if("Sentinel")
						new_xeno = new /mob/living/carbon/alien/humanoid/sentinel(L.loc)
					if("Drone")
						new_xeno = new /mob/living/carbon/alien/humanoid/drone(L.loc)
				if(L.mind)	L.mind.transfer_to(new_xeno)
				qdel(L)
				return 0
			else
				user << "<span class='danger'>You are not fully grown.</span>"
				return 0
		if(1)//hulk larva
			if(L.amount_grown >= L.max_grown)
				L << "<span class='userdanger'>YOU'VE BEEN WAITING YOUR WHOLE LIFE FOR THIS MOMENT!</span>"
				L.visible_message("<span class='danger'>[src] starts molting its exoskeleton...</span>", \
						"<span class='danger'>You start molting your exoskeleton...</span>")
				var/cached_canmove = L.canmove
				L.canmove = 0
				if(do_after(L, 30))
					L << "<span class='userdanger'>IT'S TIME TO SMASH!</span>"
					var/mob/living/carbon/alien/humanoid/ravager/hulk/new_xeno
					new_xeno = new /mob/living/carbon/alien/humanoid/ravager/hulk(L.loc)
					if(L.mind)	L.mind.transfer_to(new_xeno)
					qdel(L)
					return 0
				else
					L.canmove = cached_canmove
					return 0

			else
				user << "<span class='danger'>You are not fully grown.</span>"
				return 0
