/datum/quirk/darkpack/banned_transformation
	name = "Banned Transformation"
	ru_name = "Запретное превращение"
	//For the sake of actually being able to implement, only the 3-point version from the book.
	desc = "Некое обстоятельство, событие или условие мешает вам менять форму, если только вы не возвращаетесь в родную. Чтобы сменить форму, не тратя пункт Ярости, нужно потратить пункт воли и пройти проверку Воли (сложность 8)."
	ttrpg_sources = list(/datum/source_book/wta20 = 483)
	value = -3
	mob_trait = TRAIT_BANNED_TRANSFORMATION
	icon = FA_ICON_PERSON
	allowed_splats = SPLAT_SHIFTERS
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
