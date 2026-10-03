/datum/subsplat/vampire_clan/true_brujah
	name = "True Brujah"
	ru_name = "Истинные Бруха"
	id = VAMPIRE_CLAN_TRUE_BRUJAH
	desc = "Истинные Бруха - линия крови клана Бруха, которая считает себя потомками изначального Патриарха-основателя, а не Троиля, его дитя и диаблериста. Их отличают спокойствие и отстранённость, чем они резко непохожи на основную ветвь, известную вспыльчивым буйным нравом и неприязнью к любой власти."
	icon = "true_brujah"
	curse = "Отсутствие страстей."
	sense_the_sin_text = "не умеет выражать чувства."
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/presence,
		/datum/discipline/temporis
	)
	enlightenment = TRUE
	male_clothes = /obj/item/clothing/under/vampire/rich
	female_clothes = /obj/item/clothing/under/vampire/business
	restricted_disciplines = list(/datum/discipline/celerity)
	whitelisted = TRUE
