/datum/quirk/darkpack/pierced_veil
	name = "Pierced Veil"
	ru_name = "Прорванная Вуаль"
	// A little unsure who to do the logic on the social roll rn.
	desc = "В отличие от большинства гару, ваша форма Кринос не вызывает у смертных Делириум. Из-за этого вы особенно уязвимы перед охотниками на оборотней: им проще выследить вас до каэрна, а это ставит под удар весь ваш септ."
	ttrpg_sources = list(/datum/source_book/wta20 = 484)
	value = -3
	mob_trait = TRAIT_PIERCED_VEIL
	icon = FA_ICON_MASKS_THEATER
	allowed_splats = SPLAT_SHIFTERS
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
