GLOBAL_VAR(relay_config)

GAME_VERB_DESC(/client, go2relay, "Internet Routing Relays", "Подключиться через один из наших релеев: соединение может стать стабильнее.", "OOC")

	if(is_localhost())
		to_chat(src, span_notice("Вы на локальном сервере, релеи вам ни к чему."))
		return

	if(!length(GLOB.relay_config))
		to_chat(src, span_notice("Список релеев не настроен или пуст."))
		return

	var/list/names = list()
	var/list/name_to_relay = list()

	for(var/list/relay in GLOB.relay_config)
		var/name = relay["name"]
		names += name
		name_to_relay[name] = relay

	var/choice = tgui_input_list(src, "Через какой релей подключиться? Некоторым игрокам релей помогает снизить пинг.", "Выбор релея", names)
	if(!choice)
		to_chat(src, span_notice("Релей не выбран."))
		return

	var/list/relay = name_to_relay[choice]
	if(!relay)
		to_chat(src, span_notice("Такого релея нет."))
		return

	var/address = replacetext(relay["address"], "{port}", "[world.port]")

	var/quickname = relay["quickname"]

	to_chat_immediate(
		target = src,
		html = boxed_message(span_info(span_big("Подключаем вас к [quickname]\nЕсли ничего не происходит, попробуйте подключиться к релею вручную ([address]). Возможно, РЕЛЕЙ сейчас не работает!"))),
		type = MESSAGE_TYPE_INFO,
	)
	DIRECT_OUTPUT(src, link(address))

/datum/controller/configuration/LoadMisc()
	. = ..()
	LoadRelays()

/datum/controller/configuration/proc/LoadRelays()
	var/config_path = "[directory]/relays.toml"
	if(!fexists(file(config_path)))
		log_config("relays.toml does not exist.")
		return

	var/list/result = rustg_raw_read_toml_file(config_path)
	if(!result["success"])
		log_config("Notify Server Operators: The relay config (relays.toml) is not configured correctly! [result["content"]]")
		return

	var/list/content = json_decode(result["content"])
	if(!length(content))
		return

	GLOB.relay_config = content["relay"]
