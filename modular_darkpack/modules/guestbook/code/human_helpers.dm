/mob/living/carbon/human/proc/get_gender()
	var/override = dna?.species.visible_gender_override(src)
	if(override)
		return override
	switch(get_visible_gender())
		if(MALE)
			return "мужчина"
		if(FEMALE)
			return "женщина"
	return "человек"

/// Grammatical gender of the noun returned by get_gender()
/mob/living/carbon/human/proc/get_gender_noun_gender()
	if(dna?.species.visible_gender_override(src))
		return MALE
	return get_visible_gender() == FEMALE ? FEMALE : MALE

/// Age adjective placed before the noun, agreed with its gender
/mob/living/carbon/human/proc/get_age(noun_gender = MALE)
	switch(age)
		if(70 to INFINITY)
			return noun_gender == FEMALE ? "дряхлая" : "дряхлый"
		if(60 to 70)
			return noun_gender == FEMALE ? "пожилая" : "пожилой"
		if(50 to 60)
			return noun_gender == FEMALE ? "немолодая" : "немолодой"
		if(18 to 23)
			return noun_gender == FEMALE ? "молодая" : "молодой"
	return ""

/// Age phrase placed after the noun
/mob/living/carbon/human/proc/get_age_suffix()
	switch(age)
		if(50 to INFINITY)
			return ""
		if(40 to 50)
			return "средних лет"
		if(18 to 40)
			return "" //not necessary because this is basically the most common age range
	return "неопределённого возраста"

/mob/living/proc/get_generic_name(prefixed = FALSE, lowercase = FALSE)
	var/final_string = declent_ru(NOMINATIVE)
	return lowercase ? LOWER_TEXT(final_string) : final_string

/mob/living/carbon/human/get_generic_name(prefixed = FALSE, lowercase = FALSE)
	var/noun_gender = get_gender_noun_gender()
	var/list/words = list()
	if(visible_adjective)
		var/list/adjective_forms = GLOB.preference_adjectives_ru[visible_adjective]
		words += adjective_forms ? adjective_forms[noun_gender == FEMALE ? 2 : 1] : LOWER_TEXT(visible_adjective)
	var/visible_age = get_age(noun_gender)
	if(visible_age)
		words += visible_age
	words += get_gender()
	var/age_suffix = get_age_suffix()
	if(age_suffix)
		words += age_suffix
	var/final_string = words.Join(" ")
	return lowercase ? final_string : capitalize(final_string)
