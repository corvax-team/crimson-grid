/datum/quirk/darkpack/amnesia
	name = "Amnesia"
	ru_name = "Амнезия"
	desc = "Вы не помните ничего о своём прошлом, о себе и о своей семье (смертной или вампирской), хотя прошлое ещё может напомнить о себе. Даже собственное имя вспоминается с трудом, а самые важные воспоминания утрачены навсегда. Это ролевой недостаток без игровой механики: взяв его, вы обязуетесь отыгрывать амнезию."
	value = -1 // -2 in tabletop, but lets be real
	gain_text = span_notice("Вы забываете всё о себе и своём прошлом.")
	lose_text = span_notice("А, теперь я всё помню.")
	icon = FA_ICON_BRAIN
	failure_message = "А, теперь я всё помню."
	ttrpg_sources = list(
		/datum/source_book/vtm20 = 486,
		/datum/source_book/wta20 = 477,
		)
	roleplay_only = TRUE
