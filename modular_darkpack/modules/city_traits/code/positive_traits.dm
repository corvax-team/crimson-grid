// TODO: Need to tie into bloodpool usage? Hunger?
/datum/station_trait/red_star
	name = "Антелиос, Красная Звезда"
	trait_type = STATION_TRAIT_POSITIVE
	trait_to_give = STATION_TRAIT_RED_STAR
	weight = 1
	darkpack_allowed = TRUE

/datum/station_trait/full_moon
	name = "Полнолуние"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 2

	darkpack_allowed = TRUE
	newspaper_message = "Сегодня луна будет самой яркой за весь месяц!"
	newspaper_chance = 95

/datum/station_trait/full_moon/on_round_start()
	. = ..()
	set_starlight(null, GLOB.starlight_range*1.2, GLOB.starlight_power*1.2)
