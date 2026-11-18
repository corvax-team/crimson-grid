/*
 * Emote shortcut buttons above the chat (tgui-panel).
 * Buttons live in the client's hubStorage; the server keeps no state.
 * It only runs the edit dialogs and validates every button press as user input.
 * Entry: list("name", "type" = CHAT_EMOTE_TYPE_*, "key", "text")
 *
 * Protocol:
 * * panel -> server: `emotes/execute` {emote}, `emotes/create` {names},
 *   `emotes/contextAction` {emote, names, canMoveLeft}
 * * server -> panel: `emotes/add` {emote}, `emotes/update` {name, emote},
 *   `emotes/remove` {name}, `emotes/moveLeft` {name}
 */

/// Plain emote by key
#define CHAT_EMOTE_TYPE_EMOTE "emote"
/// Emote by key with custom text; keeps the emote's sound and effects
#define CHAT_EMOTE_TYPE_CUSTOM "custom"
/// Free-form *me
#define CHAT_EMOTE_TYPE_ME "me"

/// Keep in sync with MAX_EMOTES in tgui-panel/emotes/handlers.ts
#define CHAT_EMOTES_MAX 45
#define CHAT_EMOTE_MAX_TEXT_LENGTH 128
#define CHAT_EMOTE_MAX_NAME_LENGTH 32
/// Cooldown for buttons with custom text, against paste spam
#define CHAT_EMOTE_TEXT_COOLDOWN (1 SECONDS)

#define CHAT_EMOTE_ACTION_RENAME "Переименовать"
#define CHAT_EMOTE_ACTION_EDIT_TEXT "Изменить текст"
#define CHAT_EMOTE_ACTION_ADD_TEXT "Добавить текст"
#define CHAT_EMOTE_ACTION_MOVE_LEFT "Сдвинуть влево"
#define CHAT_EMOTE_ACTION_DELETE "Удалить"

/datum/modpack/chat_emotes
	name = "Шорткаты эмоций в чате"
	desc = "Личная панель кнопок-эмоций над чатом."
	author = "Mira (BandaStation), порт Corvax"

/datum/tgui_panel
	COOLDOWN_DECLARE(chat_emote_text_cooldown)
	/// Emote keys that can't be put on a button: picker and press validation both use this
	var/static/list/chat_emote_blacklisted_keys = list("me", "help", "do_emote")

/datum/tgui_panel/on_message(type, payload)
	. = ..()
	if(.)
		return
	switch(type)
		if("emotes/execute")
			// Soft IC filter may prompt the user
			if(islist(payload))
				INVOKE_ASYNC(src, PROC_REF(emotes_execute), payload["emote"])
			return TRUE
		if("emotes/create")
			if(islist(payload))
				INVOKE_ASYNC(src, PROC_REF(emotes_create), payload["names"])
			return TRUE
		if("emotes/contextAction")
			if(islist(payload))
				INVOKE_ASYNC(src, PROC_REF(emotes_context_action), payload["emote"], payload["names"], !!payload["canMoveLeft"])
			return TRUE

/// Validates an entry sent by the client. Returns a clean copy or null. Name is not checked.
/datum/tgui_panel/proc/emotes_validate(list/raw)
	if(!islist(raw))
		return null
	var/emote_type = raw["type"]
	var/key = raw["key"]
	var/text = raw["text"]
	. = list("name" = raw["name"], "type" = emote_type)

	if(emote_type == CHAT_EMOTE_TYPE_EMOTE || emote_type == CHAT_EMOTE_TYPE_CUSTOM)
		if(!istext(key) || (key in chat_emote_blacklisted_keys) || !length(GLOB.emote_list[key]))
			return null
		.["key"] = key
	else if(emote_type != CHAT_EMOTE_TYPE_ME)
		return null

	if(emote_type == CHAT_EMOTE_TYPE_CUSTOM || emote_type == CHAT_EMOTE_TYPE_ME)
		if(!istext(text))
			return null
		text = trim(text)
		if(!length(text) || length_char(text) > CHAT_EMOTE_MAX_TEXT_LENGTH)
			return null
		.["text"] = text

