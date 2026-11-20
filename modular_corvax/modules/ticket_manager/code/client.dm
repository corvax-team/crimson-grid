/client
	/// Ticket the ticket manager opens on its next ui_interact
	var/ticket_to_open
	/// Ticket type preselected in the ticket creation window
	var/help_ticket_type_to_create
	/// Cooldown for player ticket response
	COOLDOWN_DECLARE(ticket_response)

/datum/persistent_client
	/// Key of the player, kept while the client is offline
	var/key
	/// Ckey of the player, kept while the client is offline
	var/ckey
	/// The open ticket this player is the subject of
	var/datum/help_ticket/current_help_ticket

/datum/persistent_client/set_client(client/new_client)
	. = ..()
	if(new_client)
		key = new_client.key
		ckey = new_client.ckey

GAME_VERB_DESC(/client, ticket_manager, "Ticket Manager", "Открыть интерфейс админ/ментор тикетов", "Admin")
	GLOB.ticket_manager.ui_interact(mob)

/// Opens the player's current ticket, or the creation window with `ticket_type_id` preselected (null = ask)
/client/proc/open_help_ticket(ticket_type_id)
	if(persistent_client.current_help_ticket)
		ticket_to_open = persistent_client.current_help_ticket.id
		GLOB.ticket_manager.ui_interact(mob)
		return
	help_ticket_type_to_create = ticket_type_id
	GLOB.help_ui_handler.ui_interact(mob)

/// Sends message which bwoinks and also has window flashing effect
/proc/send_adminhelp_message(client/target, message)
	if(isnull(target))
		return
	if(target.prefs.toggles & SOUND_ADMINHELP)
		SEND_SOUND(target, sound('modular_darkpack/master_files/sounds/adminhelp.ogg'))
	window_flash(target, ignorepref = TRUE)
	to_chat(target, message, MESSAGE_TYPE_ADMINPM)

/client/cmd_admin_pm(whom, message)
	if(prefs.muted & MUTE_ADMINHELP)
		to_chat(src, span_danger("Ошибка: Вы не можете использовать ЛС (мут)."), MESSAGE_TYPE_ADMINPM)
		return

	if(!holder)
		if(persistent_client.current_help_ticket)
			open_help_ticket(null)
		else
			to_chat(src, span_danger("У вас нет открытого тикета. Создайте новый через Adminhelp (F1)."), MESSAGE_TYPE_ADMINPM)
		return

	var/client/subject = disambiguate_client(whom)
	if(!istype(subject))
		return

	if(subject.persistent_client.current_help_ticket)
		if(!GLOB.ticket_manager.open_ticket(src, subject.persistent_client.current_help_ticket))
			to_chat(
				src,
				span_danger("Игрок имеет открытый тикет, к которому у вас нет доступа."),
				MESSAGE_TYPE_ADMINPM
			)
		return

	var/message_to_send = tgui_input_text(
		src,
		"Введите сообщения для [subject.ckey]",
		"Личное сообщение",
		multiline = TRUE,
		encode = FALSE,
		ui_state = ADMIN_STATE(R_ADMIN)
	)

	if(!message_to_send)
		return

	// Double check if user created a ticket during PM writing
	if(subject.persistent_client.current_help_ticket)
		if(!GLOB.ticket_manager.open_ticket(src, subject.persistent_client.current_help_ticket, message_to_send))
			to_chat(
				src,
				span_danger("Игрок имеет открытый тикет, к которому у вас нет доступа."),
				MESSAGE_TYPE_ADMINPM
			)
		return

	var/datum/help_ticket/subject_ticket = new(subject, src, message_to_send, TICKET_TYPE_ADMIN)

	message_admins("[key_name_admin(src)] написал личное сообщение [key_name_admin(whom)]. Создан тикет [TICKET_OPEN_LINK(subject_ticket.id, "#[subject_ticket.id]")].")
	log_admin("[key_name(src)] написал личное сообщение [key_name(whom)].")

/// Mentor PM: opens the target's ticket, or starts a mentor ticket with them
/client/proc/open_mentor_ticket_with(whom, message)
	if(!is_mentor())
		if(persistent_client.current_help_ticket)
			open_help_ticket(null)
		return
	if(prefs.muted & MUTE_ADMINHELP)
		to_chat(src, span_danger("Ошибка: Вы не можете использовать ЛС (мут)."), MESSAGE_TYPE_ADMINPM)
		return
	var/client/subject
	if(ismob(whom))
		var/mob/target_mob = whom
		subject = target_mob.client
	else
		subject = disambiguate_client(whom)
	if(!istype(subject))
		return
	if(!message && !subject.persistent_client.current_help_ticket)
		message = tgui_input_text(src, "Введите сообщения для [subject.ckey]", "Личное сообщение", multiline = TRUE, encode = FALSE)
		if(!message || QDELETED(subject))
			return
	var/datum/help_ticket/subject_ticket = subject.persistent_client.current_help_ticket
	if(subject_ticket)
		if(!GLOB.ticket_manager.open_ticket(src, subject_ticket, message))
			to_chat(src, span_danger("Игрок имеет открытый тикет, к которому у вас нет доступа."), MESSAGE_TYPE_ADMINPM)
		return
	subject_ticket = new(subject, src, message, TICKET_TYPE_MENTOR)
	log_mentor("[key_name(src)] написал личное сообщение [key_name(subject)]. Создан тикет #[subject_ticket.id].")
