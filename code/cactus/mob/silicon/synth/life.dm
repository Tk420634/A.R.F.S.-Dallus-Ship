/mob/living/silicon/synth/Life()
	set invisibility = 0
	set background = BACKGROUND_ENABLED
	update_icons()
	if (src.notransform)
		return

	clamp_values()
	..()

//	if(!stat)
//		use_power()

/mob/living/silicon/synth/proc/clamp_values()
	SetStunned(min(stunned, 30))
	SetParalysis(min(paralysis, 30))
	SetWeakened(min(weakened, 20))
	sleeping = 0
	adjustBruteLoss(0)
	adjustToxLoss(0)
	adjustOxyLoss(0)
	adjustFireLoss(0)