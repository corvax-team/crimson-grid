/datum/keybinding/client/communication/whisper
	hotkey_keys = list("ShiftT")
	name = WHISPER_CHANNEL
	full_name = "Шёпот"
	keybind_signal = COMSIG_KB_CLIENT_WHISPER_DOWN

/datum/keybinding/client/communication/whisper/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	if(!user.prefs.read_preference(/datum/preference/toggle/tgui_input))
		winset(user, null, "command=[VERB_WHISPER]")
		return TRUE
	winset(user, null, "command=[user.tgui_say_create_open_command(WHISPER_CHANNEL)]")
	winset(user, SKIN_TGUISAY_BROWSER, "focus=true")
	return TRUE

/datum/tgui_say/alter_entry(payload)
	// A whisper cut short does not blurt out the half-typed text
	if(payload["channel"] == WHISPER_CHANNEL)
		return pick(alter_phrases || hurt_phrases)
	return ..()

/datum/tgui_say/delegate_speech(entry, channel)
	if(channel == WHISPER_CHANNEL)
		// whisper() prepends its own "#"; a typed one would double it and turn the whisper into plain speech
		while(copytext(entry, 1, 2) == "#")
			entry = copytext(entry, 2)
		client.mob.whisper_verb(entry)
		return TRUE
	return ..()
