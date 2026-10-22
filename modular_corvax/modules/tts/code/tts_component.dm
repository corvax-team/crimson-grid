/datum/component/tts_component
	var/datum/tts_seed/tts_seed = null
	var/list/effects = list()

/datum/component/tts_component/Initialize(datum/tts_seed/new_tts_seed, list/effects)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(ispath(new_tts_seed) && SStts_ru.tts_seeds[initial(new_tts_seed.name)])
		new_tts_seed = SStts_ru.tts_seeds[initial(new_tts_seed.name)]
	if(istype(new_tts_seed))
		tts_seed = new_tts_seed

	if(!tts_seed)
		tts_seed = get_random_tts_seed_by_gender()
	if(!tts_seed)
		return COMPONENT_INCOMPATIBLE
	if(length(effects))
		src.effects |= effects

/datum/component/tts_component/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_TTS_SEED_CHANGE, PROC_REF(tts_seed_change))
	RegisterSignal(parent, COMSIG_ATOM_TTS_CAST, PROC_REF(cast_tts))
	RegisterSignal(parent, COMSIG_ATOM_TTS_EFFECTS_ADD, PROC_REF(tts_effects_add))
	RegisterSignal(parent, COMSIG_ATOM_TTS_EFFECTS_REMOVE, PROC_REF(tts_effects_remove))

/datum/component/tts_component/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_ATOM_TTS_SEED_CHANGE,
		COMSIG_ATOM_TTS_CAST,
		COMSIG_ATOM_TTS_EFFECTS_ADD,
		COMSIG_ATOM_TTS_EFFECTS_REMOVE,
	))

/datum/component/tts_component/proc/get_random_tts_seed_by_gender()
	var/atom/being_changed = parent
	var/tts_choice = SStts_ru.pick_tts_seed_by_gender(being_changed.gender)
	return SStts_ru.tts_seeds[tts_choice]

/datum/component/tts_component/proc/tts_seed_change(atom/being_changed, mob/chooser, overrides, list/new_sound_effects)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(change_seed_async), being_changed, chooser, overrides, new_sound_effects)

/datum/component/tts_component/proc/change_seed_async(atom/being_changed, mob/chooser, overrides, list/new_sound_effects)
	var/datum/tts_seed/new_tts_seed = select_tts_seed(chooser = chooser, overrides = overrides, new_sound_effects = new_sound_effects)
	if(!new_tts_seed)
		return
	tts_seed = new_tts_seed
	if(iscarbon(being_changed))
		var/mob/living/carbon/carbon = being_changed
		carbon.dna?.tts_seed_dna = tts_seed

/datum/component/tts_component/proc/select_tts_seed(mob/chooser, silent_target = FALSE, overrides, list/new_sound_effects)
	if(!chooser)
		if(!ismob(parent))
			return null
		chooser = parent

	var/atom/being_changed = parent
	var/static/tts_test_str = "Так звучит мой голос."

	var/list/tts_seeds = list()
	if(check_rights_for(chooser.client, R_ADMIN) || (overrides & TTS_OVERRIDE_GENDER) || !ismob(being_changed))
		tts_seeds |= SStts_ru.get_tts_by_gender(MALE)
		tts_seeds |= SStts_ru.get_tts_by_gender(FEMALE)
		tts_seeds |= SStts_ru.get_tts_by_gender(NEUTER)
	else
		tts_seeds |= SStts_ru.get_tts_by_gender(being_changed.gender)
		tts_seeds |= SStts_ru.get_tts_by_gender(NEUTER)
	if(!length(tts_seeds))
		to_chat(chooser, span_warning("Не удалось найти голоса для этого пола! Текущий голос: [tts_seed.name]"))
		return null
	tts_seeds = sortTim(tts_seeds, GLOBAL_PROC_REF(cmp_text_asc))

	var/new_tts_seed_key = tgui_input_list(chooser, "Выберите голос", "Изменение голоса", tts_seeds, tts_seed.name)
	if(!new_tts_seed_key || !SStts_ru.tts_seeds[new_tts_seed_key])
		to_chat(chooser, span_warning("Голос не выбран. Текущий голос: [tts_seed.name]"))
		return null

	var/datum/tts_seed/new_tts_seed = SStts_ru.tts_seeds[new_tts_seed_key]
	if(length(new_sound_effects))
		effects = new_sound_effects

	if(!silent_target && being_changed != chooser && ismob(being_changed))
		SStts_ru.get_tts(
			listener = being_changed,
			message = tts_test_str,
			tts_seed = new_tts_seed,
			is_local = FALSE,
			effect_types = get_effects()
		)

	SStts_ru.get_tts(
		listener = chooser,
		message = tts_test_str,
		tts_seed = new_tts_seed,
		is_local = FALSE,
		effect_types = get_effects()
	)

	return new_tts_seed

