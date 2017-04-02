/datum/reagent/bubblegum
	name = "Bubblegum flavouring"
	id = "bubblegum"
	description = "A flavouring for chewing gum, this one is a standard flavour, sweet 'n tasty."
	color = "#ffa3ff" // rgb: 255, 163, 255

/datum/reagent/bubblegum/on_mob_life(mob/living/M)
	if(prob(2))
		var/message = pick("The chewing gum tastes sweet.", "You feel obnoxious because of the gum.","The chewing gum is sweet and tasty.")
		M << "<span class='notice'>[message]</span>"
	..()