/datum/tgui_panel/proc/emotes_execute(list/raw)
	var/mob/user = client?.mob
	if(!user || !islist(raw))
		return
	var/list/entry = emotes_validate(raw)
	if(!entry)
		to_chat(client, span_warning("Эта кнопка больше не работает. Удалите её через ПКМ."))
		return

	// Same gate as the Say and Me verbs
	if(GLOB.say_disabled)
		to_chat(client, span_danger("Общение было заблокировано администрацией."))
		return

	var/emote_type = entry["type"]
	var/act = emote_type == CHAT_EMOTE_TYPE_ME ? "me" : entry["key"]
	var/message = entry["text"]

	if(message)
		if(!COOLDOWN_FINISHED(src, chat_emote_text_cooldown))
			to_chat(client, span_warning("Не так быстро!"))
			return
		COOLDOWN_START(src, chat_emote_text_cooldown, CHAT_EMOTE_TEXT_COOLDOWN)
		// Same sanitization as the Me verb
		message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
		// *me runs these checks itself; a regular emote with text would skip them
		if(emote_type == CHAT_EMOTE_TYPE_CUSTOM && !emotes_check_custom_text(user, message))
			return
		if(QDELETED(user) || client?.mob != user)
			return

	QUEUE_OR_CALL_VERB_FOR(VERB_CALLBACK(user, TYPE_PROC_REF(/mob, emote), act, NONE, message, TRUE), SSspeech_controller)

/// Free-text restrictions of /datum/emote/living/custom: emote ban, IC mute, IC filters. May sleep.
/datum/tgui_panel/proc/emotes_check_custom_text(mob/user, message)
	if(!isnull(user.ckey) && is_banned_from(user.ckey, "Emote"))
		to_chat(user, span_boldwarning("Вам запрещены собственные эмоции (бан)."))
		return FALSE
	if(client.prefs.muted & MUTE_IC)
		to_chat(user, span_boldwarning("Вы не можете отправлять IC-сообщения (мут)."))
		return FALSE
	var/datum/emote/living/custom/custom_emote = locate() in GLOB.emote_list["me"]
	return custom_emote?.emote_is_valid(user, message)

/// Emotes the current mob can use: "Name (*key)" = emote
/datum/tgui_panel/proc/emotes_pickable(mob/user)
	. = list()
	for(var/key in GLOB.emote_list)
		if(key in chat_emote_blacklisted_keys)
			continue
		for(var/datum/emote/emote in GLOB.emote_list[key])
			if(emote.key != key)
				continue
			if(!emote.can_run_emote(user, status_check = FALSE, intentional = FALSE))
				continue
			.["[emote.name] (*[emote.key])"] = emote
			break
	sortTim(., GLOBAL_PROC_REF(cmp_text_asc))

/datum/tgui_panel/proc/emotes_pick_emote(mob/user)
	var/list/available = emotes_pickable(user)
	if(!length(available))
		to_chat(client, span_warning("Нет доступных эмоций."))
		return null
	var/choice = tgui_input_list(user, "Какую эмоцию добавить?", "Выбор эмоции", available)
	if(!choice || !client)
		return null
	return available[choice]

/datum/tgui_panel/proc/emotes_input_text(mob/user, datum/emote/emote, default = "")
	var/prompt = "Текст эмоции (до [CHAT_EMOTE_MAX_TEXT_LENGTH] символов):"
	if(emote?.message_param)
		prompt = "Эта эмоция принимает уточнение, текст подставится в шаблон \"[emote.message_param]\". Уточнение (до [CHAT_EMOTE_MAX_TEXT_LENGTH] символов):"
	var/text = tgui_input_text(user, prompt, "Текст эмоции", default, CHAT_EMOTE_MAX_TEXT_LENGTH, encode = FALSE)
	text = trim(text)
	return length(text) ? text : null

/// `names` are the client's existing button names, for the uniqueness check
/datum/tgui_panel/proc/emotes_input_name(mob/user, list/names, default = "")
	var/name = tgui_input_text(user, "Название кнопки:", "Название", default, CHAT_EMOTE_MAX_NAME_LENGTH, encode = FALSE)
	if(!name || !client)
		return null
	name = trim(name)
	if(!length(name))
		return null
	if(name in names)
		to_chat(client, span_warning("Кнопка \"[html_encode(name)]\" уже есть!"))
		return null
	return name

