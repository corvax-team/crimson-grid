/datum/socialrole/shop
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
	max_age = 45
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

	shoes = list(
		/obj/item/clothing/shoes/vampire/sneakers,
		/obj/item/clothing/shoes/vampire,
		/obj/item/clothing/shoes/vampire/brown
	)
	uniforms = list(
		/obj/item/clothing/under/vampire/mechanic,
		/obj/item/clothing/under/vampire/brujah,
		/obj/item/clothing/under/vampire/emo,
		/obj/item/clothing/under/vampire/suit,
		/obj/item/clothing/under/vampire/turtleneck_black,
		/obj/item/clothing/under/vampire/office,
		/obj/item/clothing/under/vampire/gangrel,
		/obj/item/clothing/under/vampire/tremere,
		/obj/item/clothing/under/vampire/supply,
	)
	pockets = list(
		/obj/item/vamp/keys/npc,
		// /obj/item/stack/dollar/rand
	)

	male_phrases = list(
		"Хотите что-нибудь купить?",
		"Вам помочь?",
		"Ну что, берёте?"
	)
	neutral_phrases = list(
		"Хотите что-нибудь купить?",
		"Вам помочь?",
		"Ну что, берёте?"
	)
	random_phrases = list(
		"Помочь вам что-нибудь найти?",
		"Если что-то понадобится - зовите.",
		"Не торопитесь.",
		"А у вас глаз намётан: это ходовой товар.",
		"Наличные, карта - мне без разницы.",
		"У нас как раз свежий завоз.",
		"Сразу видно: вы знаете, чего хотите.",
		"А вот это со скидкой. Не спрашивайте почему.",
		"Денёк сегодня вялый. Хорошо, что заглянули.",
		"Я держу это место двенадцать лет. А по ощущениям - все тридцать.",
		"Мой последний работник уволился без предупреждения. Отсюда... вот это всё.",
		"Цены у нас честные. В основном.",
		"Осматривайтесь, никто вас не торопит.",
		"Хозяина тут вечно нет. По сути, всё держится на мне.",
		"Деньги не возвращаем.",
		"Пакет нужен? Пакет - пять центов. Городской закон, я тут ни при чём!",
		"Если что - кричите, а я пока поизображаю инвентаризацию.",
	)
	answer_phrases = list("Я тут просто работаю...")
	help_phrases = list(
		"Да какого чёрта?!",
		"Проваливай, или я вызову копов!!",
		"Что происходит?!",
		"Прекрати!",
		"Кто-нибудь, вызовите скорую!"
	)
	var/masquerade_item_phrases = list(
		"А? Это что, с гаражной распродажи?",
		"Забавная штука. Подарю дяде на день рождения.",
		"Бери деньги и уходи. С сатанистами я дел не веду."
	)
	var/masquerade_item_failure_phrases = list(
		"Это ещё что такое? Приятель, у меня от тебя мурашки.",
		"Откуда это у тебя?!",
		"Ладно, куплю, только уйди, пожалуйста..."
	)
