/obj/machinery/barsign // All Signs are 64 by 32 pixels, they take two tiles
	name = "bar sign"
	desc = "Вывеска бара, которая почему-то так и не загрузилась. Пожалуйтесь кодерам!"
	icon = 'icons/obj/machines/barsigns.dmi'
	icon_state = "empty"
	req_access = list(ACCESS_BAR)
	max_integrity = 500
	integrity_failure = 0.5
	armor_type = /datum/armor/sign_barsign
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.15
	/// Selected barsign being used
	var/datum/barsign/chosen_sign
	/// Do we attempt to rename the area we occupy when the chosen sign is changed?
	var/change_area_name = FALSE
	/// What kind of sign do we drop upon being disassembled?
	var/disassemble_result = /obj/item/wallframe/barsign

/datum/armor/sign_barsign
	melee = 20
	bullet = 20
	laser = 20
	energy = 100
	fire = 50
	acid = 50

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/barsign, 32)

/obj/machinery/barsign/Initialize(mapload)
	. = ..()
	//Roundstart/map specific barsigns "belong" in their area and should be renaming it, signs created from wallmounts will not.
	change_area_name = mapload
	set_sign(new /datum/barsign/hiddensigns/signoff)
	if(mapload)
		find_and_mount_on_atom()

/obj/machinery/barsign/proc/set_sign(datum/barsign/sign)
	if(!istype(sign))
		return

	var/area/bar_area = get_area(src)
	if(change_area_name && sign.rename_area)
		rename_area(bar_area, sign.name)

	chosen_sign = sign
	update_appearance()

/obj/machinery/barsign/update_icon_state()
	if(!(machine_stat & BROKEN) && (!(machine_stat & NOPOWER) || machine_stat & EMPED) && chosen_sign && chosen_sign.icon_state)
		icon_state = chosen_sign.icon_state
	else
		icon_state = "empty"

	return ..()

/obj/machinery/barsign/update_desc()
	. = ..()

	if(chosen_sign && chosen_sign.desc)
		desc = chosen_sign.desc

/obj/machinery/barsign/update_name()
	. = ..()
	if(chosen_sign && chosen_sign.rename_area)
		name = "[initial(name)] ([chosen_sign.name])"
	else
		name = "[initial(name)]"

/obj/machinery/barsign/update_overlays()
	. = ..()

	if(((machine_stat & NOPOWER) && !(machine_stat & EMPED)) || (machine_stat & BROKEN))
		return

	if(chosen_sign && chosen_sign.light_mask)
		. += emissive_appearance(icon, "[chosen_sign.icon_state]-light-mask", src)

/obj/machinery/barsign/update_appearance(updates=ALL)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		set_light(0)
		return
	if(chosen_sign && chosen_sign.neon_color)
		set_light(MINIMUM_USEFUL_LIGHT_RANGE, 0.7, chosen_sign.neon_color)

/obj/machinery/barsign/proc/set_sign_by_name(sign_name)
	for(var/datum/barsign/sign as anything in subtypesof(/datum/barsign))
		if(initial(sign.name) == sign_name)
			var/new_sign = new sign
			set_sign(new_sign)

/obj/machinery/barsign/atom_break(damage_flag)
	. = ..()
	if(machine_stat & BROKEN)
		set_sign(new /datum/barsign/hiddensigns/signoff)

/obj/machinery/barsign/on_deconstruction(disassembled)
	if(disassembled)
		new disassemble_result(drop_location())
	else
		new /obj/item/stack/sheet/iron(drop_location(), 2)
		new /obj/item/stack/cable_coil(drop_location(), 2)

/obj/machinery/barsign/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src.loc, 'sound/effects/glass/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/machinery/barsign/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/barsign/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!allowed(user))
		balloon_alert(user, "в доступе отказано!")
		return
	if(machine_stat & (NOPOWER|BROKEN|EMPED))
		balloon_alert(user, "управление не отвечает!")
		return
	pick_sign(user)

