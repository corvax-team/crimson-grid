/datum/quirk/darkpack/permanent_third_eye
	name = "Permanent Third Eye"
	ru_name = "Незакрывающийся третий глаз"
	desc = "Обычно третий глаз можно закрыть, и тогда он выглядит как шрам на лбу, но ваш почти всегда широко открыт. Для салюбри это опасно: вас увидят Сородичи, которые верят рассказам тремеров о том, что ваш клан кишит диаблеристами-инферналистами. У тремера этот недостаток проявляется как чудом доставшееся наследие диаблери Саулота: в лучшем случае клан перестанет вам доверять, в худшем вас сразу убьют. Незакрывающийся третий глаз можно прикрыть головным убором. Недостаток доступен только тремерам и салюбри."
	value = -2
	mob_trait = TRAIT_THIRD_EYE
	gain_text = span_notice("Саулот проклинает вас за преступление вашего праотца. Ваш третий глаз открывается, чтобы никогда больше не закрыться.")
	lose_text = span_notice("Ваш третий глаз снова закрывается.")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)
	icon = FA_ICON_EYE
	failure_message = "Ваша кровь противится желанию открыть третий глаз."
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/permanent_third_eye/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(iscarbon(new_holder))
		var/mob/living/carbon/carbon_holder = new_holder
		var/obj/item/organ/eyes/salubri/three_eyes = new()
		three_eyes.Insert(carbon_holder, TRUE, DELETE_IF_REPLACED)

/datum/quirk/darkpack/permanent_third_eye/remove_from_current_holder(quirk_transfer)
	. = ..()
	// replace eyes
	var/eye_type = /obj/item/organ/eyes
	var/obj/item/organ/eyes/new_eyes = new eye_type()
	new_eyes.Insert(quirk_holder, TRUE, DELETE_IF_REPLACED)


