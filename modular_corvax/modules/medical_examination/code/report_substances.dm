/// Intoxication, substances, addictions and allergies
/datum/medical_examination/proc/show_substances_report(mob/living/carbon/doctor, mob/living/carbon/patient, level)
	var/list/render_list = list(report_header(patient, "Вещества"))
	if(level < MEDICAL_EXAM_TIER_INTERNAL)
		render_list += "<span class='notice ml-1'>Определить, что [genderize_decode(patient, "у %(него,неё,него,них)%")] в крови, не получается.</span><br>"
		send_report(doctor, render_list)
		return

	var/list/findings = list()
	var/blood_alcohol = patient.get_blood_alcohol_content()
	if(blood_alcohol > 0)
		if(blood_alcohol >= 0.24)
			findings += "<span class='alert ml-1'>Содержание алкоголя в крови: <b>КРИТИЧЕСКИЙ [blood_alcohol]%</b></span><br>"
		else
			findings += "<span class='info ml-1'>Содержание алкоголя в крови: [blood_alcohol]%</span><br>"

	var/exact = level >= MEDICAL_EXAM_TIER_EXPERT
	var/blood_text = substances_text(patient.reagents?.reagent_list, null, exact)
	if(blood_text)
		findings += "<span class='notice ml-1'>В крови: [blood_text]</span><br>"
	var/obj/item/organ/stomach/belly = patient.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(belly)
		var/stomach_text = substances_text(belly.reagents?.reagent_list, belly.food_reagents, exact)
		if(stomach_text)
			findings += "<span class='notice ml-1'>В желудке: [stomach_text]</span><br>"

	if(LAZYLEN(patient.mind?.active_addictions))
		var/list/addiction_names = list()
		for(var/datum/addiction/addiction_type as anything in patient.mind.active_addictions)
			addiction_names += initial(addiction_type.name)
		findings += "<span class='alert ml-1'>Зависимости: [jointext(addiction_names, ", ")].</span><br>"

	if(exact)
		for(var/datum/quirk/item_quirk/allergic/allergies in patient.quirks)
			findings += "<span class='alert ml-1'>Сильная аллергия на: [allergies.allergy_string].</span><br>"

	if(length(findings))
		render_list += findings
	else
		render_list += "<span class='notice ml-1'>Посторонних веществ не обнаружено.</span><br>"
	send_report(doctor, render_list)

/**
 * Text listing the given reagents, or null if none of them are noticeable
 *
 * * own_reagents - amounts that belong to the organ itself and are not counted
 * * exact - TRUE to name each substance with its amount, FALSE to name only its kind
 */
/datum/medical_examination/proc/substances_text(list/reagent_list, list/own_reagents, exact)
	var/list/entries = list()
	for(var/datum/reagent/reagent as anything in reagent_list)
		if(reagent.chemical_flags & REAGENT_INVISIBLE)
			continue
		var/volume = reagent.volume - LAZYACCESS(own_reagents, reagent.type)
		if(volume <= 0)
			continue
		var/entry
		if(exact)
			entry = "[round(volume, 0.001)] ед. [reagent.declent_ru(GENITIVE)]"
		else
			entry = reagent.get_medical_kind()
			if(!entry)
				continue
		if(reagent.overdosed)
			entry += " ([span_bolddanger("передозировка")])"
		entries |= entry
	if(!length(entries))
		return null
	return "[jointext(entries, ", ")]."
