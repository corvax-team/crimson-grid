ADMIN_VERB(toggle_canon, R_ADMIN, "Toggle Canon", "Toggle the canon of the round.", ADMIN_CATEGORY_SECOND_CITY)
	GLOB.canon_event = !GLOB.canon_event
	SEND_SOUND(world, sound('modular_darkpack/modules/round_status/sounds/canon.ogg', volume = 25))
	if(GLOB.canon_event)
		to_chat(world, "<b>РАУНД ТЕПЕРЬ КАНОНИЧЕН. ДАННЫЕ БУДУТ СОХРАНЕНЫ.</b>")
	else
		to_chat(world, "<b>РАУНД БОЛЬШЕ НЕ КАНОНИЧЕН. ДАННЫЕ СОХРАНЯТЬСЯ НЕ БУДУТ. ОТЫГРЫШ И ЭСКАЛАЦИЯ ПО-ПРЕЖНЕМУ ОБЯЗАТЕЛЬНЫ.</b>")
	message_admins("[key_name_admin(usr)] toggled the round's canonicity. The round is [GLOB.canon_event ? "now canon." : "no longer canon."]")
	log_admin("[key_name(usr)] toggled the round's canonicity. The round is [GLOB.canon_event ? "now canon." : "no longer canon."]")

	BLACKBOX_LOG_ADMIN_VERB("Toggle Canon")
