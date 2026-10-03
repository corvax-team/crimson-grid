/obj/machinery/bitcoin_miner
	name = "bitcoin miner"
	desc = "Ферма для добычи криптовалюты с подключённым монитором.\nСбоку у неё лоток, из которого намайненное каким-то чудом выдаётся наличными."
	icon = 'modular_darkpack/modules/bitcoinminer/icons/bitcoinminer.dmi'
	icon_state = "miner_off"
	density = TRUE
	var/active = FALSE
	var/starting = FALSE
	var/money_stored = 0
	var/money_per_tick_min = 1
	var/money_per_tick_max = 2

/obj/machinery/bitcoin_miner/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/machinery/bitcoin_miner/process(seconds_per_tick)
	if(active)
		money_stored += rand(money_per_tick_min, money_per_tick_max)  * seconds_per_tick
	else
		STOP_PROCESSING(SSobj, src)

/obj/machinery/bitcoin_miner/update_icon_state()
	icon_state = active ? "miner_on" : "miner_off"
	if(starting)
		icon_state = "miner_starting"
	return ..()

/obj/machinery/bitcoin_miner/examine(mob/user)
	. = ..()
	if(active && in_range(user, src))
		. += span_notice("Сейчас на счету [money_stored / 222] BTC, это $[money_stored].") // division by 222 to replicate 2015 BTC prices
		. += span_notice("<i>Alt+ЛКМ</i>, чтобы выключить [declent_ru(ACCUSATIVE)].")
	if(starting)
		. += span_notice("Похоже, она запускается.")
	if(!active && !starting)
		. += span_notice("Похоже, она выключена.")

/obj/machinery/bitcoin_miner/proc/toggle_on(mob/user)
	starting = TRUE
	playsound(src, 'sound/machines/computer/computer_start.ogg', 40)
	update_appearance()
	sleep(5 SECONDS)
	starting = FALSE
	active = TRUE
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/machinery/bitcoin_miner/proc/toggle_off(mob/user)
	active = FALSE
	playsound(src, 'sound/machines/computer/computer_start.ogg', 40)
	update_appearance()
	STOP_PROCESSING(SSobj, src)

/obj/machinery/bitcoin_miner/Destroy()
	toggle_off()
	return ..()

/obj/machinery/bitcoin_miner/proc/dump_loot(mob/user)
	if(money_stored > 0)
		var/money_to_spawn = min(money_stored, /obj/item/stack/dollar::max_amount)
		new /obj/item/stack/dollar(drop_location(), money_to_spawn)
		money_stored -= money_to_spawn
		playsound(src, 'sound/machines/eject.ogg', 30)
		to_chat(user, span_notice("Вы забираете из [declent_ru(GENITIVE)] [MONEY_SYMBOL][money_to_spawn]!"))
	else
		to_chat(user, span_notice("На счету пусто!"))

/obj/machinery/bitcoin_miner/interact(mob/user)
	. = ..()
	if(!in_range(user, src))
		return

	if(!active)
		if(starting)
			to_chat(user, span_warning("[capitalize(declent_ru(NOMINATIVE))] ещё запускается!"))
			return
		if(tgui_alert(user, "Включить [declent_ru(ACCUSATIVE)]?", "Майнинг", list("Да", "Нет")) == "Да")
			to_chat(user, span_notice("Вы включаете [declent_ru(ACCUSATIVE)]."))
			toggle_on(user)
	else
		dump_loot(user)

/obj/machinery/bitcoin_miner/click_alt(mob/user)
	. = ..()
	if(!in_range(user, src))
		return

	if(active)
		if(tgui_alert(user, "Выключить [declent_ru(ACCUSATIVE)]?", "Майнинг", list("Да", "Нет")) == "Да")
			to_chat(user, span_notice("Вы выключаете [declent_ru(ACCUSATIVE)]."))
			toggle_off()
