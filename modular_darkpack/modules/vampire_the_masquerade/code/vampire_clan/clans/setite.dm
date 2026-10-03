/datum/subsplat/vampire_clan/setite
	name = "Setite"
	ru_name = "Последователи Сета"
	id = VAMPIRE_CLAN_SETITE
	desc = "Последователи Сета, они же Министерство Сета, Министерство или сетиты, - клан вампиров, верящих, что их основателем был египетский бог Сет. Последователи Сета - растлители, которые ищут свободу в искушении и пороке. Во многих городах они держатся независимой фракцией, тесно связанной с чёрным рынком и с союзами с некоторыми из Кланов Смерти, например с Самеди и Предвестниками. Нагараджа же - заклятые враги сетитов. Стихия сетитов - тайна, манипуляция и духовное растление; почти сектантская вера клана в своего основателя Сета позволяет им выдавать себя за освободителей от оков морали. Клановый изъян ослабляет их на ярком свету, у огня и под солнцем."
	icon = "setite"
	curse = "На свету передвигаются медленнее."
	roleplay_level = "Высокий"
	sense_the_sin_text = "в каждом пятне греха видит добродетель."
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/serpentis
	)
	subsplat_traits = list(
		TRAIT_LIGHT_WEAKNESS
	)
	male_clothes = /obj/item/clothing/under/vampire/slickback
	female_clothes = /obj/item/clothing/under/vampire/burlesque
	subsplat_keys = /obj/item/vamp/keys/setite

/datum/subsplat/vampire_clan/setite/tlacique
	name = "Tlacique"
	ru_name = "Тласике"
	id = VAMPIRE_CLAN_TLACIQUE
	desc = "Тласике - линия крови родом из Мексики, обосновавшаяся там задолго до прихода прочих сетитов. В наши дни они вымирают, почти истреблённые Мечом Каина, и зачастую лишь отдалённо напоминают родительский клан."
	icon = "tlacique"
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/protean
	)
	whitelisted = TRUE

/datum/subsplat/vampire_clan/setite/warrior
	name = "Warrior Setite"
	ru_name = "Сетиты-воины"
	id = VAMPIRE_CLAN_WARRIOR_SETITE
	icon = "warrior_setite"
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/presence,
		/datum/discipline/serpentis
	)

/datum/subsplat/vampire_clan/setite/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	joining.grant_language(/datum/language/arabic)
//We don't have Mesoamerican languages.
