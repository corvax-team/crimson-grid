/// Wounds and embedded objects by body part
/datum/medical_examination/proc/show_wounds_report(mob/living/carbon/doctor, mob/living/carbon/patient, level)
	var/list/render_list = list(report_header(patient, "Раны"))
	var/show_details = level >= MEDICAL_EXAM_AUTO_SUCCESS_LEVEL
	var/list/limb_lines = list()
	var/unexplained_wounds = FALSE
	for(var/zone in patient.get_all_limbs())
		var/obj/item/bodypart/limb = patient.get_bodypart(zone)
		if(isnull(limb))
			continue
		if(level < MEDICAL_EXAM_TIER_DAMAGE)
			unexplained_wounds ||= length(limb.wounds)
			continue
		var/list/entries = list()
		for(var/datum/wound/wound as anything in limb.wounds)
			var/entry = "&rdsh; Физическая травма: [wound.name] ([wound.severity_text()])"
			if(show_details)
				entry += "<div class='ml-2'>Описание: [wound.desc]<br>Рекомендуемое лечение: [wound.treat_text]</div>"
			entries += entry
		if(show_details && LAZYLEN(limb.embedded_objects))
			var/list/embedded_names = list()
			for(var/obj/item/embed as anything in limb.embedded_objects)
				embedded_names[capitalize(embed.declent_ru(NOMINATIVE))] += 1
			for(var/embedded_name in embedded_names)
				var/amount = embedded_names[embedded_name]
				entries += "&rdsh; Инородные объекты: [amount > 1 ? "[amount]x " : ""][embedded_name]"
		if(length(entries))
			limb_lines += "<span class='alert ml-1'><b>[capitalize(limb.plaintext_zone)]:</b></span><div class='alert ml-2'>[jointext(entries, "<br>")]</div>"

	if(length(limb_lines))
		render_list += limb_lines
	else if(unexplained_wounds)
		render_list += "<span class='notice ml-1'>Раны есть, но разобраться в них не получается.</span><br>"
	else
		render_list += "<span class='notice ml-1'>Ран не обнаружено.</span><br>"
	if(show_details)
		study_wounds(patient)
	send_report(doctor, render_list)

/// Marks every wound as studied, which makes treating it easier
/datum/medical_examination/proc/study_wounds(mob/living/carbon/patient)
	for(var/datum/wound/wound as anything in patient.all_wounds)
		ADD_TRAIT(wound, TRAIT_WOUND_SCANNED, MEDICAL_EXAMINATION_TRAIT)
