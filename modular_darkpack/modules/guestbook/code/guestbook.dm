/**
 * THE GUESTBOOK DATUM
 *
 * Essentially, this datum handles the people that a given human knows,
 * to handle getting the correct names on examine and saycode.
 */
/datum/guestbook
	/// Associative list of known guests, real_name = known_name
	var/list/known_names

/datum/guestbook/Destroy(force)
	known_names = null
	return ..()

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
		names += list(list("real_name" = real_name, "given_name" = given_name))
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
	if(LAZYACCESS(known_names, guest.real_name))
		if(!rename_guest(user, guest, guest.real_name, given_name, silent))
			return FALSE
	else
		if(!add_guest(user, guest, guest.real_name, given_name, silent))
			return FALSE
	return TRUE

/datum/guestbook/proc/add_guest(mob/living/user, mob/living/carbon/guest, real_name, given_name, silent = TRUE)
	//Already exists, should be handled by rename_guest()
	var/existing_name = LAZYACCESS(known_names, real_name)
	if(existing_name)
		if(!silent)
			to_chat(user, span_warning("Вы уже знаете этого человека под именем \"[existing_name]\"."))
		return FALSE
	LAZYADDASSOC(known_names, real_name, given_name)
	user.save_guestbook(known_names)
	if(!silent)
		to_chat(user, span_notice("Вы запоминаете это лицо под именем \"[given_name]\"."))
	return TRUE

/datum/guestbook/proc/rename_guest(mob/living/user, mob/living/carbon/guest, real_name, given_name, silent = TRUE)
	var/old_name = LAZYACCESS(known_names, real_name)
	if(!old_name)
		return FALSE
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
	var/existing_name = LAZYACCESS(known_names, real_name)
	if(!existing_name)
		if(!silent)
			to_chat(user, span_warning("Вы и так не знаете этого человека."))
		return FALSE
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
	return LAZYACCESS(known_names, checked_name)

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
