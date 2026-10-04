GAME_VERB_DESC(/mob/living/carbon/human, set_custom_examine_text, "Set Custom Examine Text", "Задать текст, который увидят при осмотре: чем ваш персонаж занят прямо сейчас.", "IC")
	var/new_text = tgui_input_text(src, "Чем ваш персонаж занят прямо сейчас? Этот текст увидят при осмотре.", "Текст при осмотре", custom_examine_message, MAX_MESSAGE_LEN, TRUE)

	custom_examine_message = new_text
