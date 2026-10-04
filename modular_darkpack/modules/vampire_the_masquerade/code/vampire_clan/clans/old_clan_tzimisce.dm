/datum/subsplat/vampire_clan/old_clan_tzimisce
	name = "Old Clan Tzimisce"
	ru_name = "Старый клан Цимисхов"
	id = VAMPIRE_CLAN_OLD_CLAN_TZIMISCE
	desc = "Старый клан Цимисхов - небольшая группа Извергов, заставшая времена до искусства лепки плоти. Преображение они считают болезнью души и отказываются изучать и применять его. Во всём прочем они мало отличаются от остального клана."
	icon = "old_clan_tzimisce"
	curse = "Привязаны к родной земле."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/animalism,
		/datum/discipline/dominate
	)
	male_clothes = /obj/item/clothing/under/vampire/sport
	female_clothes = /obj/item/clothing/under/vampire/red
	enlightenment = TRUE
	//restricted_disciplines = list(/datum/discipline/vicissitude)
	whitelisted = FALSE

/datum/subsplat/vampire_clan/old_clan_tzimisce/on_join_round(mob/living/carbon/human/joining)
	. = ..()

	var/obj/item/ground_heir/heirloom = new(get_turf(joining))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	joining.equip_in_one_of_slots(heirloom, slots, FALSE)
	joining.AddComponent(/datum/component/needs_home_soil, heirloom)
