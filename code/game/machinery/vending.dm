#define STANDARD_CHARGE 1
#define CONTRABAND_CHARGE 2
#define COIN_CHARGE 3

/datum/data/vending_product
	var/product_name = "generic"
	var/product_path = null
	var/amount = 0
	var/max_amount = 0
	var/display_color = "blue"


/obj/machinery/vending
	name = "\improper Vendomat"
	desc = "A generic vending machine."
	icon = 'icons/obj/vending.dmi'
	icon_state = "generic"
	layer = 2.9
	anchored = 1
	density = 1
	verb_say = "beeps"
	verb_ask = "beeps"
	verb_exclaim = "beeps"
	var/active = 1		//No sales pitches if off!
	var/vend_ready = 1	//Are we ready to vend?? Is it time??
	var/vend_delay = 10	//How long does it take to vend?

	// To be filled out at compile time
	var/list/products	= list()	//For each, use the following pattern:
	var/list/contraband	= list()	//list(/type/path = amount,/type/path2 = amount2)
	var/list/premium 	= list()	//No specified amount = only one in stock

	var/product_slogans = ""	//String of slogans separated by semicolons, optional
	var/product_ads = ""		//String of small ad messages in the vending screen - random chance
	var/list/product_records = list()
	var/list/hidden_records = list()
	var/list/coin_records = list()
	var/list/slogan_list = list()
	var/list/small_ads = list()	//Small ad messages in the vending screen - random chance of popping up whenever you open it
	var/vend_reply				//Thank you for shopping!
	var/last_reply = 0
	var/last_slogan = 0			//When did we last pitch?
	var/slogan_delay = 6000		//How long until we can pitch again?
	var/icon_vend				//Icon_state when vending!
	var/icon_deny				//Icon_state when vending!
	var/seconds_electrified = 0	//Shock customers like an airlock.
	var/shoot_inventory = 0		//Fire items at customers! We're broken!
	var/shut_up = 0				//Stop spouting those godawful pitches!
	var/extended_inventory = 0	//can we access the hidden inventory?
	var/scan_id = 1
	var/obj/item/weapon/coin/coin
	var/datum/wires/vending/wires = null

	var/dish_quants = list()  //used by the snack machine's custom compartment to count dishes.

	var/obj/item/weapon/vending_refill/refill_canister = null		//The type of refill canisters used by this machine.

/obj/machinery/vending/New()
	..()
	wires = new(src)
	if(refill_canister) //constructable vending machine
		component_parts = list()
		var/obj/item/weapon/circuitboard/vendor/V = new(null)
		V.set_type(type)
		component_parts += V
		component_parts += new refill_canister
		component_parts += new refill_canister
		component_parts += new refill_canister
		RefreshParts()
	else
		build_inventory(products)
		build_inventory(contraband, 1)
		build_inventory(premium, 0, 1)

	slogan_list = text2list(product_slogans, ";")
	// So not all machines speak at the exact same time.
	// The first time this machine says something will be at slogantime + this random value,
	// so if slogantime is 10 minutes, it will say it at somewhere between 10 and 20 minutes after the machine is crated.
	last_slogan = world.time + rand(0, slogan_delay)
	power_change()

/obj/machinery/vending/Destroy()
	qdel(wires)
	wires = null
	qdel(coin)
	coin = null
	return ..()

/obj/machinery/vending/snack/Destroy()
	for(var/obj/item/weapon/reagent_containers/food/snacks/S in contents)
		S.loc = get_turf(src)
	qdel(wires)
	wires = null
	return ..()

/obj/machinery/vending/RefreshParts()         //Better would be to make constructable child
	if(component_parts)
		product_records = list()
		hidden_records = list()
		coin_records = list()
		build_inventory(products, start_empty = 1)
		build_inventory(contraband, 1, start_empty = 1)
		build_inventory(premium, 0, 1, start_empty = 1)
		for(var/obj/item/weapon/vending_refill/VR in component_parts)
			refill_inventory(VR, product_records, STANDARD_CHARGE)
			refill_inventory(VR, coin_records, COIN_CHARGE)
			refill_inventory(VR, hidden_records, CONTRABAND_CHARGE)

/obj/machinery/vending/ex_act(severity, target)
	..()
	if(!gc_destroyed)
		if(prob(25))
			malfunction()

/obj/machinery/vending/blob_act()
	if(prob(75))
		malfunction()
	else
		qdel(src)


/obj/machinery/vending/proc/build_inventory(list/productlist, hidden=0, req_coin=0, start_empty = null)
	for(var/typepath in productlist)
		var/amount = productlist[typepath]
		if(isnull(amount))
			amount = 0

		var/atom/temp = new typepath(null)
		var/datum/data/vending_product/R = new /datum/data/vending_product()
		R.product_name = initial(temp.name)
		R.product_path = typepath
		if(!start_empty)
			R.amount = amount
		R.max_amount = amount
		R.display_color = pick("red","blue","green")

		if(hidden)
			hidden_records += R
		else if(req_coin)
			coin_records += R
		else
			product_records += R

/obj/machinery/vending/proc/refill_inventory(obj/item/weapon/vending_refill/refill, datum/data/vending_product/machine, var/charge_type = STANDARD_CHARGE)
	var/total = 0
	var/to_restock = 0

	for(var/datum/data/vending_product/machine_content in machine)
		if(machine_content.amount == 0 && refill.charges[charge_type] > 0)
			machine_content.amount++
			refill.charges[charge_type]--
			total++
		to_restock += machine_content.max_amount - machine_content.amount
	if(to_restock <= refill.charges[charge_type])
		for(var/datum/data/vending_product/machine_content in machine)
			machine_content.amount = machine_content.max_amount
		refill.charges[charge_type] -= to_restock
		total += to_restock
	else
		var/tmp_charges = refill.charges[charge_type]
		for(var/datum/data/vending_product/machine_content in machine)
			if(refill.charges[charge_type] == 0)
				break
			var/restock = Ceiling(((machine_content.max_amount - machine_content.amount)/to_restock)*tmp_charges)
			if(restock > refill.charges[charge_type])
				restock = refill.charges[charge_type]
			machine_content.amount += restock
			refill.charges[charge_type] -= restock
			total += restock
	return total

/obj/machinery/vending/snack/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/reagent_containers/food/snacks))
		if(!compartment_access_check(user))
			return
		if(junk_check(W))
			if(!iscompartmentfull(user))
				if(!user.drop_item())
					return
				W.loc = src
				food_load(W)
				user << "<span class='notice'>You insert [W] into [src]'s chef compartment.</span>"
		else
			user << "<span class='notice'>[src]'s chef compartment does not accept junk food.</span>"
		return

	if(istype(W, /obj/item/weapon/storage/bag/tray))
		if(!compartment_access_check(user))
			return
		var/obj/item/weapon/storage/T = W
		var/loaded = 0
		var/denied_items = 0
		for(var/obj/item/weapon/reagent_containers/food/snacks/S in T.contents)
			if(iscompartmentfull(user))
				break
			if(junk_check(S))
				T.remove_from_storage(S, src)
				food_load(S)
				loaded++
			else
				denied_items++
		if(denied_items)
			user << "<span class='notice'>[src] refuses some items.</span>"
		if(loaded)
			user << "<span class='notice'>You insert [loaded] dishes into [src]'s chef compartment.</span>"
		updateUsrDialog()
		return

	..()

/obj/machinery/vending/snack/proc/compartment_access_check(user)
	req_access_txt = chef_compartment_access
	if(!allowed(user) && !emagged && scan_id)
		user << "<span class='warning'>[src]'s chef compartment blinks red: Access denied.</span>"
		req_access_txt = "0"
		return 0
	req_access_txt = "0"
	return 1

/obj/machinery/vending/snack/proc/junk_check(obj/item/weapon/reagent_containers/food/snacks/S)
	if(S.junkiness)
		return 0
	return 1

/obj/machinery/vending/snack/proc/iscompartmentfull(mob/user)
	if(contents.len >= 30) // no more than 30 dishes can fit inside
		user << "<span class='warning'>[src]'s chef compartment is full.</span>"
		return 1
	return 0

/obj/machinery/vending/snack/proc/food_load(obj/item/weapon/reagent_containers/food/snacks/S)
	if(dish_quants[S.name])
		dish_quants[S.name]++
	else
		dish_quants[S.name] = 1
	sortList(dish_quants)

/obj/machinery/vending/attackby(obj/item/weapon/W, mob/user, params)
	if(panel_open)
		if(default_unfasten_wrench(user, W, time = 60))
			return

		if(component_parts && istype(W, /obj/item/weapon/crowbar))
			default_deconstruction_crowbar(W)

	if(istype(W, /obj/item/weapon/screwdriver) && anchored)
		panel_open = !panel_open
		user << "<span class='notice'>You [panel_open ? "open" : "close"] the maintenance panel.</span>"
		overlays.Cut()
		if(panel_open)
			overlays += image(icon, "[initial(icon_state)]-panel")
		updateUsrDialog()
		return
	else if(istype(W, /obj/item/device/multitool)||istype(W, /obj/item/weapon/wirecutters))
		if(panel_open)
			attack_hand(user)
		return
	else if(istype(W, /obj/item/weapon/coin) && premium.len > 0)
		if(!user.drop_item())
			return
		W.loc = src
		coin = W
		user << "<span class='notice'>You insert [W] into [src].</span>"
		return
	else if(istype(W, refill_canister) && refill_canister != null)
		if(stat & (BROKEN|NOPOWER))
			user << "<span class='notice'>It does nothing.</span>"
		else if(panel_open)
			//if the panel is open we attempt to refill the machine
			var/obj/item/weapon/vending_refill/canister = W
			if(canister.charges[STANDARD_CHARGE] == 0)
				user << "<span class='notice'>This [canister.name] is empty!</span>"
			else
				var/transfered = refill_inventory(canister,product_records,user)
				if(transfered)
					user << "<span class='notice'>You loaded [transfered] items in \the [name].</span>"
				else
					user << "<span class='notice'>The [name] is fully stocked.</span>"
			return;
		else
			user << "<span class='notice'>You should probably unscrew the service panel first.</span>"
	else
		..()


