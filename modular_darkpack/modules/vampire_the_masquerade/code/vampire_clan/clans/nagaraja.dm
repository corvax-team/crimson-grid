/datum/subsplat/vampire_clan/nagaraja
	name = "Nagaraja"
	ru_name = "Нагараджа"
	id = VAMPIRE_CLAN_NAGARAJA
	desc = "Нагараджа - загадочная линия крови, созданная ритуалом: собственного Патриарха у неё нет. Их боятся и презирают и за искусство в некромантии, и за голод по плоти."
	curse = "В отличие от большинства Сородичей, Нагараджа питаются не кровью, а только плотью и внутренностями добычи, за что собратья прозвали их \"Пожирателями плоти\"."
	icon = "nagaraja"
	sense_the_sin_text = "жаждет плоти."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/dominate,
		/datum/discipline/necromancy
	)
	subsplat_traits = list(TRAIT_ORGANOVORE)
	male_clothes = /obj/item/clothing/under/vampire/emo
	female_clothes = /obj/item/clothing/under/vampire/emo
	whitelisted = FALSE

/datum/subsplat/vampire_clan/nagaraja/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	var/obj/item/ritual_tome/necromancy/necrotome = new()
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	gaining_mob.equip_in_one_of_slots(necrotome, slots, FALSE)
