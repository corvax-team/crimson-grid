/obj/structure/light_construct
	name = "light fixture frame"
	desc = "Недособранный светильник."
	icon = 'modular_darkpack/master_files/icons/obj/lighting.dmi' // DARKPACK EDIT CHANGE
	icon_state = "tube-construct-stage1"
	anchored = TRUE
	layer = WALL_OBJ_LAYER
	max_integrity = 200
	armor_type = /datum/armor/structure_light_construct

	///Light construction stage (LIGHT_CONSTRUCT_EMPTY, LIGHT_CONSTRUCT_WIRED, LIGHT_CONSTRUCT_CLOSED)
	var/stage = LIGHT_CONSTRUCT_EMPTY
	///Type of fixture for icon state
	var/fixture_type = "tube"
	///Amount of sheets gained on deconstruction
	var/sheets_refunded = 2
	///Reference for light object
	var/obj/machinery/light/new_light = null
	///Reference for the internal cell
	var/obj/item/stock_parts/power_store/cell
	///Can we support a cell?
	var/cell_connectors = TRUE

/datum/armor/structure_light_construct
	melee = 50
	bullet = 10
	laser = 10
	fire = 80
	acid = 50

/obj/structure/light_construct/Initialize(mapload)
	. = ..()
	if(mapload && !find_and_mount_on_atom(mark_for_late_init = TRUE))
		return INITIALIZE_HINT_LATELOAD

/obj/structure/light_construct/LateInitialize()
	find_and_mount_on_atom(late_init = TRUE)

/obj/structure/light_construct/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/structure/light_construct/get_turfs_to_mount_on()
	return list(get_step(src, dir))

/obj/structure/light_construct/get_cell()
	return cell

/obj/structure/light_construct/examine(mob/user)
	. = ..()
	switch(stage)
		if(LIGHT_CONSTRUCT_EMPTY)
			. += span_notice("Пустой каркас без проводки.")
		if(LIGHT_CONSTRUCT_WIRED)
			. += span_notice("Проводка проложена, но корпус не закручен.")
		if(LIGHT_CONSTRUCT_CLOSED)
			. += span_notice("Корпус закрыт.")
	if(cell_connectors)
		if(cell)
			. += span_notice("Внутри корпуса стоит [cell.declent_ru(NOMINATIVE)].")
		else
			. += span_notice("Батареи резервного питания в корпусе нет.")
	else
		. += span_danger("В этом корпусе нет места для батареи резервного питания.")

/obj/structure/light_construct/attack_hand(mob/user, list/modifiers)
	if(!cell)
		return
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] вынимает [cell.declent_ru(ACCUSATIVE)] из [declent_ru(GENITIVE)]!"), span_notice("Вы вынимаете [cell.declent_ru(ACCUSATIVE)]."))
	user.put_in_hands(cell)
	cell = null
	add_fingerprint(user)

/obj/structure/light_construct/attack_tk(mob/user)
	if(!cell)
		return
	to_chat(user, span_notice("Вы вынимаете [cell.declent_ru(ACCUSATIVE)] силой мысли."))
	var/obj/item/stock_parts/power_store/cell_reference = cell
	cell = null
	cell_reference.forceMove(drop_location())
	return cell_reference.attack_tk(user)

