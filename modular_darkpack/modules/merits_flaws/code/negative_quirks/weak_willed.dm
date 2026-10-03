/datum/quirk/darkpack/weak_willed
	name = "Weak Willed"
	ru_name = "Слабоволие"
	desc = "Вы почти не способны сопротивляться, когда вас пытаются подчинить или запугать. Способности, построенные на подчинении, такие как Доминирование, срабатывают против вас автоматически. Сложность ваших проверок сопротивления заклинаниям и магии, влияющим на разум, повышается на два."
	/* Need to implement the other effects still.....
		desc = {"You have little resistance to attempts to dominate or intimidate you.
		Domination-focused Powers such as Dominate, Staredown, Roll Over, etc. automatically succeed against you.
		Your difficulties to resist Social Talents such as Intimidation or Leadership, as well as mind-altering spells or magic, are increased by two.
		Your Willpower may never rise above 4"}
	*/
	ttrpg_sources = list(
		/datum/source_book/vtm20 = 486,
		/datum/source_book/wta20 = 478,
	)
	value = -1
	mob_trait = TRAIT_WEAK_WILLED
	icon = FA_ICON_BRAIN

