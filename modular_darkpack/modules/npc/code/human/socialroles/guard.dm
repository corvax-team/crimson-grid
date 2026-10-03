/datum/socialrole/guard
	s_tones = list(
		"albino",
		"caucasian1",
		"caucasian2",
		"caucasian3"
	)

	min_age = 18
	max_age = 85
	preferred_gender = MALE
	male_names = null
	surnames = null

	hair_colors = list(
		"#040404",	//Black
		"#120b05",	//Dark Brown
		"#342414",	//Brown
		"#554433",	//Light Brown
		"#695c3b",	//Dark Blond
		"#ad924e",	//Blond
		"#dac07f",	//Light Blond
		"#802400",	//Ginger
		"#a5380e",	//Ginger alt
		"#ffeace",	//Albino
		"#650b0b",	//Punk Red
		"#14350e",	//Punk Green
		"#080918"	//Punk Blue
	)
	male_hair = list(
		"Balding Hair",
		"Bedhead",
		"Bedhead 2",
		"Bedhead 3",
		"Boddicker",
		"Business Hair",
		"Business Hair 2",
		"Business Hair 3",
		"Business Hair 4",
		"Coffee House",
		"Combover",
		"Crewcut",
		"Father",
		"Flat Top",
		"Gelled Back",
		"Joestar",
		"Keanu Hair",
		"Oxton",
		"Volaju"
	)
	male_facial = list(
		"Beard (Abraham Lincoln)",
		"Beard (Chinstrap)",
		"Beard (Full)",
		"Beard (Cropped Fullbeard)",
		"Beard (Hipster)",
		"Beard (Neckbeard)",
		"Beard (Three o Clock Shadow)",
		"Beard (Five o Clock Shadow)",
		"Beard (Seven o Clock Shadow)",
		"Moustache (Hulk Hogan)",
		"Moustache (Watson)",
		"Sideburns (Elvis)",
		"Sideburns",
		"Shaved"
	)

	shoes = list(/obj/item/clothing/shoes/vampire)
	uniforms = list(/obj/item/clothing/under/vampire/guard)

	// pockets = list(/obj/item/vamp/keys/npc, /obj/item/stack/dollar/rand)

	neutral_phrases = list(
		"Проходим, не задерживаемся.",
		"Я, вообще-то, типа коп, если что.",
		"Эх, сейчас бы пару пончиков.",
		"Как тебе форма?",
		"Слушай, найди меня попозже - угощу пивом."
	)
	neutral_phrases = list(
		"Проходим, не задерживаемся.",
		"Я, вообще-то, типа коп, понимаешь?",
		"Эх, сейчас бы пару пончиков.",
		"Как тебе форма?",
		"Слушай, найди меня попозже - угощу пивом."
	)
	random_phrases = list(
		"Тихая сегодня ночка.",
		"У меня и братья, и отец тоже в охране работают."
	)
	answer_phrases = list("Мне бы кофе.")
	help_phrases = list(
		"Понеслась!",
		"А ну стоять!!",
		"Брось оружие!",
		"Ни с места!!",
		"Я тебе не просто сторож из торгового центра!"
	)
