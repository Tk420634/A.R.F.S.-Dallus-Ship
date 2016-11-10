/obj/machinery/computer/shuttle/science
	name = "Research Shuttle Console"
	desc = "Used to call and send the research shuttle."
	circuit = /obj/item/weapon/circuitboard/science_shuttle
	shuttleId = "science"
	possible_destinations = "science_home;science_away"

/obj/item/weapon/circuitboard/science_shuttle
	name = "circuit Board (Science Shuttle)"
	build_path = /obj/machinery/computer/shuttle/science

/area/toxins/xenobiology_alien
	name = "Xenomorph Biology Lab"
	icon_state = "toxlab"
	has_gravity = 1

/area/shuttle/science
	name = "Science Shuttle"

/obj/machinery/camera/xray/xenobio
	name = "reinforced xray security camera"
	unacidable = 1
	health = 9999
	network = list("xenomorph_biolab")

/obj/machinery/computer/camera_advanced/xenomorph_biolab
	name = "xenomorph management console"
	desc = "A computer used for remotely monitor the xenomorph biology lab."
	networks = list("xenomorph_biolab")
	icon_screen = "xeno_comp"
	icon_keyboard = "rd_key"

/mob/camera/aiEye/remote/xenomorph_biolab
	visible_icon = 1
	icon = 'icons/obj/abductor.dmi'
	icon_state = "camera_target"

/obj/machinery/computer/camera_advanced/xenomorph_biolab/CreateEye()
	eyeobj = new /mob/camera/aiEye/remote/xenomorph_biolab()
	eyeobj.loc = get_turf(src)
	eyeobj.origin = src
	eyeobj.visible_icon = 1
	eyeobj.icon = 'icons/obj/abductor.dmi'
	eyeobj.icon_state = "camera_target"

/mob/camera/aiEye/remote/xenomorph_biolab/setLoc(var/t)
	var/area/new_area = get_area(t)
	if(new_area && new_area.name == "Xenomorph Biology Lab" || istype(new_area, /area/toxins/xenobiology_alien ))
		return ..()
	else
		return

/obj/structure/sign/xenomorph_biolab
	name = "\improper XENOMORPH BIOLOGY"
	desc = "A sign labelling an area as a place where xenomorphs are researched."
	icon_state = "xenobio2"
