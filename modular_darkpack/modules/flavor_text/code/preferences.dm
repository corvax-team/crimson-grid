///////////////////////////////////////////////////////////////////////////

/datum/preference/text/headshot
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "headshot"
	maximum_value_length = MAX_MESSAGE_LEN
	///How much time between the informational chat messages?
	var/cooldown_duration = 1 MINUTES
	///Handles the informational chat message timer.
	COOLDOWN_DECLARE(headshot_cooldown)
	///Assoc list of ckeys and their links, used to cut down on chat spam
	var/static/list/stored_links = list()
	var/static/link_regex = regex("files.catbox.moe|images2.imgbox.com|i.gyazo.com|postimages.org|i.postimg.cc|toyhou.se|filegarden.com|file.garden|file.house") // CRIMSON EDIT - added more sites
	var/static/list/valid_extensions = list("jpg", "png", "jpeg", "webp") // Regex works fine, if you know how it works // CRIMSON EDIT - added webp

/datum/preference/text/headshot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target?.dna.features[EXAMINE_DNA_HEADSHOT] = value

/datum/preference/text/headshot/is_valid(value)
	if(!length(value))
		return TRUE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		to_chat(usr, span_warning("Ссылка должна начинаться с https!"))
		return

	if(!findtext(value, "."))
		to_chat(usr, span_warning("Некорректная ссылка!"))
		return
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(LOWER_TEXT(extension) in valid_extensions))
		to_chat(usr, span_warning("Изображение должно быть в одном из форматов: [english_list(valid_extensions)]"))
		return

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		to_chat(usr, span_warning("Изображение должно лежать на одном из этих сайтов: Gyazo (i.gyazo.com), Catbox (catbox.moe), Imgbox (images2.imgbox.com), Postimages (i.postimg.cc), toyhou.se, file.garden, file.house"))// CRIMSON EDIT - added more hosts
		return

	if(stored_links[usr.ckey] && stored_links[usr.ckey][type] != value && COOLDOWN_FINISHED(src, headshot_cooldown))
		COOLDOWN_START(src, headshot_cooldown, cooldown_duration)
		to_chat(usr, span_notice("Чтобы не ломать погружение, выберите пристойное изображение по плечи. Считайте, что это фото на документы. И главное: [span_bold("не используйте фотографии реальных людей и несерьёзные картинки.")]"))
		to_chat(usr, span_notice("Если портрет не отображается в игре, проверьте, что это прямая ссылка на изображение и что она открывается в браузере."))
		to_chat(usr, span_notice("Учтите, что портрет будет уменьшен до 250x250 пикселей: чем ближе изображение к квадрату, тем лучше оно будет смотреться."))
		log_game("[usr] has set their Headshot image to '[value]'.")

	apply_headshot(value)
	return TRUE

/datum/preference/text/headshot/proc/apply_headshot(value)
	if(isnull(stored_links[usr?.ckey]))
		stored_links[usr?.ckey] = list()
	stored_links[usr?.ckey][type] = value
	return TRUE

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_FLAVOR_TEXT] = value


/datum/preference/text/war_form_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_BODYPARTS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "war_form_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN
	relevant_inherent_trait = TRAIT_FERA_FORMS
	must_have_relevant_trait = TRUE

/datum/preference/text/war_form_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_WAR_FORM_FLAVOR_TEXT] = value


/datum/preference/text/feral_form_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_BODYPARTS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "feral_form_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN
	relevant_inherent_trait = TRAIT_FERA_FORMS
	must_have_relevant_trait = TRUE

/datum/preference/text/feral_form_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_FERAL_FORM_FLAVOR_TEXT] = value

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/nsfw_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "nsfw_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/nsfw_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(CONFIG_GET(flag/nsfw_content))
		target.dna.features[EXAMINE_DNA_NSFW_FLAVOR_TEXT] = value

/datum/preference/text/nsfw_flavor_text/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE

	if(CONFIG_GET(flag/nsfw_content) && preferences.read_preference(/datum/preference/toggle/nsfw_content_pref))
		return TRUE

	return FALSE

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/character_notes
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "character_notes"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/character_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_CHARACTER_NOTES] = value

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/ooc_notes
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ooc_notes"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/ooc_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(CONFIG_GET(flag/nsfw_content))
		target.dna.features[EXAMINE_DNA_OOC_NOTES] = value

/datum/preference/text/ooc_notes/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE

	if(CONFIG_GET(flag/nsfw_content) && preferences.read_preference(/datum/preference/toggle/nsfw_content_pref))
		return TRUE

	return FALSE
