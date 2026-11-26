/// How long a failed examination of a patient is remembered by the doctor
#define MEDICAL_EXAM_FAILURE_MEMORY (1 MINUTES)
/// Examination time at zero Medicine
#define MEDICAL_EXAM_BASE_DURATION (3 SECONDS)
/// Examination time removed per Medicine dot
#define MEDICAL_EXAM_DURATION_PER_DOT (0.5 SECONDS)
/// Shortest possible examination time
#define MEDICAL_EXAM_MIN_DURATION (0.5 SECONDS)

GLOBAL_DATUM_INIT(medical_examination, /datum/medical_examination, new)

/// Handles the examine link that lets anyone check a patient's body using their Medicine
/datum/medical_examination
	/// Failed examinations: "doctor ref-patient ref" to world.time of the failure
	var/list/failures = list()
	/// Shared roll for doctors below the auto success level
	var/datum/storyteller_roll/medical_examination/roll = new

/datum/storyteller_roll/medical_examination
	bumper_text = "медицинский осмотр"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_MEDICINE)
	roll_output_type = ROLL_FLAG_ROLLER

/datum/medical_examination/Topic(href, list/href_list)
	. = ..()
	var/mob/living/carbon/doctor = usr
	var/mob/living/carbon/patient = locate(href_list["patient"])
	var/part = href_list["part"]
	if(!istype(doctor) || !istype(patient))
		return
	if(!(part in list(MEDICAL_EXAM_PART_STATE, MEDICAL_EXAM_PART_WOUNDS, MEDICAL_EXAM_PART_SUBSTANCES)))
		return
	examine(doctor, patient, part)

/// Examine links shown to a living examiner, one per examination part
/mob/living/carbon/proc/medical_examination_link()
	var/base = "byond://?src=[REF(GLOB.medical_examination)];patient=[REF(src)];part="
	return "Медицинский осмотр: <a href='[base][MEDICAL_EXAM_PART_STATE]'>состояние</a>, \
		<a href='[base][MEDICAL_EXAM_PART_WOUNDS]'>раны</a>, \
		<a href='[base][MEDICAL_EXAM_PART_SUBSTANCES]'>вещества</a>"

/**
 * Runs one part of the examination of `patient` by `doctor`
 *
 * * part - one of the MEDICAL_EXAM_PART_* defines
 */
/datum/medical_examination/proc/examine(mob/living/carbon/doctor, mob/living/carbon/patient, part)
	if(!doctor.Adjacent(patient))
		doctor.balloon_alert(doctor, "вы слишком далеко")
		return
	if(!can_examine(doctor, patient))
		return
	forget_old_failures()
	var/failure_key = "[REF(doctor)]-[REF(patient)]-[part]"
	if(failures[failure_key])
		show_vague_impression(doctor, patient)
		return

	var/medicine = doctor.st_get_stat(STAT_MEDICINE)
	if(doctor == patient)
		doctor.visible_message(
			span_notice("[capitalize(doctor.declent_ru(NOMINATIVE))] осматривает себя."),
			span_notice("Вы осматриваете себя."),
		)
	else
		doctor.visible_message(
			span_notice("[capitalize(doctor.declent_ru(NOMINATIVE))] осматривает [patient.declent_ru(ACCUSATIVE)]."),
			span_notice("Вы осматриваете [patient.declent_ru(ACCUSATIVE)]."),
			ignored_mobs = patient,
		)
		to_chat(patient, span_notice("[capitalize(doctor.declent_ru(NOMINATIVE))] осматривает вас."))
	var/duration = max(MEDICAL_EXAM_MIN_DURATION, MEDICAL_EXAM_BASE_DURATION - medicine * MEDICAL_EXAM_DURATION_PER_DOT)
	if(!do_after(doctor, duration, patient, interaction_key = REF(src)))
		return
	if(QDELETED(patient) || !can_examine(doctor, patient))
		return

	if(medicine < MEDICAL_EXAM_AUTO_SUCCESS_LEVEL)
		var/result = roll.st_roll(doctor, patient)
		if(result == ROLL_BOTCH)
			patient.apply_damage(1, BRUTE)
		if(result != ROLL_SUCCESS)
			failures[failure_key] = world.time
			show_vague_impression(doctor, patient)
			return

	var/level = clamp(medicine, 0, MEDICAL_EXAM_MAX_LEVEL)
	switch(part)
		if(MEDICAL_EXAM_PART_STATE)
			show_state_report(doctor, patient, level)
		if(MEDICAL_EXAM_PART_WOUNDS)
			show_wounds_report(doctor, patient, level)
		if(MEDICAL_EXAM_PART_SUBSTANCES)
			show_substances_report(doctor, patient, level)

/datum/medical_examination/proc/can_examine(mob/living/carbon/doctor, mob/living/carbon/patient)
	if(doctor.incapacitated || !doctor.Adjacent(patient))
		return FALSE
	return TRUE

/datum/medical_examination/proc/forget_old_failures()
	for(var/failure_key in failures)
		if(world.time >= failures[failure_key] + MEDICAL_EXAM_FAILURE_MEMORY)
			failures -= failure_key

/// What a doctor who failed to examine the patient still notices
/datum/medical_examination/proc/show_vague_impression(mob/living/carbon/doctor, mob/living/carbon/patient)
	var/looks_hurt = patient.health < patient.maxHealth || length(patient.all_wounds) || length(patient.get_missing_limbs())
	var/message
	if(doctor == patient)
		message = looks_hurt \
			? "Я явно нездоров%(,а,о,ы)% на вид, но для конкретики мне нужно подумать и дополнительно осмотреть себя." \
			: "Я здоров%(,а,о,ы)% на вид, но для конкретики мне надо подумать и дополнительно осмотреть себя."
	else
		message = looks_hurt \
			? "%(Он,Она,Оно,Они)% явно нездоров%(,а,о,ы)% на вид, но для конкретики мне нужно подумать и дополнительно осмотреть %(его,её,его,их)%." \
			: "%(Он,Она,Оно,Они)% здоров%(,а,о,ы)% на вид, но для конкретики мне надо подумать и дополнительно осмотреть %(его,её,его,их)%."
	to_chat(doctor, span_notice(genderize_decode(patient, message)))

/// Sends one examination report to the doctor as a single chat box
/datum/medical_examination/proc/send_report(mob/living/carbon/doctor, list/render_list)
	to_chat(doctor, custom_boxed_message("blue_box", jointext(render_list, "")), type = MESSAGE_TYPE_INFO, trailing_newline = FALSE)

/datum/medical_examination/proc/report_header(mob/living/carbon/patient, title)
	return "[span_info("[title] <b>[patient.declent_ru(GENITIVE)]</b>:")]<br>"

#undef MEDICAL_EXAM_FAILURE_MEMORY
#undef MEDICAL_EXAM_BASE_DURATION
#undef MEDICAL_EXAM_DURATION_PER_DOT
#undef MEDICAL_EXAM_MIN_DURATION
