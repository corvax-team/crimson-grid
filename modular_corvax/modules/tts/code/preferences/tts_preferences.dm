/datum/preference/text/tts_seed
	savefile_key = "tts_seed"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	can_randomize = FALSE

/datum/preference/text/tts_seed/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/tts_seed/seed = SStts_ru.tts_seeds[value]
	if(!seed)
		seed = SStts_ru.tts_seeds[SStts_ru.pick_tts_seed_by_gender(target.gender)]

	target.dna.tts_seed_dna = seed
	if(CONFIG_GET(flag/tts_enabled))
		target.AddComponent(/datum/component/tts_component, seed)

/datum/preference/text/tts_seed/create_informed_default_value(datum/preferences/preferences)
	return SStts_ru.pick_tts_seed_by_gender(preferences.read_preference(/datum/preference/choiced/gender)) || ""

/datum/preference/text/tts_seed/deserialize(input, datum/preferences/preferences)
	if(!SStts_ru.tts_seeds[input])
		return create_informed_default_value(preferences)
	return input

/datum/preference/text/tts_seed/is_valid(value, datum/preferences/preferences)
	return istext(value) && (!value || SStts_ru.tts_seeds[value])
