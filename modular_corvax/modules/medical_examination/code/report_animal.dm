/// State of an animal or other simple mob, matching what the health analyzer showed for them
/datum/medical_examination/proc/show_animal_state_report(mob/living/carbon/doctor, mob/living/patient, level)
	var/list/render_list = list(report_header(patient, "Состояние"))
	render_list += "<span class='info ml-1'>Общее состояние: [IS_DEAD_OR_FAKING(patient) ? span_alert("<b>Мёртв</b>") : "<b>[round(patient.health / patient.maxHealth, 0.01) * 100]% здоровья</b>"]</span><br>"
	if(level >= MEDICAL_EXAM_TIER_DAMAGE)
		if(HAS_TRAIT(patient, TRAIT_HUSK))
			render_list += "<span class='alert ml-1'>Субъект был превращён в хаска.</span><br>"
		if(patient.get_stamina_loss())
			render_list += "<span class='alert ml-1'>Субъект страдает от переутомления.</span><br>"
		var/damage = "<span class='info ml-1'>Урон: <font color='#ff3333'>ушибы [ceil(patient.get_brute_loss())]</font>, \
			<font color='#ff9933'>ожоги [ceil(patient.get_fire_loss())]</font>"
		if(level >= MEDICAL_EXAM_TIER_SYSTEMIC)
			damage += ", <font color='#00cc66'>токсины [ceil(patient.get_tox_loss())]</font>, \
				<font color='#33ccff'>удушье [ceil(patient.get_oxy_loss())]</font>"
		render_list += "[damage]</span><br>"
	if(level >= MEDICAL_EXAM_AUTO_SUCCESS_LEVEL)
		render_list += report_blood(patient)
		render_list += temperature_line("Температура тела", patient.bodytemperature, patient)
	if(level >= MEDICAL_EXAM_TIER_INTERNAL)
		for(var/datum/disease/disease as anything in patient.diseases)
			if(disease.visibility_flags & HIDDEN_SCANNER)
				continue
			render_list += "<span class='alert ml-1'><b>Обнаружено заболевание: [disease.form]</b><br><div class='ml-2'>\
				Название: [disease.name].<br>Распространение: [disease.spread_text].<br>\
				Стадия: [disease.stage] из [disease.max_stages].<br>Лечение: [disease.cure_text]</div></span>"
		if(patient.station_timestamp_timeofdeath && IS_DEAD_OR_FAKING(patient))
			render_list += "<span class='alert ml-1'><b>Умер [DisplayTimeText(round(world.time - patient.timeofdeath))] назад.</b></span><br>"
	if(level >= MEDICAL_EXAM_TIER_EXPERT)
		// Lets status effects add what only advanced scanners see
		SEND_SIGNAL(patient, COMSIG_LIVING_HEALTHSCAN, render_list, SCANPOWER_ADVANCED, doctor, SCANNER_VERBOSE, TRUE)
	send_report(doctor, render_list)
