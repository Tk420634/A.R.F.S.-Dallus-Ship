/obj/structure/bed/chair
	name = "chair"
	desc = "You sit in this. Either by will or force.\n<span class='notice'>Alt-click to rotate it clockwise.</span>"
	icon_state = "chair"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/blue
	name = "blue chair"
	desc = "You sit in this. Either by will or force.\n<span class='notice'>Alt-click to rotate it clockwise.</span>"
	icon_state = "chair_b"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/yellow
	name = "yellow chair"
	desc = "You sit in this. Either by will or force.\n<span class='notice'>Alt-click to rotate it clockwise.</span>"
	icon_state = "chair_y"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/red
	name = "red chair"
	desc = "You sit in this. Either by will or force.\n<span class='notice'>Alt-click to rotate it clockwise.</span>"
	icon_state = "chair_r"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/green
	name = "green chair"
	desc = "You sit in this. Either by will or force.\n<span class='notice'>Alt-click to rotate it clockwise.</span>"
	icon_state = "chair_g"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/pool
	name = "pool chair"
	desc = "A blue chair. It seems best to be by a pool of some sort."
	icon_state = "chair_pool"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1


/obj/structure/bed/chair/New()
	..()
	spawn(3)	//sorry. i don't think there's a better way to do this.
		handle_layer()

/obj/structure/bed/chair/Move(atom/newloc, direct)
	..()
	handle_rotation()

/obj/structure/bed/chair/attackby(obj/item/weapon/W, mob/user, params)
	..()
	if(istype(W, /obj/item/assembly/shock_kit))
		if(!user.drop_item())
			return
		var/obj/item/assembly/shock_kit/SK = W
		var/obj/structure/bed/chair/e_chair/E = new /obj/structure/bed/chair/e_chair(src.loc)
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		E.dir = dir
		E.part = SK
		SK.loc = E
		SK.master = E
		qdel(src)

/obj/structure/bed/chair/attack_tk(mob/user)
	if(buckled_mob)
		..()
	else
		rotate()
	return

/obj/structure/bed/chair/proc/handle_rotation(direction)
	if(buckled_mob)
		buckled_mob.buckled = null //Temporary, so Move() succeeds.
		if(!direction || !buckled_mob.Move(get_step(src, direction), direction))
			buckled_mob.buckled = src
			dir = buckled_mob.dir
			return 0
		buckled_mob.buckled = src //Restoring
	handle_layer()
	return 1

/obj/structure/bed/chair/proc/handle_layer()
	if(dir == NORTH)
		src.layer = FLY_LAYER
	else
		src.layer = OBJ_LAYER

/obj/structure/bed/chair/proc/spin()
	src.dir = turn(src.dir, 90)
	handle_layer()
	if(buckled_mob)
		buckled_mob.dir = dir

/obj/structure/bed/chair/verb/rotate()
	set name = "Rotate Chair"
	set category = "Object"
	set src in oview(1)

	if(config.ghost_interaction)
		spin()
	else
		if(!usr || !isturf(usr.loc))
			return
		if(usr.stat || usr.restrained())
			return
		spin()

/obj/structure/bed/chair/AltClick(mob/user)
	..()
	if(user.incapacitated())
		user << "<span class='warning'>You can't do that right now!</span>"
		return
	if(!in_range(src, user))
		return
	else
		rotate()

// Chair types
/obj/structure/bed/chair/wood
	burn_state = 0 //Burnable
	burntime = 20
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 3

/obj/structure/bed/chair/wood/normal
	icon_state = "wooden_chair"
	name = "wooden chair"
	desc = "Old is never too old to not be in fashion."

/obj/structure/bed/chair/wood/wings
	icon_state = "wooden_chair_wings"
	name = "wooden chair"
	desc = "Old is never too old to not be in fashion."

/obj/structure/bed/chair/comfy
	name = "comfy chair"
	desc = "It looks comfy.\n<span class='notice'>Alt-click to rotate it clockwise.</span>"
	icon_state = "comfychair"
	color = rgb(255,255,255)
	burn_state = 0 //Burnable
	burntime = 30
	buildstackamount = 2
	var/image/armrest = null

/obj/structure/bed/chair/comfy/New()
	armrest = image("icons/obj/objects.dmi", "comfychair_armrest")
	armrest.layer = MOB_LAYER + 0.1

	return ..()

/obj/structure/bed/chair/comfy/post_buckle_mob(mob/living/M)
	if(buckled_mob)
		overlays += armrest
	else
		overlays -= armrest


/obj/structure/bed/chair/comfy/brown
	icon_state = "comfychair_brown"

/obj/structure/bed/chair/comfy/beige
	color = rgb(255,253,195)

/obj/structure/bed/chair/comfy/teal
	icon_state = "comfychair_blue"

/obj/structure/bed/chair/comfy/black
	color = rgb(167,164,153)

/obj/structure/bed/chair/comfy/lime
	icon_state = "comfychair_green"

/obj/structure/bed/chair/comfy/red
	icon_state = "comfychair_red"

/obj/structure/bed/chair/comfy/purple
	icon_state = "comfychair_purple"

/obj/structure/bed/chair/comfy/shuttlechair
	name = "shuttle chair"
	desc = "A chair made to go on the shuttle"
	icon_state = "shuttle__chair"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/comfy/shuttlechairred
	name = "red shuttle chair"
	desc = "A chair made to go on the shuttle"
	icon_state = "shuttle__chair-red"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/comfy/shuttlechairbrown
	name = "brown shuttle chair"
	desc = "A chair made to go on the shuttle"
	icon_state = "shuttle__chair-brown"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/comfy/shuttlechairgreen
	name = "green shuttle chair"
	desc = "A chair made to go on the shuttle"
	icon_state = "shuttle__chair-green"
	buckle_lying = 0 //you sit in a chair, not lay
	burn_state = -1 //Not Burnable
	buildstackamount = 1

/obj/structure/bed/chair/office
	anchored = 0
	buildstackamount = 5

/obj/structure/bed/chair/office/light
	icon_state = "officechair_white"

/obj/structure/bed/chair/office/dark
	icon_state = "officechair_dark"

/obj/structure/bed/chair/office/red
	icon_state = "ofice_chair_red"

/obj/structure/bed/chair/office/green
	icon_state = "ofice_chair_green"

/obj/structure/bed/chair/office/yellow
	icon_state = "ofice_chair_yellow"

/obj/structure/bed/chair/office/purple
	icon_state = "ofice_chair_purple"

/obj/structure/stool/bed/chair/sofa
	name = "old ratty sofa"
	icon_state = "sofamiddle"
	anchored = 1

/obj/structure/stool/bed/chair/sofa/left
	icon_state = "sofaend_left"
/obj/structure/stool/bed/chair/sofa/right
	icon_state = "sofaend_right"
/obj/structure/stool/bed/chair/sofa/corner
	icon_state = "sofacorner"