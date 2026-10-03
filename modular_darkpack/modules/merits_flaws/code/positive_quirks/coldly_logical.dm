/datum/quirk/darkpack/coldly_logical
	name = "Coldly Logical"
	ru_name = "Холодная логика"
	desc = "Вас могут называть сухарём, зато вы умеете отделять факты от эмоций и истерик. Сами вы можете быть как угодно эмоциональны, но ясно видите, когда другие заслоняют факты чувствами (сложность всех Дисциплин, воздействующих на ваши эмоции, таких как Величие и Мельпомения, повышается на 1)."
	ttrpg_sources = list(/datum/source_book/vtm20 = 484)
	value = 1
	mob_trait = TRAIT_COLDLY_LOGICAL
	gain_text = span_notice("Вы твёрдо знаете: факты и чувства - совсем не одно и то же")
	lose_text = span_notice("Что такое предвзятость?")
	icon = FA_ICON_FACE_MEH
	failure_message = "Что такое предвзятость?"
