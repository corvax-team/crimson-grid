#define TTS_REPLACEMENTS_FILE_PATH "modular_corvax/modules/tts/data/tts_replacements.json"
#define TTS_ACRONYM_REPLACEMENTS "tts_acronym_replacements"
#define TTS_JOB_REPLACEMENTS "tts_job_replacements"

#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDERR 3

#define FILE_CLEANUP_DELAY 30 SECONDS
#define TTS_CLIENT_PLAYBACK_BASE_OFFSET 0.5 SECONDS
#define TTS_CLIENT_PLAYBACK_MAX_PING_OFFSET 3 SECONDS

SUBSYSTEM_DEF(tts_ru)
	name = "Text-to-Speech RU"
	wait = 0.5 SECONDS
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT

	/// All time tts uses
	VAR_PRIVATE/tts_wanted = 0
	/// Amount of errored requests to providers
	VAR_PRIVATE/tts_request_failed = 0
	/// Amount of successfull requests to providers
	VAR_PRIVATE/tts_request_succeeded = 0
	/// Amount of cache hits
	VAR_PRIVATE/tts_reused = 0
	/// Assoc list of request error codes
	VAR_PRIVATE/list/tts_errors = list()
	/// Last errored requests' contents
	VAR_PRIVATE/tts_error_raw = ""

	// Simple Moving Average RPS
	VAR_PRIVATE/list/tts_rps_list = list()
	VAR_PRIVATE/tts_sma_rps = 0

	/// Requests per Second (RPS), only real API requests
	VAR_PRIVATE/tts_rps = 0
	VAR_PRIVATE/tts_rps_counter = 0

	/// Total Requests per Second (TRPS), all TTS request, even reused
	VAR_PRIVATE/tts_trps = 0
	VAR_PRIVATE/tts_trps_counter = 0

	/// Reused Requests per Second (RRPS), only reused requests
	VAR_PRIVATE/tts_rrps = 0
	VAR_PRIVATE/tts_rrps_counter = 0

	var/is_enabled = TRUE
	/// List of all available TTS seeds
	var/list/datum/tts_seed/tts_seeds = list()
	/// List of all available TTS providers
	var/list/datum/tts_provider/tts_providers = list()
	/// Shared sound effect instances: `effect type` => `effect`
	var/list/datum/tts_sound_effect/sound_effects = list()

	VAR_PRIVATE/tts_requests_queue_limit = 100
	VAR_PRIVATE/tts_rps_limit = 11
	VAR_PRIVATE/last_network_fire = 0

	/// General request queue
	VAR_PRIVATE/list/tts_queue = list()
	/// Ffmpeg queue. Is an assoc list. Each entry is a filename mapped to the list of sound processing requests which require it.
	VAR_PRIVATE/list/tts_effects_queue = list()
	/// Lazy list of request that need to performed to TTS provider API
	VAR_PRIVATE/list/tts_requests_queue

	/// List of currently existing binding of atom and sound channel: `atom` => `sound_channel`.
	VAR_PRIVATE/list/tts_local_channels_by_owner = list()

	/// Mapping of BYOND gender to TTS gender
	VAR_PRIVATE/list/gender_table = list(
		NEUTER = TTS_GENDER_ANY,
		PLURAL = TTS_GENDER_ANY,
		MALE = TTS_GENDER_MALE,
		FEMALE = TTS_GENDER_FEMALE
	)
	/// Is debug mode enabled or not. Information about `sanitized_messages_cache_hit` and `sanitized_messages_cache_miss` is printed to debug logs each SS fire
	VAR_PRIVATE/debug_mode_enabled = FALSE
	/// Whether or not caching of sanitized messages is performed
	VAR_PRIVATE/sanitized_messages_caching = TRUE
	/// Amount of message duplicates that were sanitized current SS fire. Debug purpose only
	VAR_PRIVATE/sanitized_messages_cache_hit = 0
	/// Amount of unique messages that were sanitized current SS fire. Debug purpose only
	VAR_PRIVATE/sanitized_messages_cache_miss = 0
	/// List of all messages that were sanitized as: `meesage md5 hash` => `message`
	VAR_PRIVATE/list/sanitized_messages_cache = list()

	/// List of all available TTS seed names
	VAR_PRIVATE/list/tts_seeds_names = list()

	/// List of all tts seeds mapped by TTS gender: `tts gender` => `list of seeds`
	VAR_PRIVATE/list/tts_seeds_by_gender
	/// Replacement map for acronyms for proper TTS spelling. Not private because `replacetext` can use only global procs
	var/list/tts_acronym_replacements
	/// Replacement map for jobs for proper TTS spelling
	VAR_PRIVATE/list/tts_job_replacements