/datum/component/tts_component/proc/get_effects(list/additional_effects)
	var/list/resulting_effects = effects.Copy()
	if(length(additional_effects))
		resulting_effects |= additional_effects

	return resulting_effects

/datum/component/tts_component/proc/cast_tts(
	atom/speaker,
	listener,
	message,
	atom/location,
	is_local = TRUE,
	is_radio = FALSE,
	list/additional_effects = list(),
	traits = TTS_TRAIT_RATE_FASTER,
	preSFX,
	postSFX,
	tts_seed_override,
	tts_channel_override,
	check_deafness = TRUE,
	radio_freq
)
	SIGNAL_HANDLER

	if(!message)
		return
	var/volume_preference = is_radio ? /datum/preference/numeric/volume/sound_tts_radio_volume : /datum/preference/numeric/volume/sound_tts_volume
	if(!speaker)
		speaker = parent
	var/list/input_listeners = islist(listener) ? listener : list(listener)
	var/list/tts_listeners = list()
	for(var/mob/current_listener as anything in input_listeners)
		var/datum/preferences/prefs = current_listener?.client?.prefs
		if(prefs?.read_preference(/datum/preference/choiced/sound_tts) != TTS_SOUND_ENABLED || !prefs.read_preference(volume_preference))
			continue
		if(check_deafness && HAS_TRAIT(current_listener, TRAIT_DEAF))
			continue
		if(is_radio && current_listener == speaker && !prefs.read_preference(/datum/preference/toggle/sound_tts_hear_self_radio))
			continue
		tts_listeners += current_listener
	if(!length(tts_listeners))
		return
	additional_effects = isnull(additional_effects) ? list() : additional_effects.Copy()
	if(is_radio)
		additional_effects |= /datum/tts_sound_effect/radio
		if(!location)
			is_local = FALSE
	if(!location)
		location = parent

	var/list/tts_args = list()
	tts_args[TTS_CAST_SPEAKER] = speaker
	tts_args[TTS_CAST_LISTENER] = tts_listeners
	tts_args[TTS_CAST_MESSAGE] = message
	tts_args[TTS_CAST_LOCATION] = location
	tts_args[TTS_CAST_LOCAL] = is_local
	tts_args[TTS_CAST_EFFECTS] = get_effects(additional_effects)
	tts_args[TTS_CAST_TRAITS] = traits
	tts_args[TTS_CAST_PRE_SFX] = preSFX
	tts_args[TTS_CAST_POST_SFX] = postSFX
	tts_args[TTS_CAST_SEED] = tts_seed_override || tts_seed
	tts_args[TTS_CHANNEL_OVERRIDE] = tts_channel_override
	finalize_tts(tts_args)

/datum/component/tts_component/proc/finalize_tts(list/tts_args)
	SEND_SIGNAL(parent, COMSIG_TTS_COMPONENT_PRE_CAST_TTS, tts_args)
	if(!tts_args[TTS_CAST_SEED])
		return

	SStts_ru.get_tts(
		tts_args[TTS_CAST_LOCATION],
		tts_args[TTS_CAST_LISTENER],
		tts_args[TTS_CAST_MESSAGE],
		tts_args[TTS_CAST_SEED],
		tts_args[TTS_CAST_LOCAL],
		tts_args[TTS_CAST_EFFECTS],
		tts_args[TTS_CAST_TRAITS],
		tts_args[TTS_CAST_PRE_SFX],
		tts_args[TTS_CAST_POST_SFX],
		tts_args[TTS_CHANNEL_OVERRIDE]
	)

/datum/component/tts_component/proc/tts_effects_add(atom/user, list/new_sound_effects)
	SIGNAL_HANDLER

	if(!length(new_sound_effects))
		return

	effects |= new_sound_effects

/datum/component/tts_component/proc/tts_effects_remove(atom/user, list/sound_effects_to_remove)
	SIGNAL_HANDLER

	if(!length(sound_effects_to_remove))
		return

	effects -= sound_effects_to_remove
