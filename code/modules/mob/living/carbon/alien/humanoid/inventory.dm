/mob/living/carbon/alien/humanoid/unEquip(obj/item/I)
	. = ..()
	if(!. || !I)
		return
/mob/living/carbon/alien/humanoid/get_item_by_slot(slot_id)
	switch(slot_id)
		if(slot_back)
			return back
		if(slot_wear_mask)
			return wear_mask
		if(slot_handcuffed)
			return handcuffed
		if(slot_legcuffed)
			return legcuffed
		if(slot_l_hand)
			return l_hand
		if(slot_r_hand)
			return r_hand
		if(slot_wear_id)
			return wear_id
		if(slot_head)
			return head
	return null

/mob/living/carbon/alien/humanoid/equip_to_slot(obj/item/I, slot)
	if(!..()) //a check failed or the item has already found its slot
		return
	switch(slot)
		if(slot_l_store)
			l_store = I
			update_inv_pockets()
		if(slot_r_store)
			r_store = I
			update_inv_pockets()
		else
			src << "<span class='danger'>You are trying to equip this item to an unsupported inventory slot. Report this to a coder!</span>"

/mob/living/carbon/alien/humanoid/proc/equip_in_one_of_slots(obj/item/I, list/slots, qdel_on_fail = 1)
	for(var/slot in slots)
		if(equip_to_slot_if_possible(I, slots[slot], qdel_on_fail = 0))
			return slot
	if(qdel_on_fail)
		qdel(I)
	return null