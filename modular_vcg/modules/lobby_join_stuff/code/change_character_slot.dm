
/atom/movable/screen/lobby/button/ready/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/dead/new_player/new_player = hud.mymob
	var/client/new_client = new_player?.client
	if(new_client && new_player.ready == PLAYER_READY_TO_PLAY)
		var/highest_job = new_client.prefs.GetHighestJobPreference()
		var/ready_message = "Вы готовитесь к игре за персонажа '[new_client.prefs.read_preference(/datum/preference/name/real_name)]'"
		if(length(highest_job))
			ready_message += ", приоритетная роль: [job_title_ru(highest_job)]"
		to_chat(new_client, span_notice(ready_message))


/datum/preferences/proc/GetHighestJobPreference()
	for(var/job in job_preferences)
		if(job_preferences[job] == JP_HIGH)
			return job

GAME_VERB_DESC(/client, change_character_slot, "Сменить слот персонажа", "Меняет активный слот персонажа. То же самое, что выбрать нужный слот в меню настройки персонажа.", "OOC")
	var/list/characters = prefs.create_character_profiles()
	var/list/options = list()
	var/current_slot

	for(var/i = 1 to length(characters))
		var/name = characters[i]
		if (isnull(name))
			continue

		if(prefs.default_slot == i)
			current_slot = name

		options[name] = i

	if(!length(options))
		to_chat(src, span_warning("У вас нет персонажей."))
		return

	var/choice = tgui_input_list(src, "Выберите слот персонажа", "Смена слота персонажа", options, current_slot)

	if(!choice)
		return

	var/slot = options[choice]
	prefs.save_character()
	prefs.switch_to_slot(slot)
	to_chat(src, span_notice("Выбран персонаж '[choice]'"))

/datum/latejoin_menu/ui_data(mob/user)
	. = ..()
	.["selected_character"] = user.client?.prefs?.read_preference(/datum/preference/name/real_name)

/datum/latejoin_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return TRUE
	switch(action)
		if("change_slot")
			ui.user.client.change_character_slot()
			return TRUE

/mob/dead/get_status_tab_items()
	. = ..()
	if(client?.prefs)
		. += "Выбранный персонаж: [client.prefs.read_preference(/datum/preference/name/real_name)]"
		. += ""
