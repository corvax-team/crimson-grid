/datum/language/french
	name = "French"
	desc = "Романтичный и утончённый язык, на котором говорят во Франции и далеко за её пределами."
	key = "f"
	flags = LANGUAGE_TONGUELESS_SPEECH
	space_chance = 40
	syllables = list(
		"ou", "on", "an", "in", "un", "ai", "oi", "au", "eu", "ch",
		"je", "tu", "il", "elle", "que", "qui", "me", "se", "te", "ve",
		"ca", "ce", "ci", "co", "fa", "fe", "fi", "lo", "la", "li",
		"ro", "ra", "re", "ri", "vo", "va", "ve", "po", "pe", "pi",
		"no", "na", "ne", "mo", "ma", "ta", "te", "to", "so", "se",
		"jo", "ja", "che", "tra", "ble", "tre", "clo", "cla", "cro", "fra"
	)
	icon_state = "french"
	default_priority = 90

	mutual_understanding = list(
		/datum/language/common = 10,
		/datum/language/greek = 10,
		/datum/language/latin = 10,
	)

	restricted = FALSE
