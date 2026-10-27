/**
 * THE GUESTBOOK DATUM
 *
 * Essentially, this datum handles the people that a given human knows,
 * to handle getting the correct names on examine and saycode.
 */
/datum/guestbook
	/// Associative list of known guests, real_name = known_name. PERSISTED.
	var/list/known_names
	// CORVAX EDIT ADD START
	/// Associative list of guests remembered only for this round (e.g. auto-added
	/// from a job's known_contacts, like unsaved phone numbers). NOT persisted.
	var/list/temporary_known_names
	// CORVAX EDIT ADD END

	var/list/datum/known_identity/known_identity_datums

/datum/guestbook/Destroy(force)
	LAZYNULL(known_names)
	LAZYNULL(temporary_known_names) // CORVAX EDIT
	LAZYNULL(known_identity_datums)
	return ..()

// CORVAX EDIT ADD START
/// Returns the given name for a real_name across both lists (persistent first).
/datum/guestbook/proc/find_known_name(real_name)
	var/found = LAZYACCESS(known_names, real_name)
	if(!isnull(found))
		return found
	return LAZYACCESS(temporary_known_names, real_name)
// CORVAX EDIT ADD END

/datum/guestbook/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Guestbook", "Знакомые: [user.real_name]")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/guestbook/ui_state(mob/user)
	return GLOB.always_state

/datum/guestbook/ui_data(mob/user)
	var/list/data = list()
	var/list/names = list()
	for(var/real_name in known_names)
		var/given_name = LAZYACCESS(known_names, real_name)
		names += list(list("real_name" = real_name, "given_name" = given_name, "temporary" = FALSE)) // CORVAX EDIT CHANGE - ORIGINAL: names += list(list("real_name" = real_name, "given_name" = given_name))
	// CORVAX EDIT ADD START
	for(var/real_name in temporary_known_names)
		var/given_name = LAZYACCESS(temporary_known_names, real_name)
		names += list(list("real_name" = real_name, "given_name" = given_name, "temporary" = TRUE))
	// CORVAX EDIT ADD END
	data["names"] = names
	return data

/datum/guestbook/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return .
	switch(action)
		if("rename_guest")
			var/real_name = params["real_name"]
			var/new_name = params["new_name"]
			new_name = reject_bad_name(new_name, max_length = 42)
			if(!new_name)
				to_chat(usr, span_warning("Имя так себе. <i>Придумайте что-нибудь получше</i>."))
				return FALSE
			if(!rename_guest(usr, null, real_name, new_name, silent = FALSE))
				return FALSE
			return TRUE
		if("delete_guest")
			var/real_name = params["real_name"]
			if(!remove_guest(usr, null, real_name, silent = FALSE))
				return FALSE
			return TRUE

/datum/guestbook/proc/try_add_guest(mob/user, mob/living/carbon/human/guest, silent = FALSE)
	if(user == guest)
		if(!silent)
			to_chat(user, span_warning("Это же вы! Себя вы и так прекрасно знаете."))
		return FALSE
	if(!visibility_checks(user, guest, silent))
		return FALSE
	var/given_name = tgui_input_text(user, "Под каким именем запомнить этого человека ([guest.declent_ru(NOMINATIVE)])?", "Новое знакомство", "", max_length = 42)
	if(!given_name)
		if(!silent)
			to_chat(user, span_warning("Вы передумали."))
		return FALSE
	given_name = reject_bad_name(given_name)
	if(!given_name)
		if(!silent)
			to_chat(user, span_warning("Имя так себе, придумайте другое."))
		return FALSE
	if(!visibility_checks(user, guest, silent))
		return FALSE
	// CORVAX EDIT CHANGE START - ORIGINAL: if(LAZYACCESS(known_names, guest.real_name))
	if(!isnull(find_known_name(guest.real_name)))
	// CORVAX EDIT CHANGE END
		if(!rename_guest(user, guest, guest.real_name, given_name, silent))
			return FALSE
	else
		if(!add_guest(user, guest, guest.real_name, given_name, silent))
			return FALSE
	return TRUE

// CORVAX EDIT CHANGE START - ORIGINAL: /datum/guestbook/proc/add_guest(mob/living/user, mob/living/carbon/guest, real_name, given_name, silent = TRUE)
/datum/guestbook/proc/add_guest(mob/living/user, mob/living/carbon/guest, real_name, given_name, silent = TRUE, temporary = FALSE)
	//Already exists, should be handled by rename_guest()
	// CORVAX EDIT CHANGE START - ORIGINAL: var/existing_name = LAZYACCESS(known_names, real_name)
	var/existing_name = find_known_name(real_name)
	// CORVAX EDIT CHANGE END
	if(!isnull(existing_name)) // CORVAX EDIT CHANGE - ORIGINAL: if(existing_name)
		if(!silent)
			to_chat(user, span_warning("Вы уже знаете этого человека под именем \"[existing_name]\"."))
		return FALSE
	// CORVAX EDIT ADD START
	if(temporary)
		LAZYSET(temporary_known_names, real_name, given_name)
	else
		LAZYSET(known_names, real_name, given_name)
		user.save_guestbook(known_names)
	// CORVAX EDIT ADD END
	if(!silent)
		to_chat(user, span_notice("Вы запоминаете это лицо под именем \"[given_name]\"."))
	return TRUE
