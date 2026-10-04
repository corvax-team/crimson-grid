/// Russian month name by its number, genitive is the form used after a day number
/proc/ru_month_name(month, declent = NOMINATIVE)
	var/static/list/nominative_names = list("январь", "февраль", "март", "апрель", "май", "июнь", "июль", "август", "сентябрь", "октябрь", "ноябрь", "декабрь")
	var/static/list/genitive_names = list("января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря")
	if(!isnum(month) || month < 1 || month > 12)
		return "[month]"
	return declent == GENITIVE ? genitive_names[month] : nominative_names[month]

/// Russian weekday name by the abbreviation time2text() gives for "DDD"
/proc/ru_weekday_name(weekday)
	var/static/list/names = list(
		"Mon" = "понедельник",
		"Tue" = "вторник",
		"Wed" = "среда",
		"Thu" = "четверг",
		"Fri" = "пятница",
		"Sat" = "суббота",
		"Sun" = "воскресенье",
	)
	return names[weekday] || weekday
