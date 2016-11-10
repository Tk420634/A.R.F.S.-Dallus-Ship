/mob/living/silicon/synth/update_icons()
	update_hud()
	overlays.Cut()
	if(client && stat != DEAD)
		var/eyes_overlay = image('code/cactus/icons/synth.dmi', loc = src, icon_state = "[eyes_state]")
		src.overlays += eyes_overlay
	else if(stat != DEAD)
		var/eyes_overlay = image('code/cactus/icons/synth.dmi', loc = src, icon_state = "[eyes_state]_stby")
		src.overlays += eyes_overlay