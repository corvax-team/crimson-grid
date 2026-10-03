#define OPERATION_NEW_COLOR "chosen_color"

/datum/surgery_operation/organ/eye_color_surgery
	name = "Кератопигментация"
	desc = "Изменение цвета глаз пациента."
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_MORBID
	time = 20 SECONDS
	target_type = /obj/item/organ/eyes
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED
	required_organ_flag = NONE

/datum/surgery_operation/organ/eye_color_surgery/all_required_strings()
	return list("операция на глазах (цель: глаза)") + ..()

/datum/surgery_operation/organ/eye_color_surgery/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/organ/eye_color_surgery/state_check(atom/movable/operating_on)
	return TRUE

/datum/surgery_operation/organ/eye_color_surgery/pre_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	operation_args[OPERATION_NEW_COLOR] = list()
	operation_args[OPERATION_NEW_COLOR] += tgui_color_picker(surgeon, "Левый глаз", "Кератопигментация")
	operation_args[OPERATION_NEW_COLOR] += tgui_color_picker(surgeon, "Правый глаз", "Кератопигментация")
	return !!operation_args[OPERATION_NEW_COLOR][1] || !!operation_args[OPERATION_NEW_COLOR][2]

/datum/surgery_operation/organ/eye_color_surgery/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_notice("Вы начинаете изменять глаза [patient.declent_ru(GENITIVE)]..."),
		span_notice("[surgeon] начинает изменять глаза [patient.declent_ru(GENITIVE)]."),
		span_notice("[surgeon] начинает делать надрез у глаз [patient.declent_ru(GENITIVE)]."),
	)
	display_pain(patient, "Лицо пронзает режущая боль!")

/datum/surgery_operation/organ/eye_color_surgery/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/eye_color_left = operation_args[OPERATION_NEW_COLOR][1]
	var/eye_color_right = operation_args[OPERATION_NEW_COLOR][2]
	patient.set_eye_color(sanitize_hexcolor(eye_color_left), sanitize_hexcolor(eye_color_right))
	patient.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
	patient.update_body()

	display_results(
		surgeon,
		patient,
		span_notice("Вы полностью изменяете глаза [patient.declent_ru(GENITIVE)]."),
		span_notice("[surgeon] полностью изменяет глаза [patient.declent_ru(GENITIVE)]."),
		span_notice("[surgeon] заканчивает операцию на глазах [patient.declent_ru(GENITIVE)]."),
	)
	display_pain(patient, "Боль отступает. Глаза кажутся новыми и чужими!")

/datum/surgery_operation/organ/eye_color_surgery/on_failure(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_warning("Вы ошибаетесь и повреждаете глаза [patient.declent_ru(GENITIVE)]!"),
		span_warning("[surgeon] ошибается и повреждает глаза [patient.declent_ru(GENITIVE)]!"),
		span_notice("[surgeon] заканчивает операцию на глазах [patient.declent_ru(GENITIVE)]."),
	)
	display_pain(patient, "Глаза будто рвут на части!")
	ADD_TRAIT(patient, TRAIT_DISFIGURED, TRAIT_GENERIC)
	var/obj/item/organ/eyes/eyes = patient.get_organ_slot(ORGAN_SLOT_EYES)
	eyes.apply_organ_damage(1)

#undef OPERATION_NEW_COLOR