// CORVAX EDIT CHANGE END

/datum/guestbook/proc/rename_guest(mob/living/user, mob/living/carbon/guest, real_name, given_name, silent = TRUE)
	// CORVAX EDIT CHANGE START - ORIGINAL: var/old_name = LAZYACCESS(known_names, real_name)
	var/old_name = LAZYACCESS(known_names, real_name)
	var/was_temporary = FALSE
	if(isnull(old_name))
		old_name = LAZYACCESS(temporary_known_names, real_name)
		was_temporary = !isnull(old_name)
	// CORVAX EDIT CHANGE END
	if(isnull(old_name)) // CORVAX EDIT CHANGE - ORIGINAL: if(!old_name)
		return FALSE
	// CORVAX EDIT ADD START
	if(was_temporary)
		// Manual rename on an auto-added (round-only) entry counts as "remembering"
		// it deliberately, so promote it to the persistent list.
		LAZYREMOVE(temporary_known_names, real_name)
		LAZYSET(known_names, real_name, given_name)
		user.save_guestbook(known_names)
	else
	// CORVAX EDIT ADD END
		LAZYSET(known_names, real_name, given_name)
		user.save_guestbook(known_names)
	if(!silent)
		to_chat(user, span_notice("Теперь вы знаете \"[old_name]\" под именем \"[given_name]\"."))
	return TRUE

/datum/guestbook/proc/try_remove_guest(mob/user, mob/living/carbon/human/guest, silent = FALSE)
	if(user == guest)
		if(!silent)
			to_chat(user, span_warning("Это же вы! Себя вы точно не забудете."))
		return
	if(!visibility_checks(user, guest, silent))
		return FALSE
	var/face_name = guest.get_face_name()
	if(!remove_guest(user, guest, face_name, silent))
		return FALSE
	return TRUE

/datum/guestbook/proc/remove_guest(mob/living/user, mob/living/carbon/guest, real_name, silent = TRUE)
	//Already exists, should be handled by rename_guest()
	// CORVAX EDIT CHANGE START - ORIGINAL: var/existing_name = LAZYACCESS(known_names, real_name)
	var/existing_name = LAZYACCESS(known_names, real_name)
	var/was_temporary = FALSE
	if(isnull(existing_name))
		existing_name = LAZYACCESS(temporary_known_names, real_name)
		was_temporary = !isnull(existing_name)
	// CORVAX EDIT CHANGE END
	if(isnull(existing_name)) // CORVAX EDIT CHANGE - ORIGINAL: if(!existing_name)
		if(!silent)
			to_chat(user, span_warning("Вы и так не знаете этого человека."))
		return FALSE
	// CORVAX EDIT ADD START
	if(was_temporary)
		LAZYREMOVE(temporary_known_names, real_name)
	else
	// CORVAX EDIT ADD END
		LAZYREMOVE(known_names, real_name)
		user.save_guestbook(known_names)
	if(!silent)
		to_chat(user, span_notice("Вы забываете, как выглядит \"[existing_name]\"."))
	return TRUE

/* Gets the requested name in reference to user.
 * user - The user reference from who we are checking the name from
 * guest - Optional arg, if set, uses the target reference to get a real_name for checking in reference to user.
 * checked_name - Optional arg, if guest is unset, checks the direct real_name against user's known_names list.
 */
/datum/guestbook/proc/get_known_name(mob/user, mob/living/carbon/guest, checked_name)
	if(guest)
		if(user == guest)
			return guest.real_name
		var/mob/living/carbon/carbon_guest = astype(guest)
		if((carbon_guest?.get_face_name() == "Неизвестный") && !carbon_guest.client?.prefs.read_preference(/datum/preference/toggle/show_identity_when_masked))
			return null
		checked_name = guest.real_name
	return find_known_name(checked_name) // CORVAX EDIT CHANGE - ORIGINAL: return LAZYACCESS(known_names, checked_name)

/datum/guestbook/proc/visibility_checks(mob/user, mob/living/carbon/human/guest, silent = FALSE)
	if(QDELETED(guest))
		if(!silent)
			to_chat(user, span_warning("Что?"))
		return FALSE
	var/mob/living/living_user = user
	if(istype(living_user) && !can_see(living_user, guest, DEFAULT_SIGHT_DISTANCE))
		if(!silent)
			to_chat(user, span_warning("Вы не видите этого человека!"))
		return FALSE
	var/face_name = guest.get_face_name()
	if((face_name == "Неизвестный"))
		if(!silent)
			to_chat(user, span_warning("Вам не удаётся как следует разглядеть лицо!"))
		return FALSE
	if(get_dist(user, guest) > DEFAULT_SIGHT_DISTANCE)
		if(!silent)
			to_chat(user, span_warning("Нужно подойти поближе и присмотреться!"))
		return FALSE
	return TRUE

/mob/living/carbon/human/proc/attempt_guestbook_add(datum/source, atom/A)
	SIGNAL_HANDLER

	if(!ishuman(A) || in_range(A, src))
		return
	var/mob/living/carbon/human/targeted_human = A
	if(!targeted_human.mind?.guestbook)
		return
	INVOKE_ASYNC(mind.guestbook, TYPE_PROC_REF(/datum/guestbook, try_add_guest), src, targeted_human, FALSE)
	return COMSIG_MOB_CANCEL_CLICKON