/datum/controller/subsystem/tts_ru/stat_entry(msg)
	msg += "tRPS:[tts_trps] "
	msg += "rRPS:[tts_rrps] "
	msg += "RPS:[tts_rps] "
	msg += "smaRPS:[tts_sma_rps] | "
	msg += "W:[tts_wanted] "
	msg += "F:[tts_request_failed] "
	msg += "S:[tts_request_succeeded] "
	msg += "R:[tts_reused] "
	return ..()

/datum/controller/subsystem/tts_ru/PreInit()
	. = ..()
	for(var/path in subtypesof(/datum/tts_provider))
		var/datum/tts_provider/provider = new path
		tts_providers[provider.name] = provider

	for(var/path in subtypesof(/datum/tts_sound_effect))
		sound_effects[path] = new path

	for(var/path in subtypesof(/datum/tts_seed))
		var/datum/tts_seed/seed = new path
		if(seed.value == "STUB")
			continue
		seed.provider = tts_providers[initial(seed.provider.name)]
		tts_seeds[seed.name] = seed
		tts_seeds_names += seed.name
		LAZYADDASSOCLIST(tts_seeds_by_gender, seed.gender, seed.name)
	tts_seeds_names = sortTim(tts_seeds_names, GLOBAL_PROC_REF(cmp_text_asc))

/datum/controller/subsystem/tts_ru/Initialize()
	if(!CONFIG_GET(flag/tts_enabled))
		is_enabled = FALSE
		return SS_INIT_NO_NEED

	if(!CONFIG_GET(string/tts_api_url_silero))
		is_enabled = FALSE
		log_config("TTS_ENABLED is set, but TTS_API_URL_SILERO is empty. Text-to-speech stays disabled.")
		return SS_INIT_NO_NEED

	load_replacements()

	return SS_INIT_SUCCESS

/datum/controller/subsystem/tts_ru/fire()
	if(last_network_fire + 1 SECONDS <= world.time)
		fire_networking()
	fire_sound_processing()

/datum/controller/subsystem/tts_ru/Recover()
	is_enabled = SStts_ru.is_enabled
	tts_wanted = SStts_ru.tts_wanted
	tts_request_failed = SStts_ru.tts_request_failed
	tts_request_succeeded = SStts_ru.tts_request_succeeded
	tts_reused = SStts_ru.tts_reused
	tts_acronym_replacements = SStts_ru.tts_acronym_replacements
	tts_job_replacements = SStts_ru.tts_job_replacements

