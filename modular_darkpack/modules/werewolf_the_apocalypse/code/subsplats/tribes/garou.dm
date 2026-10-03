/datum/subsplat/werewolf/tribe/garou
	abstract_type = /datum/subsplat/werewolf/tribe/garou
	fera_restriction = SPLAT_GAROU

/datum/subsplat/werewolf/tribe/garou/galestalkers
	name = TRIBE_GALESTALKERS
	ru_name = "Охотники Бури"
	desc = "Неутомимые следопыты и несравненные охотники, Охотники Бури носят имя ветра, что гуляет над тундрой."
	gifts_provided = list()
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/ghostcouncil
	name = TRIBE_UKTENA
	ru_name = "Уктена"
	desc = "Искатели тайн, скрытные донельзя, Уктена - одно из самых непонятых племён. Среди них есть проводники, учёные и люди веры."
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/spirit_speech, // DARKPACK TODO - (Selectable Gifts)
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/hartwardens
	name = TRIBE_FIANNA
	ru_name = "Фианна"
	desc = "Растить, творить, возделывать и беречь самые естественные создания Геи - вот дело Фианна, и мало кто ближе них к природе. Где бы они ни были, они умеют вызвать благословение Геи из всего, что есть под рукой."
	gifts_provided = list(
		/datum/action/cooldown/power/gift/faerie_light,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/glasswalkers
	name = TRIBE_GLASS_WALKERS
	ru_name = "Ходящие по Стеклу"
	desc = "Ближе всех к Ткачихе, они глубоко вросли в современное человеческое общество с его религией, техникой и городами. Каждое новое изобретение, каждое открытие Ходящим по Стеклу не помеха, а подспорье."
	gifts_provided = list(
		/datum/action/cooldown/power/gift/control_machine/simple,
	)
	subsplat_keys = /obj/item/vamp/keys/techstore

/datum/subsplat/werewolf/tribe/garou/bonegnawers
	name = TRIBE_BONE_GNAWERS
	ru_name = "Грызущие Кости"
	desc = "Выживальщики и падальщики, часто нищие и бездомные. В Грызущих Кости видят дворняг, что кормятся объедками, но сами они знают, что это не так. Они умеют выживать как никто и терпеливо ждут часа, когда можно будет ударить по зазнавшемуся врагу."
	gifts_provided = list(
		/datum/action/cooldown/power/gift/desperate_strength,
	)
	subsplat_keys = /obj/item/vamp/keys/children_of_gaia

/datum/subsplat/werewolf/tribe/garou/childrenofgaia
	name = TRIBE_CHILDREN_OF_GAIA
	ru_name = "Дети Геи"
	desc = "Миротворцы, посредники, создатели договоров и философы. Дети Геи изо всех сил стремятся привести разрозненные племена к пониманию и единству, чтобы те встали против врагов одним строем."
	gifts_provided = list(
		/datum/action/cooldown/power/gift/jam_weapon
		// /datum/action/cooldown/power/gift/mothers_touch, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/resist_pain, // DARKPACK TODO - (Selectable Gifts)
	)
	subsplat_keys = /obj/item/vamp/keys/children_of_gaia

/datum/subsplat/werewolf/tribe/garou/getoffenris
	name = TRIBE_GET_OF_FENRIS
	ru_name = "Потомство Фенрира"
	desc = "Воины, сострадательные и свирепые. Себя они считают сильнейшими героями Геи, но прочие племена смотрят на них с опаской: их жестокость известна больше, чем их отвага."
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/razor_claws, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/resist_pain, // DARKPACK TODO - (Selectable Gifts)
		/datum/action/cooldown/power/gift/visage_of_fenris,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/blackfuries
	name = TRIBE_BLACK_FURIES
	ru_name = "Чёрные Фурии"
	desc = "Племя, в котором одни женщины, матриархи гару. Чёрных Фурий чтят за честь, мудрость, гордость и редкое боевое мастерство."
	gifts_provided = list(
		/datum/action/cooldown/power/gift/breath_of_the_wyld,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/silentstriders
	name = TRIBE_SILENT_STRIDERS
	ru_name = "Безмолвные Странники"
	desc = "Глубоко духовные кочевники. Безмолвные Странники уходили в глубины Умбры дальше и дольше любого другого племени."
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/sense_wyrm, // DARKPACK TODO - (Selectable Gifts)
		/datum/action/cooldown/power/gift/speed_of_thought,
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/shadowlords
	name = TRIBE_SHADOW_LORDS
	ru_name = "Теневые Владыки"
	desc = "Если гару вообще можно назвать 'политиком', то это о них. Теневые Владыки вертят и племенами, и собственными врагами, полагаясь на хитрость и ум больше, чем на силу. Искусных воинов в их рядах хватает, но в племени голову ценят выше мышц."
	gifts_provided = list(
		/datum/action/cooldown/power/gift/aura_of_confidence,
		/datum/action/cooldown/power/gift/fatal_flaw,
	)
	subsplat_keys = /obj/item/vamp/keys/techstore

/datum/subsplat/werewolf/tribe/garou/redtalons
	name = TRIBE_RED_TALONS
	ru_name = "Красные Когти"
	desc = "В племени одни люпусы. Красные Когти сторонятся людей и видят в человечестве язву на теле Геи."
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/beast_speech, // DARKPACK TODO - (Selectable Gifts)
		/datum/action/cooldown/power/gift/hidden_killer,
	)

/datum/subsplat/werewolf/tribe/garou/silverfangs
	name = TRIBE_SILVER_FANGS
	ru_name = "Серебряные Клыки"
	desc = "В Нации Гару их зовут 'вожаками': в их рядах потомственные правители и военные вожди. Племя славится честью и отвагой, но у молодых Клыков всё чаще проявляются странности рассудка, и племя начинают одолевать болезни духа и разума."
	gifts_provided = list(
		// /datum/action/cooldown/power/gift/inspiration, // DARKPACK TODO - (Selectable Gifts)
	)
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/stargazers
	name = TRIBE_STARGAZERS
	ru_name = "Звездочёты"
	desc = "Самые спокойные из гару, известные своей замкнутостью. Это самое малочисленное из уцелевших племён: многих Звездочётов истребил Вирм."
	gifts_provided = list()
//	subsplat_keys = /obj/item/vamp/keys/nps //CRIMSON EDIT REMOVAL - Park Keys For Roles

/datum/subsplat/werewolf/tribe/garou/blackspiraldancers
	name = TRIBE_BLACK_SPIRAL_DANCERS
	ru_name = "Танцоры Чёрной Спирали"
	desc = "Потерянное племя. Волки ужаса. Те, кто танцует в ногу с Вирмом. Те, кто вошёл в Лабиринт и вернулся другим.\n<b>{ЭТО СЛОЖНОЕ ПЛЕМЯ, НОВИЧКАМ ОНО НЕ РЕКОМЕНДУЕТСЯ. ДЛЯ ИГРЫ НУЖНО ЗНАТЬ ЛОР}</B>"
	gifts_provided = list(
		/datum/action/cooldown/power/gift/bane_protector,
		// /datum/action/cooldown/power/gift/resist_pain, // DARKPACK TODO - (Selectable Gifts)
		// /datum/action/cooldown/power/gift/sense_wyrm, // DARKPACK TODO - (Selectable Gifts)
	)
	subsplat_traits = list(TRAIT_WYRMTAINTED)

/datum/subsplat/werewolf/tribe/garou/blackspiraldancers/psychomania_effect(mob/living/target, mob/living/owner)
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
	target.visible_message(span_warning("[capitalize(target.declent_ru(NOMINATIVE))] скулит в животном ужасе"), span_cult("ПЕРЕД ГЛАЗАМИ ВСПЫХИВАЮТ ВИДЕНИЯ СЕРЫ И ПЛАМЕНИ"))
	target.Paralyze(5 SECONDS)

	// CRIMSON GRID ADD END: DARK THAUMATURGY
	to_chat(target, span_cult("ЗВЕРЬ В МОЕЙ ГОЛОВЕ ВОПИТ: БЕГИ"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY

/datum/subsplat/werewolf/tribe/garou/ronin
	name = TRIBE_RONIN
	ru_name = "Ронин"
	desc = "Гару, которые по той или иной причине стали изгоями Нации."
	gifts_provided = list()