/obj/machinery/barsign/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	panel_open = !panel_open
	if(panel_open)
		balloon_alert(user, "панель открыта")
		set_sign(new /datum/barsign/hiddensigns/signoff)
		return ITEM_INTERACT_SUCCESS

	balloon_alert(user, "панель закрыта")

	if(machine_stat & (NOPOWER|BROKEN) || !chosen_sign)
		set_sign(new /datum/barsign/hiddensigns/signoff)
	else
		set_sign(chosen_sign)

	return ITEM_INTERACT_SUCCESS

/obj/machinery/barsign/wrench_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		balloon_alert(user, "нужно открыть панель!")
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	if(!do_after(user, (10 SECONDS), target = src))
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/barsign/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(istype(tool, /obj/item/blueprints) && !change_area_name)
		if(!panel_open)
			balloon_alert(user, "нужно открыть панель!")
			return ITEM_INTERACT_BLOCKING

		change_area_name = TRUE
		balloon_alert(user, "вывеска привязана")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/cable_coil) && panel_open)
		var/obj/item/stack/cable_coil/wire = tool

		if(atom_integrity >= max_integrity)
			balloon_alert(user, "ремонт не нужен!")
			return ITEM_INTERACT_BLOCKING

		if(!wire.use(2))
			balloon_alert(user, "нужно два кабеля!")
			return ITEM_INTERACT_BLOCKING

		balloon_alert(user, "починено")
		atom_integrity = max_integrity
		set_machine_stat(machine_stat & ~BROKEN)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/barsign/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return

	set_machine_stat(machine_stat | EMPED)
	addtimer(CALLBACK(src, PROC_REF(fix_emp), chosen_sign), 60 SECONDS)
	set_sign(new /datum/barsign/hiddensigns/empbarsign)

/// Callback to un-emp the sign some time.
/obj/machinery/barsign/proc/fix_emp(datum/barsign/sign)
	set_machine_stat(machine_stat & ~EMPED)
	if(!istype(sign))
		return

	set_sign(sign)

/obj/machinery/barsign/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(machine_stat & (NOPOWER|BROKEN|EMPED))
		balloon_alert(user, "управление не отвечает!")
		return FALSE

	balloon_alert(user, "загружена левая вывеска")
	addtimer(CALLBACK(src, PROC_REF(finish_emag_act)), 10 SECONDS)
	return TRUE

/// Timer proc, called after ~10 seconds after [emag_act], since [emag_act] returns a value and cannot sleep
/obj/machinery/barsign/proc/finish_emag_act()
	set_sign(new /datum/barsign/hiddensigns/syndibarsign)

/obj/machinery/barsign/proc/pick_sign(mob/user)
	var/picked_name = tgui_input_list(user, "Доступные вывески", "Вывеска бара", sort_list(get_bar_names()))
	if(isnull(picked_name))
		return
	set_sign_by_name(picked_name)
	SSblackbox.record_feedback("tally", "barsign_picked", 1, chosen_sign.type)

/proc/get_bar_names()
	var/list/names = list()
	for(var/d in subtypesof(/datum/barsign))
		var/datum/barsign/D = d
		if(!initial(D.hidden))
			names += initial(D.name)
	. = names

/datum/barsign
	/// User-visible name of the sign.
	var/name
	/// Icon state associated with this sign
	var/icon_state
	/// Description shown in the sign's examine text.
	var/desc
	/// Hidden from list of selectable options.
	var/hidden = FALSE
	/// Rename the area when this sign is selected.
	var/rename_area = TRUE
	/// If a barsign has a light mask for emission effects
	var/light_mask = TRUE
	/// The emission color of the neon light
	var/neon_color

/datum/barsign/New()
	if(!desc)
		desc = "На вывеске написано \"[name]\"."

// Specific bar signs.