/datum/controller/subsystem/tts_ru/proc/fire_networking()
	last_network_fire = world.time

	tts_rps = tts_rps_counter
	tts_rps_counter = 0
	tts_trps = tts_trps_counter
	tts_trps_counter = 0
	tts_rrps = tts_rrps_counter
	tts_rrps_counter = 0

	tts_rps_list += tts_rps
	if(length(tts_rps_list) > 15)
		tts_rps_list.Cut(1, 2)

	var/rps_sum = 0
	for(var/rps in tts_rps_list)
		rps_sum += rps
	tts_sma_rps = round(rps_sum / length(tts_rps_list), 0.1)

	var/free_rps = clamp(tts_rps_limit - tts_rps, 0, tts_rps_limit)
	var/requests_to_send = min(LAZYLEN(tts_requests_queue), free_rps)
	if(requests_to_send)
		var/list/requests = tts_requests_queue.Copy(1, requests_to_send + 1)
		tts_requests_queue.Cut(1, requests_to_send + 1)
		UNSETEMPTY(tts_requests_queue)
		for(var/list/request as anything in requests)
			var/datum/tts_seed/seed = request[2]
			var/datum/tts_provider/provider = seed.provider
			provider.request(request[1], seed, request[3])
			tts_rps_counter++

	if(sanitized_messages_caching)
		sanitized_messages_cache.Cut()
		if(debug_mode_enabled)
			logger.Log(LOG_CATEGORY_DEBUG, "sanitized_messages_cache: HIT=[sanitized_messages_cache_hit] / MISS=[sanitized_messages_cache_miss]")
		sanitized_messages_cache_hit = 0
		sanitized_messages_cache_miss = 0

/datum/controller/subsystem/tts_ru/proc/fire_sound_processing()
	var/queue_position = 1
	while(LAZYLEN(tts_effects_queue) >= queue_position)
		var/filename = tts_effects_queue[queue_position++]
		INVOKE_ASYNC(src, PROC_REF(process_filename_sound_effect_requests), filename)

		if(MC_TICK_CHECK)
			break

	if(queue_position > 1)
		tts_effects_queue.Cut(1, queue_position)

/datum/controller/subsystem/tts_ru/proc/process_filename_sound_effect_requests(filename)
	var/list/filename_requests = tts_effects_queue[filename]
	var/datum/sound_effects_request/request = filename_requests[1]

	if(!apply_sound_effects(request.effects, request.original_filename, request.output_filename))
		return
	if(!CONFIG_GET(flag/tts_cache_enabled))
		addtimer(CALLBACK(src, PROC_REF(cleanup_tts_file), request.output_filename), FILE_CLEANUP_DELAY)

	for(var/datum/sound_effects_request/adjacent_request as anything in filename_requests)
		adjacent_request.cb.InvokeAsync()

/datum/controller/subsystem/tts_ru/proc/load_replacements()
	if(!fexists(TTS_REPLACEMENTS_FILE_PATH))
		logger.Log(LOG_CATEGORY_DEBUG, "No file for TTS replacements located at: [TTS_REPLACEMENTS_FILE_PATH]. No replacements will be applied for TTS.")
		return

	var/tts_replacements_json = file2text(TTS_REPLACEMENTS_FILE_PATH)
	if(!length(tts_replacements_json))
		logger.Log(LOG_CATEGORY_DEBUG, "TTS replacements file is empty at: [TTS_REPLACEMENTS_FILE_PATH].")
		return

	var/list/replacements = json_decode(tts_replacements_json)
	tts_acronym_replacements = replacements[TTS_ACRONYM_REPLACEMENTS]
	tts_job_replacements = replacements[TTS_JOB_REPLACEMENTS]