/datum/tgui_panel/proc/emotes_create(list/names)
	var/mob/user = client?.mob
	if(!user)
		return
	if(!islist(names))
		names = list()
	// Lobby, ghost and dead mobs have a different emote set than the character
	if(!isliving(user) || user.stat == DEAD)
		to_chat(client, span_warning("Добавлять эмоции можно только играя за живого персонажа."))
		return
	if(length(names) >= CHAT_EMOTES_MAX)
		to_chat(client, span_warning("Достигнут максимум кнопок: [CHAT_EMOTES_MAX]."))
		return

	var/kind = tgui_alert(user, "Какую кнопку добавить?", "Новая эмоция", list("Эмоция", "Эмоция со своим текстом", "*me"))
	if(!kind || !client)
		return

	var/list/entry
	var/suggested_name
	switch(kind)
		if("Эмоция")
			var/datum/emote/emote = emotes_pick_emote(user)
			if(!emote)
				return
			suggested_name = emote.name
			entry = list("type" = CHAT_EMOTE_TYPE_EMOTE, "key" = emote.key)
		if("Эмоция со своим текстом")
			var/datum/emote/emote = emotes_pick_emote(user)
			if(!emote)
				return
			var/text = emotes_input_text(user, emote)
			if(!text || !client)
				return
			suggested_name = emote.name
			entry = list("type" = CHAT_EMOTE_TYPE_CUSTOM, "key" = emote.key, "text" = text)
		if("*me")
			var/text = emotes_input_text(user)
			if(!text || !client)
				return
			suggested_name = copytext_char(text, 1, CHAT_EMOTE_MAX_NAME_LENGTH + 1)
			entry = list("type" = CHAT_EMOTE_TYPE_ME, "text" = text)
	if(!entry)
		return

	var/name = emotes_input_name(user, names, suggested_name)
	if(!name)
		return
	entry["name"] = name
	window.send_message("emotes/add", list("emote" = entry))

/datum/tgui_panel/proc/emotes_context_action(list/raw, list/names, can_move_left)
	var/mob/user = client?.mob
	if(!user || !islist(raw))
		return
	var/name = raw["name"]
	if(!istext(name))
		return
	if(!islist(names))
		names = list()

	// Stale or broken entries (removed emote, blacklisted key) can only be deleted
	var/list/entry = emotes_validate(raw)
	var/list/actions = list()
	if(entry)
		actions += CHAT_EMOTE_ACTION_RENAME
		actions += entry["type"] == CHAT_EMOTE_TYPE_EMOTE ? CHAT_EMOTE_ACTION_ADD_TEXT : CHAT_EMOTE_ACTION_EDIT_TEXT
		if(can_move_left)
			actions += CHAT_EMOTE_ACTION_MOVE_LEFT
	else
		to_chat(client, span_warning("Кнопка \"[html_encode(name)]\" больше не работает, её можно только удалить."))
	actions += CHAT_EMOTE_ACTION_DELETE

	var/action = tgui_input_list(user, "Что сделать с кнопкой \"[html_encode(name)]\"?", "Кнопка эмоции", actions)
	if(!action || !client)
		return

	switch(action)
		if(CHAT_EMOTE_ACTION_RENAME)
			var/new_name = emotes_input_name(user, names, name)
			if(!new_name)
				return
			entry["name"] = new_name
			window.send_message("emotes/update", list("name" = name, "emote" = entry))
		if(CHAT_EMOTE_ACTION_ADD_TEXT, CHAT_EMOTE_ACTION_EDIT_TEXT)
			var/datum/emote/emote = entry["key"] ? GLOB.emote_list[entry["key"]]?[1] : null
			var/text = emotes_input_text(user, emote, entry["text"] || "")
			if(!text || !client)
				return
			entry["text"] = text
			if(entry["type"] == CHAT_EMOTE_TYPE_EMOTE)
				entry["type"] = CHAT_EMOTE_TYPE_CUSTOM
			window.send_message("emotes/update", list("name" = name, "emote" = entry))
		if(CHAT_EMOTE_ACTION_MOVE_LEFT)
			window.send_message("emotes/moveLeft", list("name" = name))
		if(CHAT_EMOTE_ACTION_DELETE)
			if(tgui_alert(user, "Удалить кнопку \"[html_encode(name)]\"?", "Подтверждение", list(CHAT_EMOTE_ACTION_DELETE, "Отмена")) != CHAT_EMOTE_ACTION_DELETE)
				return
			if(!client)
				return
			window.send_message("emotes/remove", list("name" = name))

#undef CHAT_EMOTE_TYPE_EMOTE
#undef CHAT_EMOTE_TYPE_CUSTOM
#undef CHAT_EMOTE_TYPE_ME
#undef CHAT_EMOTES_MAX
#undef CHAT_EMOTE_MAX_TEXT_LENGTH
#undef CHAT_EMOTE_MAX_NAME_LENGTH
#undef CHAT_EMOTE_TEXT_COOLDOWN
#undef CHAT_EMOTE_ACTION_RENAME
#undef CHAT_EMOTE_ACTION_EDIT_TEXT
#undef CHAT_EMOTE_ACTION_ADD_TEXT
#undef CHAT_EMOTE_ACTION_MOVE_LEFT
#undef CHAT_EMOTE_ACTION_DELETE
