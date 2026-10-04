/datum/subsplat
	/// Russian name shown to players, name stays the internal key
	var/ru_name

/datum/subsplat/proc/get_display_name()
	return ru_name || name

/datum/morality
	/// Russian name shown to players, name stays the internal key
	var/ru_name

/datum/morality/proc/get_display_name()
	return ru_name || name

/datum/splat
	/// Russian name shown to players, name stays the internal key
	var/ru_name

/datum/splat/proc/get_display_name()
	return ru_name || name

/datum/quirk
	/// Russian name shown to players, name stays the key saved in preferences
	var/ru_name

/datum/quirk/proc/get_display_name()
	return ru_name || name

/datum/quirk/bilingual
	ru_name = "Дополнительный язык"

/datum/quirk/item_quirk/signer
	ru_name = "Язык жестов"

/datum/quirk/poor_aim
	ru_name = "Меткость штурмовика"

/datum/quirk/item_quirk/scarred_eye
	ru_name = "Одноглазость"

/datum/bodypart_overlay/simple/clan_mark
	/// Russian name shown to players, the stored value is built from the typepath
	var/ru_name

/obj/ritual_rune
	/// Russian ritual name shown in tomes and pickers, name stays English
	var/ru_name

/obj/ritual_rune/Initialize(mapload)
	. = ..()
	if(!ru_name)
		return
	ritual_name = ru_name
	ru_names_rename(ru_names_list(initial(name), "руна \"[ru_name]\"", "руны \"[ru_name]\"", "руне \"[ru_name]\"", "руну \"[ru_name]\"", "руной \"[ru_name]\"", "руне \"[ru_name]\"", FEMALE))

// the base type appends " rune" to name, so the lookup by name in /atom/New would wipe the declensions
/obj/ritual_rune/ru_names_rename(list/new_list)
	if(ru_name && new_list?["base"] != initial(name))
		return
	return ..()

/datum/preference/external_choiced/compile_constant_data()
	var/list/display_names = get_display_names()
	if(!length(display_names))
		return null
	return list(CHOICED_PREFERENCE_DISPLAY_NAMES = display_names)

/// Picker labels mapped back to the stored values
/datum/preference/external_choiced/proc/get_choice_labels(datum/preferences/preferences)
	var/list/labels = list()
	for(var/choice in get_choices(preferences))
		labels[get_choice_label(choice)] = choice
	return labels

/datum/preference/external_choiced/proc/get_choice_label(value)
	return get_display_names()?[value] || value

/// Stored value -> label shown to the player, null to show the stored values as is
/datum/preference/external_choiced/proc/get_display_names()
	return null

/// Russian picker labels mapped back to the keys of GLOB.aura_list
/proc/aura_emotion_labels()
	var/static/list/labels
	if(!labels)
		labels = list()
		for(var/emotion in GLOB.emotion_to_quality)
			labels[capitalize(GLOB.emotion_to_quality[emotion])] = emotion
		labels = sort_list(labels)
	return labels

/datum/map_config
	/// Russian name shown to players, map_name stays the key for saves, persistence and the database
	var/map_name_ru

/datum/map_config/proc/get_display_name()
	return map_name_ru || map_name

/datum/vote
	/// Russian name shown to players, name stays the key in SSvote.possible_votes
	var/display_name

/datum/vote/proc/get_display_name()
	return display_name || name

/// Text shown for a choice, the choice itself stays the key
/datum/vote/proc/get_choice_label(choice)
	return "[choice]"

/datum/vote/map_vote/get_choice_label(choice)
	var/datum/map_config/choice_config = global.config.maplist[choice]
	return choice_config?.get_display_name() || ..()

/obj/item/toy/singlecard/Flip(is_face_up)
	. = ..()
	update_ru_card_name()

/obj/item/toy/singlecard/update_name()
	. = ..()
	update_ru_card_name()

/// cardname builds the icon_state, so the Russian form lives only in the declensions
/obj/item/toy/singlecard/proc/update_ru_card_name()
	ru_names_rename(flipped ? ru_card_names(cardname, initial(name)) : ru_names_toml(initial(name)))

/obj/item/toy/singlecard/proc/get_display_cardname()
	return ru_card_names(cardname, initial(name))?[NOMINATIVE] || cardname