/datum/controller/subsystem/tts_ru/proc/get_tts(
	atom/speaker,
	listener,
	message,
	datum/tts_seed/tts_seed,
	is_local = TRUE,
	list/effect_types,
	traits = TTS_TRAIT_RATE_MEDIUM,
	preSFX = null,
	postSFX = null,
	channel_override,
)
	set waitfor = FALSE

	if(!is_enabled)
		return
	if(!message)
		return
	var/list/listeners = islist(listener) ? listener : list(listener)
	var/list/valid_listeners = list()
	for(var/mob/current_listener as anything in listeners)
		if(current_listener?.client)
			valid_listeners += current_listener
	if(!length(valid_listeners))
		return
	if(ispath(tts_seed) && tts_seeds[initial(tts_seed.name)])
		tts_seed = tts_seeds[initial(tts_seed.name)]
	if(!istype(tts_seed))
		return

	tts_wanted++
	tts_trps_counter++

	var/datum/tts_provider/provider = tts_seed.provider
	if(!provider.is_enabled)
		return
	if(provider.throttle_check())
		return

	var/text = sanitize_tts_input(message)

	if(!text)
		return

	text = trim(text, MAX_MESSAGE_LEN)

	if(traits & TTS_TRAIT_RATE_FASTER)
		text = provider.rate_faster(text)

	if(traits & TTS_TRAIT_RATE_MEDIUM)
		text = provider.rate_medium(text)

	if(traits & TTS_TRAIT_PITCH_WHISPER)
		text = provider.pitch_whisper(text)

	var/hash = md5(LOWER_TEXT(text))

	var/filename = "data/tts_cache/[tts_seed.value]/[hash]"
	var/list/effect_instances = list()
	for(var/effect_type in effect_types)
		var/datum/tts_sound_effect/effect = sound_effects[effect_type]
		if(effect)
			effect_instances += effect

	if(fexists("[filename].ogg"))
		tts_reused++
		tts_rrps_counter++
		play_tts(speaker, valid_listeners, filename, is_local, effect_instances, preSFX, postSFX, channel_override)
		return

	var/datum/callback/play_tts_cb = CALLBACK(\
		src, PROC_REF(play_tts), speaker, valid_listeners, filename, is_local, effect_instances, preSFX, postSFX, channel_override
	)

	if(LAZYLEN(tts_queue[filename]))
		tts_reused++
		tts_rrps_counter++
		LAZYADD(tts_queue[filename], play_tts_cb)
		return

	queue_request(text, tts_seed, CALLBACK(src, PROC_REF(get_tts_callback), filename, tts_seed))

	LAZYADD(tts_queue[filename], play_tts_cb)

/datum/controller/subsystem/tts_ru/proc/sanitize_tts_input(message)
	var/hash
	if(sanitized_messages_caching)
		hash = md5(LOWER_TEXT(message))
		if(sanitized_messages_cache[hash])
			sanitized_messages_cache_hit++
			return sanitized_messages_cache[hash]
		sanitized_messages_cache_miss++
	. = message
	. = trim(.)
	var/static/regex/punctuation_check = new(@"[.,?!]\Z")
	if(!punctuation_check.Find(.))
		. += "."
	var/static/regex/html_tags = new(@"<[^>]*>", "g")
	. = html_tags.Replace(., "")
	. = html_decode(.)
	var/static/regex/forbidden_symbols = new(@"[^a-zA-Z0-9а-яА-ЯёЁ,!?+./ \r\n\t:()-]", "g")
	. = forbidden_symbols.Replace(., "")
	var/static/regex/acronyms = new(@"(?<![a-zA-Zа-яёА-ЯЁ])[a-zA-Zа-яёА-ЯЁ]+?(?![a-zA-Zа-яёА-ЯЁ])", "gm")
	. = replacetext_char(., acronyms, GLOBAL_PROC_REF(tts_acronym_replacer))

	if(LAZYLEN(tts_job_replacements))
		for(var/job in tts_job_replacements)
			. = replacetext_char(., job, tts_job_replacements[job])
	. = rustutils_latin_to_cyrillic(.)

	var/static/regex/decimals = new(@"-?\d+\.\d+", "g")
	. = replacetext_char(., decimals, GLOBAL_PROC_REF(dec_in_words))

	var/static/regex/numbers = new(@"-?\d+", "g")
	. = replacetext_char(., numbers, GLOBAL_PROC_REF(num_in_words))
	if(sanitized_messages_caching)
		sanitized_messages_cache[hash] = .

