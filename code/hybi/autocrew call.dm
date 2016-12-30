// TO DO:
// make it read from config.

/datum/subsystem/vote/proc/autotransfer()
	SSvote.initiate_vote("auto_transfer","the server")
	message_admins("The server has called a crew transfer vote")
	world << sound('sound/misc/notice2.ogg')

var/datum/subsystem/transfer_controller/SStransfer

/datum/subsystem/transfer_controller
	name = "transfer controller"
	var/timerbuffer = 10800 //buffer for time check
	var/intervalbuffer = 36000
	can_fire = 1

/datum/subsystem/transfer_controller/New()
	NEW_SS_GLOBAL(SStransfer)
//	timerbuffer = config.vote_autotransfer_initial //	This aint working?
//	intervalbuffer = config.vote_autotransfer_interval


/datum/subsystem/transfer_controller/fire()
	if(world.time >= timerbuffer)
		SSvote.autotransfer()
		timerbuffer = timerbuffer + intervalbuffer


