/datum/quirk/darkpack/vengeful
	name = "Vengeful"
	ru_name = "Мстительность"
	desc = "Вам есть с кем свести счёты: обида осталась со смертной жизни или со времён Становления. Вы одержимы местью конкретному человеку или группе, и в любой ситуации она для вас важнее всего. Это ролевой недостаток без игровой механики: взяв его, вы обязуетесь отыгрывать персонажа, одержимого местью."
	ttrpg_sources = list(/datum/source_book/vtm20 = 486)
	value = -1 // its a 2pt flaw in tabletop but lets be honest bro
	gain_text = span_notice("Вы одержимы жаждой мести.")
	lose_text = span_notice("Месть вас больше не заботит.")
	icon = FA_ICON_FACE_ANGRY
	failure_message = "Месть вас больше не заботит."
	roleplay_only = TRUE