/datum/controller/subsystem/tts_ru/proc/queue_request(text, datum/tts_seed/seed, datum/callback/proc_callback)
	if(LAZYLEN(tts_requests_queue) > tts_requests_queue_limit)
		is_enabled = FALSE
		message_admins("Очередь запросов озвучки превысила лимит, подсистема [name] отключена.")
		log_game("TTS request queue exceeded its limit, [name] was disabled.")
		return FALSE

	if(tts_rps_counter < tts_rps_limit)
		var/datum/tts_provider/provider = seed.provider
		provider.request(text, seed, proc_callback)
		tts_rps_counter++
		return TRUE

	LAZYADD(tts_requests_queue, list(list(text, seed, proc_callback)))
	return TRUE

/datum/controller/subsystem/tts_ru/proc/get_tts_callback(filename, datum/tts_seed/seed, datum/http_response/response)
	var/datum/tts_provider/provider = seed.provider

	if(response.errored)
		provider.timed_out_requests++
		tts_queue -= filename
		log_game("Error connecting to [provider.name] TTS API.")
		message_admins("Не удалось подключиться к API озвучки [provider.name].")
		return

	if(response.status_code != 200)
		provider.failed_requests++
		tts_queue -= filename
		log_game("Error performing [provider.name] TTS API request (Code: [response.status_code])")
		message_admins("Ошибка запроса к API озвучки [provider.name] (код: [response.status_code]).")
		tts_request_failed++
		if(response.status_code)
			tts_errors["[response.status_code]"]++
		tts_error_raw = response.error
		return

	tts_request_succeeded++

	var/voice = provider.process_response(response)
	if(!voice)
		tts_queue -= filename
		return

	if(!write_voice_file(voice, filename))
		tts_queue -= filename
		return

	if(!CONFIG_GET(flag/tts_cache_enabled))
		addtimer(CALLBACK(src, PROC_REF(cleanup_tts_file), "[filename].ogg"), FILE_CLEANUP_DELAY)

	for(var/datum/callback/cb in tts_queue[filename])
		cb.InvokeAsync()

	tts_queue -= filename

/datum/controller/subsystem/tts_ru/proc/write_voice_file(voice, filename)
	rustutils_file_write_b64decode(voice, "[filename].ogg")
	if(!fexists("[filename].ogg"))
		log_runtime("TTS: failed to write audio into [filename].ogg")
		return FALSE
	return TRUE

/datum/controller/subsystem/tts_ru/proc/play_tts(
	atom/speaker,
	list/listeners,
	pure_filename,
	is_local = TRUE,
	list/effects,
	preSFX = null,
	postSFX = null,
	channel_override = null,
)
	if(!length(listeners))
		return

	var/list/filename_suffixes = list()
	for(var/datum/tts_sound_effect/effect as anything in effects)
		if(effect.complex)
			filename_suffixes = list(effect.suffix)
			break

		filename_suffixes |= effect.suffix

	sortTim(filename_suffixes, GLOBAL_PROC_REF(cmp_text_asc))

	var/filename2play = "[pure_filename][filename_suffixes.Join()].ogg"

	if(!length(effects) || fexists(filename2play))
		output_tts(speaker, listeners, filename2play, is_local, preSFX, postSFX, channel_override)
		return

	var/datum/callback/output_tts_cb = CALLBACK(src, PROC_REF(output_tts), speaker, listeners, filename2play, is_local, preSFX, postSFX, channel_override)
	queue_sound_effect_processing(pure_filename, effects, filename2play, output_tts_cb)

/datum/controller/subsystem/tts_ru/proc/queue_sound_effect_processing(pure_filename, list/effects, processed_filename, datum/callback/output_tts_cb)
	var/datum/sound_effects_request/request = new("[pure_filename].ogg", processed_filename, output_tts_cb, effects)
	LAZYADD(tts_effects_queue[processed_filename], request)