/datum/barsign/maltesefalcon
	name = "Maltese Falcon"
	icon_state = "maltesefalcon"
	desc = "\"Мальтийский сокол\", бар и гриль."
	neon_color = "#5E8EAC"

/datum/barsign/thebark
	name = "The Bark"
	icon_state = "thebark"
	desc = "Любимый бар одного корги по кличке Иан."
	neon_color = "#f7a604"

/datum/barsign/harmbaton
	name = "The Harmbaton"
	icon_state = "theharmbaton"
	desc = "Здесь одинаково вкусно кормят и копов, и тех, кого они гоняют."
	neon_color = "#ff7a4d"

/datum/barsign/thesingulo
	name = "The Singulo"
	icon_state = "thesingulo"
	desc = "Сюда ходят те, кто предпочитает, чтобы их не звали по имени."
	neon_color = "#E600DB"

/datum/barsign/thedrunkcarp
	name = "The Drunk Carp"
	icon_state = "thedrunkcarp"
	desc = "Выпил - не ныряй."
	neon_color = "#a82196"

/datum/barsign/scotchservinwill
	name = "Scotch Servin Willy's"
	icon_state = "scotchservinwill"
	desc = "Из клоунов в бармены: Вилли явно пошёл в гору."
	neon_color = "#fee4bf"

/datum/barsign/officerbeersky
	name = "Officer Beersky's"
	icon_state = "officerbeersky"
	desc = "Да чтоб меня, выпивка тут отличная."
	neon_color = "#16C76B"

/datum/barsign/thecavern
	name = "The Cavern"
	icon_state = "thecavern"
	desc = "Хорошая выпивка под хорошую музыку."
	neon_color = "#0fe500"

/datum/barsign/theouterspess
	name = "The Outer Spess"
	icon_state = "theouterspess"
	desc = "Вообще-то этот бар находится вовсе не в открытом космосе."
	neon_color = "#30f3cc"

/datum/barsign/slipperyshots
	name = "Slippery Shots"
	icon_state = "slipperyshots"
	desc = "С нашими шотами скатиться в запой проще простого!"
	neon_color = "#70DF00"

/datum/barsign/thegreytide
	name = "The Grey Tide"
	icon_state = "thegreytide"
	desc = "Отложите ящик с инструментами и спокойно выпейте пива!"
	neon_color = "#00F4D6"

/datum/barsign/honkednloaded
	name = "Honked 'n' Loaded"
	icon_state = "honkednloaded"
	desc = "Хонк."
	neon_color = "#FF998A"

/datum/barsign/le_cafe_silencieux
	name = "Le Café Silencieux"
	icon_state = "le_cafe_silencieux"
	desc = "..."
	neon_color = "#ffffff"

/datum/barsign/thenest
	name = "The Nest"
	icon_state = "thenest"
	desc = "Отличное место, чтобы пропустить стаканчик после долгой ночи борьбы с преступностью."
	neon_color = "#4d6796"

/datum/barsign/thecoderbus
	name = "The Coderbus"
	icon_state = "thecoderbus"
	desc = "Весьма спорное заведение, известное широким и постоянно меняющимся выбором напитков."
	neon_color = "#ffffff"

/datum/barsign/theadminbus
	name = "The Adminbus"
	icon_state = "theadminbus"
	desc = "Сюда заглядывают в основном судьи. Взрывают тут куда реже, чем на судебных заседаниях."
	neon_color = "#ffffff"

/datum/barsign/oldcockinn
	name = "The Old Cock Inn"
	icon_state = "oldcockinn"
	desc = "Что-то в этой вывеске вгоняет в тоску."
	neon_color = "#a4352b"

/datum/barsign/thewretchedhive
	name = "The Wretched Hive"
	icon_state = "thewretchedhive"
	desc = "По закону обязаны предупредить: перед употреблением проверяйте, нет ли в напитке кислоты."
	neon_color = "#26b000"

