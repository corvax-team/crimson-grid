
/datum/socialrole/bandit
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
	is_criminal = TRUE

	hair_colors = list(
		"#040404",	//Black
		"#120b05",	//Dark Brown
		"#342414",	//Brown
		"#554433"	//Light Brown
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
		/obj/item/clothing/shoes/vampire/sneakers/red,
		/obj/item/clothing/shoes/vampire/jackboots
	)
	uniforms = list(
		/obj/item/clothing/under/vampire/larry,
		/obj/item/clothing/under/vampire/bandit,
		/obj/item/clothing/under/vampire/biker
	)
	hats = list(
		/obj/item/clothing/head/vampire/bandana,
		/obj/item/clothing/head/vampire/bandana/red,
		/obj/item/clothing/head/vampire/bandana/black,
		/obj/item/clothing/head/vampire/beanie,
		/obj/item/clothing/head/vampire/beanie/black
	)
	pockets = list(
		// /obj/item/stack/dollar/rand,
		/obj/item/vamp/keys/hack
	)

	//[Lucia] - this has been edited to have better English because it included slurs, but none of the others have yet
	male_phrases = list(
		"Чё пялишься?",
		"Ты мне угрожаешь, что ли?",
		"Чё надо?",
		"А яйца у тебя есть, этого не отнять.",
		"Ты в курсе, на кого я работаю?",
		"Вали отсюда, пока я своих пацанов не свистнул.",
		"Проблемы ищешь, сопля?",
		"Свали, либерал.",
		"Вали с нашего района.",
		"Думаешь, я тебя боюсь? Ты хоть знаешь, под кем я хожу?",
		"Думаешь, ты тут круче всех?"
	)
	neutral_phrases = list(
		"Чё ты на меня так смотришь?",
		"Ещё один клоун строит из себя грозного.",
		"Хэллоуин уже прошёл, чё за наряд.",
		"Походу, та шлюха наградила меня триппером.",
		"Мне домой пора, семью кормить и всё такое.",
		"Свали, либерал.",
		"Кажется... я скучаю по жене.",
		"Чё? Надо чего?",
		"С дороги.",
		"Отвали, мудила, не до тебя сейчас.",
		"Отвали на хер."
	)
	random_phrases = list(
		"Дебил.",
		"Скучаю по своей девчонке...",
		"Чё стряслось, бро?",
		"ДОБРЫЙ. МАТЬ ЕГО. ВЕЧЕР.",
		"Вечер добрый.",
		"Я ведь видел, как ты дурь толкаешь, ты в курсе?",
		"Нам всем хана, на хрен...",
		"Всё кончено...",
		"Гхх..."
	)
	answer_phrases = list(
		"Да понял я...",
		"Весь этот город - сраная дыра.",
		"Вот дерьмо, чувак.",
		"Что-то я тебя не припомню... Мы знакомы?",
		"Ну да.",
		"Э-э... Ну круто, наверное",
		"Нормально так пожрал в Gummaguts, только вот живот теперь крутит..."
	)
	help_phrases = list(
		"Господи, только не опять!",
		"УРОД грёбаный!",
		"Ты чё творишь?!",
		"Ну всё, ты попал!",
		"Берега попутал, дурень?!",
		"У нас найдётся кое-что, чтоб заткнуть тебя навсегда!"
	)
