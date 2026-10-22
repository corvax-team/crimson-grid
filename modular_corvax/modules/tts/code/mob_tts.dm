/mob/living/Initialize(mapload)
	. = ..()
	add_tts_component()

/mob/living/proc/add_tts_component()
	if(!CONFIG_GET(flag/tts_enabled))
		return FALSE
	AddComponent(/datum/component/tts_component)
	return TRUE

/mob/living/carbon/add_tts_component()
	. = ..()
	if(. && dna)
		dna.tts_seed_dna = get_tts_seed()

/mob/living/carbon/human/npc/add_tts_component()
	if(!CONFIG_GET(flag/tts_npc_enabled))
		return FALSE
	return ..()

/// Called from Hear() once the message was actually heard, voices it for this listener
/mob/proc/hear_tts(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	if(!SStts_ru.is_enabled || !client || !speaker)
		return
	if(LAZYACCESS(message_mods, MODE_CUSTOM_SAY_ERASE_INPUT))
		return
	if(radio_freq && !hears_radio_tts(radio_freq))
		return
	var/is_local = !radio_freq && message_range != INFINITY
	if(is_local && get_dist(get_turf(speaker), get_turf(src)) > SOUND_RANGE)
		return

	var/tts_message = LAZYACCESS(message_mods, MODE_TTS_MESSAGE_OVERRIDE) || raw_message
	if(message_language)
		tts_message = translate_language(speaker, message_language, tts_message, spans, message_mods)

	speaker.cast_tts(
		src,
		tts_message,
		is_local = is_local,
		is_radio = !!radio_freq,
		effects = LAZYACCESS(message_mods, MODE_TTS_FILTERS),
		tts_seed_override = LAZYACCESS(message_mods, MODE_TTS_SEED_OVERRIDE),
		channel_override = radio_freq ? CHANNEL_TTS_RADIO : null,
		radio_freq = radio_freq,
	)

/mob/proc/hears_radio_tts(radio_freq)
	switch(client.prefs.read_preference(/datum/preference/choiced/sound_tts_radio))
		if(TTS_SOUND_NO_RADIO)
			return FALSE
		if(TTS_SOUND_DEPARTMENTAL_RADIO)
			return radio_freq != FREQ_COMMON
	return TRUE

/// Whether this mob hears the speaker through text-to-speech, in which case the blooper is skipped for it
/mob/proc/hears_tts_voice_of(atom/movable/speaker)
	if(!SStts_ru.is_enabled || !client || !speaker?.get_tts_seed())
		return FALSE
	var/datum/preferences/prefs = client.prefs
	if(prefs.read_preference(/datum/preference/choiced/sound_tts) != TTS_SOUND_ENABLED)
		return FALSE
	return prefs.read_preference(/datum/preference/numeric/volume/sound_tts_volume) > 0