/obj/machinery/vending/default_deconstruction_crowbar(obj/item/O)
	var/product_list = list(product_records, hidden_records, coin_records)
	for(var/i=1, i<=3, i++)
		for(var/datum/data/vending_product/machine_content in product_list[i])
			while(machine_content.amount !=0)
				var/safety = 0 //to avoid infinite loop
				for(var/obj/item/weapon/vending_refill/VR in component_parts)
					safety++
					if(VR.charges[i] < VR.init_charges[i])
						VR.charges[i]++
						machine_content.amount--
						if(!machine_content.amount)
							break
					else
						safety--
				if(safety <= 0) // all refill canisters are full
					break
	..()

/obj/machinery/vending/emag_act(mob/user)
	if(!emagged)
		emagged  = 1
		user << "<span class='notice'>You short out the product lock on [src].</span>"

/obj/machinery/vending/attack_paw(mob/user)
	return attack_hand(user)


/obj/machinery/vending/attack_ai(mob/user)
	return attack_hand(user)


/obj/machinery/vending/attack_hand(mob/user)
	var/dat = ""
	if(panel_open)
		dat += wires()
		if(product_slogans != "")
			dat += "The speaker switch is [shut_up ? "off" : "on"]. <a href='?src=\ref[src];togglevoice=[1]'>Toggle</a>"
	else
		if(stat & (BROKEN|NOPOWER))
			return

		dat += "<h3>Select an item</h3>"
		dat += "<div class='statusDisplay'>"
		if(product_records.len == 0)
			dat += "<font color = 'red'>No product loaded!</font>"
		else
			var/list/display_records = product_records
			if(extended_inventory)
				display_records = product_records + hidden_records
			if(coin)
				display_records = product_records + coin_records
			if(coin && extended_inventory)
				display_records = product_records + hidden_records + coin_records
			dat += "<ul>"
			for (var/datum/data/vending_product/R in display_records)
				dat += "<li>"
				if(R.amount > 0)
					dat += "<a href='byond://?src=\ref[src];vend=\ref[R]'>Vend</a> "
				else
					dat += "<span class='linkOff'>Sold out</span> "
				dat += "<font color = '[R.display_color]'><b>[sanitize(R.product_name)]</b>:</font>"
				dat += " <b>[R.amount]</b>"
				dat += "</li>"
			dat += "</ul>"
		dat += "</div>"
		if(premium.len > 0)
			dat += "<b>Coin slot:</b> "
			if (coin)
				dat += "[coin]&nbsp;&nbsp;<a href='byond://?src=\ref[src];remove_coin=1'>Remove</a>"
			else
				dat += "<i>No coin</i>&nbsp;&nbsp;<span class='linkOff'>Remove</span>"
		if(istype(src, /obj/machinery/vending/snack))
			dat += "<h3>Chef's Food Selection</h3>"
			dat += "<div class='statusDisplay'>"
			for (var/O in dish_quants)
				if(dish_quants[O] > 0)
					var/N = dish_quants[O]
					dat += "<a href='byond://?src=\ref[src];dispense=[sanitize(O)]'>Dispense</A> "
					dat += "<B>[capitalize(O)]: [N]</B><br>"
			dat += "</div>"
	user.set_machine(src)
	if(seconds_electrified && !(stat & NOPOWER))
		if(shock(user, 100))
			return

	//user << browse(dat, "window=vending")
	//onclose(user, "")
	var/datum/browser/popup = new(user, "vending", (name))
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()


// returns the wire panel text
/obj/machinery/vending/proc/wires()
	return wires.GetInteractWindow()


/obj/machinery/vending/Topic(href, href_list)
	if(..())
		return


	if(istype(usr,/mob/living/silicon))
		if(istype(usr,/mob/living/silicon/robot))
			var/mob/living/silicon/robot/R = usr
			if(!(R.module && istype(R.module,/obj/item/weapon/robot_module/butler) ))
				usr << "<span class='notice'>The vending machine refuses to interface with you, as you are not in its target demographic!</span>"
				return
		else
			usr << "<span class='notice'>The vending machine refuses to interface with you, as you are not in its target demographic!</span>"
			return

	if(href_list["remove_coin"])
		if(!coin)
			usr << "<span class='notice'>There is no coin in this machine.</span>"
			return

		coin.loc = loc
		if(!usr.get_active_hand())
			usr.put_in_hands(coin)
		usr << "<span class='notice'>You remove [coin] from [src].</span>"
		coin = null


	usr.set_machine(src)

	if((href_list["dispense"]) && (vend_ready))
		var/N = href_list["dispense"]
		if(dish_quants[N] <= 0) // Sanity check, there are probably ways to press the button when it shouldn't be possible.
			return
		vend_ready = 0
		use_power(5)

		spawn(vend_delay)
			dish_quants[N] = max(dish_quants[N] - 1, 0)
			for(var/obj/O in contents)
				if(O.name == N)
					O.loc = src.loc
					break
			vend_ready = 1
			updateUsrDialog()
		return

	if((href_list["vend"]) && (vend_ready))
		if(panel_open)
			usr << "<span class='notice'>The vending machine cannot dispense products while its service panel is open!</span>"
			return

		if((!allowed(usr)) && !emagged && scan_id)	//For SECURE VENDING MACHINES YEAH
			usr << "<span class='warning'>Access denied.</span>"	//Unless emagged of course
			flick(icon_deny,src)
			return

		vend_ready = 0 //One thing at a time!!

		var/datum/data/vending_product/R = locate(href_list["vend"])
		if(!R || !istype(R) || !R.product_path)
			vend_ready = 1
			return

		if(R in hidden_records)
			if(!extended_inventory)
				vend_ready = 1
				return
		else if(R in coin_records)
			if(!coin)
				usr << "<span class='warning'>You need to insert a coin to get this item!</span>"
				vend_ready = 1
				return
			if(coin.string_attached)
				if(prob(50))
					if(usr.put_in_hands(coin))
						usr << "<span class='notice'>You successfully pull [coin] out before [src] could swallow it.</span>"
						coin = null
					else
						usr << "<span class='warning'>You couldn't pull [coin] out because your hands are full!</span>"
						qdel(coin)
						coin = null
				else
					usr << "<span class='warning'>You weren't able to pull [coin] out fast enough, the machine ate it, string and all!</span>"
					qdel(coin)
					coin = null
			else
				qdel(coin)
				coin = null
		else if (!(R in product_records))
			vend_ready = 1
			message_admins("Vending machine exploit attempted by [key_name(usr, usr.client)]!")
			return

		if (R.amount <= 0)
			usr << "<span class='warning'>Sold out.</span>"
			vend_ready = 1
			return
		else
			R.amount--

		if(((last_reply + (vend_delay + 200)) <= world.time) && vend_reply)
			speak(vend_reply)
			last_reply = world.time

		use_power(5)
		if(icon_vend) //Show the vending animation if needed
			flick(icon_vend,src)
		spawn(vend_delay)
			new R.product_path(get_turf(src))
			vend_ready = 1
			return

		updateUsrDialog()
		return

	else if(href_list["togglevoice"] && panel_open)
		shut_up = !shut_up

	updateUsrDialog()


/obj/machinery/vending/process()
	if(stat & (BROKEN|NOPOWER))
		return
	if(!active)
		return

	if(seconds_electrified > 0)
		seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && prob(5))
		var/slogan = pick(slogan_list)
		speak(slogan)
		last_slogan = world.time

	if(shoot_inventory && prob(2))
		throw_item()


/obj/machinery/vending/proc/speak(message)
	if(stat & (BROKEN|NOPOWER))
		return
	if(!message)
		return

	say(message)

/obj/machinery/vending/power_change()
	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
	else
		if(powered())
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
		else
			icon_state = "[initial(icon_state)]-off"
			stat |= NOPOWER


//Oh no we're malfunctioning!  Dump out some product and break.
/obj/machinery/vending/proc/malfunction()
	for(var/datum/data/vending_product/R in product_records)
		if(R.amount <= 0) //Try to use a record that actually has something to dump.
			continue
		var/dump_path = R.product_path
		if(!dump_path)
			continue

		while(R.amount>0)
			new dump_path(loc)
			R.amount--
		continue

	stat |= BROKEN
	icon_state = "[initial(icon_state)]-broken"
	return

//Somebody cut an important wire and now we're following a new definition of "pitch."
/obj/machinery/vending/proc/throw_item()
	var/obj/throw_item = null
	var/mob/living/target = locate() in view(7,src)
	if(!target)
		return 0

	for(var/datum/data/vending_product/R in product_records)
		if(R.amount <= 0) //Try to use a record that actually has something to dump.
			continue
		var/dump_path = R.product_path
		if(!dump_path)
			continue

		R.amount--
		throw_item = new dump_path(loc)
		break
	if(!throw_item)
		return 0

	throw_item.throw_at(target, 16, 3)
	visible_message("<span class='danger'>[src] launches [throw_item] at [target]!</span>")
	return 1


/obj/machinery/vending/proc/shock(mob/user, prb)
	if(stat & (BROKEN|NOPOWER))		// unpowered, no shock
		return 0
	if(!prob(prb))
		return 0
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	if(electrocute_mob(user, get_area(src), src, 0.7))
		return 1
	else
		return 0

