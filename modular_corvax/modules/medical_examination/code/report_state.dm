#define EXAM_AGGRAVATED_COLOR "#b266ff"

/// General condition, damage table, vitals, organs, diseases and rare findings
/datum/medical_examination/proc/show_state_report(mob/living/carbon/doctor, mob/living/carbon/patient, level)
	var/list/render_list = list(report_header(patient, "Состояние"))
	render_list += "<span class='info ml-1'>Общее состояние: [IS_DEAD_OR_FAKING(patient) ? span_alert("<b>Мёртв</b>") : "<b>[round(patient.health / patient.maxHealth, 0.01) * 100]% здоровья</b>"]</span><br>"
	render_list += report_body_basics(doctor, patient, level)
	if(level >= MEDICAL_EXAM_TIER_DAMAGE)
		render_list += report_damage(doctor, patient, level)
	if(level >= MEDICAL_EXAM_AUTO_SUCCESS_LEVEL)
		render_list += report_vitals(patient)
	if(level >= MEDICAL_EXAM_TIER_INTERNAL)
		render_list += report_internal(patient, level)
	if(level >= MEDICAL_EXAM_TIER_EXPERT)
		render_list += report_expert(doctor, patient)
	send_report(doctor, render_list)

/// Missing limbs, prosthetics, implants, a still heart, husking and exhaustion
/datum/medical_examination/proc/report_body_basics(mob/living/carbon/doctor, mob/living/carbon/patient, level)
	var/list/lines = list()
	var/list/missing_names = list()
	for(var/zone in patient.get_missing_limbs())
		missing_names += parse_zone(zone)
	if(length(missing_names))
		lines += "<span class='alert ml-1'>Отсутствуют: [jointext(missing_names, ", ")].</span><br>"

	var/list/prosthetics = list()
	for(var/obj/item/bodypart/limb as anything in patient.bodyparts)
		if(IS_ROBOTIC_LIMB(limb))
			prosthetics += limb.declent_ru(NOMINATIVE)
	for(var/obj/item/organ/organ as anything in patient.organs)
		if(IS_ROBOTIC_ORGAN(organ) && !(organ.organ_flags & ORGAN_HIDDEN))
			prosthetics += organ.examine_title(doctor)
	if(length(prosthetics))
		lines += "<span class='notice ml-1'>Протезы и импланты: [jointext(prosthetics, ", ")].</span><br>"

	if(level < MEDICAL_EXAM_TIER_DAMAGE)
		return lines
	if(get_kindred_splat(patient) && !patient.heart_is_beating())
		lines += "<span class='alert ml-1'>Пульс не прощупывается.</span><br>"
	if(HAS_TRAIT(patient, TRAIT_HUSK))
		lines += "<span class='alert ml-1'>Субъект был превращён в хаска.</span><br>"
	if(patient.get_stamina_loss())
		lines += "<span class='alert ml-1'>Субъект страдает от переутомления.</span><br>"
	return lines

