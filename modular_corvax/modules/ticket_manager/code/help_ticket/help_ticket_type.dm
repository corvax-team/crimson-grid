GLOBAL_LIST_INIT_TYPED(help_ticket_types, /datum/help_ticket_type, initialize_help_ticket_types())

/proc/initialize_help_ticket_types()
	var/list/help_ticket_types = list()
	for(var/datum/help_ticket_type/path as anything in subtypesof(/datum/help_ticket_type))
		help_ticket_types[path::id] = new path

	return help_ticket_types

/datum/help_ticket_type
	/// Ticket type id. Used in `/datum/help_ticket`
	var/id = "no id"
	/// Ticket type name. Used in various UIs
	var/name
	/// Tickets can be converted to other tickets. It's the type it will be converted to
	var/type_to_convert_to
	/// Boxed message class used in chat messages related to ticket
	var/boxed_message_class = ""
	/// Text span class class used in chat messages related to ticket
	var/text_span_class = ""

/// Whether `target` handles tickets of this type as staff
/datum/help_ticket_type/proc/is_staff(client/target)
	return FALSE

/datum/help_ticket_type/admin
	id = TICKET_TYPE_ADMIN
	name = "Админ"
	type_to_convert_to = TICKET_TYPE_MENTOR
	boxed_message_class = "red_box"
	text_span_class = "adminhelp"

/datum/help_ticket_type/admin/is_staff(client/target)
	return check_rights_for(target, R_ADMIN)

/datum/help_ticket_type/mentor
	id = TICKET_TYPE_MENTOR
	name = "Ментор"
	type_to_convert_to = TICKET_TYPE_ADMIN
	boxed_message_class = "blue_box"
	text_span_class = "mentor"

/datum/help_ticket_type/mentor/is_staff(client/target)
	return !!target?.is_mentor()
