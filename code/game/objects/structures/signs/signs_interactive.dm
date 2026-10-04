/obj/structure/sign/clock
	name = "wall clock"
	desc = "Самые обычные настенные часы. Отлично подходят для того, чтобы пялиться на них вместо работы."
	icon_state = "clock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/clock, 32)

/obj/structure/sign/clock/examine(mob/user)
	. = ..()
	. += span_info("Часы показывают [server_timestamp(ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))].") // DAKRPACK EDIT CHANGE - CITY_TIME
	/* //DARKPACK EDIT REMOVAL
	if(user.is_literate())
		. += span_info("That means it is currently [round_timestamp()] into the shift.")
	*/

/obj/structure/sign/calendar
	name = "wall calendar"
	desc = "Старый добрый настенный календарь. Может, в век техники он и не нужен, но офис без него представить трудно."
	icon_state = "calendar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/calendar, 32)

/obj/structure/sign/calendar/examine(mob/user)
	. = ..()
	. += span_info("Сегодня [ru_weekday_name(time2text(world.realtime, "DDD", world.timezone))], [text2num(time2text(world.realtime, "DD", world.timezone))] [ru_month_name(text2num(time2text(world.realtime, "MM", world.timezone)), GENITIVE)] [CURRENT_STATION_YEAR] года.")
	if(length(GLOB.holidays))
		. += span_info("События:")
		for(var/holidayname in GLOB.holidays)
			. += span_info("[holidayname]")