/// Damage table by body part
/datum/medical_examination/proc/report_damage(mob/living/carbon/doctor, mob/living/carbon/patient, level)
	var/show_systemic = level >= MEDICAL_EXAM_TIER_SYSTEMIC
	// Obeah lets a healer measure aggravated harm precisely
	var/aggravated_as_number = !isnull(doctor.get_discipline(/datum/discipline/obeah))
	var/brute_loss = patient.get_brute_loss()
	var/fire_loss = patient.get_fire_loss()
	var/tox_loss = patient.get_tox_loss()
	var/oxy_loss = patient.get_oxy_loss()
	var/total_loss = brute_loss + fire_loss + tox_loss + oxy_loss
	if(HAS_TRAIT(patient, TRAIT_FAKEDEATH) && patient.stat != DEAD && total_loss < 200)
		oxy_loss = clamp(oxy_loss + 200 - total_loss, 0, 200)

	var/list/rows = list()
	for(var/zone in patient.get_all_limbs())
		var/obj/item/bodypart/limb = patient.get_bodypart(zone)
		if(isnull(limb))
			continue
		var/has_aggravated = show_systemic && limb.aggravated_dam > 0
		if(!limb.brute_dam && !limb.burn_dam && !has_aggravated)
			continue
		var/row = "<tr><td><font color='#cc3333'>[capitalize(limb.plaintext_zone)]:</font></td>\
			<td><font color='#cc3333'>[ceil(limb.brute_dam)]</font></td>\
			<td><font color='#ff9933'>[ceil(limb.burn_dam)]</font></td>"
		if(show_systemic)
			row += "<td></td><td></td><td><font color='[EXAM_AGGRAVATED_COLOR]'>[aggravated_as_number ? ceil(limb.aggravated_dam) : aggravated_severity(limb)]</font></td>"
		rows += "[row]</tr>"

	var/any_damage = brute_loss > 0 || fire_loss > 0 || (show_systemic && (tox_loss > 0 || oxy_loss > 0))
	if(!any_damage && !length(rows))
		return list()

	var/report = "<hr><span class='info ml-1'>Состояние тела:</span><font face='Verdana'><table class='ml-2'>\
		<tr><td style='width:7em;'><font color='#ff0000'><b>Урон:</b></font></td>\
		<td style='width:5em;'><font color='#ff3333'><b>Ушибы</b></font></td>\
		<td style='width:4em;'><font color='#ff9933'><b>Ожоги</b></font></td>"
	if(show_systemic)
		report += "<td style='width:4em;'><font color='#00cc66'><b>Токсины</b></font></td>\
			<td style='width:5em;'><font color='#33ccff'><b>Удушье</b></font></td>\
			<td style='width:8em;'><font color='[EXAM_AGGRAVATED_COLOR]'><b>Гноящиеся</b></font></td>"
	report += "</tr><tr><td><font color='#ff3333'><b>Общий:</b></font></td>\
		<td><font color='#ff3333'><b>[ceil(brute_loss)]</b></font></td>\
		<td><font color='#ff9933'><b>[ceil(fire_loss)]</b></font></td>"
	if(show_systemic)
		report += "<td><font color='#00cc66'><b>[ceil(tox_loss)]</b></font></td>\
			<td><font color='#33ccff'><b>[ceil(oxy_loss)]</b></font></td>\
			<td><font color='[EXAM_AGGRAVATED_COLOR]'><b>[aggravated_as_number ? ceil(patient.get_agg_loss()) : ""]</b></font></td>"
	report += "</tr>[jointext(rows, "")]</table></font>"
	return list(report)

/// Words for the aggravated damage of a limb, for doctors who cannot measure it
/datum/medical_examination/proc/aggravated_severity(obj/item/bodypart/limb)
	if(limb.aggravated_dam <= 0)
		return ""
	var/ratio = limb.aggravated_dam / limb.max_damage
	if(ratio < 1 / 3)
		return "лёгкие"
	if(ratio < 2 / 3)
		return "серьёзные"
	return "тяжёлые"

/// Blood level, temperature and major disabilities
/datum/medical_examination/proc/report_vitals(mob/living/carbon/patient)
	var/list/lines = list("<hr>")
	var/datum/blood_type/blood_type = patient.get_bloodtype()
	if(blood_type)
		var/blood_volume = patient.get_blood_volume(apply_modifiers = TRUE)
		if(blood_volume <= BLOOD_VOLUME_OKAY)
			lines += "<span class='alert ml-1'>Уровень крови: <b>КРИТИЧЕСКИЙ</b></span><br>"
		else if(blood_volume <= BLOOD_VOLUME_SAFE)
			lines += "<span class='alert ml-1'>Уровень крови: НИЗКИЙ</span><br>"
		else
			lines += "<span class='info ml-1'>Уровень крови: в норме</span><br>"

	// A Kindred whose heart still beats passes for a living body
	var/fake_living = get_kindred_splat(patient) && patient.heart_is_beating()
	if(ishuman(patient))
		var/mob/living/carbon/human/human_patient = patient
		lines += temperature_line("Внутренняя температура тела", fake_living ? BODYTEMP_NORMAL : human_patient.coretemperature, patient)
	lines += temperature_line("Температура тела", fake_living ? BODYTEMP_NORMAL : patient.bodytemperature, patient)

	// Same condition and split the health analyzer uses
	if(LAZYLEN(patient.quirks))
		lines += "<span class='info ml-1'>Значительные отклонения: [patient.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY, from_scan = TRUE)].</span><br>"
	return lines

/datum/medical_examination/proc/temperature_line(label, temperature, mob/living/carbon/patient)
	var/text = "[label]: [round(temperature - T0C, 0.1)] &deg;C ([round(temperature * 1.8 - 459.67, 0.1)] &deg;F)"
	if(temperature >= patient.get_body_temp_heat_damage_limit())
		return "<span class='alert ml-1'>☼ [text] ☼</span><br>"
	if(temperature <= patient.get_body_temp_cold_damage_limit())
		return "<span class='alert ml-1'>❄ [text] ❄</span><br>"
	return "<span class='info ml-1'>[text]</span><br>"

