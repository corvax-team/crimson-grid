/datum/quirk/darkpack/the_largest_maw
	name = "The Largest Maw"
	ru_name = "Огромная пасть"
	desc = "Ваши зубы растут рядами, как у акулы, и они так велики, что вам трудно говорить. Слова тонут в слюне, а порой вы прикусываете собственные зубы. Вы тише прочих нагараджа и можете говорить только шёпотом."
	icon = FA_ICON_COMMENT
	value = -2
	mob_trait = TRAIT_FORCE_WHISPER
	gain_text = span_danger("Ваши зубы неприятно сдвигаются и занимают во рту ещё больше места. Говорить теперь трудно.")
	lose_text = span_notice("Ваши зубы словно втягиваются, и голос звучит громче прежнего.")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_NAGARAJA)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
