/datum/help_ticket
	/// Unique ID of the ticket
	var/id
	/// Name used for stat panel
	var/stat_name
	/// The current state of the ticket
	var/state = TICKET_OPEN
	/// Ticket type id. Used for sorting Admin/Mentor tickets.
	var/ticket_type_id
	/// Hidden type. Used for chat messages
	var/ticket_type_hidden = TICKET_TYPE_HIDDEN_TICKET
	/// The time at which the ticket was opened
	var/opened_at
	/// The time at which the ticket was closed
	var/closed_at
	/// Initiator key name
	var/initiator
	/// Initiator key. More stable
	var/initiator_key
	/// Fields SSplexora reads off a ticket (it was written against /datum/admin_help)
	var/name
	var/initiator_ckey
	var/initiator_key_name
	/// Whether Plexora has been told about this ticket
	var/plexora_announced = FALSE
	/// Replies the player may still send to staff answering from outside the game
	var/external_replies_left = 0
	/// Has the admin replied to this ticket yet?
	var/admin_replied = FALSE
	/// ID for the autoclose timer
	var/ticket_autoclose_timer_id
	/// It's the person who ahelped/was bwoinked
	var/datum/persistent_client/initiator_client
	/// It's admin who linked to current ticket
	var/datum/persistent_client/linked_admin
	/// Cached ticket type datum instance
	var/datum/help_ticket_type/ticket_type
	/// List of all client keys who currently write to this ticket
	var/list/writers = list()
	/// Collection of all ticket messages
	var/list/messages
	/// Static counter used for generating each ticket ID
	var/static/ticket_counter = 0
	/// No active admin was in the game when this ticket was opened, so it was relayed outside
	var/heard_by_no_admins = FALSE
	/// The adminhelp webhook was told about this ticket and has not yet heard that somebody took it
	var/webhook_sent = FALSE
	/// Prevents convert spam
	COOLDOWN_DECLARE(convert_cooldown)

/datum/help_ticket/New(client/creator, client/admin, message, ticket_type_id)
	if(!message || !creator || !creator.mob)
		qdel(src)
		CRASH("Tried to create a ticket with invalid arguments!")

	stat_name = sanitize(trim(message, TICKET_STAT_PANEL_MESSAGE_MAX_LENGTH))
	if(length(message) > TICKET_STAT_PANEL_MESSAGE_MAX_LENGTH)
		stat_name += "..."

	id = ++ticket_counter
	opened_at = TICKET_TIMESTAMP()
	initiator_client = creator.persistent_client
	initiator = key_name(creator)
	initiator_key = creator.key
	name = stat_name
	initiator_ckey = creator.ckey
	initiator_key_name = initiator
	set_ticket_type_id(ticket_type_id)
	messages = list(list(
		"sender" = admin ? admin.key : initiator_key,
		"message" = emoji_parse(message),
		"time" = opened_at,
	))

	if(initiator_client.current_help_ticket) //This is a bug
		stack_trace("Multiple help tickets opened by a single player!")
		GLOB.ticket_manager.set_ticket_state(null, initiator_client.current_help_ticket, TICKET_CLOSED)

	initiator_client.current_help_ticket = src
	GLOB.ticket_manager.all_tickets[id] = src
	SStgui.update_uis(GLOB.ticket_manager)

	if(admin)
		admin_replied = TRUE
		linked_admin = admin.persistent_client
		ticket_type_hidden = TICKET_TYPE_HIDDEN_PM
		GLOB.ticket_manager.send_chat_message_to_player(admin, src, message)
	else
		send_creation_message(creator, message, ticket_type_id)
		ticket_autoclose_timer_id = addtimer(CALLBACK(GLOB.ticket_manager, TYPE_PROC_REF(/datum/ticket_manager, autoclose_ticket), src), TICKET_AUTOCLOSE_TIMER, TIMER_STOPPABLE)
		if(ticket_type_id == TICKET_TYPE_ADMIN)
			notify_external_admin_chat(message)

	if(ticket_type_id == TICKET_TYPE_ADMIN)
		plexora_announced = TRUE
		SSplexora.aticket_new(src, message, !isnull(admin), FALSE, admin?.ckey)
	SSblackbox.LogAhelp(id, TICKET_AHELP_ACTION_OPENED, message, null, initiator_key)

