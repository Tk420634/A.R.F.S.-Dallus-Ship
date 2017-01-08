//SOMEONE WANTED BOLA, SO I ADD THEM

/datum/table_recipe/bola
	name = "Bola"
	result = /obj/item/weapon/restraints/legcuffs/bola
	reqs = list(/obj/item/weapon/restraints/handcuffs/cable = 1,
				/obj/item/stack/sheet/metal = 6)
	time = 20//15 faster than crafting them by hand!
	category = CAT_WEAPON


/obj/item/weapon/restraints/legcuffs/bola
	name = "bola"
	desc = "A restraining device designed to be thrown at the target. Upon connecting with said target, it will wrap around their legs, making it difficult for them to move quickly."
	icon_state = "bola"
	breakouttime = 35//easy to apply, easy to break out of
	gender = NEUTER
	origin_tech = "engineering=3;combat=1"
	var/weaken = 0

/obj/item/weapon/restraints/legcuffs/bola/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback)
	if(!..())
		return
	playsound(src.loc,'sound/weapons/bolathrow.ogg', 75, 1)

/obj/item/weapon/restraints/legcuffs/bola/throw_impact(atom/hit_atom)
	if(..() || !iscarbon(hit_atom))//if it gets caught or the target can't be cuffed,
		return//abort
	var/mob/living/carbon/C = hit_atom
	if(!C.legcuffed)
		visible_message("<span class='danger'>\The [src] ensnares [C]!</span>")
		C.legcuffed = src
		src.loc = C
		C.update_inv_legcuffed()
		feedback_add_details("handcuffs","B")
		C << "<span class='userdanger'>\The [src] ensnares you!</span>"
		C.Weaken(weaken)

/obj/item/weapon/restraints/legcuffs/bola/tactical//traitor variant
	name = "reinforced bola"
	desc = "A strong bola, made with a long steel chain. It looks heavy, enough so that it could trip somebody."
	icon_state = "bola_r"
	breakouttime = 70
	origin_tech = "engineering=4;combat=3"
	weaken = 1

/obj/item/weapon/restraints/legcuffs/bola/energy //For Security
	name = "energy bola"
	desc = "A specialized hard-light bola designed to ensnare fleeing criminals and aid in arrests."
	icon_state = "ebola"
	hitsound = 'sound/weapons/taserhit.ogg'
	w_class = 2
	breakouttime = 60

/obj/item/weapon/restraints/legcuffs/bola/energy/throw_impact(atom/hit_atom)
	if(iscarbon(hit_atom))
		var/obj/item/weapon/restraints/legcuffs/beartrap/B = new /obj/item/weapon/restraints/legcuffs/beartrap/energy/cyborg(get_turf(hit_atom))
		var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
		sparks.set_up(2, 2, src)
		sparks.start()
		B.Crossed(hit_atom)
		qdel(src)
	..()


/obj/item/weapon/restraints/legcuffs/beartrap/energy
	name = "energy snare"
	armed = 1
	icon_state = "e_snare"
	trap_damage = 0

/obj/item/weapon/restraints/legcuffs/beartrap/energy/proc/dissipate()
	if(!istype(loc, /mob))
		var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
		sparks.set_up(2, 2, src)
		sparks.start()
		qdel(src)

/obj/item/weapon/restraints/legcuffs/beartrap/energy/attack_hand(mob/user)
	Crossed(user) //honk

/obj/item/weapon/restraints/legcuffs/beartrap/energy/cyborg
	breakouttime = 20 // Cyborgs shouldn't have a strong restraint