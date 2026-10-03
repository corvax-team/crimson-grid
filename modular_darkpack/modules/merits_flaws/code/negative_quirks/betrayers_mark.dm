/datum/quirk/darkpack/betrayers_mark
	name = "Betrayer's Mark"
	ru_name = "Клеймо предателя"
	desc = "На вашем лбу выжжена мистическая буква \"Т\" - знак того, что вы, тремер, прошли обряд Братания. Метку видят только другие тремеры, и для них вы антитрибу. Возможно, вы вернулись в клан, а может, получили метку, хотя никогда не участвовали в Братании и всегда хранили верность. Так или иначе, из-за неё собратья по клану относятся к вам с большой опаской."
	value = -3
	mob_trait = TRAIT_BETRAYERS_MARK
	gain_text = span_notice("На вашем лбу выжжена мистическая \"Т\". Клеймо предателя")
	lose_text = span_notice("Буква \"Т\" на вашем лбу, кажется, бледнеет... о нет... ТОЛЬКО НЕ СНОВА!!!") // look up what happened to the antitribu tremeres in 1998
	icon = FA_ICON_T
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)
	failure_message = "Буква \"Т\" на вашем лбу, кажется, бледнеет... о нет... ТОЛЬКО НЕ СНОВА!!!"
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
