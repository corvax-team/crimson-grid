GAME_VERB_DESC(/client, open_character_preferences, "Open Character Preferences", "Открыть настройки персонажа", "OOC")

	if(!prefs)
		return
	prefs.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
	prefs.update_static_data(usr)
	prefs.ui_interact(usr)

GAME_VERB_DESC(/client, open_game_preferences, "Open Game Preferences", "Открыть настройки игры", "OOC")

	if(!prefs)
		return
	prefs.current_window = PREFERENCE_TAB_GAME_PREFERENCES
	prefs.update_static_data(usr)
	prefs.ui_interact(usr)