/// Relays a new ticket nobody in the game can take to TGS chat and the adminhelp webhook, as /datum/admin_help did
/datum/help_ticket/proc/notify_external_admin_chat(message)
	var/admin_number_present = send2tgs_adminless_only(initiator_ckey, "Ticket #[id]: [message]")
	log_admin_private("Ticket #[id]: [initiator_key_name]: [name] - heard by [admin_number_present] non-AFK admins who have +BAN.")
	if(admin_number_present > 0)
		return

	heard_by_no_admins = TRUE
	to_chat(get_initiator_client(), span_notice("Сейчас в игре нет активных администраторов: ваш тикет отправлен тем, кто доступен в Discord."), MESSAGE_TYPE_ADMINPM)
	if(!CONFIG_GET(string/regular_adminhelp_webhook_url))
		return

	var/datum/discord_embed/embed = build_webhook_embed()
	embed.description = "<byond://[world.internet_address]:[world.port]>"
	embed.author = initiator_key_name
	embed.content = CONFIG_GET(string/ahelp_message)
	embed.footer = "This player sent an ahelp when no admins are available"

	var/round_state
	switch(SSticker.current_state)
		if(GAME_STATE_STARTUP, GAME_STATE_PREGAME, GAME_STATE_SETTING_UP)
			round_state = "Round has not started"
		if(GAME_STATE_PLAYING)
			round_state = "Round is ongoing."
		if(GAME_STATE_FINISHED)
			round_state = "Round has ended"
	var/list/admin_counts = get_admin_counts(R_BAN)
	var/stealth_admins = jointext(admin_counts["stealth"], ", ")
	var/afk_admins = jointext(admin_counts["afk"], ", ")
	var/other_admins = jointext(admin_counts["noflags"], ", ")
	var/admin_text = ""
	if(stealth_admins)
		admin_text += "**Stealthed**: [stealth_admins]\n"
	if(afk_admins)
		admin_text += "**AFK**: [afk_admins]\n"
	if(other_admins)
		admin_text += "**Lacks +BAN**: [other_admins]\n"
	embed.fields = list(
		"CKEY" = initiator_ckey,
		"PLAYERS" = "**Total**: [length(GLOB.clients)], **Living**: [length(GLOB.alive_player_list)], **Dead**: [length(GLOB.dead_player_list)], **Observers**: [length(GLOB.current_observers_list)]",
		"ROUND STATE" = round_state,
		"ROUND ID" = GLOB.round_id,
		"ROUND TIME" = round_timestamp(),
		"MESSAGE" = message,
		"ADMINS" = admin_text,
	)
	send2adminchat_webhook(embed, urgent = FALSE)
	webhook_sent = TRUE

/// Tells the outside admin chat that a ticket it was asked about has been picked up. `what_happened` is plain text.
/datum/help_ticket/proc/notify_external_admin_chat_handled(what_happened)
	if(heard_by_no_admins)
		heard_by_no_admins = FALSE
		send2adminchat(initiator_ckey, "Ticket #[id]: [what_happened]")
	if(!webhook_sent)
		return

	webhook_sent = FALSE
	var/datum/discord_embed/embed = build_webhook_embed()
	embed.description = what_happened
	send2adminchat_webhook(embed, urgent = FALSE)

/datum/help_ticket/proc/build_webhook_embed()
	var/datum/discord_embed/embed = new()
	embed.title = "Ticket #[id]"
	if(CONFIG_GET(string/adminhelp_ahelp_link))
		embed.url = replacetext(replacetext(CONFIG_GET(string/adminhelp_ahelp_link), "$RID", GLOB.round_id), "$TID", "[id]")
	return embed

/datum/help_ticket/ui_data(mob/user)
	var/list/data = list()
	data["number"] = id
	data["state"] = state
	data["type"] = ticket_type_id
	data["initiator"] = initiator
	data["openedTime"] = opened_at
	data["closedTime"] = closed_at
	data["linkedAdmin"] = !!linked_admin || external_replies_left > 0
	data["writers"] = writers
	data["messages"] = messages
	data["userHasStaffAccess"] = has_staff_access(user.client)
	data["isLinkedToCurrentAdmin"] = linked_admin?.client == user.client
	if(check_rights_for(user.client, R_ADMIN))
		data["character"] = get_character_summary()
	return data

