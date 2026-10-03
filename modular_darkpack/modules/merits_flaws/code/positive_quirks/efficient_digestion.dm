/datum/quirk/darkpack/efficient_digestion
	name = "Efficient Digestion"
	ru_name = "Эффективное пищеварение"
	desc = "Вы извлекаете из крови больше питательной силы, чем обычно. Когда вы кормитесь, за каждые два выпитых пункта крови ваш запас крови получает ещё один."
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 3
	mob_trait = TRAIT_EFFICIENT_DIGESTION
	gain_text = span_notice("Кажется, насытиться вам теперь будет легко.")
	lose_text = span_notice("Внутри пусто, и чтобы заполнить эту пустоту, понадобится больше...")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_FILL_DRIP
	failure_message = "Внутри пусто, и чтобы заполнить эту пустоту, понадобится больше..."
