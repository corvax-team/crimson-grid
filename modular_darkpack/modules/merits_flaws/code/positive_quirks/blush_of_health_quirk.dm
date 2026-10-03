/datum/quirk/darkpack/blush_of_health
	name = "Blush of Health"
	ru_name = "Здоровый вид"
	desc = "Некоторым Сородичам иллюзия жизни даётся лучше, чем прочим. Без особых усилий вы кажетесь живым человеком: кожа тёплая и румяная, грудь вздымается от дыхания. Распознать в вас нежить намного труднее. Пока достоинство действует, вы выглядите живее обычного."
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 1
	mob_trait = TRAIT_BLUSH_OF_HEALTH
	gain_text = span_notice("По коже разливается лёгкое тепло: вы обретаете здоровый вид.")
	lose_text = span_notice("Тепло уходит из вашей кожи, и она снова бледна и холодна.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_HEART

