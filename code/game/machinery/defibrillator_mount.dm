//Holds defibs does NOT recharge them
//You can activate the mount with an empty hand to grab the paddles
//Not being adjacent will cause the paddles to snap back
/obj/machinery/defibrillator_mount
	name = "defibrillator mount"
	desc = "Настенное крепление для дефибриллятора. Если он на месте, можно взять электроды."
	icon = 'icons/obj/machines/defib_mount.dmi'
	icon_state = "defibrillator_mount"
	density = FALSE
	use_power = NO_POWER_USE
	active_power_usage = 40 * BASE_MACHINE_ACTIVE_CONSUMPTION
	power_channel = AREA_USAGE_EQUIP
	req_one_access = list(ACCESS_MEDICAL, ACCESS_COMMAND, ACCESS_SECURITY) //used to control clamps
	processing_flags = NONE
	/// The mount's defib
	var/obj/item/defibrillator/defib
	/// if true, and a defib is loaded, it can't be removed without unlocking the clamps
	var/clamps_locked = FALSE
	/// the type of wallframe it 'disassembles' into
	var/wallframe_type = /obj/item/wallframe/defib_mount

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/defibrillator_mount, 28)

/obj/machinery/defibrillator_mount/Initialize(mapload)
	. = ..()
	if(mapload)
		find_and_mount_on_atom()

/obj/machinery/defibrillator_mount/loaded/Initialize(mapload) //loaded subtype for mapping use
	. = ..()
	defib = new/obj/item/defibrillator/loaded(src)

/obj/machinery/defibrillator_mount/Destroy()
	QDEL_NULL(defib)
	return ..()

/obj/machinery/defibrillator_mount/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == defib)
		// Make sure processing ends before the defib is nulled
		end_processing()
		defib = null
		update_appearance()

/obj/machinery/defibrillator_mount/examine(mob/user)
	. = ..()
	if(defib)
		. += span_notice("Дефибриллятор на месте. Alt+ЛКМ, чтобы снять.")
		if(SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_RED)
			. += span_notice("Из-за чрезвычайной ситуации фиксаторы сейчас открываются любой картой.")
		else
			. += span_notice("Фиксаторы можно [clamps_locked ? "открыть" : "закрыть"] картой с нужным доступом.")

/obj/machinery/defibrillator_mount/update_overlays()
	. = ..()
	if(isnull(defib))
		return

	var/mutable_appearance/defib_overlay = mutable_appearance(icon, "defib", layer = layer+0.01, offset_spokesman = src)

	if(defib.powered)
		var/obj/item/stock_parts/power_store/cell = defib.cell
		var/mutable_appearance/safety = mutable_appearance(icon, defib.safety ? "online" : "emagged", offset_spokesman = src)
		var/mutable_appearance/charge_overlay = mutable_appearance(icon, "charge[CEILING((cell.charge / cell.maxcharge) * 4, 1) * 25]", offset_spokesman = src)

		defib_overlay.overlays += list(safety, charge_overlay)

	if(clamps_locked)
		var/mutable_appearance/clamps = mutable_appearance(icon, "clamps", offset_spokesman = src)
		defib_overlay.overlays += clamps

	. += defib_overlay

//defib interaction
/obj/machinery/defibrillator_mount/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!defib)
		to_chat(user, span_warning("В креплении нет дефибриллятора!"))
		return
	if(defib.paddles.loc != defib)
		to_chat(user, span_warning("Электроды дефибриллятора уже [defib.paddles.loc == user ? "у вас в руках" : "в чьих-то руках"]!"))
		return
	if(!in_range(src, user))
		to_chat(user, span_warning("Провод натягивается, и электроды вырываются у вас из рук!"))
		return
	user.put_in_hands(defib.paddles)

/obj/machinery/defibrillator_mount/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/defibrillator))
		if(defib)
			to_chat(user, span_warning("В креплении уже есть дефибриллятор!"))
			return ITEM_INTERACT_BLOCKING
		var/obj/item/defibrillator/new_defib = tool
		if(!new_defib.get_cell())
			to_chat(user, span_warning("Сюда можно повесить только дефибриллятор с батареей!"))
			return ITEM_INTERACT_BLOCKING
		if(HAS_TRAIT(new_defib, TRAIT_NODROP) || !user.transferItemToLoc(new_defib, src))
			to_chat(user, span_warning("Дефибриллятор не отлипает от руки!"))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_notice("[user] вешает дефибриллятор на крепление!"), \
		span_notice("Вы вставляете дефибриллятор в крепление, и он со щелчком встаёт на место."))
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		// Make sure the defib is set before processing begins.
		defib = new_defib
		begin_processing()
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(defib && tool == defib.paddles)
		defib.paddles.snap_back()
		return ITEM_INTERACT_SUCCESS

	if(!tool.GetID())
		return NONE

	if((!allowed(user) && SSsecurity_level.get_current_level_as_number() < SEC_LEVEL_RED)) //anyone can toggle the clamps in red alert!
		to_chat(user, span_warning("Недостаточно доступа."))
		return ITEM_INTERACT_BLOCKING

	if(!defib)
		to_chat(user, span_warning("Нельзя зафиксировать дефибриллятор, которого нет."))
		return ITEM_INTERACT_BLOCKING

	clamps_locked = !clamps_locked
	to_chat(user, span_notice("Фиксаторы [clamps_locked ? "закрыты" : "открыты"]."))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/defibrillator_mount/multitool_act(mob/living/user, obj/item/multitool)
	..()
	if(!defib)
		to_chat(user, span_warning("Фиксировать нечего: дефибриллятора нет!"))
		return TRUE
	if(!clamps_locked)
		to_chat(user, span_warning("Фиксаторы и так открыты!"))
		return TRUE
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] вставляет [multitool.declent_ru(ACCUSATIVE)] в прорезь для карты..."), \
	span_notice("Вы начинаете взламывать фиксаторы..."))
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	if(!do_after(user, 10 SECONDS, target = src) || !clamps_locked)
		return
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] подаёт импульс, и фиксаторы поднимаются."), \
	span_notice("Вы взламываете фиксаторы!"))
	playsound(src, 'sound/machines/locktoggle.ogg', 50, TRUE)
	clamps_locked = FALSE
	update_appearance()
	return TRUE