/datum/barsign/robustacafe
	name = "The Robusta Cafe"
	icon_state = "robustacafe"
	desc = "Пять лет подряд удерживает рекорд \"Самые смертоносные барные драки\"."
	neon_color = "#c45f7a"

/datum/barsign/emergencyrumparty
	name = "The Emergency Rum Party"
	icon_state = "emergencyrumparty"
	desc = "Недавно снова получил лицензию после долгого простоя."
	neon_color = "#f90011"

/datum/barsign/combocafe
	name = "The Combo Cafe"
	icon_state = "combocafe"
	desc = "Славится на всю округу поразительно скучными сочетаниями напитков."
	neon_color = "#33ca40"

/datum/barsign/vladssaladbar
	name = "Vlad's Salad Bar"
	icon_state = "vladssaladbar"
	desc = "Под новым руководством. Влад всегда слишком охотно хватался за дробовик."
	neon_color = "#306900"

/datum/barsign/theshaken
	name = "The Shaken"
	icon_state = "theshaken"
	desc = "Здесь взбалтывают, но не смешивают."
	neon_color = "#dcd884"

/datum/barsign/thealenath
	name = "The Ale' Nath"
	icon_state = "thealenath"
	desc = "Так, приятель. По-моему, тебе уже ЭЙ НАТ. Пора вызывать такси."
	neon_color = "#ed0000"

/datum/barsign/thealohasnackbar
	name = "The Aloha Snackbar"
	icon_state = "alohasnackbar"
	desc = "Со вкусом сделанная, совершенно безобидная вывеска тики-бара."
	neon_color = ""

/datum/barsign/thenet
	name = "The Net"
	icon_state = "thenet"
	desc = "Стоит зайти - и застрянешь на несколько часов."
	neon_color = "#0e8a00"

/datum/barsign/maidcafe
	name = "Maid Cafe"
	icon_state = "maidcafe"
	desc = "С возвращением, господин!"
	neon_color = "#ff0051"

/datum/barsign/the_lightbulb
	name = "The Lightbulb"
	icon_state = "the_lightbulb"
	desc = "Кафе, куда все слетаются как мотыльки на свет. Однажды закрылось на неделю: барменша пересыпала запасную форму нафталином."
	neon_color = "#faff82"

/datum/barsign/goose
	name = "The Loose Goose"
	icon_state = "goose"
	desc = "Пейте, пока не стошнит и/или пока не нарушатся законы реальности!"
	neon_color = "#00cc33"

/datum/barsign/maltroach
	name = "Maltroach"
	icon_state = "maltroach"
	desc = "Тараканы вежливо приглашают вас в бар. Или это они друг с другом здороваются?"
	neon_color = "#649e8a"

/datum/barsign/rock_bottom
	name = "Rock Bottom"
	icon_state = "rock-bottom"
	desc = "Если уж оказался на самом дне, почему бы не выпить."
	neon_color = "#aa2811"

/datum/barsign/orangejuice
	name = "Oranges' Juicery"
	icon_state = "orangejuice"
	desc = "Для тех, кто хочет проявить предельную чуткость к непьющим."
	neon_color = COLOR_ORANGE

/datum/barsign/tearoom
	name = "Little Treats Tea Room"
	icon_state = "little_treats"
	desc = "Восхитительно уютная чайная для всех утончённых особ на свете."
	neon_color = COLOR_LIGHT_ORANGE

/datum/barsign/assembly_line
	name = "The Assembly Line"
	icon_state = "the-assembly-line"
	desc = "Каждый напиток здесь мастерски собран с промышленной эффективностью!"
	neon_color = "#ffffff"

/datum/barsign/bargonia
	name = "Bargonia"
	icon_state = "bargonia"
	desc = "Склад жаждал высшего предназначения... и снабженцы провозгласили БАРГОНИЮ!"
	neon_color = COLOR_WHITE

/datum/barsign/cult_cove
	name = "Cult Cove"
	icon_state = "cult-cove"
	desc = "Любимое место отдыха Нар'Си"
	neon_color = COLOR_RED

