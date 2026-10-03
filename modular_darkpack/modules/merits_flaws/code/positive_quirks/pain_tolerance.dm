/datum/quirk/darkpack/pain_tolerance
	name = "Pain Tolerance"
	ru_name = "Устойчивость к боли"
	desc = "Может, вы крепкий орешек или отключили себе нервы Преображением. Может, сир провёл вас через такие изощрённые круги ада, что с вами мало кто сравнится. А может, вас это просто заводит. Как бы то ни было, боль от ран вас не замедляет."
	ttrpg_sources = list(/datum/source_book/vtm20/lotc = 238)
	value = 2
	gain_text = span_notice("Кажется, теперь вы способны вытерпеть больше боли")
	lose_text = span_notice("Вы снова переносите боль как все")
	icon = FA_ICON_SKULL
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL)
	included_clans = list(VAMPIRE_CLAN_TZIMISCE)
	failure_message = "Вы снова переносите боль как все"

/datum/quirk/darkpack/pain_tolerance/add(client/client_source)
	quirk_holder.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	quirk_holder.add_traits(list(TRAIT_ANALGESIA, TRAIT_NO_DAMAGE_OVERLAY), QUIRK_TRAIT)

/datum/quirk/darkpack/pain_tolerance/remove(client/client_source)
	quirk_holder.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	quirk_holder.remove_traits(list(TRAIT_ANALGESIA, TRAIT_NO_DAMAGE_OVERLAY), QUIRK_TRAIT)