/*
 * Vending machine types
 */

/*

/obj/machinery/vending/[vendors name here]   // --vending machine template   :)
	name = ""
	desc = ""
	icon = ''
	icon_state = ""
	vend_delay = 15
	products = list()
	contraband = list()
	premium = list()

IF YOU MODIFY THE PRODUCTS LIST OF A MACHINE, MAKE SURE TO UPDATE ITS RESUPPLY CANISTER CHARGES in vending_items.dm
*/

/*
/obj/machinery/vending/atmospherics //Commenting this out until someone ponies up some actual working, broken, and unpowered sprites - Quarxink
	name = "Tank Vendor"
	desc = "A vendor with a wide variety of masks and gas tanks."
	icon = 'icons/obj/objects.dmi'
	icon_state = "dispenser"
	product_paths = "/obj/item/weapon/tank/internals/oxygen;/obj/item/weapon/tank/internals/plasma;/obj/item/weapon/tank/internals/emergency_oxygen;/obj/item/weapon/tank/internals/emergency_oxygen/engi;/obj/item/clothing/mask/breath"
	product_amounts = "10;10;10;5;25"
	vend_delay = 0
*/

/obj/machinery/vending/boozeomat
	name = "\improper Booze-O-Mat"
	desc = "A technological marvel, supposedly able to mix just the mixture you'd like to drink the moment you ask for one."
	icon_state = "boozeomat"        //////////////18 drink entities below, plus the glasses, in case someone wants to edit the number of bottles
	icon_deny = "boozeomat-deny"
	products = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/gin = 5,/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey = 5,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/tequila = 5,/obj/item/weapon/reagent_containers/food/drinks/bottle/vodka = 5,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/vermouth = 5,/obj/item/weapon/reagent_containers/food/drinks/bottle/rum = 5,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/wine = 5,/obj/item/weapon/reagent_containers/food/drinks/bottle/cognac = 5,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/kahlua = 5,/obj/item/weapon/reagent_containers/food/drinks/beer = 6,
					/obj/item/weapon/reagent_containers/food/drinks/ale = 6,/obj/item/weapon/reagent_containers/food/drinks/bottle/orangejuice = 4,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/tomatojuice = 4,/obj/item/weapon/reagent_containers/food/drinks/bottle/limejuice = 4,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/cream = 4,/obj/item/weapon/reagent_containers/food/drinks/soda_cans/tonic = 8,
					/obj/item/weapon/reagent_containers/food/drinks/soda_cans/cola = 8, /obj/item/weapon/reagent_containers/food/drinks/soda_cans/sodawater = 15,
					/obj/item/weapon/reagent_containers/food/drinks/drinkingglass = 30,/obj/item/weapon/reagent_containers/food/drinks/ice = 10,
					/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/shotglass = 12)
	contraband = list(/obj/item/weapon/reagent_containers/food/drinks/mug/tea = 12)
	vend_delay = 15
	product_slogans = "I hope nobody asks me for a bloody cup o' tea...;Alcohol is humanity's friend. Would you abandon a friend?;Quite delighted to serve you!;Is nobody thirsty on this station?"
	product_ads = "Drink up!;Booze is good for you!;Alcohol is humanity's best friend.;Quite delighted to serve you!;Care for a nice, cold beer?;Nothing cures you like booze!;Have a sip!;Have a drink!;Have a beer!;Beer is good for you!;Only the finest alcohol!;Best quality booze since 2053!;Award-winning wine!;Maximum alcohol!;Man loves beer.;A toast for progress!"
	req_access_txt = "25"
	refill_canister = /obj/item/weapon/vending_refill/boozeomat

/obj/machinery/vending/assist
	products = list(	/obj/item/device/assembly/prox_sensor = 5,/obj/item/device/assembly/igniter = 3,/obj/item/device/assembly/signaler = 4,
						/obj/item/weapon/wirecutters = 1, /obj/item/weapon/cartridge/signal = 4)
	contraband = list(/obj/item/device/flashlight = 5,/obj/item/device/assembly/timer = 2, /obj/item/device/assembly/voice = 2, /obj/item/device/assembly/health = 2)
	product_ads = "Only the finest!;Have some tools.;The most robust equipment.;The finest gear in space!"

/obj/machinery/vending/coffee
	name = "\improper Solar's Best Hot Drinks"
	desc = "A vending machine which dispenses hot drinks."
	product_ads = "Have a drink!;Drink up!;It's good for you!;Would you like a hot joe?;I'd kill for some coffee!;The best beans in the galaxy.;Only the finest brew for you.;Mmmm. Nothing like a coffee.;I like coffee, don't you?;Coffee helps you work!;Try some tea.;We hope you like the best!;Try our new chocolate!;Admin conspiracies"
	icon_state = "coffee"
	icon_vend = "coffee-vend"
	vend_delay = 34
	products = list(/obj/item/weapon/reagent_containers/food/drinks/coffee = 25,/obj/item/weapon/reagent_containers/food/drinks/mug/tea = 25,/obj/item/weapon/reagent_containers/food/drinks/mug/coco = 25)
	contraband = list(/obj/item/weapon/reagent_containers/food/drinks/ice = 12)
	refill_canister = /obj/item/weapon/vending_refill/coffee

/obj/machinery/vending/snack
	name = "\improper Getmore Chocolate Corp"
	desc = "A snack machine courtesy of the Getmore Chocolate Corporation, based out of Mars"
	product_slogans = "Try our new nougat bar!;Twice the calories for half the price!"
	product_ads = "The healthiest!;Award-winning chocolate bars!;Mmm! So good!;Oh my god it's so juicy!;Have a snack.;Snacks are good for you!;Have some more Getmore!;Best quality snacks straight from mars.;We love chocolate!;Try our new jerky!"
	icon_state = "snack"
	products = list(/obj/item/weapon/reagent_containers/food/snacks/candy = 6,/obj/item/weapon/reagent_containers/food/drinks/dry_ramen = 6,/obj/item/weapon/reagent_containers/food/snacks/chips =6,
					/obj/item/weapon/reagent_containers/food/snacks/sosjerky = 6,/obj/item/weapon/reagent_containers/food/snacks/no_raisin = 6,/obj/item/weapon/reagent_containers/food/snacks/spacetwinkie = 6,
					/obj/item/weapon/reagent_containers/food/snacks/cheesiehonkers = 6)
	contraband = list(/obj/item/weapon/reagent_containers/food/snacks/syndicake = 6)
	refill_canister = /obj/item/weapon/vending_refill/snack
	var/chef_compartment_access = "28"

/obj/machinery/vending/sustenance
	name = "\improper Sustenance Vendor"
	desc = "A vending machine which vends food, as required by section 47-C of the NT's Prisoner Ethical Treatment Agreement."
	product_slogans = "Enjoy your meal.;Enough calories to support strenuous labor."
	product_ads = "Sufficiently healthy.;Efficiently produced tofu!;Mmm! So good!;Have a meal.;You need food to live!;Have some more candy corn!;Try our new ice cups!"
	icon_state = "sustenance"
	products = list(/obj/item/weapon/reagent_containers/food/snacks/tofu = 24,
					/obj/item/weapon/reagent_containers/food/drinks/ice = 12,
					/obj/item/weapon/reagent_containers/food/snacks/candy_corn = 6)
	contraband = list(/obj/item/weapon/kitchen/knife = 6)


/obj/machinery/vending/cola
	name = "\improper Robust Softdrinks"
	desc = "A softdrink vendor provided by Robust Industries, LLC."
	icon_state = "Cola_Machine"
	product_slogans = "Robust Softdrinks: More robust than a toolbox to the head!"
	product_ads = "Refreshing!;Hope you're thirsty!;Over 1 million drinks sold!;Thirsty? Why not cola?;Please, have a drink!;Drink up!;The best drinks in space."
	products = list(/obj/item/weapon/reagent_containers/food/drinks/soda_cans/cola = 10,/obj/item/weapon/reagent_containers/food/drinks/soda_cans/space_mountain_wind = 10,
					/obj/item/weapon/reagent_containers/food/drinks/soda_cans/dr_gibb = 10,/obj/item/weapon/reagent_containers/food/drinks/soda_cans/starkist = 10,
					/obj/item/weapon/reagent_containers/food/drinks/soda_cans/space_up = 10,
					/obj/item/weapon/reagent_containers/food/drinks/soda_cans/lemon_lime = 10)
	contraband = list(/obj/item/weapon/reagent_containers/food/drinks/soda_cans/thirteenloko = 6)
	refill_canister = /obj/item/weapon/vending_refill/cola

//This one's from bay12
/obj/machinery/vending/cart
	name = "\improper PTech"
	desc = "Cartridges for PDAs"
	product_slogans = "Carts to go!"
	icon_state = "cart"
	icon_deny = "cart-deny"
	products = list(/obj/item/weapon/cartridge/medical = 10,/obj/item/weapon/cartridge/engineering = 10,/obj/item/weapon/cartridge/security = 10,
					/obj/item/weapon/cartridge/janitor = 10,/obj/item/weapon/cartridge/signal/toxins = 10,/obj/item/device/pda/heads = 10,
					/obj/item/weapon/cartridge/captain = 3,/obj/item/weapon/cartridge/quartermaster = 10)

