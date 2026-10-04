/proc/toggle_looc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling ooc
		if(toggle != GLOB.ooc_allowed)
			GLOB.looc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.looc_allowed = !GLOB.looc_allowed
	to_chat(world, span_oocplain("<B>LOOC [GLOB.looc_allowed ? "включён" : "отключён"] для всех.</B>"))

ADMIN_VERB(toggle_looc, R_ADMIN, "Toggle LOOC", "Toggle local OOC on or off.", ADMIN_CATEGORY_SERVER)
	toggle_looc()
	log_admin("[key_name(user)] toggled LOOC.")
	message_admins("[key_name_admin(user)] toggled LOOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle LOOC", "[GLOB.looc_allowed ? "Enabled" : "Disabled"]"))
