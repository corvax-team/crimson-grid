// V20 p. 481
/datum/quirk/darkpack/smell_of_the_grave
	name = "Smell Of The Grave"
	ru_name = "Могильный запах"
	desc = "От вас пахнет сыростью и свежевскопанной землёй, и никакие духи этого не перебьют. Смертным рядом с вами не по себе, поэтому сложность всех социальных проверок против смертных повышается на один."
	value = -1
	mob_trait = TRAIT_GRAVE_SMELL
	gain_text = span_notice("От вас ужасно пахнет.")
	lose_text = span_notice("Кажется, вы стали пахнуть намного лучше.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_SPRAY_CAN
	failure_message = span_notice("Кажется, вы стали пахнуть намного лучше.")
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
