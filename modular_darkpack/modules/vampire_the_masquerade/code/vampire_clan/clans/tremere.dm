/datum/subsplat/vampire_clan/tremere
	name = "Tremere"
	ru_name = "Тремер"
	id = VAMPIRE_CLAN_TREMERE
	desc = "Загадочный клан Тремер когда-то был домом смертных магов, которые искали бессмертия, а нашли лишь не-жизнь. Став вампирами, они в совершенстве научились подчинять собственную кровь своей воле и чарами опутывают и мир смертных, и мир вампиров. Сила делает их ценными, но мало кто из вампиров доверяет этим интриганам. Тремеры - скрытные собиратели оккультных знаний и чародеи крови. Их прочно держит Пирамида - система уз, которая привязывает каждого члена клана к Внутреннему Кругу и его воле. От тремера ждут, что интересы клана он поставит выше своих, хотя кое-кому удаётся уйти в Дом Карны, податься в инферналисты ради запретной силы, обрести независимость или даже примкнуть к Шабашу. Из-за кланового изъяна узы крови действуют на них гораздо сильнее, чем на прочих Сородичей."
	icon = "tremere"
	curse = "Узы крови действуют на тремеров гораздо сильнее."
	roleplay_level = "Высокий"
	sense_the_sin_text = "требует безупречности от каждого своего поступка."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/dominate,
		/datum/discipline/thaumaturgy
	)
	male_clothes = /obj/item/clothing/under/vampire/tremere
	female_clothes = /obj/item/clothing/under/vampire/tremere/female

/datum/subsplat/vampire_clan/tremere/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("Кровь хлещет из моего тела и складывается в гротескную фигуру"))
	new /obj/effect/client_image_holder/baali_demon/tremere(get_turf(target), list(target))
