//Why are these a subclass of cat?
/mob/living/simple_animal/cat/bird
	name = "parrot"
	desc = "A domesticated bird. Tweet tweet!"
	icon = 'icons/mob/birds.dmi'
	icon_state = "parrot-flap"
	icon_living = "parrot-flap"
	icon_dead = "parrot-dead"
	speak = list("Chirp!","Caw!","Screech!","Squawk!")
	speak_emote = list("chirps", "caws")
	emote_hear = list("chirps","caws")
	emote_see = list("shakes their head", "ruffles their feathers")

/mob/living/simple_animal/cat/bird/fluff/kea
	name = "Kea"
	icon_state = "kea-flap"
	icon_living = "kea-flap"
	icon_dead = "kea-dead"

/mob/living/simple_animal/cat/bird/fluff/eclectus
	name = "Eclectus"
	icon_state = "eclectus-flap"
	icon_living = "eclectus-flap"
	icon_dead = "eclectus-dead"

/mob/living/simple_animal/cat/bird/fluff/eclectusf
	name = "Eclectus"
	icon_state = "eclectusf-flap"
	icon_living = "eclectusf-flap"
	icon_dead = "eclectusf-dead"

/mob/living/simple_animal/cat/bird/fluff/greybird
	name = "Grey Bird"
	icon_state = "agrey-flap"
	icon_living = "agrey-flap"
	icon_dead = "agrey-dead"

/mob/living/simple_animal/cat/bird/fluff/blue_caique
	name = "Blue Caique "
	icon_state = "bcaique-flap"
	icon_living = "bcaique-flap"
	icon_dead = "bcaique-dead"

/mob/living/simple_animal/cat/bird/fluff/white_caique
	name = "White caique"
	icon_state = "wcaique-flap"
	icon_living = "wcaique-flap"
	icon_dead = "wcaique-dead"

/mob/living/simple_animal/cat/bird/fluff/green_budgerigar
	name = "Green Budgerigar"
	icon_state = "gbudge-flap"
	icon_living = "gbudge-flap"
	icon_dead = "gbudge-dead"

/mob/living/simple_animal/cat/bird/fluff/blue_Budgerigar
	name = "Blue Budgerigar"
	icon_state = "bbudge-flap"
	icon_living = "bbudge-flap"
	icon_dead = "bbudge-dead"

/mob/living/simple_animal/cat/bird/fluff/bluegreen_Budgerigar
	name = "Bluegreen Budgerigar"
	icon_state = "bgbudge-flap"
	icon_living = "bgbudge-flap"
	icon_dead = "bgbudge-dead"

/mob/living/simple_animal/cat/bird/fluff/commonblackbird
	name = "Black Bird"
	icon_state = "commonblackbird"
	icon_living = "commonblackbird"
	icon_dead = "commonblackbird-dead"

/mob/living/simple_animal/cat/bird/fluff/azuretit
	name = "Azure Tit"
	icon_state = "azuretit"
	icon_living = "azuretit"
	icon_dead = "azuretit-dead"

/mob/living/simple_animal/cat/bird/fluff/europeanrobin
	name = "European Robin"
	icon_state = "europeanrobin"
	icon_living = "europeanrobin"
	icon_dead = "europeanrobin-dead"

/mob/living/simple_animal/cat/bird/fluff/goldcrest
	name = "Goldcrest"
	icon_state = "goldcrest"
	icon_living = "goldcrest"
	icon_dead = "goldcrest-dead"

/mob/living/simple_animal/cat/bird/fluff/ringneckdove
	name = "Ringneck Dove"
	icon_state = "ringneckdove"
	icon_living = "ringneckdove"
	icon_dead = "ringneckdove-dead"

/mob/living/simple_animal/cat/bird/fluff/cockatiel
	name = "Cockatiel"
	icon_state = "tiel-flap"
	icon_living = "tiel-flap"
	icon_dead = "tiel-dead"

/mob/living/simple_animal/cat/bird/fluff/white_cockatiel
	name = "White Cockatiel"
	icon_state = "wtiel-flap"
	icon_living = "wtiel-flap"
	icon_dead = "wtiel-dead"

/mob/living/simple_animal/cat/bird/fluff/yellowish_cockatiel
	name = "Yellowish Cockatiel"
	icon_state = "luttiel-flap"
	icon_living = "luttiel-flap"
	icon_dead = "luttiel-dead"

/mob/living/simple_animal/cat/bird/fluff/grey_cockatiel
	name = "Grey Cockatiel"
	icon_state = "blutiel-flap"
	icon_living = "blutiel-flap"
	icon_dead = "blutiel-dead"

/mob/living/simple_animal/cat/bird/fluff/too
	name = "Too"
	icon_state = "too-flap"
	icon_living = "too-flap"
	icon_dead = "too-dead"

/mob/living/simple_animal/cat/bird/fluff/hooded_too
	name = "Utoo"
	icon_state = "utoo-flap"
	icon_living = "utoo-flap"
	icon_dead = "utoo-dead"

/mob/living/simple_animal/cat/bird/fluff/pink_too
	name = "Mtoo"
	icon_state = "mtoo-flap"
	icon_living = "mtoo-flap"
	icon_dead = "mtoo-dead"

/obj/item/weapon/holder/bird
	name = "Bird"
	desc = "It's a bird!"
	icon_state = null

/mob/living/simple_animal/pet/cat/bird/fluff/Life()
	//MICE!
	if((src.loc) && isturf(src.loc))
		if(!stat && !resting && !buckled)
			for(var/mob/living/simple_animal/mouse/M in view(1,src))
				if(!M.stat && Adjacent(M))
					emote("me", 1, "pecks \the [M]!")
					M.splat()
					movement_target = null
					stop_automated_movement = 0
					break