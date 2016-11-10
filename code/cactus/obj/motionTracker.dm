//////////////////////
////MOTION TRACKER////
//////////////////////

/obj/item/device/t_scanner/motionTracker
	name = "motion tracker"
	icon = 'code/cactus/obj/obj.dmi'
	icon_state = "tracker"
	desc = "A nifty handheld motion tracker that requires meson scanners to function properly."
	flags = CONDUCT
	slot_flags = SLOT_BELT
	var/cooldown = 35
	var/on_cooldown = 0
	var/range = 7
	var/meson = FALSE
	var/cell
	var/cellcharge
	var/cellmaxcharge
	var/soundDetect = 'code/cactus/sound/trackFull.ogg'
	var/soundNoDetect = 'code/cactus/sound/trackHalf.ogg'
//	var/soundInt = pick('code/cactus/sound/trackInt1.ogg', 'code/cactus/sound/trackInt2.ogg')
	var/soundToggle = 'code/cactus/sound/switch.ogg'
	origin_tech = "engineering=4;magnets=5"

/obj/item/device/t_scanner/motionTracker/New()

	cell = new /obj/item/weapon/stock_parts/cell
//	cellcharge = cell.charge
//	cellmaxcharge = cell.maxcharge

/obj/item/device/t_scanner/process()
	if(!on)
		SSobj.processing.Remove(src)
		return null
	scan()
	/*
	cell.charge -= 100
	if(cell.charge <= 0)
		cell.charge = 0
		SSobj.processing.Remove(src)
		on = 0
	*/
/obj/item/device/t_scanner/motionTracker/attack_self(mob/user)
	playsound(get_turf(src), soundToggle, 100, 0, -5)
	on = !on
	if(on)
		user << text("<span class='notice'>You turn on [src].</span>")
		SSobj.processing |= src
	if(!on)
		user << text("<span class='notice'>You turn off [src].</span>")
/*
/obj/item/device/t_scanner/motionTracker/proc/updateIcons(var/obj/item/weapon/stock_parts/cell/C)
	var/chargeFull = image('code/cactus/obj/obj.dmi', loc = src, icon_state = "trackerLightPowerFull")
	var/chargeHalf = image('code/cactus/obj/obj.dmi', loc = src, icon_state = "trackerLightPowerHalf")
	var/chargeLow = image('code/cactus/obj/obj.dmi', loc = src, icon_state = "trackerLightPowerLow")
	var/chargeEmpty = image('code/cactus/obj/obj.dmi', loc = src, icon_state = "trackerLightPowerEmpty")
	if(cell && cellcharge)
		if(cell && C.charge < (C.maxcharge/5))
			overlays = chargeLow
		else if(cell && cell.charge < (cell.maxcharge/2))
			overlays = chargeHalf
		else if(cell && cell.charge > (cell.maxcharge/2))
			overlays = chargeFull
	if(!charge || !cell)
		overlays = chargeEmpty
*/
/obj/item/device/t_scanner/motionTracker/scan(mob/living/carbon/user)
	if(!on_cooldown)
		on_cooldown = 1
		spawn(cooldown)
			on_cooldown = 0
		var/turf/t = get_turf(src)
		var/list/mobs = recursive_mob_check(t, 1,0,0)
		if(!mobs.len)
			return
		motionTrackScan(mobs, range)


/obj/item/device/t_scanner/motionTracker/proc/motionTrackScan()
	for(var/turf/T in range(7, get_turf(src)) )
		for(var/mob/O in T.contents)
			var/mob/living/L = locate() in T
			if(L && (get_turf(L) != get_turf(src)) && !L.stat)
				flick_blip(O.loc)
				playsound(get_turf(L),'code/cactus/sound/trackFull.ogg', 25, 0 ,0)
			else
				playsound(get_turf(src),'code/cactus/sound/trackHalf.ogg', 15, 0 ,0)

/obj/item/device/t_scanner/proc/flick_blip(turf/T)
	var/image/B = image('code/cactus/obj/obj.dmi', T, icon_state = "blip")
	var/list/nearby = list()
	for(var/mob/M in viewers(T))
		if(M.client)
			nearby |= M.client
			flick_overlay(B,nearby, 8)