/obj/structure/light_construct/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	add_fingerprint(user)
	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		if(!cell_connectors)
			to_chat(user, span_warning("Сюда батарею не поставить!"))
			return ITEM_INTERACT_BLOCKING

		if(!user.temporarilyRemoveItemFromInventory(tool))
			to_chat(user, span_warning("[capitalize(tool.declent_ru(NOMINATIVE))] не отлипает от руки!"))
			return ITEM_INTERACT_BLOCKING

		if(cell)
			to_chat(user, span_warning("Батарея уже установлена!"))
			return ITEM_INTERACT_BLOCKING

		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] подключает [tool.declent_ru(ACCUSATIVE)] к [declent_ru(DATIVE)]."), \
		span_notice("Вы подключаете [tool.declent_ru(ACCUSATIVE)] к [declent_ru(DATIVE)]."))
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		tool.forceMove(src)
		cell = tool
		add_fingerprint(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/light))
		to_chat(user, span_warning("Светильник ещё не собран до конца!"))
		return ITEM_INTERACT_BLOCKING

	if(stage == LIGHT_CONSTRUCT_EMPTY && istype(tool, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = tool
		if(!coil.use(1))
			to_chat(user, span_warning("Чтобы проложить проводку, нужен кусок кабеля!"))
			return ITEM_INTERACT_BLOCKING
		icon_state = "[fixture_type]-construct-stage2"
		stage = LIGHT_CONSTRUCT_WIRED
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] прокладывает проводку в [declent_ru(PREPOSITIONAL)]."), \
							span_notice("Вы прокладываете проводку в [declent_ru(PREPOSITIONAL)]."))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/light_construct/wrench_act(mob/living/user, obj/item/tool)
	switch(stage)
		if(LIGHT_CONSTRUCT_EMPTY)
			if(cell)
				to_chat(user, span_warning("Сначала выньте батарею!"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Вы начинаете разбирать [declent_ru(ACCUSATIVE)]..."))
			if (!tool.use_tool(src, user, 30, volume=50))
				return ITEM_INTERACT_BLOCKING
			user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] разбирает [declent_ru(ACCUSATIVE)]."), \
								span_notice("Вы разбираете [declent_ru(ACCUSATIVE)]."), \
								span_hear("Слышен треск гаечного ключа."))
			playsound(src, 'sound/items/deconstruct.ogg', 75, TRUE)
			deconstruct()
			return ITEM_INTERACT_SUCCESS
		if(LIGHT_CONSTRUCT_WIRED)
			to_chat(usr, span_warning("Сначала уберите проводку!"))
			return ITEM_INTERACT_BLOCKING
	return NONE

/obj/structure/light_construct/screwdriver_act(mob/living/user, obj/item/tool)
	if(stage != LIGHT_CONSTRUCT_WIRED)
		return NONE
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] закрывает корпус светильника."), \
						span_notice("Вы закрываете корпус светильника."), \
						span_hear("Слышно, как что-то закручивают."))
	tool.play_tool_sound(src, 75)
	switch(fixture_type)
		if("tube")
			new_light = new /obj/machinery/light/empty(loc)
		if("bulb")
			new_light = new /obj/machinery/light/small/empty(loc)
		if("floor")
			new_light = new /obj/machinery/light/floor/empty(loc)
	new_light.setDir(dir)
	new_light.find_and_mount_on_atom()
	transfer_fingerprints_to(new_light)
	if(!QDELETED(cell))
		new_light.cell = cell
		cell.forceMove(new_light)
		cell = null
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/light_construct/wirecutter_act(mob/living/user, obj/item/tool)
	if(stage != LIGHT_CONSTRUCT_WIRED)
		return NONE
	stage = LIGHT_CONSTRUCT_EMPTY
	icon_state = "[fixture_type]-construct-stage1"
	new /obj/item/stack/cable_coil(drop_location(), 1, "red")
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] вытаскивает проводку из [declent_ru(GENITIVE)]."), \
						span_notice("Вы вытаскиваете проводку из [declent_ru(GENITIVE)]."), \
						span_hear("Слышны щелчки."))
	tool.play_tool_sound(src, 100)
	return ITEM_INTERACT_SUCCESS

/obj/structure/light_construct/blob_act(obj/structure/blob/attacking_blob)
	if(attacking_blob && attacking_blob.loc == loc)
		deconstruct(FALSE)

/obj/structure/light_construct/atom_deconstruct(disassembled)
	new /obj/item/stack/sheet/iron(loc, sheets_refunded)
	if(stage == LIGHT_CONSTRUCT_WIRED)
		new /obj/item/stack/cable_coil(drop_location(), 1, "red")

/obj/structure/light_construct/small
	name = "small light fixture frame"
	icon_state = "bulb-construct-stage1"
	fixture_type = "bulb"
	sheets_refunded = 1

/obj/structure/light_construct/floor
	name = "floor light fixture frame"
	icon_state = "floor-construct-stage1"
	fixture_type = "floor"
	sheets_refunded = 1

/obj/structure/light_construct/floor/get_turfs_to_mount_on()
	return list(get_turf(src))

/obj/structure/light_construct/floor/is_mountable_turf(turf/target)
	return !isgroundlessturf(target)