/// Organs, diseases, time of death and minor disabilities
/datum/medical_examination/proc/report_internal(mob/living/carbon/patient, level)
	var/list/lines = list()
	var/scanpower = level >= MEDICAL_EXAM_TIER_EXPERT ? SCANPOWER_ADVANCED : SCANPOWER_BASIC
	if(ishuman(patient))
		var/mob/living/carbon/human/human_patient = patient
		var/list/organ_rows = list()
		var/list/missing_organs = human_patient.get_missing_organs()
		for(var/organ_slot in GLOB.organ_process_order)
			var/obj/item/organ/organ = human_patient.get_organ_slot(organ_slot)
			if(isnull(organ))
				if(missing_organs[organ_slot])
					organ_rows += "<tr><td><font color='#cc3333'>[missing_organs[organ_slot]]:</font></td><td><font color='#cc3333'>Отсутствует</font></td></tr>"
				continue
			var/status = organ.get_status_text(scanpower, TRUE)
			var/appendix = organ.get_status_appendix(scanpower, TRUE)
			if(!status && !appendix)
				continue
			organ_rows += "<tr><td><font color='#cc3333'>[capitalize(organ.declent_ru(NOMINATIVE))]:</font></td><td>[status || "<font color='#ffcc33'>OK</font>"]</td></tr>"
			if(appendix)
				organ_rows += "<tr><td colspan=2><span class='alert ml-2'>&rdsh; [appendix]</span></td></tr>"
		if(length(organ_rows))
			lines += "<hr><span class='info ml-1'>Состояние органов:</span><font face='Verdana'><table class='ml-2'>\
				<tr><td style='width:8em;'><font color='#ff0000'><b>Орган:</b></font></td><td style='width:30em;'><font color='#ff0000'><b>Состояние</b></font></td></tr>\
				[jointext(organ_rows, "")]</table></font>"

	var/list/other_lines = list()
	for(var/datum/disease/disease as anything in patient.diseases)
		if(disease.visibility_flags & HIDDEN_SCANNER)
			continue
		var/cure_text = disease.cure_text
		if(istype(disease, /datum/disease/advance))
			var/datum/disease/advance/advanced_disease = disease
			cure_text = advanced_disease.generate_cure_text(2)
		other_lines += "<span class='alert ml-1'><b>Обнаружено заболевание: [disease.form]</b><br><div class='ml-2'>\
			Название: [disease.name].<br>Распространение: [disease.spread_text].<br>\
			Стадия: [disease.stage] из [disease.max_stages].<br>Лечение: [cure_text]</div></span>"

	if(patient.station_timestamp_timeofdeath && IS_DEAD_OR_FAKING(patient))
		other_lines += "<span class='alert ml-1'><b>Умер [DisplayTimeText(round(world.time - patient.timeofdeath))] назад.</b></span><br>"

	if(LAZYLEN(patient.quirks))
		other_lines += "<span class='info ml-1'>Незначительные отклонения: [patient.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY, from_scan = TRUE)].</span><br>"
	if(length(other_lines))
		lines += "<hr>"
		lines += other_lines
	return lines

/// The cause of husking, hallucinations and a Garou's unnatural healing
/datum/medical_examination/proc/report_expert(mob/living/carbon/doctor, mob/living/carbon/patient)
	var/list/lines = list()
	if(HAS_TRAIT(patient, TRAIT_HUSK))
		if(HAS_TRAIT_FROM(patient, TRAIT_HUSK, SKELETON_TRAIT))
			lines += "<span class='alert ml-1'>Тело иссохло из-за потери мягких тканей.</span><br>"
		else if(HAS_TRAIT_FROM(patient, TRAIT_HUSK, BURN) && length(GET_TRAIT_SOURCES(patient, TRAIT_HUSK)) == 1)
			lines += "<span class='alert ml-1'>Тело иссохло от сильных ожогов.</span><br>"
		else
			lines += "<span class='alert ml-1'>Тело иссохло по неясной причине.</span><br>"

	// Lets status effects add what only advanced scanners see, hallucinations among them
	SEND_SIGNAL(patient, COMSIG_LIVING_HEALTHSCAN, lines, SCANPOWER_ADVANCED, doctor, SCANNER_VERBOSE, TRUE)

	if(get_garou_splat(patient) && (patient.get_brute_loss() || patient.get_fire_loss() || patient.get_agg_loss()))
		lines += "<span class='notice ml-1'>Раны затягиваются неестественно быстро.</span><br>"
	return lines

#undef EXAM_AGGRAVATED_COLOR
