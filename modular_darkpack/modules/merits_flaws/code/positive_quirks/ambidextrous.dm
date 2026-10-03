/datum/quirk/darkpack/ambidextrous
	name = "Ambidextrous"
	ru_name = "Амбидекстр"
	desc = "Вы отлично владеете обеими руками и выполняете действия \"неудобной\" рукой без штрафа. Штрафы за стрельбу с двух рук не действуют."
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 1
	mob_trait = TRAIT_AMBIDEXTROUS
	gain_text = span_notice("Обе руки слушаются вас одинаково хорошо.")
	lose_text = span_notice("Вторая рука уже не так послушна, как ведущая")
	icon = FA_ICON_HANDS
	failure_message = "Вторая рука уже не так послушна, как ведущая"
