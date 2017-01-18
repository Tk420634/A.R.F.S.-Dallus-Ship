// WIP



var/donators = list(
"tk420634",
"jonathanhybrid",
"sacafe",
"chokin and tokin",
"andyman105",
"hibou4",
"suicidalpickles"
)
//List of all the donators, ckeys = their username all lowercased with no spaces.
// I.E: "Its hip to fuck bees" would be "itshiptofuckbees" and in the list it would look like list("itshiptofuckbees","randomckey")

mob/living/carbon/human/d_spawn(mob/user = usr)
	if(stat == UNCONSCIOUS)
		return

	if(stat == DEAD)
		return

	if(!ckey in donators)
		usr << "Sorry, you aren't a donator. If you have donated, you will be able to access this feature in the next update."
		return


	var/list/donatoritems = list(/obj/item/weapon/reagent_containers/food/snacks/grown/poppy/geranium,/obj/item/weapon/reagent_containers/food/snacks/cookie,/obj/item/weapon/drilldo, /obj/item/clothing/under/bowlingoutfit,/obj/item/clothing/under/middriftturtleneck,/obj/item/clothing/tie/watch,/obj/item/toy/cattoygreen,/obj/item/clothing/suit/space/hardsuit/miningsacafe)
	// List of the items they can get while being a donator. If you have a donator item you want on the list, put object path in here.
	// I.E: list(/obj/donatoritem,/obj/item/weapon/reagent_containers/food/snacks/cookie, /obj/item/weapon/pen)
	// BUT ITEMS HERE MUST BE /OBJ/ AND MUST BE SEPERATED WITH A "," BUT THE LAST ITEM MUST NOT HAVE A ","

	var/list/items = list()

	for(var/donatoritem in donatoritems)
		var/obj/D = new donatoritem
		items[capitalize(D.name)] = D


	var/list/show_items = list("EXIT" = null) + sortList(items) // the list that will be shown to the user to pick from
	var/chosen_item = input(usr, "Choose a donator item to spawn.", "Choose an item.") in show_items

	if(chosen_item == null)
		return

	var/input_item = items[chosen_item]

	new input_item(get_turf(usr))

	log_admin("[key_name(usr)] donator spawned [input_item]") //Logging
	message_admins("[key_name(usr)] donator spawned [input_item]")
	usr << "<span class='adminnotice'>You've spawned in your <b>[input_item]</b>!</span>"

/mob/verb/d_spawn()
	set name = "Donator Item Spawn"
	set category = "OOC"
	set desc = "Spawn in an item!"
	return