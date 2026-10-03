// V20 p. 482
/datum/quirk/darkpack/permafangs
	name = "Permanent Fangs"
	ru_name = "Торчащие клыки"
	desc = "Ваши клыки не втягиваются, и скрыть свою истинную природу вы не можете. Кто-то из смертных решит, что вы подпилили зубы или носите накладки, но рано или поздно вам встретится тот, кто поймёт, кто вы на самом деле."
	ttrpg_sources = list(/datum/source_book/vtm20 = 482)
	// TTRPG accurate would be -3? But this is also missing the max Appearance lock..
	value = -1
	mob_trait = TRAIT_PERMAFANGS
	gain_text = span_notice("Ваши клыки больше не втягиваются.")
	lose_text = span_notice("Вы чувствуете, что клыки снова втягиваются.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_TEETH
	failure_message = "Вы чувствуете, что клыки втягиваются."
