#define FAVOR_MULTIPLIER 3

/obj/structure/retail/occult/baali
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "baali"
	pixel_w = -16
	pixel_z = -16
	owner_needed = FALSE
	desc = "Ваши демонические познания позволяют просить милостей у Инфернальных сил."
	name = "Infernal Rune"
	resistance_flags = INDESTRUCTIBLE // CORVAX EDIT ADD

	products_list = list(
	// SPELLBOOKS
	new /datum/data/vending_product("Гримуар Пути Боли (уровень I)",	/obj/item/path_spellbook/path_of_pain/level1,	130),
	new /datum/data/vending_product("Гримуар Пути Боли (уровень II)",	/obj/item/path_spellbook/path_of_pain/level2,	180),
	new /datum/data/vending_product("Гримуар Пути Боли (уровень III)",	/obj/item/path_spellbook/path_of_pain/level3,	210),
	new /datum/data/vending_product("Гримуар Пути Боли (уровень IV)",	/obj/item/path_spellbook/path_of_pain/level4,	240),
	new /datum/data/vending_product("Гримуар Пути Боли (уровень V)",	/obj/item/path_spellbook/path_of_pain/level5,	270),

	new /datum/data/vending_product("Гримуар Огней Преисподней (уровень I)",	/obj/item/path_spellbook/fires_of_inferno/level1,	130),
	new /datum/data/vending_product("Гримуар Огней Преисподней (уровень II)",	/obj/item/path_spellbook/fires_of_inferno/level2,	180),
	new /datum/data/vending_product("Гримуар Огней Преисподней (уровень III)",	/obj/item/path_spellbook/fires_of_inferno/level3,	210),
	new /datum/data/vending_product("Гримуар Огней Преисподней (уровень IV)",	/obj/item/path_spellbook/fires_of_inferno/level4,	240),
	new /datum/data/vending_product("Гримуар Огней Преисподней (уровень V)",	/obj/item/path_spellbook/fires_of_inferno/level5, 270),

	new /datum/data/vending_product("Гримуар Лишения Духа (уровень I)",	/obj/item/path_spellbook/taking_of_spirit/level1,	130),
	new /datum/data/vending_product("Гримуар Лишения Духа (уровень II)",	/obj/item/path_spellbook/taking_of_spirit/level2,	180),
	new /datum/data/vending_product("Гримуар Лишения Духа (уровень III)",	/obj/item/path_spellbook/taking_of_spirit/level3,	210),
	new /datum/data/vending_product("Гримуар Лишения Духа (уровень IV)",	/obj/item/path_spellbook/taking_of_spirit/level4,	240),
	new /datum/data/vending_product("Гримуар Лишения Духа (уровень V)",	/obj/item/path_spellbook/taking_of_spirit/level5, 270),

	// ARTIFACTS
	// Lower tier artifacts
	new /datum/data/vending_product("Викапогский чертополох", /obj/item/occult_artifact/vampire/weekapaug_thistle, 135),
	new /datum/data/vending_product("Безделушка из бинтов мумии", /obj/item/occult_artifact/vampire/mummywrap_fetish, 90),
	new /datum/data/vending_product("Галдьюм", /obj/item/occult_artifact/vampire/galdjum, 90),
	new /datum/data/vending_product("Кровавая звезда", /obj/item/occult_artifact/vampire/bloodstar, 135),

	// Mid tier artifacts
	new /datum/data/vending_product("Амулет фей", /obj/item/occult_artifact/vampire/fae_charm, 180),
	new /datum/data/vending_product("Даймонори", /obj/item/occult_artifact/vampire/daimonori, 180),
	new /datum/data/vending_product("Ключ Аламута", /obj/item/occult_artifact/vampire/key_of_alamut, 200),
	new /datum/data/vending_product("Сердце Элизы", /obj/item/occult_artifact/vampire/heart_of_eliza, 230),
	new /datum/data/vending_product("Кровавый камень", /obj/item/occult_artifact/vampire/bloodstone, 230),

	// High tier artifacts
	new /datum/data/vending_product("Гнусная чаша", /obj/item/occult_artifact/vampire/odious_chalice, 250),

)

