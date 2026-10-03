/datum/action/changeling/mimicvoice
	name = "Mimic Voice"
	desc = "Мы формируем наши голосовые железы так, чтобы они звучали желаемым голосом. Поддержание этой силы замедляет выработку химических веществ."
	button_icon_state = "mimic_voice"
	helptext = "Превратит ваш голос в имя, которое вы введете. Мы должны постоянно расходовать химические вещества, чтобы поддерживать такую форму."
	category = "stealth"
	chemical_cost = 0//constant chemical drain hardcoded
	dna_cost = 1
	req_human = TRUE

// Fake Voice
/datum/action/changeling/mimicvoice/sting_action(mob/living/carbon/human/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(user.override_voice)
		changeling.chem_recharge_slowdown -= 0.25
		user.override_voice = ""
		to_chat(user, span_notice("We return our vocal glands to their original position."))
		return

	var/mimic_voice = sanitize_name(tgui_input_text(user, "Enter a name to mimic", "Mimic Voice", max_length = MAX_NAME_LEN))
	if(!mimic_voice)
		return
	..()
	changeling.chem_recharge_slowdown += 0.25
	user.override_voice = mimic_voice
	to_chat(user, span_notice("We shape our glands to take the voice of <b>[mimic_voice]</b>, this will slow down regenerating chemicals while active."))
	to_chat(user, span_notice("Use this power again to return to our original voice and return chemical production to normal levels."))
	return TRUE

/datum/action/changeling/mimicvoice/Remove(mob/living/carbon/human/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(user.override_voice)
		changeling?.chem_recharge_slowdown = max(0, changeling.chem_recharge_slowdown - 0.25)
		user.override_voice = ""
		to_chat(user, span_notice("Our vocal glands return to their original position."))
	. = ..()
