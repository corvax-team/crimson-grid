/datum/quirk/darkpack/monstrous
	name = "Monstrous"
	ru_name = "Чудовищная внешность"
	desc = "Ваше тело изуродовано и открыто выдаёт вашу звериную суть: любому, кто на вас взглянет, ясно, что природа тут ни при чём. Вы едва узнаёте себя в зеркале, ведь похожи скорее на дикое чудовище, чем на человека. Привлекательность всегда равна нулю, а внешность нарушает Маскарад, так что на людях придётся носить маску. Носферату и другие линии крови, чья Привлекательность изначально равна нулю, не могут взять этот недостаток."
	value = -3
	mob_trait = TRAIT_MONSTROUS
	gain_text = span_notice("Ваше тело искажается, обретая чудовищный облик...")
	lose_text = span_notice("Ваши черты смягчаются, словно с плеч упал тяжкий груз: вы снова можете открыть лицо.")
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GAROU)
	excluded_clans = list(VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_HARBINGER)
	icon = FA_ICON_FACE_ANGRY
	failure_message = "Ваши черты смягчаются, словно с плеч упал тяжкий груз: вы снова можете открыть лицо."
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/monstrous/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.rot_body(1)
	ADD_TRAIT(human_holder, TRAIT_MASQUERADE_VIOLATING_FACE, type)
	human_holder.st_add_stat_clamp(STAT_APPEARANCE, 0, type)

/datum/quirk/darkpack/monstrous/remove()
	. = ..()
	quirk_holder.st_remove_stat_clamp(STAT_APPEARANCE, type)
