/datum/preference_middleware/text_to_speech
	action_delegations = list(
		"listen" = PROC_REF(listen_voice),
		"select_voice" = PROC_REF(select_voice),
	)

/datum/preference_middleware/text_to_speech/get_ui_data(mob/user)
	var/list/data = list()
	data["tts_seed"] = preferences.read_preference(/datum/preference/text/tts_seed)
	data["tts_enabled"] = SStts_ru.is_enabled
	return data

/datum/preference_middleware/text_to_speech/get_constant_data()
	var/list/data = list()
	data["providers"] = get_tts_providers_ui_data()
	data["seeds"] = get_tts_seeds_ui_data()
	data["phrases"] = TTS_PHRASES
	return data

/datum/preference_middleware/text_to_speech/proc/get_tts_providers_ui_data()
	var/list/providers = list()
	for(var/provider_name in SStts_ru.tts_providers)
		var/datum/tts_provider/provider = SStts_ru.tts_providers[provider_name]
		providers += list(list(
			"name" = provider.name,
			"is_enabled" = provider.is_enabled,
		))
	return providers

/datum/preference_middleware/text_to_speech/proc/get_tts_seeds_ui_data()
	var/list/seeds = list()
	for(var/seed_name in SStts_ru.tts_seeds)
		var/datum/tts_seed/seed = SStts_ru.tts_seeds[seed_name]
		seeds += list(list(
			"name" = seed.name,
			"value" = seed.value,
			"category" = seed.category,
			"gender" = seed.gender,
			"provider" = initial(seed.provider.name),
		))
	return seeds

/datum/preference_middleware/text_to_speech/proc/listen_voice(list/params, mob/user)
	var/datum/tts_seed/seed = SStts_ru.tts_seeds[params["seed"]]
	if(!seed)
		return FALSE

	var/phrase = params["phrase"]
	if(!(phrase in TTS_PHRASES))
		phrase = pick(TTS_PHRASES)

	SStts_ru.get_tts(null, user, phrase, seed, FALSE)
	return FALSE

/datum/preference_middleware/text_to_speech/proc/select_voice(list/params, mob/user)
	var/seed_name = params["seed"]
	if(!SStts_ru.tts_seeds[seed_name])
		return FALSE

	preferences.update_preference(GLOB.preference_entries[/datum/preference/text/tts_seed], seed_name)
	return TRUE
