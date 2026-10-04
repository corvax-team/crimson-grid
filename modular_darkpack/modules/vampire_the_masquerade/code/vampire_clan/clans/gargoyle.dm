/datum/subsplat/vampire_clan/gargoyle
	name = "Gargoyle"
	ru_name = "Горгульи"
	id = VAMPIRE_CLAN_GARGOYLE
	desc = "Горгульи - вампирская линия крови, созданная Тремер в качестве слуг. Формально они не относятся к клану Тремер, но по большей части остаются под его властью. В Последние Ночи Горгулий становится всё больше: старые свободные Горгульи выходят из укрытий и вступают в Камарилью, всё больше подневольных вырываются из хватки Тремер, а свободные начали сами давать Становление смертным."
	icon = "gargoyle"
	curse = "Все Горгульи, как и Носферату, уродливы: таково следствие их оккультного происхождения (и разношёрстной крови Сородичей, из которой они созданы). Поэтому Горгульям, как и Носферату, приходится прятаться от простых смертных: один их вид уже нарушает Маскарад. Кроме того, происхождение линии сказывается в том, что Горгульи крайне восприимчивы к любому контролю над разумом. Эта слабость не случайна: Тремер намеренно заложили её во всех Горгулий, рассчитывая, что так ими будет легче управлять (и они реже станут бунтовать)."
	sense_the_sin_text = "держит ворота своего разума распахнутыми настежь."
	clan_disciplines = list(
		/datum/discipline/fortitude,
		/datum/discipline/potence,
		/datum/discipline/visceratika
	)
	subsplat_traits = list(
		TRAIT_CANNOT_RESIST_MIND_CONTROL,
		TRAIT_MASQUERADE_VIOLATING_FACE,
		TRAIT_WEAK_TO_DOMINATE,
	)
	alt_sprite = "gargoyle"
	male_clothes = /obj/item/clothing/under/vampire/malkavian
	female_clothes = /obj/item/clothing/under/vampire/malkavian
	default_accessory = "gargoyle_full"
	clan_marks = list(
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/full,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/left,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/right,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/broken,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/round,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/oni,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/devil,
	)
	whitelisted = TRUE

	// Type to use for the extra clan mark they get.
	var/datum/bodypart_overlay/simple/clan_mark/gargy_tail_type = /datum/bodypart_overlay/simple/clan_mark/gargoyle/tail

/datum/subsplat/vampire_clan/gargoyle/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	gaining_mob.physiology.brute_mod = 0.8

	var/obj/item/organ/wings/functional/gargoyle/wings = new()
	wings.Insert(gaining_mob)

/datum/subsplat/vampire_clan/gargoyle/on_lose(mob/living/carbon/human/losing_mob)
	. = ..()
	losing_mob.physiology.brute_mod = 1

	var/obj/item/organ/wings/functional/gargoyle/wings = losing_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	if(wings)
		wings.Remove(losing_mob)
		qdel(wings)

	var/obj/item/bodypart/part = losing_mob.get_bodypart(BODY_ZONE_CHEST)
	part.remove_bodypart_overlay(gargy_tail_type)
