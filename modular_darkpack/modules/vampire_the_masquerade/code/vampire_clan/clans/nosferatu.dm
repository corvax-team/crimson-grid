/datum/subsplat/vampire_clan/nosferatu
	name = "Nosferatu"
	ru_name = "Носферату"
	id = VAMPIRE_CLAN_NOSFERATU
	desc = "Носферату носят своё проклятие снаружи. Становление чудовищно искажает и уродует их тела, и они таятся на задворках городов, промышляя шпионажем и торговлей сведениями. Звери и собственный сверхъестественный дар прятаться служат им так хорошо, что от глаз Канализационных Крыс не ускользает ничего. Носферату выживают за счёт скрытности и торговли информацией. Во многих городах они тесно связаны с Камарильей, но немало их действует в других сектах, само по себе или поддерживает связи поверх границ сект. Прежде всего они верны клану, какой бы ни была секта. Клановый изъян навсегда превращает их в чудовищ, которым не сойти за людей."
	icon = "nosferatu"
	curse = "Внешность, нарушающая Маскарад."
	roleplay_level = "Средний"
	sense_the_sin_text = "не может устоять перед неизведанным."
	alt_sprite = "nosferatu"
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/potence,
		/datum/discipline/obfuscate
	)
	subsplat_traits = list(
		TRAIT_MASQUERADE_VIOLATING_FACE,
		TRAIT_VENTCRAWLER_ALWAYS,
		TRAIT_TRUE_NIGHT_VISION //CRIMSON GRID ADDITION - NOSFERATU GET NIGHT VISION

	)
	male_clothes = /obj/item/clothing/under/vampire/nosferatu
	female_clothes = /obj/item/clothing/under/vampire/nosferatu/female
	clan_marks = list(/datum/bodypart_overlay/simple/clan_mark/nosferatu_ears)
	default_accessory = /datum/bodypart_overlay/simple/clan_mark/nosferatu_ears
	subsplat_keys = /obj/item/vamp/keys/nosferatu

//CRIMSON GRID ADDITION - NOSFERATU GET NIGHT VISION
/datum/subsplat/vampire_clan/nosferatu/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. =  ..()
	gaining_mob.update_sight()

/datum/subsplat/vampire_clan/nosferatu/on_lose(mob/living/carbon/human/losing_mob)
	. = ..()
	if(!QDELETED(losing_mob))
		losing_mob.update_sight()