/datum/barsign/neon_flamingo
	name = "Neon Flamingo"
	icon_state = "neon-flamingo"
	desc = "Заведение для всех, кому не чужда тяга к эпатажу."
	neon_color = COLOR_PINK

/datum/barsign/slowdive
	name = "Slowdive"
	icon_state = "slowdive"
	desc = "Первая остановка после ада, последняя перед раем."
	neon_color = COLOR_RED

/datum/barsign/the_red_mons
	name = "The Red Mons"
	icon_state = "the-red-mons"
	desc = "Напитки с Красной планеты."
	neon_color = COLOR_RED

/datum/barsign/the_rune
	name = "The Rune"
	icon_state = "therune"
	desc = "Напитки, от которых плывёт реальность."
	neon_color = COLOR_RED

/datum/barsign/the_wizard
	name = "The Wizard"
	icon_state = "the-wizard"
	desc = "Волшебные коктейли."
	neon_color = COLOR_RED

/datum/barsign/months_moths_moths
	name = "Moths Moths Moths"
	icon_state = "moths-moths-moths"
	desc = "ЖИВЫЕ МОТЫЛЬКИ!"
	neon_color = COLOR_RED

/datum/barsign/coldones
	name = "Cold Ones"
	icon_state = "cold-ones"
	desc = "Вот это и называется \"эффект йогурта\"."
	neon_color = ""

/datum/barsign/doctorsorders
	name = "Doctor's Orders"
	icon_state = "doctors-orders"
	desc = "Обезболивающее без рецепта."
	neon_color = ""

/datum/barsign/wrongturn
	name = "Wrong Turn"
	icon_state = "wrong-turn"
	desc = "Заблудившимся вы себя не чувствуете. Впрочем, пара стаканов это исправит."
	neon_color = ""

/datum/barsign/punpunspub
	name = "Punpun's Pub"
	icon_state = "pun-puns-pub"
	desc = "После всего, что он пережил? Я бы тоже держался поближе к выпивке."
	neon_color = ""

// Hidden signs list below this point

/datum/barsign/hiddensigns
	hidden = TRUE

/datum/barsign/hiddensigns/empbarsign
	name = "EMP'd"
	icon_state = "empbarsign"
	desc = "Что-то пошло совсем не так."
	rename_area = FALSE

/datum/barsign/hiddensigns/syndibarsign
	name = "Syndi Cat"
	icon_state = "syndibarsign"
	desc = "Синдикат или смерть."
	neon_color = "#ff0000"

/datum/barsign/hiddensigns/signoff
	name = "Off"
	icon_state = "empty"
	desc = "Похоже, вывеска выключена."
	rename_area = FALSE
	light_mask = FALSE

// For other locations that aren't in the main bar
/obj/machinery/barsign/all_access
	req_access = null
	disassemble_result = /obj/item/wallframe/barsign/all_access

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/barsign/all_access, 32)

/obj/item/wallframe/barsign
	name = "bar sign frame"
	desc = "Помогает заманить публику в ваш бар. Требуется сборка."
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "barsign"
	result_path = /obj/machinery/barsign
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	pixel_shift = 32

/obj/item/wallframe/barsign/Initialize(mapload)
	. = ..()
	desc += " Вывеску можно привязать к помещению, где она висит, с помощью [span_bold("чертежей здания")]."

/obj/item/wallframe/barsign/try_build(turf/on_wall, mob/user)
	. = ..()
	if(!.)
		return .

	if(isopenturf(get_step(on_wall, EAST))) //This takes up 2 tiles so we want to make sure we have two tiles to hang it from.
		balloon_alert(user, "нужна опора покрепче!")
		return FALSE

/obj/item/wallframe/barsign/all_access
	desc = "Помогает заманить публику в ваш бар. Требуется сборка. У этой нет замка доступа."
	result_path = /obj/machinery/barsign/all_access
