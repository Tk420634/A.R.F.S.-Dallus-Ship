// Cause I need a way to get everything sorted.
// You have to have this ACTIVATED for some stuff to work.

/mob/proc/setClickCooldown(var/timeout)
	next_move = max(world.time + timeout, next_move)

