/// Generic reagent applicator type for pills and patches
/obj/item/reagent_containers/applicator
	name = "generic reagent applicator"
	desc = "Report this please."
	abstract_type = /obj/item/reagent_containers/applicator
	has_variable_transfer_amount = FALSE
	/// Action string displayed in vis_message
	var/apply_method = "проглотить"
	/// CORVAX EDIT ADD - finite verb form for the self-use message
	var/apply_method_self = "проглатываете"
	/// Does the item get its name changed as volume when its produced
	var/rename_with_volume = FALSE
	/// How long does it take to apply this item to someone else?
	var/application_delay = 3 SECONDS
	/// How long does it take to apply this item to self?
	var/self_delay = 0

/obj/item/reagent_containers/applicator/Initialize(mapload)
	. = ..()
	if(reagents.total_volume && rename_with_volume)
		name += " ([reagents.total_volume]u)"

/// Consumption effects, must be overriden by children
/obj/item/reagent_containers/applicator/proc/on_consumption(mob/consumer, mob/giver, list/modifiers)
	return

/obj/item/reagent_containers/applicator/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!ismob(interacting_with))
		return NONE

	var/mob/target_mob = interacting_with
	if(!canconsume(target_mob, user))
		return ITEM_INTERACT_BLOCKING

	user.changeNext_move(CLICK_CD_MELEE)
	if(target_mob == user)
		target_mob.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] пытается [apply_method] [declent_ru(ACCUSATIVE)]."))
		if(self_delay)
			if(!do_after(user, self_delay, target_mob))
				return ITEM_INTERACT_BLOCKING
		to_chat(target_mob, span_notice("Вы [apply_method_self] [declent_ru(ACCUSATIVE)].")) // CORVAX EDIT CHANGE - ORIGINAL: to_chat(target_mob, span_notice("You [apply_method] [src]."))
		on_consumption(user, user, modifiers)
		return ITEM_INTERACT_SUCCESS

	target_mob.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] пытается заставить [target_mob.declent_ru(ACCUSATIVE)] [apply_method] [declent_ru(ACCUSATIVE)]."), span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] пытается заставить вас [apply_method] [declent_ru(ACCUSATIVE)]."))
	if(!do_after(user, CHEM_INTERACT_DELAY(application_delay, user), target_mob))
		return ITEM_INTERACT_BLOCKING

	target_mob.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] заставляет [target_mob.declent_ru(ACCUSATIVE)] [apply_method] [declent_ru(ACCUSATIVE)]."), span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] заставляет вас [apply_method] [declent_ru(ACCUSATIVE)]."))
	on_consumption(target_mob, user, modifiers)
	return ITEM_INTERACT_SUCCESS
