///Given to items that can tell you the time by being examined.
/datum/element/readable_time

/datum/element/readable_time/Attach(datum/target, invisible = FALSE)
	. = ..()
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/readable_time/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_EXAMINE)

/datum/element/readable_time/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += "[capitalize(source.declent_ru(NOMINATIVE))]: <b>[server_timestamp("hh:mm:ss", ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))], [text2num(server_timestamp("DD", ic_time = TRUE))] [ru_month_name(text2num(server_timestamp("MM", ic_time = TRUE)), GENITIVE)]</b>."
	examine_list += "Значит, сегодня <b>[ru_weekday_name(server_timestamp("DDD", ic_time = TRUE))]</b>."