/obj/machinery/vending/liberationstation
	name = "\improper Liberation Station"
	desc = "An overwhelming amount of <b>ancient patriotism</b> washes over you just by looking at the machine."
	icon_state = "liberationstation"
	req_access_txt = "1"
	product_slogans = "Liberation Station: Your one-stop shop for all things second ammendment!;Be a patriot today, pick up a gun!;Quality weapons for cheap prices!;Better dead than red!"
	product_ads = "Float like an astronaut, sting like a bullet!;Express your second ammendment today!;Guns don't kill people, but you can!;Who needs responsibilities when you have guns?"
	vend_reply = "Remember the name: Liberation Station!"
	products = list(/obj/item/weapon/gun/projectile/automatic/pistol/deagle/gold = 2,/obj/item/weapon/gun/projectile/automatic/pistol/deagle/camo = 2,
					/obj/item/weapon/gun/projectile/automatic/pistol/m1911 = 2,/obj/item/weapon/gun/projectile/automatic/proto/unrestricted = 2,
					/obj/item/weapon/gun/projectile/shotgun/automatic/combat = 2,/obj/item/weapon/gun/projectile/automatic/gyropistol = 1,
					/obj/item/weapon/gun/projectile/shotgun = 2,/obj/item/weapon/gun/projectile/automatic/ar = 2)
	premium = list(/obj/item/ammo_box/magazine/smgm9mm = 2,/obj/item/ammo_box/magazine/m50 = 4,/obj/item/ammo_box/magazine/m45 = 2,/obj/item/ammo_box/magazine/m75 = 2)
	contraband = list(/obj/item/clothing/under/patriotsuit = 1,/obj/item/weapon/bedsheet/patriot = 3)

/obj/machinery/vending/cigarette
	name = "\improper ShadyCigs Deluxe"
	desc = "If you want to get cancer, might as well do it in style"
	product_slogans = "Space cigs taste good like a cigarette should.;I'd rather toolbox than switch.;Smoke!;Don't believe the reports - smoke today!"
	product_ads = "Probably not bad for you!;Don't believe the scientists!;It's good for you!;Don't quit, buy more!;Smoke!;Nicotine heaven.;Best cigarettes since 2150.;Award-winning cigs."
	vend_delay = 34
	icon_state = "cigs"
	products = list(/obj/item/weapon/storage/fancy/cigarettes = 5,
					/obj/item/weapon/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/weapon/storage/fancy/cigarettes/cigpack_robust = 3,
					/obj/item/weapon/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/weapon/storage/fancy/cigarettes/cigpack_midori = 3,
					/obj/item/weapon/storage/box/matches = 10,
					/obj/item/weapon/lighter/greyscale = 4,
					/obj/item/weapon/storage/fancy/rollingpapers = 5)
	contraband = list(/obj/item/weapon/lighter = 3)
	premium = list(/obj/item/weapon/storage/fancy/cigarettes/cigpack_robustgold = 3, \
	/obj/item/weapon/storage/fancy/cigarettes/cigars = 1, /obj/item/weapon/storage/fancy/cigarettes/cigars/havana = 1, /obj/item/weapon/storage/fancy/cigarettes/cigars/cohiba = 1)
	refill_canister = /obj/item/weapon/vending_refill/cigarette

/obj/machinery/vending/medical
	name = "\improper NanoMed Plus"
	desc = "Medical drug dispenser."
	icon_state = "med"
	icon_deny = "med-deny"
	product_ads = "Go save some lives!;The best stuff for your medbay.;Only the finest tools.;Natural chemicals!;This stuff saves lives.;Don't you want some?;Ping!"
	req_access_txt = "5"
	products = list(/obj/item/weapon/reagent_containers/syringe = 12,/obj/item/stack/medical/gauze = 8,/obj/item/weapon/reagent_containers/pill/patch/styptic = 5, /obj/item/weapon/reagent_containers/pill/insulin = 10,
				/obj/item/weapon/reagent_containers/pill/patch/silver_sulf = 5,/obj/item/weapon/reagent_containers/glass/bottle/charcoal = 4,
				/obj/item/weapon/reagent_containers/glass/bottle/epinephrine = 4,/obj/item/weapon/reagent_containers/glass/bottle/morphine = 4,
				/obj/item/weapon/reagent_containers/glass/bottle/toxin = 3,/obj/item/weapon/reagent_containers/syringe/antiviral = 6,/obj/item/weapon/reagent_containers/pill/salbutamol = 2,/obj/item/device/healthanalyzer = 4, /obj/item/device/sensor_device = 2)
	contraband = list(/obj/item/weapon/reagent_containers/pill/tox = 3,/obj/item/weapon/reagent_containers/pill/morphine = 4,/obj/item/weapon/reagent_containers/pill/charcoal = 6)


//This one's from bay12
/obj/machinery/vending/plasmaresearch
	name = "\improper Toximate 3000"
	desc = "All the fine parts you need in one vending machine!"
	products = list(/obj/item/clothing/under/rank/scientist = 6,/obj/item/clothing/suit/bio_suit = 6,/obj/item/clothing/head/bio_hood = 6,
					/obj/item/device/transfer_valve = 6,/obj/item/device/assembly/timer = 6,/obj/item/device/assembly/signaler = 6,
					/obj/item/device/assembly/prox_sensor = 6,/obj/item/device/assembly/igniter = 6)
	contraband = list(/obj/item/device/assembly/health = 3)

/obj/machinery/vending/wallmed
	name = "\improper NanoMed"
	desc = "Wall-mounted Medical Equipment dispenser."
	icon_state = "wallmed"
	icon_deny = "wallmed-deny"
	req_access_txt = "5"
	density = 0 //It is wall-mounted, and thus, not dense. --Superxpdude
	products = list(/obj/item/weapon/reagent_containers/syringe = 6,/obj/item/weapon/reagent_containers/pill/patch/styptic = 5,
					/obj/item/weapon/reagent_containers/pill/patch/silver_sulf = 5,/obj/item/weapon/reagent_containers/glass/bottle/charcoal = 2,
					/obj/item/weapon/reagent_containers/glass/bottle/epinephrine = 2,/obj/item/weapon/reagent_containers/glass/bottle/morphine = 2,
					/obj/item/weapon/reagent_containers/glass/bottle/diphenhydramine = 2,/obj/item/weapon/reagent_containers/glass/bottle/potass_iodide = 2,
					/obj/item/weapon/reagent_containers/glass/bottle/salglu_solution = 3,/obj/item/weapon/reagent_containers/glass/bottle/atropine = 2,/obj/item/weapon/reagent_containers/syringe/antiviral = 3,
					/obj/item/weapon/reagent_containers/syringe/calomel = 5,/obj/item/weapon/reagent_containers/pill/salbutamol = 5,/obj/item/weapon/reagent_containers/pill/mannitol = 5,
					/obj/item/weapon/reagent_containers/pill/mutadone = 3,/obj/item/device/healthanalyzer = 2, /obj/item/device/sensor_device = 1,/obj/item/weapon/reagent_containers/glass/bottle/toxin = 2)
	contraband = list(/obj/item/weapon/reagent_containers/pill/tox = 2,/obj/item/weapon/reagent_containers/pill/morphine = 2,/obj/item/weapon/reagent_containers/pill/charcoal = 3)

/obj/machinery/vending/security
	name = "\improper SecTech"
	desc = "A security equipment vendor"
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon_state = "sec"
	icon_deny = "sec-deny"
	req_access_txt = "1"
	products = list(/obj/item/weapon/restraints/handcuffs = 8,/obj/item/weapon/restraints/handcuffs/cable/zipties = 10,/obj/item/weapon/grenade/flashbang = 4,/obj/item/device/assembly/flash/handheld = 5,
					/obj/item/weapon/reagent_containers/food/snacks/donut = 12,/obj/item/weapon/storage/box/evidence = 6,/obj/item/device/flashlight/seclite = 4)
	contraband = list(/obj/item/clothing/glasses/sunglasses = 2,/obj/item/weapon/storage/fancy/donut_box = 2)
	premium = list(/obj/item/weapon/coin/antagtoken = 1)

/obj/machinery/vending/hydronutrients
	name = "\improper NutriMax"
	desc = "A plant nutrients vendor"
	product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants are people too!"
	product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	products = list(/obj/item/weapon/reagent_containers/glass/bottle/nutrient/ez = 30,/obj/item/weapon/reagent_containers/glass/bottle/nutrient/l4z = 20,/obj/item/weapon/reagent_containers/glass/bottle/nutrient/rh = 10,/obj/item/weapon/reagent_containers/spray/pestspray = 20,
					/obj/item/weapon/reagent_containers/syringe = 5,/obj/item/weapon/storage/bag/plants = 5)
	contraband = list(/obj/item/weapon/reagent_containers/glass/bottle/ammonia = 10,/obj/item/weapon/reagent_containers/glass/bottle/diethylamine = 5)

