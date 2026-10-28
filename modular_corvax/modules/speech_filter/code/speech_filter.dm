#define SPEECH_FILTER_FILE "config/crimson/speech_filter.json"

/datum/config_entry/flag/enable_speech_filter

/datum/config_entry/str_list/speech_filter_bypass

/mob/living/Login()
	. = ..()
	AddElement(/datum/element/speech_filter)

/datum/element/speech_filter
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY
	var/static/list/filter_notifications = list(
		"Почему у меня такой скудный словарный запас? Стоит сходить в библиотеку и прочесть книгу...",
		"Что, чёрт побери, я несу?",
		"Я в своём уме? Надо следить за языком.",
		"Неужели я не могу подобрать нужных слов? Позор мне...",
	)

/datum/element/speech_filter/Attach(datum/target)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE
	var/mob/mob_to_censor = target
	if(!mob_to_censor.client)
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(mob_to_censor, COMSIG_MOB_SAY, PROC_REF(filter_speech), TRUE)
	RegisterSignal(mob_to_censor, COMSIG_MOB_LOGOUT, PROC_REF(Detach), TRUE)

/datum/element/speech_filter/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, list(COMSIG_MOB_SAY, COMSIG_MOB_LOGOUT))

/datum/element/speech_filter/proc/filter_speech(mob/speaker, list/speech_args)
	SIGNAL_HANDLER
	if(!CONFIG_GET(flag/enable_speech_filter) || can_bypass_filter(speaker))
		return
	var/message = speech_args[SPEECH_MESSAGE]
	if(!length(message) || message[1] == "*")
		return
	var/regex/filter_regex = get_filter_regex()
	if(!filter_regex)
		return
	var/original_message = message
	message = filter_regex.Replace(message, "цветочек")
	if(original_message == message)
		return
	speech_args[SPEECH_MESSAGE] = message
	addtimer(CALLBACK(speaker, TYPE_PROC_REF(/mob, emote), "drool"), 0.3 SECONDS)
	to_chat(speaker, span_priorityalert(pick(filter_notifications)))
	message_admins("[ADMIN_LOOKUPFLW(speaker)] попытался сказать запрещённое слово: [html_encode(original_message)]")
	log_game("[key_name(speaker)] has attempted to say forbidden word. His message was: [original_message]")

/datum/element/speech_filter/proc/get_filter_regex()
	var/static/regex/filter_regex
	var/static/loaded = FALSE
	if(loaded)
		return filter_regex
	loaded = TRUE
	if(!fexists(SPEECH_FILTER_FILE))
		return
	var/list/parsed_filter = safe_json_decode(file2text(SPEECH_FILTER_FILE))
	if(isnull(parsed_filter))
		log_config("JSON parsing failure for [SPEECH_FILTER_FILE]")
		return
	var/list/patterns = list()
	for(var/pattern in parsed_filter["brainrot_filter"])
		if(length(pattern))
			patterns |= cyrillic_word_boundaries(pattern)
	if(length(patterns))
		filter_regex = regex(patterns.Join("|"), "gi")
	return filter_regex

/// BYOND regex treats only latin letters as word characters, so \b never matches around Russian words
/datum/element/speech_filter/proc/cyrillic_word_boundaries(pattern)
	if(copytext(pattern, 1, 3) == @"\b")
		pattern = @"(?<![\wа-яё])" + copytext(pattern, 3)
	if(copytext(pattern, -2) == @"\b")
		pattern = copytext(pattern, 1, -2) + @"(?![\wа-яё])"
	return "(?:[pattern])"

/datum/element/speech_filter/proc/can_bypass_filter(mob/mob_to_check)
	return mob_to_check.client?.ckey in CONFIG_GET(str_list/speech_filter_bypass)

#undef SPEECH_FILTER_FILE