/datum/controller/subsystem/tts_ru/proc/output_tts(
	atom/speaker,
	list/listeners,
	filename2play,
	is_local = TRUE,
	preSFX = null,
	postSFX = null,
	channel_override = null,
)
	var/channel_volume_preference_path = get_volume_preference_for_channel(channel_override)
	var/list/valid_listeners = list()
	var/highest_ping = 0
	for(var/mob/listener as anything in listeners)
		var/client/listener_client = listener?.client
		if(!listener_client?.prefs?.read_preference(channel_volume_preference_path))
			continue
		valid_listeners += listener
		highest_ping = max(highest_ping, listener_client.avgping || listener_client.lastping)
	if(!length(valid_listeners))
		return

	var/turf/turf_source = get_turf(speaker)

	var/sound/output = sound(filename2play)
	output.status = SOUND_STREAM
	if(!is_local || isnull(speaker))
		output.wait = TRUE
		output.environment = SOUND_ENVIRONMENT_NONE
		output.channel = channel_override
		for(var/mob/listener as anything in valid_listeners)
			output.volume = listener.client.prefs.read_preference(channel_volume_preference_path)
			play_sfx_if_exists(listener, preSFX, output)
			SEND_SOUND(listener, output)
			play_sfx_if_exists(listener, postSFX, output)
		return

	if(!turf_source)
		return

	for(var/mob/listener as anything in valid_listeners)
		output.volume = listener.client.prefs.read_preference(channel_volume_preference_path)
		play_sfx_if_exists(listener, preSFX, output)

	output.volume = 100
	var/list/threed_listeners = valid_listeners
	var/mob/self_listener
	if(ismob(speaker))
		var/mob/speaking_mob = speaker
		if(speaking_mob in valid_listeners)
			self_listener = speaking_mob
			threed_listeners = valid_listeners.Copy()
			threed_listeners -= self_listener
		if(speaking_mob.client)
			output.channel = get_local_channel_by_owner(speaker)
			output.wait = TRUE
	var/reserved_channel
	if(!output.channel)
		reserved_channel = SSsounds.reserve_sound_channel()
		output.channel = reserved_channel || SSsounds.random_available_channel()
	var/sound_length = SSsounds.get_sound_length(filename2play) || FILE_CLEANUP_DELAY
	var/client_playback_offset = TTS_CLIENT_PLAYBACK_BASE_OFFSET + min(ceil(highest_ping / 100), TTS_CLIENT_PLAYBACK_MAX_PING_OFFSET)

	if(self_listener)
		self_listener.playsound_local(
			turf_source,
			vol = 100,
			falloff_exponent = SOUND_FALLOFF_EXPONENT,
			channel = output.channel,
			pressure_affected = TRUE,
			sound_to_use = output,
			max_distance = SOUND_RANGE,
			falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE,
			distance_multiplier = 1,
			use_reverb = TRUE,
			volume_preference = channel_volume_preference_path
		)

	if(length(threed_listeners))
		new /datum/threed_sound(
			speaker,
			output,
			threed_listeners,
			volume = 100,
			sound_range = SOUND_RANGE,
			sound_length = sound_length + client_playback_offset,
			channel = output.channel,
			preference_volume = channel_volume_preference_path,
			preference_signal = channel_override == CHANNEL_TTS_RADIO ? COMSIG_MOB_TTS_RADIO_VOLUME_PREFERENCE_APPLIED : COMSIG_MOB_TTS_VOLUME_PREFERENCE_APPLIED,
			falloff_exponent = SOUND_FALLOFF_EXPONENT,
			falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE,
			pressure_affected = TRUE
		)
	if(reserved_channel)
		addtimer(CALLBACK(SSsounds, TYPE_PROC_REF(/datum/controller/subsystem/sounds, free_sound_channel), reserved_channel), sound_length + client_playback_offset, TIMER_DELETE_ME)

	if(postSFX)
		for(var/mob/listener as anything in valid_listeners)
			play_sfx(listener, postSFX, listener.client.prefs.read_preference(channel_volume_preference_path), output.environment, output.channel)

