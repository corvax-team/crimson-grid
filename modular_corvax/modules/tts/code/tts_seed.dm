/datum/dna
	var/datum/tts_seed/tts_seed_dna

/datum/dna/copy_dna(datum/dna/new_dna, transfer_flags)
	. = ..()
	new_dna.tts_seed_dna = tts_seed_dna
	if(tts_seed_dna && istype(new_dna.holder) && CONFIG_GET(flag/tts_enabled))
		new_dna.holder.AddComponent(/datum/component/tts_component, tts_seed_dna)

/atom/proc/cast_tts(listener, message, atom/location, is_local = TRUE, is_radio = FALSE, list/effects, traits = TTS_TRAIT_RATE_FASTER, preSFX, postSFX, tts_seed_override, channel_override, check_deafness = TRUE, radio_freq)
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_CAST, listener, message, location, is_local, is_radio, effects, traits, preSFX, postSFX, tts_seed_override, channel_override, check_deafness, radio_freq)

/atom/movable/virtualspeaker/cast_tts(listener, message, atom/location, is_local = TRUE, is_radio = FALSE, list/effects, traits = TTS_TRAIT_RATE_FASTER, preSFX, postSFX, tts_seed_override, channel_override, check_deafness = TRUE, radio_freq)
	if(QDELETED(source))
		return
	SEND_SIGNAL(source, COMSIG_ATOM_TTS_CAST, listener, message, location || (is_radio ? radio : null), is_local, is_radio, effects, traits, preSFX, postSFX, tts_seed_override, channel_override, check_deafness, radio_freq)

/atom/proc/get_tts_seed()
	var/datum/component/tts_component/tts_component = GetComponent(/datum/component/tts_component)
	return tts_component?.tts_seed

/atom/proc/change_tts_seed(mob/chooser, overrides, list/new_sound_effects)
	if(!get_tts_seed())
		if(tgui_alert(chooser, "Отсутствует компонент озвучки. Создать?", "Изменение голоса", list("Да", "Нет")) != "Да")
			return
		AddComponent(/datum/component/tts_component)
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_SEED_CHANGE, chooser, overrides, new_sound_effects)

/atom/proc/tts_effects_add(list/effects)
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_EFFECTS_ADD, effects)

/atom/proc/tts_effects_remove(list/effects)
	SEND_SIGNAL(src, COMSIG_ATOM_TTS_EFFECTS_REMOVE, effects)