/// What the initiator is currently playing, for the admin view. Null while they have no living body.
/datum/help_ticket/proc/get_character_summary()
	var/mob/living/character = initiator_client?.mob
	if(!istype(character))
		return null

	var/breaches = 0
	for(var/list/masquerade_breach as anything in SSmasquerade.masquerade_breachers)
		if(masquerade_breach[1] == character)
			breaches++

	var/datum/splat/vampire/kindred/kindred = get_kindred_splat(character)
	return list(
		"splat" = character.get_primary_splat()?.name,
		"clan" = kindred?.clan?.name,
		"generation" = kindred?.generation,
		"breaches" = breaches,
	)

/// Notifies the staff about the new ticket, and sends a creation confirmation to the creator
/datum/help_ticket/proc/send_creation_message(client/creator, message)
	var/text_span_class = get_text_span_class()
	var/boxed_message_class = get_boxed_message_class()

	var/title = span_class(text_span_class, "Тикет #[id]")
	var/body = "[TICKET_REPLY_LINK(id, initiator)]\n\n[span_class(get_text_span_class(), (sanitize(trim(message))))]"
	for(var/client/admin as anything in GLOB.ticket_manager.get_staff_clients())
		if(!has_staff_access(admin))
			continue


		var/ticket_body_actions = check_rights_for(admin, R_ADMIN) ? TICKET_ADMIN(creator.mob, id) : TICKET_MENTOR(creator.mob, id)
		send_adminhelp_message(
			admin,
			fieldset_block(\
				title, \
				"[body]\n\n[ticket_body_actions]", \
				"boxed_message [boxed_message_class]" \
			)
		)

	to_chat(
		creator,
		custom_boxed_message("[boxed_message_class]", span_class(text_span_class, "[title] был создан! Ожидайте ответ. Вы можете открыть тикет нажав F1")),
		MESSAGE_TYPE_ADMINPM
	)