/obj/machinery/vending/hydroseeds
	name = "\improper MegaSeed Servitor"
	desc = "When you need seeds fast!"
	product_slogans = "THIS'S WHERE TH' SEEDS LIVE! GIT YOU SOME!;Hands down the best seed selection on the station!;Also certain mushroom varieties available, more for experts! Get certified today!"
	product_ads = "We like plants!;Grow some crops!;Grow, baby, growww!;Aw h'yeah son!"
	icon_state = "seeds"
	products = list(/obj/item/seeds/ambrosiavulgarisseed = 3,/obj/item/seeds/appleseed = 3,/obj/item/seeds/bananaseed = 3,/obj/item/seeds/berryseed = 3,
						/obj/item/seeds/cabbageseed = 3,/obj/item/seeds/carrotseed = 3,/obj/item/seeds/cherryseed = 3,/obj/item/seeds/chantermycelium = 3,
						/obj/item/seeds/chiliseed = 3,/obj/item/seeds/cocoapodseed = 3,/obj/item/seeds/coffee_arabica_seed = 3,/obj/item/seeds/cornseed = 3,
						/obj/item/seeds/eggplantseed = 3,/obj/item/seeds/grapeseed = 3,/obj/item/seeds/grassseed = 3,/obj/item/seeds/lemonseed = 3,
						/obj/item/seeds/limeseed = 3,/obj/item/seeds/orangeseed = 3,/obj/item/seeds/potatoseed = 3,/obj/item/seeds/poppyseed = 3,
						/obj/item/seeds/pumpkinseed = 3,/obj/item/seeds/replicapod = 3,/obj/item/seeds/soyaseed = 3,/obj/item/seeds/sunflowerseed = 3,
						/obj/item/seeds/tea_aspera_seed = 3,/obj/item/seeds/tobacco_seed = 3,/obj/item/seeds/tomatoseed = 3,
						/obj/item/seeds/towermycelium = 3,/obj/item/seeds/watermelonseed = 3,/obj/item/seeds/wheatseed = 3,/obj/item/seeds/whitebeetseed = 3,/obj/item/seeds/vanillapodseed = 3,/obj/item/seeds/riceseed = 3)
	contraband = list(/obj/item/seeds/amanitamycelium = 2,/obj/item/seeds/glowshroom = 2,/obj/item/seeds/libertymycelium = 2,/obj/item/seeds/nettleseed = 2,
						/obj/item/seeds/plumpmycelium = 2,/obj/item/seeds/reishimycelium = 2)
	premium = list(/obj/item/weapon/reagent_containers/spray/waterflower = 1)


/obj/machinery/vending/magivend
	name = "\improper MagiVend"
	desc = "A magic vending machine."
	icon_state = "MagiVend"
	product_slogans = "Sling spells the proper way with MagiVend!;Be your own Houdini! Use MagiVend!"
	vend_delay = 15
	vend_reply = "Have an enchanted evening!"
	product_ads = "FJKLFJSD;AJKFLBJAKL;1234 LOONIES LOL!;>MFW;Kill them fuckers!;GET DAT FUKKEN DISK;HONK!;EI NATH;Destroy the station!;Admin conspiracies since forever!;Space-time bending hardware!"
	products = list(/obj/item/clothing/head/wizard = 1,/obj/item/clothing/suit/wizrobe = 1,
	/obj/item/clothing/head/wizard/red = 1,/obj/item/clothing/suit/wizrobe/red = 1,
	/obj/item/clothing/head/wizard/yellow = 1,/obj/item/clothing/suit/wizrobe/yellow = 1,
	/obj/item/clothing/shoes/sandal = 1,/obj/item/weapon/staff = 2,
	/obj/item/clothing/head/blackmage = 1, /obj/item/clothing/head/greywizard = 1,
	/obj/item/clothing/head/greenwizard = 1, /obj/item/clothing/head/jesterwizard = 1,
	/obj/item/clothing/head/pimpwizard = 1, /obj/item/clothing/head/rainbowwizard = 1,
	/obj/item/clothing/head/whitewizard = 1, /obj/item/clothing/suit/blackmage = 1,
	/obj/item/clothing/suit/greywizard = 1,/obj/item/clothing/suit/greenwizard = 1,
	/obj/item/clothing/suit/jesterwizard = 1, /obj/item/clothing/suit/pimpwizard = 1,
	/obj/item/clothing/suit/rainbowwizard = 1, /obj/item/clothing/suit/whitewizard = 1)
	contraband = list(/obj/item/weapon/reagent_containers/glass/bottle/wizarditis = 1)	//No one can get to the machine to hack it anyways; for the lulz - Microwave

/obj/machinery/vending/autodrobe
	name = "\improper AutoDrobe"
	desc = "A vending machine for costumes."
	icon_state = "theater"
	icon_deny = "theater-deny"
	req_access_txt = "46" //Theatre access needed, unless hacked.
	product_slogans = "Dress for success!;Suited and booted!;It's show time!;Why leave style up to fate? Use AutoDrobe!"
	vend_delay = 15
	vend_reply = "Thank you for using AutoDrobe!"
	products = list(/obj/item/clothing/head/powdered_wig = 4, /obj/item/clothing/head/skeleton = 4,
	/obj/item/clothing/head/predator = 4, /obj/item/clothing/head/tardbaby = 4,
	/obj/item/clothing/head/werewolf = 4, /obj/item/clothing/head/roach = 4,
	/obj/item/clothing/head/neckstump = 4, /obj/item/clothing/head/mailman = 4,
	/obj/item/clothing/head/plaguedoctorhat = 4, /obj/item/clothing/head/cardborg = 4,
	/obj/item/clothing/head/rabbitears  = 4, /obj/item/clothing/head/pirate = 4,
	/obj/item/clothing/head/hgpiratecap = 4, /obj/item/clothing/head/bandana  = 4,
	/obj/item/clothing/head/witchwig  = 4, /obj/item/clothing/head/chicken = 4,
	/obj/item/clothing/head/griffin  = 4, /obj/item/clothing/head/bearpelt = 4,
	/obj/item/clothing/head/xenos = 4, /obj/item/clothing/head/xenom_q = 4, /obj/item/clothing/head/cone  = 4,
	/obj/item/clothing/head/santa = 4, /obj/item/clothing/head/jester  = 4,
	/obj/item/clothing/head/rice_hat = 4,  /obj/item/clothing/under/cluwne = 4,
	/obj/item/clothing/under/catholic = 4, /obj/item/clothing/under/rabbi = 4,
	/obj/item/clothing/under/muslim = 4, /obj/item/clothing/under/arroganza = 2,
	/obj/item/clothing/under/buddhist = 4,
	/obj/item/clothing/under/siropa = 4, /obj/item/clothing/under/fancyclown = 4,
	/obj/item/clothing/under/patriotsuit = 4, /obj/item/clothing/under/sl_suit = 4,
	/obj/item/clothing/under/roman = 4, /obj/item/clothing/under/rank/mailman = 4,
	/obj/item/clothing/under/sexyclown = 4, /obj/item/clothing/under/owl = 4,
	/obj/item/clothing/under/griffin = 4, /obj/item/clothing/under/pirate = 4,
	/obj/item/clothing/under/soviet = 4, /obj/item/clothing/under/kilt = 4,
	/obj/item/clothing/under/sexymime = 4, /obj/item/clothing/under/gladiator = 4,
	/obj/item/clothing/under/jester = 4, /obj/item/clothing/suit/pirate = 4,
	/obj/item/clothing/suit/hgpirate = 4, /obj/item/clothing/suit/cyborg_suit = 4,
	/obj/item/clothing/suit/judgerobe = 4, /obj/item/clothing/suit/imperium_monk = 4,
	/obj/item/clothing/suit/chickensuit = 4, /obj/item/clothing/suit/monkeysuit = 4,
	/obj/item/clothing/suit/toggle/owlwings = 4, /obj/item/clothing/suit/cardborg = 4,
	/obj/item/clothing/suit/banecoat = 4, /obj/item/clothing/suit/beesuit = 4,
	/obj/item/clothing/suit/sneakman = 4, /obj/item/clothing/shoes/sneakers/mime = 4,
	/obj/item/clothing/shoes/baneboots = 4, /obj/item/clothing/shoes/clown_shoes = 4,
	/obj/item/clothing/shoes/cluwne = 4, /obj/item/clothing/shoes/cyborg = 4,
	/obj/item/clothing/shoes/roman = 4, /obj/item/clothing/shoes/griffin = 4,
	/obj/item/clothing/suit/apron/overalls = 4, /obj/item/clothing/suit/poncho = 4,
	/obj/item/clothing/suit/bluesweater = 4, /obj/item/clothing/suit/redsweater = 4,
	/obj/item/clothing/suit/greensweater = 4, /obj/item/clothing/suit/poncho/green = 4,
	/obj/item/clothing/suit/poncho/red = 4, /obj/item/clothing/suit/whitedress = 4,
	/obj/item/clothing/suit/ianshirt = 4, /obj/item/clothing/suit/nerdshirt = 4,
	/obj/item/clothing/suit/jacket = 4, /obj/item/clothing/suit/jacket/leather = 4,
	/obj/item/clothing/suit/jacket/puffer = 4, /obj/item/clothing/suit/scorpianjacket = 4,
	/obj/item/clothing/suit/jacket/puffer/vest = 4, /obj/item/clothing/suit/jacket/miljacket = 4,
	/obj/item/clothing/suit/hooded/wintercoat = 4,/obj/item/clothing/suit/hunterscoat = 4,
	/obj/item/clothing/suit/overcoat = 2,/obj/item/clothing/suit/cec_dress = 2,
	/obj/item/clothing/under/dolan = 2, /obj/item/clothing/under/yay = 2,
	/obj/item/clothing/under/utena = 2, /obj/item/clothing/under/kilt2 = 2,
	/obj/item/clothing/under/bane = 2, /obj/item/clothing/under/maximusarmor =2,
	/obj/item/clothing/suit/draculacoat = 2, /obj/item/clothing/suit/magiciansuit = 2,
	/obj/item/clothing/suit/goodblanket = 2, /obj/item/clothing/suit/shittyuglyawfulBADblanket = 2,
	/obj/item/clothing/suit/snowman = 2, /obj/item/clothing/suit/bonearmor = 2,
	/obj/item/clothing/suit/bee = 2, /obj/item/clothing/suit/witchhunter = 2)
	refill_canister = /obj/item/weapon/vending_refill/autodrobe

