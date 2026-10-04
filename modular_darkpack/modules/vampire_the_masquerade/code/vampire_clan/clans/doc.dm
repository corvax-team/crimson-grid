/datum/subsplat/vampire_clan/daughters_of_cacophony
	name = "Daughters of Cacophony"
	ru_name = "Дочери Какофонии"
	id = VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY
	desc = "Сегодня линия состоит в основном из женщин: обучить певца с обычным мужским диапазоном слишком трудно. Дочери владеют Мельпоменией - Дисциплиной, которая позволяет творить странные вещи с помощью пения. Они - непревзойдённые хористки среди немёртвых, и принять их у себя почётно для любого тореадора."
	icon = "daughters_of_cacophony"
	curse = "Слышат больше, чем следует."
	sense_the_sin_text = "не слышит собственных мыслей за несмолкающей музыкой."
	clan_disciplines = list(
		/datum/discipline/fortitude,
		/datum/discipline/melpominee,
		/datum/discipline/presence
	)
	male_clothes = /obj/item/clothing/under/vampire/sexy
	female_clothes = /obj/item/clothing/under/vampire/toreador/female
	enlightenment = FALSE
	whitelisted = TRUE
	subsplat_keys = /obj/item/vamp/keys/daughters
