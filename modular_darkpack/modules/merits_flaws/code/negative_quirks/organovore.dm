/datum/quirk/darkpack/organovore
	name = "Organovore"
	ru_name = "Людоед"
	desc = "Вы восполняете запас крови, только поедая человеческую плоть. Нагараджа не могут взять этот недостаток: они и так питаются плотью."
	value = -5
	mob_trait = TRAIT_ORGANOVORE
	gain_text = span_notice("Вас терзает неутолимая тяга к плоти.")
	lose_text = span_notice("Вы чувствуете, что снова можете питаться как обычно.")
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_NAGARAJA)
	icon = FA_ICON_TEETH
	failure_message = "Вы чувствуете, что снова можете питаться как обычно."
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
