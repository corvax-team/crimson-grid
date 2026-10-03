/obj/machinery/radio_tranceiver
	name = "radio transceiver"
	desc = "Аппарат, который подключает рации к своей сети и управляет ими."
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "walkietalkie"
	density = TRUE
	pass_flags = PASSTABLE
	pass_flags_self = LETPASSTHROW
	var/radio_network = "Unnamed Network"
	var/radio_frequency = FREQ_COMMON
	var/list/connected_radios = list()

/obj/machinery/radio_tranceiver/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/radio_tranceiver/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(held_item?.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = anchored ? "Открутить" : "Прикрутить"
		return CONTEXTUAL_SCREENTIP_SET
	return ..()

/obj/machinery/radio_tranceiver/examine(mob/user)
	. = ..()
	. += span_notice("Сейчас обслуживает сеть \"[radio_network_ru(radio_network)]\".")

/obj/machinery/radio_tranceiver/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/radio/headset/darkpack))
		return ..()

	if(CONFIG_GET(flag/punishing_zero_dots) && user.st_get_stat(STAT_TECHNOLOGY) < 1)
		to_chat(user, span_warning("Вы не знаете, как с этим обращаться!"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/radio/headset/darkpack/radio = tool
	if(radio.radio_id)
		if("[radio.radio_id]" in connected_radios)
			to_chat(user, span_notice("Вы отвязываете [radio.declent_ru(ACCUSATIVE)] от сети \"[radio_network_ru(radio_network)]\"."))
			leave_network(radio)
			playsound(src, 'modular_darkpack/modules/radios/sounds/radio_off.ogg', 60, TRUE)
			return ITEM_INTERACT_SUCCESS
		else
			to_chat(user, span_notice("Привязать [radio.declent_ru(ACCUSATIVE)] к сети \"[radio_network_ru(radio_network)]\" не выйдет: рация уже подключена к сети \"[radio_network_ru(radio.radio_network)]\"!"))
			return ITEM_INTERACT_SUCCESS
	else
		var/input_number = tgui_input_number(user = user, message = "Введите числовой идентификатор рации в этой сети.", title = "Идентификатор рации", max_value = 999, min_value = 1, round_value = TRUE)
		if(!input_number)
			return ITEM_INTERACT_BLOCKING
		if("[input_number]" in connected_radios)
			to_chat(user, span_warning("Рация с таким идентификатором уже подключена к этой сети!"))
			return ITEM_INTERACT_BLOCKING
		join_network(radio, input_number)
		playsound(src, 'modular_darkpack/modules/radios/sounds/radio_on.ogg', 60, TRUE)
		to_chat(user, span_notice("Вы привязываете [radio.declent_ru(ACCUSATIVE)] к сети \"[radio_network_ru(radio_network)]\"."))
	return ITEM_INTERACT_SUCCESS

/obj/machinery/radio_tranceiver/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	balloon_alert(user, anchored ? "откручиваете..." : "прикручиваете...")
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 1 TURNS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, vary = TRUE)
		balloon_alert(user, anchored ? "откручено" : "прикручено")
		set_anchored(!anchored)
	return TRUE

/obj/machinery/radio_tranceiver/proc/radio_network_ru(network)
	var/static/list/network_names = list(
		NETWORK_POLICE = "Полиция",
		NETWORK_CLINIC = "Клиника",
		NETWORK_MILITARY = "Армия",
		NETWORK_CAMARILLA = "Башня",
		NETWORK_ANARCH = "Бар",
		NETWORK_ENDRON = "Эндрон",
		"Unnamed Network" = "Без названия",
	)
	return network_names[network] || network

/obj/machinery/radio_tranceiver/proc/join_network(obj/item/radio/headset/darkpack/connected_radio, radio_id)
	connected_radio.radio_id = radio_id
	connected_radio.radio_network = radio_network
	connected_radio.set_frequency(radio_frequency)
	var/datum/weakref/radio_weakref = WEAKREF(connected_radio)
	connected_radios["[radio_id]"] = radio_weakref

/obj/machinery/radio_tranceiver/proc/leave_network(obj/item/radio/headset/darkpack/disconnected_radio)
	disconnected_radio.radio_network = null
	disconnected_radio.set_frequency(FREQ_COMMON)
	connected_radios -= "[disconnected_radio.radio_id]"
	disconnected_radio.radio_id = null

/obj/machinery/radio_tranceiver/police
	radio_network = NETWORK_POLICE
	radio_frequency = FREQ_POLICE
	var/obj/item/radio/headset/darkpack/police/radio
	COOLDOWN_DECLARE(crime_reporting_cooldown)

/obj/machinery/radio_tranceiver/police/Initialize(mapload)
	. = ..()
	radio = new()
	join_network(radio, 911)
	RegisterSignal(SSdcs, COMSIG_GLOB_REPORT_CRIME, PROC_REF(crime_reported))

/obj/machinery/radio_tranceiver/police/Destroy(force)
	UnregisterSignal(SSdcs, COMSIG_GLOB_REPORT_CRIME)
	QDEL_NULL(radio)
	return ..()

/obj/machinery/radio_tranceiver/police/proc/crime_reported(datum/source, crime, turf/location)
	SIGNAL_HANDLER

	if(crime == CRIME_EMERGENCY) // Bypasses cooldown because of gameplay reasons.
		radio.talk_into(radio, span_red("406 - ЭКСТРЕННЫЙ ВЫЗОВ - ТРЕБУЕТСЯ ПОДКРЕПЛЕНИЕ: [english_list(list(location.x, location.y, location.z, get_area_name(location, TRUE)), and_text = ", ")]."), FREQ_POLICE, list(SPAN_ROBOT, SPAN_COMMAND))

		var/datum/signal/subspace/radio/signal = new(FREQ_POLICE, list())
		INVOKE_ASYNC(signal, TYPE_PROC_REF(/datum/signal/subspace/radio, send_to_receivers))
		log_message("Emergency alarm triggered at: [english_list(list(location.x, location.y, location.z, get_area_name(location, TRUE)), and_text = ", ")]", LOG_PDA)
		return

	if(!COOLDOWN_FINISHED(src, crime_reporting_cooldown))
		return
	var/area/vtm/crime_area = astype(get_area(location))
	if(!crime_area || crime_area.zone_type != ZONE_MASQUERADE) // prevents sewer rats from reporting crime
		return
	COOLDOWN_START(src, crime_reporting_cooldown, 10 SECONDS)
	switch(crime)
		if(CRIME_GUNSHOTS)
			radio.talk_into(radio, "Поступило сообщение о стрельбе. Место: [get_area_name(location, TRUE)].", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_FIREFIGHT)
			radio.talk_into(radio, "Сообщают о перестрелке, огонь ещё ведётся. Место: [get_area_name(location, TRUE)].", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_MURDER)
			radio.talk_into(radio, "Поступило сообщение об убийстве. Место: [get_area_name(location, TRUE)].", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_BURGLARY)
			radio.talk_into(radio, "Поступило сообщение о краже со взломом. Место: [get_area_name(location, TRUE)].", FREQ_POLICE, list(SPAN_ROBOT))
		if(CRIME_ATM_TAMPERING)
			radio.talk_into(radio, "Взломан или повреждён банкомат. Место: [get_area_name(location, TRUE)].", FREQ_POLICE, list(SPAN_ROBOT))

/datum/signal/subspace/radio

/datum/signal/subspace/radio/New(frequency, data)  // the frequency the signal is taking place on
	src.frequency = frequency
	src.data = data

/datum/signal/subspace/radio/broadcast()
	set waitfor = FALSE

	var/list/radios = list()
	// Reaches any radios on the levels
	var/list/all_radios_of_our_frequency = GLOB.all_radios["[frequency]"]
	if(LAZYLEN(all_radios_of_our_frequency))
		radios = all_radios_of_our_frequency.Copy()

	for(var/obj/item/radio/subspace_radio in radios)
		if(!subspace_radio.can_receive(frequency, RADIO_NO_Z_LEVEL_RESTRICTION))
			radios -= subspace_radio

	for(var/called_radio in radios)
		playsound(get_turf(called_radio), 'modular_darkpack/modules/radios/sounds/panic.ogg', 50, TRUE)

/obj/machinery/radio_tranceiver/clinic
	radio_network = NETWORK_CLINIC
	radio_frequency = FREQ_CLINIC

/obj/machinery/radio_tranceiver/camarilla
	radio_network = NETWORK_CAMARILLA
	radio_frequency = FREQ_CAMARILLA

/obj/machinery/radio_tranceiver/anarch
	radio_network = NETWORK_ANARCH
	radio_frequency = FREQ_ANARCH

/obj/machinery/radio_tranceiver/endron
	radio_network = NETWORK_ENDRON
	radio_frequency = FREQ_ENDRON
