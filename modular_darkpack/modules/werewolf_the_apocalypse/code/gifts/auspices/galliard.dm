/datum/action/cooldown/power/gift/beast_speech
	name = "Язык зверей"
	desc = "Владеющий этим Даром оборотень способен говорить с любыми животными, от рыб до зверей."
	button_icon_state = "beast_speech"
	rank = 1
	rage_cost = 1
	//gnosis_cost = 1

// Extreamly TTRPG innacurate.
/datum/action/cooldown/power/gift/beast_speech/Activate(atom/target)
	. = ..()

	var/mob/living/carbon/human/human_owner = astype(owner)
	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/wolves.ogg', 75, FALSE)
	human_owner?.add_beastmaster_minion(/mob/living/basic/pet/dog/wolf/summoned)


/datum/action/cooldown/power/gift/call_of_the_wyld
	name = "Зов Вильда"
	desc = "Вой оборотня разносится далеко за пределы обычной слышимости и полон такого чувства, что у собратьев-гару вскипает кровь, а у всех прочих она стынет в жилах."
	button_icon_state = "call_of_the_wyld"
	rage_cost = 1
	rank = 1

/datum/action/cooldown/power/gift/call_of_the_wyld/Activate(atom/target)
	. = ..()

	owner.emote("howl")
	for(var/mob/living/carbon/human/guy in orange(7, owner))
		var/datum/splat/werewolf/werewolf_splat = get_werewolf_splat(guy)
		if(werewolf_splat)
			guy.emote("howl")
			werewolf_splat.adjust_gnosis(1)
//	awo1


// Very inaccurate right now
/datum/action/cooldown/power/gift/mindspeak
	name = "Мысленная речь"
	desc = "Призвав силу снов наяву, гару связывает избранных безмолвным общением."
	button_icon_state = "mindspeak"
	rank = 1
//	gnosis_cost = 1


/datum/action/cooldown/power/gift/mindspeak/Activate(atom/target)
	. = ..()
	var/input = tgui_input_text(usr, "Что вы хотите передать своему племени?", name, max_length = MAX_MESSAGE_LEN)
	if(!input || !IsAvailable(feedback = TRUE))
		return

	var/list/filter_result = CAN_BYPASS_FILTER(usr) ? null : is_ic_filtered(input)
	if(filter_result)
		REPORT_CHAT_FILTER_TO_USER(usr, filter_result)
		return

	var/list/soft_filter_result = CAN_BYPASS_FILTER(usr) ? null : is_soft_ic_filtered(input)
	if(soft_filter_result)
		if(tgui_alert(usr,"В вашем сообщении есть \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\". Вы точно хотите это сказать?", "Нежелательное слово", list("Да", "Нет")) != "Да")
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[html_encode(input)]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[input]\"")
	commune_tribe(usr, input)

/datum/action/cooldown/power/gift/mindspeak/proc/commune_tribe(mob/living/user, message)
	var/my_message
	if(!message || !user.mind)
		return

	my_message = "<b>[findtextEx(user.name, user.real_name) ? user.name : "[user.real_name] (под именем [user.name])"]:</b> [message]"
	var/datum/splat/werewolf/our_splat = get_werewolf_splat(user)
	if(!our_splat?.tribe)
		return
	for(var/mob/living/listener in viewers(9, owner))
		var/datum/splat/werewolf/listener_splat = get_werewolf_splat(listener)
		if(listener == user)
			to_chat(user, "Вы мысленно передаёте соплеменникам поблизости: <b>[message]</b>", type = MESSAGE_TYPE_RADIO, avoid_highlighting = TRUE)
		else if(listener_splat?.tribe?.name == our_splat.tribe.name)
			to_chat(listener, "В вашей голове звучит чужой голос... <b>[message]</b>", type = MESSAGE_TYPE_RADIO)

	for(var/mob/listener in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(listener, user)
		to_chat(listener, "[link] [my_message]", type = MESSAGE_TYPE_RADIO)