/// Declensions for a standard or tarot card name such as "Ace of Spades", null for anything else
/proc/ru_card_names(cardname, base)
	var/static/list/ranks = list(
		"Ace" = list("туз", "туза", "тузу", "туза", "тузом", "тузе", MALE),
		"1" = list("туз", "туза", "тузу", "туза", "тузом", "тузе", MALE),
		"2" = list("двойка", "двойки", "двойке", "двойку", "двойкой", "двойке", FEMALE),
		"3" = list("тройка", "тройки", "тройке", "тройку", "тройкой", "тройке", FEMALE),
		"4" = list("четвёрка", "четвёрки", "четвёрке", "четвёрку", "четвёркой", "четвёрке", FEMALE),
		"5" = list("пятёрка", "пятёрки", "пятёрке", "пятёрку", "пятёркой", "пятёрке", FEMALE),
		"6" = list("шестёрка", "шестёрки", "шестёрке", "шестёрку", "шестёркой", "шестёрке", FEMALE),
		"7" = list("семёрка", "семёрки", "семёрке", "семёрку", "семёркой", "семёрке", FEMALE),
		"8" = list("восьмёрка", "восьмёрки", "восьмёрке", "восьмёрку", "восьмёркой", "восьмёрке", FEMALE),
		"9" = list("девятка", "девятки", "девятке", "девятку", "девяткой", "девятке", FEMALE),
		"10" = list("десятка", "десятки", "десятке", "десятку", "десяткой", "десятке", FEMALE),
		"Jack" = list("валет", "валета", "валету", "валета", "валетом", "валете", MALE),
		"Valet" = list("валет", "валета", "валету", "валета", "валетом", "валете", MALE),
		"Chevalier" = list("кавалер", "кавалера", "кавалеру", "кавалера", "кавалером", "кавалере", MALE),
		"Queen" = list("дама", "дамы", "даме", "даму", "дамой", "даме", FEMALE),
		"Dame" = list("дама", "дамы", "даме", "даму", "дамой", "даме", FEMALE),
		"King" = list("король", "короля", "королю", "короля", "королём", "короле", MALE),
		"Roi" = list("король", "короля", "королю", "короля", "королём", "короле", MALE),
	)
	var/static/list/suits = list(
		"Hearts" = "червей",
		"Spades" = "пик",
		"Pikes" = "пик",
		"Clubs" = "треф",
		"Clovers" = "треф",
		"Diamonds" = "бубен",
		"Tiles" = "бубен",
	)
	var/static/list/jokers = list(
		"Joker Clown" = "клоун",
		"Joker Mime" = "мим",
	)
	var/static/list/trumps = list(
		"The Magician" = "Маг",
		"The High Priestess" = "Верховная Жрица",
		"The Empress" = "Императрица",
		"The Emperor" = "Император",
		"The Hierophant" = "Иерофант",
		"The Lover" = "Влюблённые",
		"The Chariot" = "Колесница",
		"Justice" = "Справедливость",
		"The Hermit" = "Отшельник",
		"The Wheel of Fortune" = "Колесо Фортуны",
		"Strength" = "Сила",
		"The Hanged Man" = "Повешенный",
		"Death" = "Смерть",
		"Temperance" = "Умеренность",
		"The Devil" = "Дьявол",
		"The Tower" = "Башня",
		"The Star" = "Звезда",
		"The Moon" = "Луна",
		"The Sun" = "Солнце",
		"Judgement" = "Суд",
		"The World" = "Мир",
		"The Fool" = "Шут",
	)
	var/joker = jokers[cardname]
	if(joker)
		return ru_names_list(base, "джокер-[joker]", "джокера-[joker]а", "джокеру-[joker]у", "джокера-[joker]а", "джокером-[joker]ом", "джокере-[joker]е", MALE)
	var/trump = trumps[cardname]
	if(trump)
		return ru_names_list(base, "аркан \"[trump]\"", "аркана \"[trump]\"", "аркану \"[trump]\"", "аркан \"[trump]\"", "арканом \"[trump]\"", "аркане \"[trump]\"", MALE)
	var/list/parts = splittext(cardname, " of ")
	if(length(parts) != 2)
		return null
	var/list/rank = ranks[parts[1]]
	var/suit = suits[parts[2]]
	if(!rank || !suit)
		return null
	return ru_names_list(base, "[rank[1]] [suit]", "[rank[2]] [suit]", "[rank[3]] [suit]", "[rank[4]] [suit]", "[rank[5]] [suit]", "[rank[6]] [suit]", rank[7])

/// Radial label, command_name stays the key in available_commands
/datum/pet_command/proc/get_display_name()
	var/static/list/labels = list(
		"Stay" = "Место",
		"Loose" = "Гулять",
		"Follow" = "За мной",
		"Play Dead" = "Умри",
		"Good Boy" = "Похвалить",
		"Attack" = "Фас",
		"Breed" = "Размножаться",
		"Use ability" = "Способность",
		"Protect owner" = "Защищать хозяина",
		"Fish" = "Рыбачить",
		"Move" = "Идти",
		"Fetch" = "Апорт",
	)
	return labels[command_name] || command_name
