/datum/quirk/darkpack/cast_no_reflection
	name = "Cast No Reflection"
	ru_name = "Отсутствие отражения"
	desc = "Вы и правда не отражаетесь в зеркалах, совсем как вампиры из легенд. Это сильно мешает, когда нужно сойти за человека."
	ttrpg_sources = list(
		/datum/source_book/vtm20 = 494,
		/datum/source_book/mta20/bos = 82,
		)
	value = -1
	mob_trait = TRAIT_NO_MIRROR_REFLECTION
	icon = FA_ICON_PERSON_THROUGH_WINDOW
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_LASOMBRA)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
