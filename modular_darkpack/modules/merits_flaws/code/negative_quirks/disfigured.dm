// VTM pg. 481
/datum/quirk/darkpack/disfigured
	name = "Disfigured"
	ru_name = "Уродство"
	desc = "Уродство делает вашу внешность отталкивающей и запоминающейся. Сложность всех проверок, связанных с социальным взаимодействием, повышается на два. Привлекательность не может быть выше 2."
	icon = FA_ICON_FACE_GRIMACE
	value = -2
	gain_text = span_notice("Ваше лицо обезображено!")
	lose_text = span_notice("Кажется, вы стали выглядеть намного лучше.")
	failure_message = span_notice("Вы выглядите не так уж плохо.")
	mob_trait = TRAIT_DISFIGURED_APPEARANCE
	excluded_clans = list(VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_HARBINGER)// Anyone who already gets masq violating faces or other issues like that.
	var/appearance_to_subtract

/datum/quirk/darkpack/disfigured/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	if(human_holder.st_get_stat(STAT_APPEARANCE) > 2)
		to_chat(human_holder, span_warning("Привлекательность снижена: с этим недостатком она не может быть выше двух."))
	human_holder.st_add_stat_clamp(STAT_APPEARANCE, 2, type)

/datum/quirk/darkpack/disfigured/remove()
	. = ..()
	quirk_holder.st_remove_stat_clamp(STAT_APPEARANCE, type)
