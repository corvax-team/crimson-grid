/datum/quirk/darkpack/beacon_of_the_unholy
	name = "Beacon of the Unholy"
	ru_name = "Светоч тьмы"
	desc = "От вас исходит ощутимое зло. Священнослужители и набожные смертные нутром чуют, что с вами что-то очень не так, и ведут себя соответственно."
	ttrpg_sources = list(/datum/source_book/vtm20 = 494)
	value = -2
	mob_trait = TRAIT_BEACON_OF_THE_UNHOLY
	icon = FA_ICON_LIGHTBULB
	allowed_splats = list(SPLAT_KINDRED)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