/// Converts ticket to ticket type specified `type_to_convert_to`
/datum/help_ticket/proc/convert(client/converter)
	if(!has_staff_access(converter))
		message_admins("[key_name_admin(converter)] попытался конвертировать тикет #[id] не имея прав доступа.")
		log_admin("[key_name(converter)] попытался конвертировать тикет #[id] не имея прав доступа.")
		return FALSE

	var/type_to_convert_to = type_to_convert_to()
	if(!type_to_convert_to)
		to_chat(
			converter,
			span_danger("Тикет `[id]` не может быть конвертирован."),
			MESSAGE_TYPE_ADMINPM
		)
		return FALSE

	if(!isnull(linked_admin))
		unlink_linked_admin()

	set_ticket_type_id(type_to_convert_to)
	if(ticket_type_id == TICKET_TYPE_ADMIN)
		if(plexora_announced)
			SSplexora.aticket_reopened(src, converter.ckey)
		else
			plexora_announced = TRUE
			SSplexora.aticket_new(src, messages[1]["message"], FALSE, FALSE)
	else if(plexora_announced)
		SSplexora.aticket_closed(src, converter.ckey, AHELP_CLOSETYPE_CLOSE, AHELP_CLOSEREASON_MENTOR)

	message_admins("[key_name_admin(converter)] конвертировал тикет #[id] в [ticket_type_id].")
	log_admin("[key_name(converter)] конвертировал тикет #[id] в [ticket_type_id].")

	var/boxed_message_class = get_boxed_message_class()
	var/text_span_class = get_text_span_class()

	var/ticket_converted_message = custom_boxed_message(\
		"[boxed_message_class]", \
		span_class(text_span_class, "[key_name_admin(converter)] конвертировал тикет [TICKET_OPEN_LINK(id, "#[id]")] в [ticket_type_id].") \
	)
	for(var/client/admin as anything in GLOB.ticket_manager.get_staff_clients())
		if(admin == converter || !has_staff_access(admin))
			continue

		send_adminhelp_message(admin, ticket_converted_message)

	messages += list(list(
		"sender" = TICKET_LOG_SENDER_ADMIN_TICKET_LOG,
		"message" = "[converter.ckey] конвертировал тикет в [ticket_type_id]",
		"time" = TICKET_TIMESTAMP(),
	))
	SSblackbox.LogAhelp(id, TICKET_AHELP_ACTION_CONVERT, "[converter.ckey] converted ticket to [ticket_type_id]", initiator_key, converter.ckey)

	return TRUE

/// Sets `ticket_type_id` and and updates `ticket_type` variable
/datum/help_ticket/proc/set_ticket_type_id(new_ticket_type_id)
	ticket_type_id = new_ticket_type_id
	ticket_type = GLOB.help_ticket_types[ticket_type_id]
	return ticket_type

/// Return actual client of `initiator_client` persistent client
/datum/help_ticket/proc/get_initiator_client()
	return initiator_client?.client

/// Links passed admin to the ticket, if required permissions are present
/datum/help_ticket/proc/link_admin(client/admin)
	if(!isnull(linked_admin))
		return FALSE

	if(!has_user_access(admin))
		message_admins(
			"[key_name_admin(admin)] попытался взять тикет #[id], не имея прав доступа к нему!"
		)

		stack_trace("Tried to link admin to ticket without required rights!")
		return FALSE

	linked_admin = admin.persistent_client
	deltimer(ticket_autoclose_timer_id)
	ticket_autoclose_timer_id = addtimer(CALLBACK(GLOB.ticket_manager, TYPE_PROC_REF(/datum/ticket_manager, autoclose_ticket), src), TICKET_AUTOCLOSE_TIMER, TIMER_STOPPABLE)
	message_admins("[key_name_admin(admin)] взял тикет #[id] на рассмотрение.")
	log_admin("[key_name_admin(admin)] взял тикет #[id] на рассмотрение.")
	return TRUE

/// Unlnks `linked_admin` from the ticket,
/// start autoclosure timer and notifies responsible admins
/datum/help_ticket/proc/unlink_linked_admin()
	var/autoclose_delay = TICKET_AUTOCLOSE_TIMER / 2
	deltimer(ticket_autoclose_timer_id)

	ticket_autoclose_timer_id = addtimer(\
		CALLBACK(GLOB.ticket_manager, TYPE_PROC_REF(/datum/ticket_manager, autoclose_ticket), src), \
		autoclose_delay, \
		TIMER_STOPPABLE \
	)

	var/client/initiator = get_initiator_client()
	if(initiator)
		var/chat_message = custom_boxed_message(\
			"[get_boxed_message_class()]",\
			span_class(\
				get_text_span_class(), \
				("[linked_admin.key] отказался от вашего тикета. Ожидайте другого администратора. Если никто не ответит на ваш тикет, он автоматически закроется через [autoclose_delay / (1 SECONDS)] секунд.") \
			) \
		)

		to_chat(initiator, chat_message, MESSAGE_TYPE_ADMINPM)

	messages += list(list(
		"sender" = TICKET_LOG_SENDER_ADMIN_TICKET_LOG,
		"message" = "[linked_admin.key] отказался от тикета",
		"time" = TICKET_TIMESTAMP(),
	))
	SSblackbox.LogAhelp(id, TICKET_AHELP_ACTION_UNASSIGNED, "[linked_admin.key] refused ticket", initiator_key, linked_admin.ckey)

	linked_admin = null

	return TRUE

/// Checks if the ticket can be viewed and interacted by passed `target`
/datum/help_ticket/proc/has_user_access(client/target)
	return has_staff_access(target) || initiator_key == target?.key

/// Checks if the ticket can be converted by passed `target`
/datum/help_ticket/proc/has_staff_access(client/target)
	return !!get_ticket_type()?.is_staff(target)

/// Returns type this help ticket can be converted to
/datum/help_ticket/proc/type_to_convert_to()
	return get_ticket_type()?.type_to_convert_to

/// Returns ticket type datum instance
/datum/help_ticket/proc/get_ticket_type() as /datum/help_ticket_type
	if(isnull(ticket_type))
		ticket_type = GLOB.help_ticket_types[ticket_type_id]

		if(isnull(ticket_type))
			stack_trace("ticket `[id]` without valid ticket type `[ticket_type_id]`")
			return null

	return ticket_type

/// Returns boxed messaged class for this ticket
/datum/help_ticket/proc/get_boxed_message_class()
	return get_ticket_type()?.boxed_message_class || /datum/help_ticket_type::boxed_message_class

/// Returns boxed messaged class for this ticket
/datum/help_ticket/proc/get_text_span_class()
	return get_ticket_type()?.text_span_class || /datum/help_ticket_type::text_span_class
