/datum/quirk/darkpack/time_sense
	name = "Time Sense"
	ru_name = "Чувство времени"
	desc = "У вас врождённое чувство времени: вы точно определяете, сколько его прошло, без часов и прочих приборов, даже после долгого беспамятства. Помимо прочего, вы всегда знаете, в какой фазе сейчас луна."
	ttrpg_sources = list(
		/datum/source_book/wta20 = 475,
		/datum/source_book/vtm20 = 484,
		/datum/source_book/htr3/pg = 111,
		)
	value = 1
	mob_trait = TRAIT_TIME_SENSE
	icon = FA_ICON_STOPWATCH

	excluded_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH)

/mob/proc/get_time_status()
	. = list()
	. += "Местное время: [SSticker.round_start_timeofday ? "[server_timestamp("hh:mm", ic_time = TRUE, twelve_hour_clock = client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))] [ru_month_name(text2num(server_timestamp("MM", ic_time = TRUE)))] [server_timestamp("YYYY", ic_time = TRUE)]" : "раунд ещё не начался!"]"

/mob/living/get_time_status()
	. = list()
	if(HAS_TRAIT(src, TRAIT_TIME_SENSE))
		. += "Местное время: [server_timestamp("hh:mm", ic_time = TRUE, twelve_hour_clock = client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))] [ru_month_name(text2num(server_timestamp("MM", ic_time = TRUE)))] [server_timestamp("YYYY", ic_time = TRUE)]"
		var/static/list/moon_phase_names = list(
			MOON_NEW = "новолуние",
			MOON_WAXING_CRESENT = "растущий серп",
			MOON_FIRST_QUARTER = "первая четверть",
			MOON_WAXING_GIBBOUS = "растущая луна",
			MOON_FULL = "полнолуние",
			MOON_WANING_GIBBOUS = "убывающая луна",
			MOON_LAST_QUARTER = "последняя четверть",
			MOON_WANING_CRESCENT = "убывающий серп",
		)
		var/moon_state = get_moon_state()
		. += "Фаза луны: [moon_phase_names[moon_state] || moon_state]"
	else
		. += "Местное время: [CURRENT_STATION_YEAR] год? Купите себе часы."