/obj/structure/retail/occult/baali/has_purchase_privileges(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		return human_user.get_discipline(/datum/discipline/daimonion)

/obj/structure/retail/occult/baali/proc/calculate_favor(mob/living/carbon/human/sacrificed)
	var/favor = 50
	if(get_kindred_splat(sacrificed))
		favor = ((GHOUL_GENERATION - clamp(sacrificed.get_generation(), 1, 17)) * 8 + 78) // Linear scale with GHOUL_GENERATION = 15: 8th = 134, 13th = 94, 15th = 78, 16th = 70.
	if(get_shifter_splat(sacrificed))
		favor = 100

	// CORVAX GRID ADD: REWORK BAALI RUNE
	var/state_multiplier = 100
	if(sacrificed.stat == DEAD)
		if(!sacrificed.mind || !sacrificed.client)
			state_multiplier = 10
		else
			state_multiplier = 50
	else if(!sacrificed.mind || !sacrificed.client)
		state_multiplier = 20

	// Integer percentages avoid floating-point precision issues in BYOND.
	return floor((favor * FAVOR_MULTIPLIER * state_multiplier) / 100)

/obj/structure/retail/occult/baali/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(can_shop(user))
		var/sacrifice = FALSE
		if(ishuman(user))
			var/mob/living/carbon/human/human_user = user
			for(var/mob/living/carbon/human/sacrificed_human in get_turf(src))
			// CORVAX GRID ADD: REWORK BAALI RUNE
				if(sacrificed_human.stat != SOFT_CRIT && sacrificed_human.stat != HARD_CRIT && sacrificed_human.stat != DEAD)
					continue
				// CORVAX GRID ADD: REWORK BAALI RUNE
				if(HAS_TRAIT(sacrificed_human, TRAIT_BAALI_SACRIFICED))
					continue
				if(HAS_TRAIT_FROM(sacrificed_human, TRAIT_AURA_OF_INFERNO, DAIMONION_TRAIT))
					to_chat(sacrificed_human, span_userdanger("ВАШУ ДУШУ УТАСКИВАЮТ В ПРЕИСПОДНЮЮ!"))
					human_user.infernal_favor += calculate_favor(sacrificed_human)
					ADD_TRAIT(sacrificed_human, TRAIT_BAALI_SACRIFICED, DAIMONION_TRAIT)
					sacrificed_human.dust(drop_items = TRUE)
					if(sacrificed_human.ckey)
						var/mob/dead/new_player/player = new()
						player.ckey = sacrificed_human.ckey
					qdel(sacrificed_human)
					sacrifice = TRUE
					continue
				if(!sacrificed_human.mind || !sacrificed_human.client)
					ADD_TRAIT(sacrificed_human, TRAIT_BAALI_SACRIFICED, DAIMONION_TRAIT)
					human_user.infernal_favor += calculate_favor(sacrificed_human)
					sacrificed_human.dust(drop_items = TRUE)
					sacrifice = TRUE
					continue
				human_user.infernal_favor += calculate_favor(sacrificed_human)
				var/spawn_point = sacrificed_human.mind.assigned_role.get_roundstart_spawn_point()
				if(spawn_point)
					to_chat(sacrificed_human, span_userdanger("ЧТО-ТО РВЁТ ВАШУ ДУШУ НА ЧАСТИ! КАКАЯ БОЛЬ!"))
					sacrificed_human.forceMove(spawn_point)
					ADD_TRAIT(sacrificed_human, TRAIT_AURA_OF_INFERNO, DAIMONION_TRAIT)
					ADD_TRAIT(sacrificed_human, TRAIT_BEACON_OF_THE_UNHOLY, DAIMONION_TRAIT)
					SEND_SIGNAL(sacrificed_human, COMSIG_MOB_UPDATE_AURA)
					sacrificed_human.AdjustSleeping(5 SECONDS)
					addtimer(CALLBACK(src, PROC_REF(on_wake_up), sacrificed_human), 5 SECONDS)
					sacrificed_human.log_message("has been sacrificed the first time on baali rune by [key_name(user)].", LOG_GAME)
					log_admin("[key_name(sacrificed_human)] has been sacrificed the first time on baali rune by [key_name(user)].")
				else
					ADD_TRAIT(sacrificed_human, TRAIT_BAALI_SACRIFICED, DAIMONION_TRAIT)
					sacrificed_human.dust(drop_items = TRUE)
					var/mob/dead/new_player/player = new()
					player.ckey = sacrificed_human.ckey
					qdel(sacrificed_human)
				sacrifice = TRUE
			/* CORVAX GRID COMMENTED
			if(upset)
				to_chat(human_user, span_warning("ИНФЕРНАЛЬНЫМ СИЛАМ НУЖНЫ ТОЛЬКО РАЗУМНЫЕ СОЗДАНИЯ!"))
				human_user.adjust_fire_stacks(1, overwrite_color = COLOR_VERY_DARK_LIME_GREEN)
			if(sacrifice || upset)
			*/
			if(sacrifice)
				playsound(get_turf(src), 'sound/effects/magic/demon_dies.ogg', 100, TRUE)
				animate(src, color = initial(color), time = 0.5 SECONDS)
				addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_atom_colour)), 0.5 SECONDS)
			else
				interface_interact(human_user)

/obj/structure/retail/occult/baali/proc/on_wake_up(mob/living/carbon/human/sacrificed_human)
	sacrificed_human.SetSleeping(0)
	to_chat(sacrificed_human, span_warning("Боль утихает, но внутри у вас пусто. Второго раза вы не переживёте."))
	to_chat(sacrificed_human, span_userdanger("ВЫ НЕ ПОМНИТЕ, КТО ВАС ЗАБРАЛ, ГДЕ ВЫ БЫЛИ И ЧТО ВООБЩЕ ПРИВЕЛО К ЭТОМУ МИГУ."))