/datum/controller/subsystem/tts_ru/proc/get_volume_preference_for_channel(channel_override)
	if(channel_override == CHANNEL_TTS_RADIO)
		return /datum/preference/numeric/volume/sound_tts_radio_volume
	return /datum/preference/numeric/volume/sound_tts_volume

/datum/controller/subsystem/tts_ru/proc/play_sfx_if_exists(mob/listener, sfx, sound/output)
	if(sfx)
		play_sfx(listener, sfx, output.volume, output.environment, output.channel)

/datum/controller/subsystem/tts_ru/proc/play_sfx(mob/listener, sfx, volume, environment, channel)
	var/sound/output = sound(sfx)
	output.status = SOUND_STREAM
	output.wait = TRUE
	output.volume = volume
	output.environment = environment
	output.channel = channel
	SEND_SOUND(listener, output)

/datum/controller/subsystem/tts_ru/proc/get_local_channel_by_owner(owner)
	var/channel = tts_local_channels_by_owner[owner]
	if(isnull(channel))
		channel = SSsounds.reserve_sound_channel()
		if(!channel)
			return null
		tts_local_channels_by_owner[owner] = channel
		RegisterSignal(owner, COMSIG_QDELETING, PROC_REF(clear_channel))
	return channel

/datum/controller/subsystem/tts_ru/proc/clear_channel(owner)
	SIGNAL_HANDLER

	var/channel = tts_local_channels_by_owner[owner]
	if(channel)
		SSsounds.free_sound_channel(channel)
	tts_local_channels_by_owner -= owner

/datum/controller/subsystem/tts_ru/proc/cleanup_tts_file(filename)
	fdel(filename)

/datum/controller/subsystem/tts_ru/proc/get_random_seed()
	return pick(tts_seeds_names)

/datum/controller/subsystem/tts_ru/proc/get_tts_by_gender(gender)
	return LAZYACCESS(tts_seeds_by_gender, get_tts_gender(gender))

/datum/controller/subsystem/tts_ru/proc/get_tts_gender(gender)
	var/tts_gender = gender_table[gender]
	if(!tts_gender)
		log_runtime("No mapping found for gender `[gender]` in `SStts_ru.gender_table`")
		return TTS_GENDER_ANY

	return tts_gender

/datum/controller/subsystem/tts_ru/proc/pick_tts_seed_by_gender(gender)
	var/list/tts_by_gender = get_tts_by_gender(gender)
	if(!length(tts_by_gender))
		tts_by_gender = LAZYACCESS(tts_seeds_by_gender, TTS_GENDER_ANY)

	if(!length(tts_by_gender))
		logger.Log(LOG_CATEGORY_DEBUG, "No tts for gender `[gender]`")
		return null

	return pick(tts_by_gender)

/// Global because `replacetext` can't call non-global procs
/proc/tts_acronym_replacer(word)
	if(!word || !LAZYLEN(SStts_ru.tts_acronym_replacements))
		return word

	var/match = SStts_ru.tts_acronym_replacements[LOWER_TEXT(word)]
	return match || word

/datum/sound_effects_request
	var/original_filename
	var/output_filename
	var/datum/callback/cb
	var/list/effects = list()

/datum/sound_effects_request/New(original_filename, output_filename, datum/callback/cb, list/effects)
	src.original_filename = original_filename
	src.output_filename = output_filename
	src.cb = cb
	if(length(effects))
		src.effects |= effects

#undef TTS_REPLACEMENTS_FILE_PATH
#undef TTS_ACRONYM_REPLACEMENTS
#undef TTS_JOB_REPLACEMENTS

#undef SHELLEO_ERRORLEVEL
#undef SHELLEO_STDERR

#undef FILE_CLEANUP_DELAY
#undef TTS_CLIENT_PLAYBACK_BASE_OFFSET
#undef TTS_CLIENT_PLAYBACK_MAX_PING_OFFSET