/obj/machinery/defibrillator_mount/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(!wallframe_type)
		return ..()
	if(user.combat_mode)
		return ..()
	if(defib)
		to_chat(user, span_warning("Пока в креплении дефибриллятор, его не разобрать!"))
		..()
		return TRUE
	new wallframe_type(get_turf(src))
	qdel(src)
	tool.play_tool_sound(user)
	to_chat(user, span_notice("Вы сняли крепление со стены."))
	return TRUE

/obj/machinery/defibrillator_mount/click_alt(mob/living/carbon/user)
	if(!defib)
		to_chat(user, span_warning("Трудно снять дефибриллятор с крепления, на котором его нет."))
		return CLICK_ACTION_BLOCKING
	if(clamps_locked)
		to_chat(user, span_warning("Вы дёргаете дефибриллятор, но фиксаторы держат его намертво!"))
		return CLICK_ACTION_BLOCKING
	if(!user.put_in_hands(defib))
		to_chat(user, span_warning("Нужна свободная рука!"))
		user.visible_message(span_notice("[user] снимает дефибриллятор с крепления и роняет на пол."), \
		span_notice("Вы вынимаете дефибриллятор, отцепляете зарядные провода и роняете его на пол."))
	else
		user.visible_message(span_notice("[user] снимает дефибриллятор с крепления."), \
		span_notice("Вы вынимаете дефибриллятор и отцепляете зарядные провода."))
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
	return CLICK_ACTION_SUCCESS

/obj/machinery/defibrillator_mount/charging
	name = "PENLITE defibrillator mount"
	desc = "Крепление для дефибриллятора. Если он на месте, можно взять электроды. Эта модель PENLITE ещё и понемногу подзаряжает дефибриллятор."
	icon_state = "penlite_mount"
	use_power = IDLE_POWER_USE
	wallframe_type = /obj/item/wallframe/defib_mount/charging


/obj/machinery/defibrillator_mount/charging/Initialize(mapload)
	. = ..()
	if(is_operational)
		begin_processing()


/obj/machinery/defibrillator_mount/charging/on_set_is_operational(old_value)
	if(old_value) //Turned off
		end_processing()
	else //Turned on
		begin_processing()


/obj/machinery/defibrillator_mount/charging/process(seconds_per_tick)
	if(isnull(defib))
		return
	var/obj/item/stock_parts/power_store/defib_cell = defib.get_cell()
	if(isnull(defib_cell)) // Something is very wrong if we hit this, so we should stack trace
		stack_trace("[src] was set to process with no cell inside its defib")
		return PROCESS_KILL
	if(defib_cell.charge < defib_cell.maxcharge)
		charge_cell(active_power_usage * seconds_per_tick, defib_cell)
		defib.update_power()

//wallframe, for attaching the mounts easily
/obj/item/wallframe/defib_mount
	name = "unhooked defibrillator mount"
	desc = "Основа настенного крепления для дефибриллятора. Повешенное крепление можно снять гаечным ключом."
	icon = 'icons/obj/machines/defib_mount.dmi'
	icon_state = "defibrillator_mount"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	w_class = WEIGHT_CLASS_BULKY
	result_path = /obj/machinery/defibrillator_mount
	pixel_shift = 28

/obj/item/wallframe/defib_mount/charging
	name = "unhooked PENLITE defibrillator mount"
	desc = "Основа крепления PENLITE для дефибриллятора. В отличие от обычного, оно подзаряжает дефибриллятор."
	icon_state = "penlite_mount"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)
	result_path = /obj/machinery/defibrillator_mount/charging

//mobile defib

/obj/machinery/defibrillator_mount/mobile
	name = "mobile defibrillator mount"
	icon_state = "mobile"
	anchored = FALSE
	density = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.15, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5)

/obj/machinery/defibrillator_mount/mobile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noisy_movement)

/obj/machinery/defibrillator_mount/mobile/find_and_mount_on_atom(mark_for_late_init, late_init)
	return //its mobile

/obj/machinery/defibrillator_mount/mobile/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return ..()
	if(defib)
		to_chat(user, span_warning("Пока в креплении дефибриллятор, его не разобрать!"))
		..()
		return TRUE
	balloon_alert(user, "deconstructing...")
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 5 SECONDS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, vary = TRUE)
		deconstruct()
	return TRUE

/obj/machinery/defibrillator_mount/mobile/on_deconstruction(disassembled)
	var/atom/drop = drop_location()
	if(disassembled)
		new /obj/item/stack/sheet/iron(drop, 5)
		new /obj/item/stack/sheet/mineral/silver(drop)
		new /obj/item/stack/cable_coil(drop, 15)
	else
		new /obj/item/stack/sheet/iron(drop, 5)

///For mapping
/obj/machinery/defibrillator_mount/mobile/immobile
	anchored = TRUE
	name = "defibrillator mount"
