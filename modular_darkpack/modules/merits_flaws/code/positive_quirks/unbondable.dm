/datum/quirk/darkpack/unbondable
	name = "Unbondable"
	ru_name = "Невосприимчивость к узам крови"
	desc = "Вас невозможно связать узами крови. Тремеры не могут взять это достоинство."
	ttrpg_sources = list(/datum/source_book/vtm20 = 494)
	value = 5
	mob_trait = TRAIT_UNBONDABLE
	icon = FA_ICON_CHAIN_BROKEN
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_TREMERE)


/datum/quirk/darkpack/unbondable/ghoul
	name = "Unbondable (Ghoul)"
	ru_name = "Невосприимчивость к узам крови (гуль)"
	desc = "Вас невозможно связать узами крови."
	value = 6
	allowed_splats = list(SPLAT_GHOUL)
