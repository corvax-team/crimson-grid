/datum/quirk/darkpack/iron_will
	name = "Iron Will"
	ru_name = "Железная воля"
	desc = "Если вы на что-то решились, ничто не собьёт вас с пути. Сложность применения против вас Помешательства, Доминирования и любых других Дисциплин, воздействующих на разум, повышается на 3. К Величию это не относится." // TODO: no check exists for characters under 8 wp
	ttrpg_sources = list(/datum/source_book/vtm20 = 485)
	value = 3
	mob_trait = TRAIT_IRON_WILL
	gain_text = span_notice("Ваша воля крепка как железо.")
	lose_text = span_notice("Ваша воля уже не так крепка.")
	icon = FA_ICON_USER_SHIELD
	failure_message = "Ваша воля уже не так крепка."
	allowed_splats = list(SPLAT_KINDRED)

/datum/quirk/darkpack/iron_will/human
	name = "Iron Will (Non-Vampire)"
	ru_name = "Железная воля (не вампир)"
	ttrpg_sources = list(/datum/source_book/huntershunted1 = 60) // Hunters Hunted 1st edition
	value = 4
	allowed_splats = null
	forbidden_splats = list(SPLAT_KINDRED)