/obj/machinery/vending/dinnerware
	name = "\improper Plasteel Chef's Dinnerware Vendor"
	desc = "A kitchen and restaurant equipment vendor"
	product_ads = "Mm, food stuffs!;Food and food accessories.;Get your plates!;You like forks?;I like forks.;Woo, utensils.;You don't really need these..."
	icon_state = "dinnerware"
	products = list(/obj/item/weapon/storage/bag/tray = 8,/obj/item/weapon/kitchen/fork = 6,/obj/item/weapon/kitchen/knife = 3,/obj/item/weapon/kitchen/rollingpin = 2,/obj/item/weapon/reagent_containers/food/drinks/drinkingglass = 8,/obj/item/clothing/suit/apron/chef = 2,/obj/item/weapon/reagent_containers/food/condiment/pack/ketchup = 5,/obj/item/weapon/reagent_containers/food/condiment/pack/hotsauce = 5,/obj/item/weapon/reagent_containers/glass/bowl = 20)
	contraband = list(/obj/item/weapon/kitchen/rollingpin = 2, /obj/item/weapon/kitchen/knife/butcher = 2)

/obj/machinery/vending/sovietsoda
	name = "\improper BODA"
	desc = "Old sweet water vending machine"
	icon_state = "sovietsoda"
	product_ads = "For Tsar and Country.;Have you fulfilled your nutrition quota today?;Very nice!;We are simple people, for this is all we eat.;If there is a person, there is a problem. If there is no person, then there is no problem."
	products = list(/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/filled/soda = 30)
	contraband = list(/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/filled/cola = 20)

/obj/machinery/vending/tool
	name = "\improper YouTool"
	desc = "Tools for tools."
	icon_state = "tool"
	icon_deny = "tool-deny"
	//req_access_txt = "12" //Maintenance access
	products = list(/obj/item/stack/cable_coil/random = 10,/obj/item/weapon/crowbar = 5,/obj/item/weapon/weldingtool = 3,/obj/item/weapon/wirecutters = 5,
					/obj/item/weapon/wrench = 5,/obj/item/device/analyzer = 5,/obj/item/device/t_scanner = 5,/obj/item/weapon/screwdriver = 5)
	contraband = list(/obj/item/weapon/weldingtool/hugetank = 2,/obj/item/clothing/gloves/color/fyellow = 2)
	premium = list(/obj/item/clothing/gloves/color/fyellow = 1) // I hate powergaming trash.  ~Tk

/obj/machinery/vending/engivend
	name = "\improper Engi-Vend"
	desc = "Spare tool vending. What? Did you expect some witty description?"
	icon_state = "engivend"
	icon_deny = "engivend-deny"
	req_access_txt = "11" //Engineering Equipment access
	products = list(/obj/item/clothing/glasses/meson/engine = 2,/obj/item/device/multitool = 4,/obj/item/weapon/electronics/airlock = 10,/obj/item/weapon/electronics/apc = 10,/obj/item/weapon/electronics/airalarm = 10,/obj/item/weapon/stock_parts/cell/high = 10, /obj/item/weapon/rcd/loaded = 3, /obj/item/device/geiger_counter = 5)
	contraband = list(/obj/item/weapon/stock_parts/cell/potato = 3)
	premium = list(/obj/item/weapon/storage/belt/utility = 3)

//This one's from bay12
/obj/machinery/vending/engineering
	name = "\improper Robco Tool Maker"
	desc = "Everything you need for do-it-yourself station repair."
	icon_state = "engi"
	icon_deny = "engi-deny"
	req_access_txt = "11"
	products = list(/obj/item/clothing/under/rank/chief_engineer = 4,/obj/item/clothing/under/rank/engineer = 4,/obj/item/clothing/shoes/sneakers/orange = 4,/obj/item/clothing/head/hardhat = 4,
					/obj/item/weapon/storage/belt/utility = 4,/obj/item/clothing/glasses/meson/engine = 4,/obj/item/clothing/gloves/color/yellow = 4, /obj/item/weapon/screwdriver = 12,
					/obj/item/weapon/crowbar = 12,/obj/item/weapon/wirecutters = 12,/obj/item/device/multitool = 12,/obj/item/weapon/wrench = 12,/obj/item/device/t_scanner = 12,
					/obj/item/weapon/stock_parts/cell = 8, /obj/item/weapon/weldingtool = 8,/obj/item/clothing/head/welding = 8,
					/obj/item/weapon/light/tube = 10,/obj/item/clothing/suit/fire = 4, /obj/item/weapon/stock_parts/scanning_module = 5,/obj/item/weapon/stock_parts/micro_laser = 5,
					/obj/item/weapon/stock_parts/matter_bin = 5,/obj/item/weapon/stock_parts/manipulator = 5,/obj/item/weapon/stock_parts/console_screen = 5)

//This one's from bay12
/obj/machinery/vending/robotics
	name = "\improper Robotech Deluxe"
	desc = "All the tools you need to create your own robot army."
	icon_state = "robotics"
	icon_deny = "robotics-deny"
	req_access_txt = "29"
	products = list(/obj/item/clothing/suit/toggle/labcoat = 4,/obj/item/clothing/under/rank/roboticist = 4,/obj/item/stack/cable_coil = 4,/obj/item/device/assembly/flash/handheld = 4,
					/obj/item/weapon/stock_parts/cell/high = 12, /obj/item/device/assembly/prox_sensor = 3,/obj/item/device/assembly/signaler = 3,/obj/item/device/healthanalyzer = 3,
					/obj/item/weapon/scalpel = 2,/obj/item/weapon/circular_saw = 2,/obj/item/weapon/tank/internals/anesthetic = 2,/obj/item/clothing/mask/breath/medical = 5,
					/obj/item/weapon/screwdriver = 5,/obj/item/weapon/crowbar = 5)


//DON'T FORGET TO CHANGE THE REFILL SIZE IF YOU CHANGE THE MACHINE'S CONTENTS!
/obj/machinery/vending/clothing
	name = "ClothesMate" //renamed to make the slogan rhyme
	desc = "A vending machine for clothing."
	icon_state = "clothes"
	product_slogans = "Dress for success!;Prepare to look swagalicious!;Look at all this free swag!;Why leave style up to fate? Use the ClothesMate!"
	vend_delay = 15
	vend_reply = "Thank you for using the ClothesMate!"
	products = list(/obj/item/clothing/under/bluebride = 4, /obj/item/clothing/under/blackswimsuit = 4,
	/obj/item/clothing/under/bluebride = 4, /obj/item/clothing/under/blackswimsuit = 4,
	/obj/item/clothing/under/blueswimsuit = 4, /obj/item/clothing/under/greenswimsuit = 4,
	/obj/item/clothing/under/purpleswimsuit = 4, /obj/item/clothing/under/redswimsuit = 4,
	/obj/item/clothing/under/blackswimsuit = 4, /obj/item/clothing/under/yang = 4,
	/obj/item/clothing/under/whitesundress = 4, /obj/item/clothing/under/darkreddress = 4,
	/obj/item/clothing/under/bluecheongsam = 4, /obj/item/clothing/under/whitedress2 = 4,
	/obj/item/clothing/under/redcheongsam = 4, /obj/item/clothing/under/whitedress  = 4,
	/obj/item/clothing/under/tiandress = 4, /obj/item/clothing/under/sakurakimono = 4,
	/obj/item/clothing/under/hawaiian = 4,/obj/item/clothing/under/bowlingoutfit = 4,
	/obj/item/clothing/under/orangebride = 4, /obj/item/clothing/under/purplebride = 4,
	/obj/item/clothing/under/redbride = 4, /obj/item/clothing/under/whitebride = 4,
	/obj/item/clothing/under/firedress = 4, /obj/item/clothing/under/firereddress = 4,
	/obj/item/clothing/under/greendress = 4, /obj/item/clothing/under/orangedress = 4,
	/obj/item/clothing/under/pinkdress = 4, /obj/item/clothing/under/saloondress = 4,
	/obj/item/clothing/under/yellowdress = 4, /obj/item/clothing/under/roll = 4,
	/obj/item/clothing/under/towel = 4, /obj/item/clothing/under/miku = 4,
	/obj/item/clothing/under/princess = 4, /obj/item/clothing/under/anthy = 4,
	/obj/item/clothing/under/pinkdress = 4, /obj/item/clothing/under/middriftturtleneck = 4,
	/obj/item/clothing/under/pj/red = 4, /obj/item/clothing/under/pj/blue = 4,
	/obj/item/clothing/under/blackskirt = 4, /obj/item/clothing/under/blueskirt = 4,
	/obj/item/clothing/under/blueskirt/redskirt = 4, /obj/item/clothing/under/schoolgirl = 4,
	/obj/item/clothing/under/schoolgirl/red = 4, /obj/item/clothing/under/schoolgirl/green = 4,
	/obj/item/clothing/under/schoolgirl/orange = 4, /obj/item/clothing/under/kilt = 4,
	/obj/item/clothing/under/sundress = 4, /obj/item/clothing/under/blacktango = 4,
	/obj/item/clothing/under/stripeddress = 4, /obj/item/clothing/under/sailordress = 4,
	/obj/item/clothing/under/redeveninggown = 4, /obj/item/clothing/under/maid = 4,
	/obj/item/clothing/under/janimaid = 4, /obj/item/clothing/under/plaid_skirt = 4,
	/obj/item/clothing/under/plaid_skirt/blue = 4, /obj/item/clothing/under/plaid_skirt/purple = 4,
	/obj/item/clothing/under/bb = 4, /obj/item/clothing/under/bb/sweater = 4,
	/obj/item/clothing/under/bb/sweater/purple = 4, /obj/item/clothing/under/bb/sweater/green = 4,
	/obj/item/clothing/under/bb/sweater/red = 4, /obj/item/clothing/under/bb/sweater/blue = 4,
	/obj/item/clothing/under/pants/classicjeans = 4, /obj/item/clothing/under/pants/mustangjeans =4,
	/obj/item/clothing/under/pants/blackjeans = 4, /obj/item/clothing/under/pants/youngfolksjeans =4,
	/obj/item/clothing/under/pants/white = 4, /obj/item/clothing/under/pants/red = 4,
	/obj/item/clothing/under/pants/black = 4, /obj/item/clothing/under/pants/tan = 4,
	/obj/item/clothing/under/pants/track = 4, /obj/item/clothing/under/pants/jeans = 4,
	/obj/item/clothing/under/pants/khaki = 4, /obj/item/clothing/under/pants/camo = 4,
	/obj/item/clothing/under/lawyer/black = 2, /obj/item/clothing/under/lawyer/female = 2,
	/obj/item/clothing/under/lawyer/red = 2, /obj/item/clothing/under/lawyer/blue = 2,
	/obj/item/clothing/under/lawyer/bluesuit = 2, /obj/item/clothing/under/lawyer/purpsuit = 2,
	/obj/item/clothing/under/toga = 4, /obj/item/clothing/under/latexmaid = 4,
	/obj/item/clothing/tie/blackcollar = 4, /obj/item/clothing/tie/shinycollar = 4,
	/obj/item/clothing/tie/goldcollar = 4, /obj/item/clothing/tie/necklace/bellcollar = 4,
	/obj/item/clothing/tie/necklace/pinkcollar = 4, /obj/item/clothing/tie/necklace/flowercollar = 4, /obj/item/clothing/tie/necklace/spikedmant = 4,
	/obj/item/clothing/tie/necklace/steelcollar = 4, /obj/item/clothing/tie = 4,
	/obj/item/clothing/tie/blue = 4, /obj/item/clothing/tie/red = 4,
	/obj/item/clothing/tie/black = 4, /obj/item/clothing/tie/horrible = 4,
	/obj/item/clothing/tie/waistcoat = 4, /obj/item/clothing/tie/scarf = 4,
	/obj/item/clothing/tie/scarf/red = 4, /obj/item/clothing/tie/scarf/green = 4,
	/obj/item/clothing/tie/scarf/darkblue = 4, /obj/item/clothing/tie/scarf/purple = 4,
	/obj/item/clothing/tie/scarf/yellow = 4, /obj/item/clothing/tie/scarf/orange = 4,
	/obj/item/clothing/tie/scarf/orange = 4, /obj/item/clothing/tie/scarf/lightblue = 4,
	/obj/item/clothing/tie/scarf/white = 4, /obj/item/clothing/tie/scarf/black = 4,
	/obj/item/clothing/tie/scarf/zebra = 4, /obj/item/clothing/tie/scarf/christmas = 4,
	/obj/item/clothing/tie/stripedredscarf = 4, /obj/item/clothing/tie/stripedgreenscarf = 4,
	/obj/item/clothing/tie/stripedbluescarf = 4, /obj/item/clothing/tie/mantelet = 4,
	/obj/item/clothing/tie/mantelet/white = 4, /obj/item/clothing/tie/mantelet/cc = 4,
	/obj/item/clothing/gloves/weddingring = 6, /obj/item/clothing/gloves/weddingring/silver = 6,
	/obj/item/clothing/under/shizunewinter = 4, /obj/item/clothing/under/shizunenormal = 4,
	/obj/item/clothing/under/keyholesweater = 4, /obj/item/clothing/under/hoodiejeans = 4,
	/obj/item/clothing/under/hoodieskirt = 4, /obj/item/clothing/under/castiledress = 2,
	/obj/item/clothing/under/flapperdress = 2, /obj/item/clothing/under/purplecheer = 2,
	/obj/item/clothing/under/yellowcheer = 2, /obj/item/clothing/under/whitecheer = 2,
	/obj/item/clothing/under/schoolgirlblack = 2, /obj/item/clothing/under/sasha = 2,
	/obj/item/clothing/under/cuttopred = 2, /obj/item/clothing/under/croptop = 2,
	/obj/item/clothing/under/bowlingoutfit = 2, /obj/item/clothing/under/purpleskirt = 2,
	/obj/item/clothing/under/geisha = 2, /obj/item/clothing/under/ysing = 2,
	/obj/item/clothing/under/bsing = 2, /obj/item/clothing/under/arroganza = 2)


	refill_canister = /obj/item/weapon/vending_refill/clothing

