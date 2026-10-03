/datum/language_holder/garou //for homid and glabro
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
	)

/datum/language_holder/crinos
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)

/datum/language_holder/primal //for lupus and hispos form
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)

/datum/language/garou_tongue
	name = "Garou Tongue"
	desc = "Гортанный, резкий язык гару, известный также как Высокая Речь. Ему можно научиться, но в человеческом обличье говорить на нём трудно."
	key = "w"
	flags = LANGUAGE_TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 40
	syllables = list(
		"то", "ло", "оф", "ли", "ка", "ха", "хе", "ах", "ни", "ро",
		"ли", "ме", "ад", "хе", "ах", "ум", "ко", "га", "гар", "фа",
		"эл", "ра", "иа", "оф", "ос", "ра", "та", "на", "га", "хо",
		"лу", "лу", "фе", "зи", "мо", "ша", "ру", "те", "во", "ни",
		"кса", "жо", "да", "ку", "пе", "су", "йо", "ве", "ми", "ба"
	)
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_languages.dmi'
	icon_state = "garou"
	default_priority = 90

/datum/language/primal_tongue
	name = "Primal Tongue"
	desc = "Язык, который гару любой породы знают от рождения. Говорить на нём можно только в формах Люпус, Кринос и Хиспо."
	key = "p"
	flags = LANGUAGE_TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 40
	syllables = list (
		"гра", "грр", "гру", "гха", "ша", "жо", "йип", "вху", "зар", "рук",
		"кра", "хья", "тза", "ска", "ырр", "фру", "тхра", "хво", "вра", "снар",
		"кру", "пха", "гха", "хро", "тзо", "вха", "брак", "тхру", "чур", "дра",
		"вру", "сна", "йру", "хру", "йла", "фро", "рик", "зру", "скра", "жу",
		"кро", "тхро", "зьи", "ша", "хза", "мру", "вру", "брук", "хка", "тза"
	)
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_languages.dmi'
	icon_state = "garou"
	default_priority = 90