// BaaliSpellbookVendor.jsx in tgui/interfaces
/obj/structure/retail/occult/baali/proc/interface_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BaaliSpellbookVendor", capitalize(declent_ru(NOMINATIVE)))
		ui.open()

/obj/structure/retail/occult/baali/ui_data(mob/user)
	. = list()
	.["user"] = list()
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		.["user"]["points"] = human_user.infernal_favor
		.["user"]["name"] = "[human_user.real_name]"
		.["user"]["has_daimonion"] = !!human_user.get_discipline(/datum/discipline/daimonion)
		.["user"]["has_privileges"] = has_purchase_privileges(human_user)
	else
		.["user"]["points"] = 0
		.["user"]["name"] = "Неизвестный"
		.["user"]["has_daimonion"] = FALSE
		.["user"]["has_privileges"] = FALSE

	.["product_records"] = list()
	for(var/datum/data/vending_product/prize in products_list)
		var/stock_count = prize.amount
		var/obj/item/product_item = prize.product_path
		var/list/product_data = list(
			path = replacetext(replacetext("[prize.product_path]", "/obj/item/", ""), "/", "-"),
			name = prize.name,
			price = prize.price,
			ref = REF(prize),
			stock = stock_count,
			available = (stock_count > 0),
			icon = initial(product_item.icon),
			icon_state = initial(product_item.icon_state)
		)
		.["product_records"] += list(product_data)

/obj/structure/retail/occult/baali/ui_act(action, params)
	if(action != "purchase")
		return ..()

	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/human_user = usr

	if(!get_kindred_splat(usr))
		return

	var/datum/data/vending_product/prize = locate(params["ref"]) in products_list
	var/current_stock = prize.amount
	if(current_stock <= 0)
		to_chat(usr, span_alert("Нет в наличии: [prize.name]!"))
		return

	if(prize.price > human_user.infernal_favor)
		to_chat(usr, span_alert("Не хватает благосклонности! Нужно: [prize.price]."))
		return

	human_user.infernal_favor -= prize.price

	prize.amount -= 1

	to_chat(usr, span_notice("Инфернальная руна источает демоническую энергию и воплощает перед вами: [prize.name]!"))
	new prize.product_path(loc)
	return TRUE

//offer artifacts to the shop for research points AND increment stock
/obj/structure/retail/occult/baali/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/occult_artifact))
		var/obj/item/occult_artifact/artifact = tool

		if(!ishuman(user))
			return ITEM_INTERACT_BLOCKING

		var/mob/living/carbon/human/human_user = user

		if(artifact.research_value <= 0)
			to_chat(user, span_warning("Инфернальные силы не видят в этом артефакте никакой ценности."))
			return ITEM_INTERACT_BLOCKING

		human_user.infernal_favor += artifact.research_value

		increment_stock(artifact.type)

		//when donating an artifact, increase stock of a random spellbook
		increment_stock(pick(
			/obj/item/path_spellbook/path_of_pain/level1,
			/obj/item/path_spellbook/path_of_pain/level2,
			/obj/item/path_spellbook/path_of_pain/level3,
			/obj/item/path_spellbook/path_of_pain/level4,
			/obj/item/path_spellbook/path_of_pain/level5,
			/obj/item/path_spellbook/fires_of_inferno/level1,
			/obj/item/path_spellbook/fires_of_inferno/level2,
			/obj/item/path_spellbook/fires_of_inferno/level3,
			/obj/item/path_spellbook/fires_of_inferno/level4,
			/obj/item/path_spellbook/fires_of_inferno/level5,
			/obj/item/path_spellbook/taking_of_spirit/level1,
			/obj/item/path_spellbook/taking_of_spirit/level2,
			/obj/item/path_spellbook/taking_of_spirit/level3,
			/obj/item/path_spellbook/taking_of_spirit/level4,
			/obj/item/path_spellbook/taking_of_spirit/level5))

		if(artifact.research_value >= 20)
			to_chat(user, span_nicegreen("Инфернальные силы жадно поглощают могущественный артефакт и пополняют им своё собрание. Вы получаете благосклонность: [artifact.research_value]!"))
		else if(artifact.research_value >= 10)
			to_chat(user, span_notice("Инфернальные силы вбирают сущность артефакта и сохраняют его знания. Вы получаете благосклонность: [artifact.research_value]."))
		else
			to_chat(user, span_notice("Инфернальные силы нехотя принимают малозначительный артефакт и убирают его с глаз. Вы получаете благосклонность: [artifact.research_value]."))

		qdel(artifact)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/path_spellbook))
		var/obj/item/path_spellbook/spellbook = tool

		if(!ishuman(user))
			return ITEM_INTERACT_BLOCKING

		var/mob/living/carbon/human/human_user = user

		var/research_reward = 50
		human_user.infernal_favor += research_reward

		increment_stock(spellbook.type)

		to_chat(user, span_notice("Инфернальные силы принимают ваш гримуар и пополняют его знаниями своё собрание. Вы получаете благосклонность: [research_reward]."))

		qdel(spellbook)
		return ITEM_INTERACT_SUCCESS

#undef FAVOR_MULTIPLIER
