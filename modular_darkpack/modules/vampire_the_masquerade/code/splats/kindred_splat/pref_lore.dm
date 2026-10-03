/datum/splat/vampire/kindred/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#333333", update = FALSE)
	human.set_hairstyle("Undercut Left", update = TRUE)
	human.set_eye_color("#ff0000")
	human.undershirt = "T-Shirt (Red)"
	human.update_body()
	human.equipOutfit(/datum/outfit/job/vampire/prince, TRUE)

// note - we have unused desc vars on splats
/datum/splat/vampire/kindred/get_splat_description()
	return "Бессмертные хищники, обречённые жить в ночи. Они питаются человеческой кровью и прячут своё существование за ширмой, которую зовут Маскарадом. Разделённые на кланы и секты, расколотые враждой, они ведут под поверхностью смертного общества бесконечные политические и идейные войны.\n\nФормально городом правит Камарилья, но во многих городах есть и анархи, и Шабаш, и независимые фракции. Это шаткое равновесие вечно под угрозой: его расшатывают и сами соперники, и внешние силы, и внутренние распри. Каждый Сородич борется с первобытными порывами Зверя внутри, и от кровавого Безумия и превращения в чудовище его всегда отделяет одна ошибка."

// Pulled straight from the wiki https://whitewolf.fandom.com/wiki/Vampire_(WOD)
/datum/splat/vampire/kindred/get_splat_lore()
	return list(
		"Кровопийцы, что рыщут по Миру Тьмы, зовут себя в основном Сородичами, упырями или каинитами. Завсегдатаям Элизиума и теоретикам анархической утопии слово \"вампир\" кажется дурным тоном: оно отдаёт дешёвыми сиквелами студии \"Хаммер\" и замшелым фольклором для туристов. Однако те, кто получил Становление в последние десятилетия, всё чаще называют так самих себя (\"возвращают себе слово на букву В\") и тем заявляют право на это звание, как бы ни была слаба их Кровь.",
	)

/datum/splat/vampire/kindred/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_BOOK_DEAD,
			SPECIES_PERK_NAME = "Кланы Сородичей",
			SPECIES_PERK_DESC = "Сородичи принадлежат к разным кланам, и у каждого клана свои особые способности и слабости. Клан выбирается в настройках персонажа!",
		),
	)

	return to_add

/*
// Vampire blood is special, so it needs to be handled with its own entry.
/datum/splat/vampire/kindred/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Example Negative Perk",
		SPECIES_PERK_DESC = "Lorem Ipsum",
	))

	return to_add
*/

// There isn't a "Minor Undead" biotype, so we have to explain it in an override (see: dullahans)
/datum/splat/vampire/kindred/create_pref_biotypes_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SKULL,
		SPECIES_PERK_NAME = "Малая нежить",
		SPECIES_PERK_DESC = "Сородичи - малая нежить. \
			Ей доступны некоторые преимущества мёртвых: \
			не нужно ни дышать, ни есть. Но от большинства опасностей среды, \
			которые нипочём настоящей нежити, она не защищена.",
	))

	return to_add