/obj/machinery/vending/kink
	name = "KinkMate"
	desc = "A vending machine for all your unmentionable desires."
	icon_state = "kink"
	product_slogans = "Kinky!;Sexy!;Check me out, big boy!"
	vend_delay = 15
	vend_reply = "Have fun, you shameless pervert!"
	products = list(/obj/item/clothing/under/maid=5,/obj/item/clothing/under/schoolgirl=3,
	/obj/item/clothing/tie/petcollar=5,/obj/item/clothing/tie/spikecollar=3,
	/obj/item/clothing/ears/earmuffs=2,/obj/item/clothing/glasses/sunglasses/blindfold=2,
	/obj/item/clothing/mask/muzzle=2,/obj/item/weapon/dildo=10,/obj/item/weapon/dildos/canine=4,
	/obj/item/weapon/dildos/purpledong=4,/obj/item/weapon/dildos/bigblackdick=4,
	/obj/item/weapon/dildos/floppydick=4,/obj/item/weapon/bulletvibe=4,
	/obj/item/weapon/fleshlight=2, /obj/item/clothing/under/birthdaysuit = 4,
	/obj/item/weapon/dildos/analbeads=2)
	contraband = list()
	premium = list(/obj/item/clothing/under/latexmaid=3,/obj/item/weapon/dildo/psych=2,/obj/item/weapon/restraints/handcuffs/kink=2,
	/obj/item/clothing/head/wizard/fake=1,/obj/item/clothing/suit/wizrobe/fake=1)
	refill_canister = /obj/item/weapon/vending_refill/kink

/obj/machinery/vending/donut
	name = "A Donut Vendor!"
	desc = "It dispenses donuts to officers! Sprinkle Power!"
	product_ads = "Sprinkle your foes!;Donuts are good for your heath!;Free sprinkles with every coin!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon_state = "Donut"
	icon_deny = "Donut-deny"
	vend_reply = "Enjoy!"
	req_access_txt = "1"
	products = list(/obj/item/weapon/reagent_containers/food/snacks/donut=20,/obj/item/weapon/reagent_containers/food/snacks/donut=20)
	contraband = list()
	premium = list()

/obj/machinery/vending/taco
	name = "Taco Vendor"
	desc = "Looks like it was made for a taco bird. Weird."
	product_ads = "Inhale tacos. Exhale Negativity!;I'm a big taco fan!;Free sprinkles with every coin!;Hey you. Yeah, you. No, not you..The other guy. You right there! Yes, you. Do you like tacos?.;Live everday like it's Taco Tuesday!"
	icon_state = "taco"
	vend_reply = "Make tacos. Not war."
	req_access_txt = "1"
	products = list(/obj/item/weapon/reagent_containers/food/snacks/taco=50)
	contraband = list()
	premium = list()

/obj/machinery/vending/shoes
	name = "Shoe Vendor"
	desc = "A place for all your shoe needs!"
	product_ads = "Get your kicks here!"
	icon_state = "shoes"
	vend_reply = "Shoe like in both form and fuction!"
	products = list(/obj/item/clothing/shoes/cowboy = 4, /obj/item/clothing/shoes/slippers = 4,
	/obj/item/clothing/shoes/whiteflats = 4, /obj/item/clothing/shoes/blackflats = 4,
	/obj/item/clothing/shoes/redflats = 4, /obj/item/clothing/shoes/blueflats = 4,
	/obj/item/clothing/shoes/brownflats = 4, /obj/item/clothing/shoes/purpleflats = 4,
	/obj/item/clothing/shoes/sandal = 4, /obj/item/clothing/shoes/jackboots = 4,
	/obj/item/clothing/shoes/winterboots = 4, /obj/item/clothing/shoes/workboots = 4,
	/obj/item/clothing/shoes/laceup = 4, /obj/item/clothing/shoes/kneesock = 4,
	/obj/item/clothing/shoes/aviatorboots = 4)

/obj/machinery/vending/hats
	name = "Hat Vendor"
	desc = "A place for all your hat needs!"
	product_ads = "Euphoric!;You can hide in our shade!;Stylish!;Just like the royal wedding!"
	icon_state = "hats"
	vend_reply = "Tipping intensifies.;At least its not a fedora!"
	products = list(/obj/item/clothing/head/that = 4, /obj/item/clothing/head/cat = 4,
	/obj/item/clothing/head/mousewhite = 4, /obj/item/clothing/head/mousegrey = 4,
	/obj/item/clothing/head/mousebrown = 4, /obj/item/clothing/head/monkey = 4,
	/obj/item/clothing/head/monkey = 4, /obj/item/clothing/head/farwa = 4,
	/obj/item/clothing/head/stok = 4, /obj/item/clothing/head/hijab = 4,
	/obj/item/clothing/head/turban = 4, /obj/item/clothing/head/towel = 4,
	/obj/item/clothing/head/blackberet = 4, /obj/item/clothing/head/blueberet = 4,
	/obj/item/clothing/head/purpleberet = 4, /obj/item/clothing/head/cowboyhat = 4,
	/obj/item/clothing/head/papersack = 4, /obj/item/clothing/head/papersacksmile = 4,
	/obj/item/clothing/head/crown = 4, /obj/item/clothing/head/fancycrown = 4,
	/obj/item/clothing/head/lindaberet = 4, /obj/item/clothing/head/canada = 4,
	/obj/item/clothing/head/bowler = 4, /obj/item/clothing/head/fedora = 4,
	/obj/item/clothing/head/sombrero = 4, /obj/item/clothing/head/sombrero/green = 4,
	/obj/item/clothing/head/hunter = 4, /obj/item/clothing/glasses/regular = 4,
	/obj/item/clothing/glasses/regular/hipster = 4, /obj/item/clothing/glasses/sunglasses = 2,
	/obj/item/clothing/head/bmhead = 4, /obj/item/clothing/head/maidhat = 4,
	/obj/item/clothing/head/pajamahatblue = 4, /obj/item/clothing/head/pajamahatred = 4,
	/obj/item/clothing/head/enhead = 4, /obj/item/clothing/head/polarbearpelt = 4,
	/obj/item/clothing/head/witchhunterhat = 4, /obj/item/clothing/head/tvhead = 4,
	/obj/item/clothing/head/beanie  = 4, /obj/item/clothing/head/beanie/striped = 4,
	/obj/item/clothing/head/beanie/stripedred = 4, /obj/item/clothing/head/beanie/stripedblue = 4,
	/obj/item/clothing/head/beanie/stripedgreen = 4, /obj/item/clothing/head/mouse = 4,
	/obj/item/clothing/head/cakehat = 4, /obj/item/clothing/head/kitty = 4,
	/obj/item/clothing/head/huntinghat = 4, /obj/item/clothing/head/beesuithat = 4,
	/obj/item/clothing/head/bigfancycrown = 4, /obj/item/clothing/head/dragon = 4,
	/obj/item/clothing/head/snowman = 4)

