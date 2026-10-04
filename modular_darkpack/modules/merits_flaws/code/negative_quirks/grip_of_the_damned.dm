/datum/quirk/darkpack/grip_of_the_damned
	name = "Grip of the Damned"
	ru_name = "Хватка проклятого"
	desc = "В вашем укусе нет экстаза - только ужас и боль. Смертные, из которых вы пьёте, вырываются и кричат всё время, пока вы кормитесь."
	ttrpg_sources = list(/datum/source_book/vtm20 = 495)
	icon = FA_ICON_DRUMSTICK_BITE
	value = -4
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_GIOVANNI)
	mob_trait = TRAIT_PAINFUL_VAMPIRE_KISS
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
