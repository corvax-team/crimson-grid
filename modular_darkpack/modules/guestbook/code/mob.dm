///Shows guestbook tgui window
GAME_VERB_DESC(/mob, guestbook, "Список знакомых", "Посмотреть, кого знает ваш персонаж.", "IC")
	if(!mind)
		var/fail_message = "У вас нет разума!"
		if(isobserver(src))
			fail_message += " Чтобы он появился, нужно хотя бы раз войти в текущий раунд."
		to_chat(src, span_warning(fail_message))
		return
	mind.guestbook.ui_interact(usr)
