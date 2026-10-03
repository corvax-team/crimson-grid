// inspired* by Fallout NV's Wild Wasteland Trait
// TODO: Make this do anything lol
/*
/datum/station_trait/wild_masquerade
	name = "Wild Masquerade"
	weight = 1
	trait_to_give = STATION_TRAIT_WILD_MASQUERADE
	darkpack_allowed = TRUE
*/

/datum/station_trait/filled_trash
	name = "Забастовка мусорщиков"
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	blacklist = list(/datum/station_trait/empty_trash)
	trait_to_give = STATION_TRAIT_FILLED_MAINT
	// This station trait is checked when loot drops initialize, so it's too late
	can_revert = FALSE

	darkpack_allowed = TRUE
	newspaper_message = "Местный профсоюз мусорщиков объявил забастовку: на этой неделе вывоза мусора не ждите."
	newspaper_chance = 90

/datum/station_trait/empty_trash
	name = "День вывоза мусора"
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	blacklist = list(/datum/station_trait/filled_trash)
	trait_to_give = STATION_TRAIT_EMPTY_MAINT
	// This station trait is checked when loot drops initialize, so it's too late
	can_revert = FALSE

	darkpack_allowed = TRUE

/datum/station_trait/infestation
	name = "Нашествие крыс"
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	blacklist = list(/datum/station_trait/pest_control)
	trait_to_give = STATION_TRAIT_INFESTATION
	darkpack_allowed = TRUE

/datum/station_trait/infestation/revert()
	for(var/obj/structure/ladder/manhole/down/manhole_entrance in world)
		var/spawner = manhole_entrance.GetComponent(/datum/component/spawner)
		if(spawner)
			qdel(spawner)
	return ..()

/datum/station_trait/pest_control
	name = "Дератизация"
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	blacklist = list(/datum/station_trait/infestation)
	trait_to_give = STATION_TRAIT_PEST_CONTROL
	darkpack_allowed = TRUE

/datum/station_trait/stray_migration
	name = "Нашествие бродячих животных"
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	trait_to_give = STATION_TRAIT_PEST_CONTROL
	darkpack_allowed = TRUE

// DARKPACK TODO - Not touching this till npc outfit refactor
/datum/station_trait/cosplay_convention
	name = "Косплей-конвент"
	weight = 3
	trait_to_give = STATION_TRAIT_COSPLAY_CONVENTION

	darkpack_allowed = TRUE
	newspaper_message = "В центре города проходит конвент любителей \"косплея\"."
	newspaper_chance = 90
