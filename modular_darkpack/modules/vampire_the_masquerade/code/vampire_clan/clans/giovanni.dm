/datum/subsplat/vampire_clan/giovanni
	name = "Giovanni"
	ru_name = "Джованни"
	id = VAMPIRE_CLAN_GIOVANNI
	desc = "Джованни - узурпаторы клана Каппадокийцев и один из самых молодых кланов. Исторически это и клан, и семья: Становление они дают почти исключительно родне, а все их помыслы сосредоточены на деньгах и некромантической власти."
	icon = "giovanni"
	curse = "Их укус причиняет чудовищную боль и ранит добычу: жертва кричит и может погибнуть, тогда как укус других кланов погружает её в приятное туманное забытьё."
	sense_the_sin_text = "ради семьи не остановится ни перед чем."
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/dominate,
		/datum/discipline/necromancy
	)
	subsplat_traits = list(
		TRAIT_PAINFUL_VAMPIRE_KISS
	)
	male_clothes = /obj/item/clothing/under/vampire/suit
	female_clothes = /obj/item/clothing/under/vampire/suit/female

/datum/subsplat/vampire_clan/giovanni/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	joining.grant_language(/datum/language/italian)

/datum/subsplat/vampire_clan/giovanni/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("Вас наполняет глубокий ужас: в сознание проникают беззвучные слова"))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
	new /obj/effect/client_image_holder/baali_demon/spectre(get_turf(target), list(target))