/obj/machinery/vending/masks
	name = "Mask Vendor"
	desc = "A place for all your face needs!"
	product_ads = "Cover your face in style!"
	icon_state = "masks"
	vend_reply = "Stay frosty!"
	products = list(/obj/item/clothing/mask/gas/plaguedoctor = 4, /obj/item/clothing/mask/gas/clown_hat = 4,
	/obj/item/clothing/mask/gas/sexyclown = 4, /obj/item/clothing/mask/gas/mime = 4,
	/obj/item/clothing/mask/gas/sexymime = 4, /obj/item/clothing/mask/gas/monkeymask = 4,
	/obj/item/clothing/mask/gas/owl_mask = 4, /obj/item/clothing/mask/gas/carp = 4,
	/obj/item/clothing/mask/joy = 2, /obj/item/clothing/mask/rat/tribal = 2,
	/obj/item/clothing/mask/rat/jackal = 2, /obj/item/clothing/mask/rat/raven = 2,
	/obj/item/clothing/mask/rat/bat = 2, /obj/item/clothing/mask/rat/bear = 2,
	/obj/item/clothing/mask/rat/bee = 2, /obj/item/clothing/mask/rat/fox = 2,
	/obj/item/clothing/mask/rat = 2, /obj/item/clothing/mask/fakemoustache = 4,
	/obj/item/clothing/mask/tikieyebrow = 4, /obj/item/clothing/mask/tikihappy = 4,
	/obj/item/clothing/mask/tikiconfused = 4, /obj/item/clothing/mask/tikiangry = 4,
	/obj/item/clothing/mask/rainbowmask = 4, /obj/item/clothing/mask/scarecrowmask = 4,
	/obj/item/clothing/mask/cluwne = 4, /obj/item/clothing/mask/pig = 4,
	/obj/item/clothing/mask/horsehead = 4, /obj/item/clothing/mask/bandana/red = 4,
	/obj/item/clothing/mask/bandana/blue = 4, /obj/item/clothing/mask/bandana/green = 4,
	/obj/item/clothing/mask/bandana/gold = 4, /obj/item/clothing/mask/bandana/black = 4,
	/obj/item/clothing/mask/bandana/skull = 4)

/*
/obj/machinery/vending/suits
	name = "Suit Vender"
	desc = "You wonder for a moment why all of your shirts and pants come conjoined. This hurts your head and you stop thinking about it"
	product_ads = "Pre-Ironed, Pre-Washed, Pre-Wor-*BZZT*;Blood of your enemies washes right out!;Who are YOU wearing?;Look dapper! Look like an idiot!;Dont carry your size? How about you shave off some pounds you fat lazy- *BZZT*"
	icon_state "jacket"
	vend_reply = "Dapper time!"
	products = list(/obj/item/clothing/suit/apron/overalls = 4, /obj/item/clothing/suit/poncho = 4,
	/obj/item/clothing/suit/bluesweater = 4, /obj/item/clothing/suit/redsweater = 4,
	/obj/item/clothing/suit/greensweater = 4, /obj/item/clothing/suit/poncho/green = 4,
	/obj/item/clothing/suit/poncho/red = 4, /obj/item/clothing/suit/whitedress = 4,
	/obj/item/clothing/suit/ianshirt = 4, /obj/item/clothing/suit/nerdshirt = 4,
	/obj/item/clothing/suit/jacket = 4, /obj/item/clothing/suit/jacket/leather = 4,
	/obj/item/clothing/suit/leatherovercoat = 4, /obj/item/clothing/suit/jacket/puffer = 4,
	/obj/item/clothing/suit/jacket/puffer/vest = 4, /obj/item/clothing/suit/jacket/miljacket = 4,
	/obj/item/clothing/suit/hooded/wintercoat = 4)

/obj/machinery/sec/equipment_vendor
	name = "security equipment vendor"
	desc = "An equipment vendor for security personnel, points collected at a security redemption machine can be spent here."
	icon = 'icons/obj/vending.dmi'
	icon_state = "robustation"
	density = 1
	anchored = 1
	var/obj/item/weapon/card/id/inserted_id
	var/list/prize_list = list(
		new /datum/data/sec_equipment("Stimpack",			/obj/item/weapon/reagent_containers/hypospray/medipen/stimpack,	    50),
		new /datum/data/sec_equipment("Stimpack Bundle",		/obj/item/weapon/storage/box/medipens/utility,	 			   200),
		)

/datum/data/sec_equipment/
	var/equipment_name = "generic"
	var/equipment_path = null
	var/cost = 0

/datum/data/sec_equipment/New(name, path, cost)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost

/obj/machinery/sec/equipment_vendor/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/weapon/circuitboard/security_equipment_vendor(null)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(null)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(null)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(null)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(null)
	RefreshParts()

/obj/machinery/sec/equipment_vendor/attack_hand(mob/user)
	if(..())
		return
	interact(user)

/obj/machinery/sec/equipment_vendor/interact(mob/user)
	var/dat
	dat +="<div class='statusDisplay'>"
	if(istype(inserted_id))
		dat += "You have [inserted_id.sec_points] security points collected. <A href='?src=\ref[src];choice=eject'>Eject ID.</A><br>"
	else
		dat += "No ID inserted.  <A href='?src=\ref[src];choice=insert'>Insert ID.</A><br>"
	dat += "</div>"
	dat += "<br><b>Equipment point cost list:</b><BR><table border='0' width='200'>"
	for(var/datum/data/sec_equipment/prize in prize_list)
		dat += "<tr><td>[prize.equipment_name]</td><td>[prize.cost]</td><td><A href='?src=\ref[src];purchase=\ref[prize]'>Purchase</A></td></tr>"
	dat += "</table>"

	var/datum/browser/popup = new(user, "secvendor", "Security Equipment Vendor", 400, 350)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/sec/equipment_vendor/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"])
		if(istype(inserted_id))
			if(href_list["choice"] == "eject")
				inserted_id.loc = loc
				inserted_id.verb_pickup()
				inserted_id = null
		else if(href_list["choice"] == "insert")
			var/obj/item/weapon/card/id/I = usr.get_active_hand()
			if(istype(I))
				if(!usr.drop_item())
					return
				I.loc = src
				inserted_id = I
			else usr << "<span class='danger'>No valid ID.</span>"
	if(href_list["purchase"])
		if(istype(inserted_id))
			var/datum/data/security_equipment/prize = locate(href_list["purchase"])
			if (!prize || !(prize in prize_list))
				return
			if(prize.cost > inserted_id.sec_points)
			else
				inserted_id.sec_points -= prize.cost
				new prize.equipment_path(src.loc)
	updateUsrDialog()
	return

/obj/machinery/sec/equipment_vendor/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/sec_voucher))
		RedeemVoucher(I, user)
		return
	if(istype(I,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/C = usr.get_active_hand()
		if(istype(C) && !istype(inserted_id))
			if(!usr.drop_item())
				return
			C.loc = src
			inserted_id = C
			interact(user)
		return
	if(default_deconstruction_screwdriver(user, "robustation-open", "robustation", I))
		updateUsrDialog()
		return
	if(panel_open)
		if(istype(I, /obj/item/weapon/crowbar))
			default_deconstruction_crowbar(I)
		return 1
	..()

/obj/machinery/sec/equipment_vendor/proc/RedeemVoucher(obj/item/weapon/sec_voucher/voucher, mob/redeemer)
	var/selection = input(redeemer, "Pick your equipment", "Security Voucher Redemption") as null|anything in list("Kinetic Accelerator", "Resonator", "Mining Drone", "Advanced Scanner")
	if(!selection || !Adjacent(redeemer) || voucher.gc_destroyed || voucher.loc != redeemer)
		return
	switch(selection)
		if("Kinetic Accelerator")
			new /obj/item/weapon/gun/energy/kinetic_accelerator(src.loc)
		if("Resonator")
			new /obj/item/weapon/resonator(src.loc)
		if("Mining Drone")
			new /mob/living/simple_animal/hostile/mining_drone(src.loc)
			new /obj/item/weapon/weldingtool/hugetank(src.loc)
		if("Advanced Scanner")
			new /obj/item/device/t_scanner/adv_mining_scanner(src.loc)
	qdel(voucher)

/obj/machinery/sec/equipment_vendor/ex_act(severity, target)
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	if(prob(50 / severity) && severity < 3)
		qdel(src)

*/
#undef STANDARD_CHARGE
#undef CONTRABAND_CHARGE
#undef COIN_CHARGE
