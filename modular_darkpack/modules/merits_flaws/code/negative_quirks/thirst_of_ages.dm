/datum/quirk/darkpack/thirst_of_ages
	name = "Methuselah's Thirst"
	ru_name = "Жажда мафусаила"
	desc = "Некоторые очень старые вампиры уже не могут насытиться кровью смертных. Вы способны питаться только кровью сверхъестественных существ."
	ttrpg_sources = list(/datum/source_book/gt_tmr = 177)
	value = -7
	mob_trait = TRAIT_THIRST_OF_AGES
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_NAGARAJA)	//Eating organs for vitae would bypass this downside.
	icon = FA_ICON_TEETH
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

