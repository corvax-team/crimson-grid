/datum/socialrole/bouncer
	is_criminal = TRUE

	//Appearence
	s_tones = list(
		"albino",
		"caucasian1",
		"caucasian2",
		"caucasian3",
		"latino",
		"mediterranean",
		"asian1",
		"asian2",
		"arab",
		"indian",
		"african1",
		"african2"
	)

	min_age = 18
	max_age = 85
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

	female_hair = list("Ahoge",
		"Long Bedhead",
		"Beehive",
		"Beehive 2",
		"Bob Hair",
		"Bob Hair 2",
		"Bob Hair 3",
		"Bob Hair 4",
		"Bobcurl",
		"Braided",
		"Braided Front",
		"Braid (Short)",
		"Braid (Low)",
		"Bun Head",
		"Bun Head 2",
		"Bun Head 3",
		"Bun (Large)",
		"Bun (Tight)",
		"Double Bun",
		"Emo",
		"Emo Fringe",
		"Feather",
		"Gentle",
		"Long Hair 1",
		"Long Hair 2",
		"Long Hair 3",
		"Long Over Eye",
		"Long Emo",
		"Long Fringe",
		"Ponytail",
		"Ponytail 2",
		"Ponytail 3",
		"Ponytail 4",
		"Ponytail 5",
		"Ponytail 6",
		"Ponytail 7",
		"Ponytail (High)",
		"Ponytail (Short)",
		"Ponytail (Long)",
		"Ponytail (Country)",
		"Ponytail (Fringe)",
		"Poofy",
		"Short Hair Rosa",
		"Shoulder-length Hair",
		"Volaju")

	shoes = list(/obj/item/clothing/shoes/vampire/jackboots)
	uniforms = list(/obj/item/clothing/under/vampire/guard)
	pockets = list(/obj/item/vamp/keys/npc, /obj/item/stack/dollar/rand)
	backpacks = list()

	//Voice Lines
	neutral_phrases = list(
		"Приятель, сделай-ка шаг назад.",
		"Дальше только для VIP.",
		"Веди себя прилично."
	)
	random_phrases = list(
		"Тихая сегодня ночка."
	)

	answer_phrases = list("Вот дерьмо.")
	help_phrases = list(
		"Тебе пора на выход.",
		"Пойдём, покажу, где дверь.",
		"Спокойная была ночь, пока ты не заявился.",
		"Мне от этого будет больнее, чем тебе."
	)


	//Phrase said when someone is denied entry
	var/denial_phrases = list(
		"Тебя нет в списке.",
		"Входа нет. Для тебя - нет.",
		"Дальше закрытое мероприятие."
	)


	var/entry_phrases = list(
		"Рад снова вас видеть.",
		"Добро пожаловать на тёмную сторону.",
		"Вас уже ждут.",
		"Как всегда, рады вам."
	)

	var/police_block_phrases = list(
		"К чёрту легавых.",
		"Да ну? Вот с ордером и приходи.",
		"Без ордера не войдёшь.",
		"Я свои права знаю. Вали отсюда."
	)

	var/block_phrases = list(
		"Тебе же сказали: проваливай.",
		"Последний раз говорю: не пройдёшь.",
		"Складно заливаешь, дружок. А теперь брысь."
	)

	var/bouncer_weapon_type = /obj/item/gun/ballistic/shotgun/vampire
	var/bouncer_backup_weapon_type = /obj/item/claymore/machete
