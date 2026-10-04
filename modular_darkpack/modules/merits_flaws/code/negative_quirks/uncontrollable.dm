//Clanbook: Brujah Revised (69)
/datum/quirk/darkpack/uncontrollable
	name = "Uncontrollable"
	ru_name = "Неуправляемый"
	desc = "В душе вспыльчивого бруха вечно борются гнев и страсть. Возможно, у вас был скверный нрав ещё до Становления, а может, кровь Бруха разбудила дремавшую злобу. Так или иначе, вы впадаете в безумие даже легче, чем ваши собратья по клану. Сложность проверок сопротивления безумию для вас всегда равна 10. Готовьтесь: будет недолго и адски жарко."
	value = -5
	mob_trait = TRAIT_UNCONTROLLABLE
	icon = FA_ICON_HEART_CRACK
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_BRUJAH)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
