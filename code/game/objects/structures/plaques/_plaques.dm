/obj/structure/plaque //This is a plaque you can craft with gold, then permanently engrave a title and description on, with a fountain pen.
	icon = 'icons/obj/signs.dmi'
	icon_state = "blankplaque"
	name = "blank plaque"
	desc = "Пустая табличка. Гравировку можно нанести хорошей перьевой ручкой. Со стены снимается гаечным ключом."
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	layer = SIGN_LAYER
	custom_materials = list(/datum/material/gold =SHEET_MATERIAL_AMOUNT)
	max_integrity = 200 //Twice as durable as regular signs.
	armor_type = /datum/armor/structure_plaque
	///Custom plaque structures and items both start "unengraved", once engraved with a fountain pen their text can't be altered again. Static plaques are already engraved.
	var/engraved = FALSE

/datum/armor/structure_plaque
	melee = 50
	fire = 50
	acid = 50

/obj/structure/plaque/Initialize(mapload)
	. = ..()
	if(mapload)
		find_and_mount_on_atom()
	register_context()

/obj/structure/plaque/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	switch (held_item?.tool_behaviour)
		if (TOOL_WELDER)
			context[SCREENTIP_CONTEXT_LMB] = "Repair"
			return CONTEXTUAL_SCREENTIP_SET
		if (TOOL_WRENCH)
			context[SCREENTIP_CONTEXT_LMB] = "Unfasten"
			return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/pen/fountain) && !engraved)
		context[SCREENTIP_CONTEXT_LMB] = "Engrave"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/plaque/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(. || user.is_blind())
		return
	user.examinate(src)

/obj/structure/plaque/wrench_act(mob/living/user, obj/item/wrench/I)
	. = ..()
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает снимать [declent_ru(ACCUSATIVE)]..."), \
		span_notice("Вы начинаете откручивать [declent_ru(ACCUSATIVE)]."))
	I.play_tool_sound(src)
	if(!I.use_tool(src, user, 4 SECONDS))
		return TRUE
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] снимает [declent_ru(ACCUSATIVE)] со стены."), \
		span_notice("Вы снимаете [declent_ru(ACCUSATIVE)] со стены."))
	var/obj/item/plaque/unwrenched_plaque = new (get_turf(user))
	if(engraved) //If it's still just a basic unengraved plaque, we can (and should) skip some of the below variable transfers.
		unwrenched_plaque.name = name //Copy over the plaque structure variables to the plaque item we're creating when we unwrench it.
		unwrenched_plaque.desc = desc
		unwrenched_plaque.engraved = engraved
	unwrenched_plaque.icon_state = icon_state
	unwrenched_plaque.update_integrity(get_integrity())
	unwrenched_plaque.setDir(dir)
	qdel(src) //The plaque structure on the wall goes poof and only the plaque item from unwrenching remains.
	return TRUE

/obj/structure/plaque/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(user.combat_mode)
		return FALSE
	if(atom_integrity == max_integrity)
		to_chat(user, span_warning("Табличка и так в идеальном состоянии."))
		return TRUE
	if(!I.tool_start_check(user, amount=1))
		return TRUE
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает чинить [declent_ru(ACCUSATIVE)]..."), \
		span_notice("Вы начинаете чинить [declent_ru(ACCUSATIVE)]."))
	if(!I.use_tool(src, user, 4 SECONDS, volume = 50))
		return TRUE
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] заканчивает чинить [declent_ru(ACCUSATIVE)]."), \
			span_notice("Вы заканчиваете чинить [declent_ru(ACCUSATIVE)]."))
	atom_integrity = max_integrity
	return TRUE

/obj/structure/plaque/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/pen))
		return NONE

	if(!istype(tool, /obj/item/pen/fountain))
		if(engraved)
			to_chat(user, span_warning("На табличке уже есть гравировка, да и ручка у вас для такого не годится! Найдите перьевую."))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_warning("Такой ручкой гравировку не нанести! Найдите перьевую.")) //Go steal the Curator's.
		return ITEM_INTERACT_BLOCKING

	if(engraved)
		to_chat(user, span_warning("На табличке уже есть гравировка."))
		return ITEM_INTERACT_BLOCKING

	var/namechoice = tgui_input_text(user, "Озаглавьте табличку (например, \"Лучшему работнику месяца\" или \"Памяти погибших пожарных\")", "Гравировка таблички", max_length = MAX_NAME_LEN)
	if(!namechoice)
		return ITEM_INTERACT_BLOCKING

	var/descriptionchoice = tgui_input_text(user, "Текст, который будет выгравирован на табличке", "Гравировка таблички", max_length = MAX_PLAQUE_LEN)
	if(!descriptionchoice)
		return ITEM_INTERACT_BLOCKING

	if(!Adjacent(user)) //Make sure user is adjacent still
		to_chat(user, span_warning("Чтобы гравировать, нужно стоять рядом с табличкой!"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает гравировать табличку."), \
						span_notice("Вы начинаете гравировать табличку."))
	if(!do_after(user, 4 SECONDS, target = src)) //This spits out a visible message that somebody is engraving a plaque, then has a delay.
		return ITEM_INTERACT_BLOCKING

	name = "\improper [namechoice]" //We want improper here so examine doesn't get weird if somebody capitalizes the plaque title.
	desc = "На табличке выгравировано: \"[descriptionchoice]\""
	engraved = TRUE //The plaque now has a name, description, and can't be altered again.
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] наносит гравировку на табличку."), \
						span_notice("Вы наносите гравировку на табличку."))
	return ITEM_INTERACT_SUCCESS

/obj/item/plaque //The item version of the above.
	icon = 'icons/obj/signs.dmi'
	icon_state = "blankplaque"
	inhand_icon_state = "blankplaque"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	name = "blank plaque"
	desc = "Пустая табличка. Гравировку можно нанести хорошей перьевой ручкой. Её можно повесить на стену."
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/gold =SHEET_MATERIAL_AMOUNT)
	max_integrity = 200
	armor_type = /datum/armor/item_plaque
	///This points the item to make the proper structure when placed on a wall.
	var/plaque_path = /obj/structure/plaque
	///Custom plaque structures and items both start "unengraved", once engraved with a fountain pen their text can't be altered again.
	var/engraved = FALSE

/datum/armor/item_plaque
	melee = 50
	fire = 50
	acid = 50

/obj/item/plaque/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(user.combat_mode)
		return FALSE
	if(atom_integrity == max_integrity)
		to_chat(user, span_warning("Табличка и так в идеальном состоянии."))
		return TRUE
	if(!I.tool_start_check(user, amount=1))
		return TRUE
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает чинить [declent_ru(ACCUSATIVE)]..."), \
		span_notice("Вы начинаете чинить [declent_ru(ACCUSATIVE)]."))
	if(!I.use_tool(src, user, 4 SECONDS, volume = 50))
		return TRUE
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] заканчивает чинить [declent_ru(ACCUSATIVE)]."), \
		span_notice("Вы заканчиваете чинить [declent_ru(ACCUSATIVE)]."))
	atom_integrity = max_integrity
	return TRUE


/obj/item/plaque/item_interaction(mob/living/user, obj/item/tool, list/modifiers) //Same as part of the above, except for the item in hand instead of the structure.
	if(!istype(tool, /obj/item/pen))
		return NONE

	if(!istype(tool, /obj/item/pen/fountain))
		if(engraved)
			to_chat(user, span_warning("На табличке уже есть гравировка, да и ручка у вас для такого не годится! Найдите перьевую."))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_warning("Такой ручкой гравировку не нанести! Найдите перьевую.")) //Go steal the Curator's.
		return ITEM_INTERACT_BLOCKING

	if(engraved)
		to_chat(user, span_warning("На табличке уже есть гравировка."))
		return ITEM_INTERACT_BLOCKING

	var/namechoice = tgui_input_text(user, "Озаглавьте табличку (например, \"Лучшему работнику месяца\" или \"Памяти погибших пожарных\")", "Гравировка таблички", max_length = MAX_NAME_LEN)
	if(!namechoice)
		return ITEM_INTERACT_BLOCKING

	var/descriptionchoice = tgui_input_text(user, "Текст, который будет выгравирован на табличке", "Гравировка таблички", max_length = MAX_PLAQUE_LEN)
	if(!descriptionchoice)
		return ITEM_INTERACT_BLOCKING

	if(!Adjacent(user)) //Make sure user is adjacent still
		to_chat(user, span_warning("Чтобы гравировать, нужно стоять рядом с табличкой!"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает гравировать табличку."), \
						span_notice("Вы начинаете гравировать табличку."))
	if(!do_after(user, 4 SECONDS, target = src)) //This spits out a visible message that somebody is engraving a plaque, then has a delay.
		return ITEM_INTERACT_BLOCKING

	name = "\improper [namechoice]" //We want improper here so examine doesn't get weird if somebody capitalizes the plaque title.
	desc = "На табличке выгравировано: \"[descriptionchoice]\""
	engraved = TRUE //The plaque now has a name, description, and can't be altered again.
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] наносит гравировку на табличку."), \
						span_notice("Вы наносите гравировку на табличку."))
	return ITEM_INTERACT_SUCCESS

/obj/item/plaque/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!iswallturf(interacting_with))
		return NONE
	var/turf/target_turf = interacting_with
	var/turf/user_turf = get_turf(user)
	var/obj/structure/plaque/placed_plaque = new plaque_path(user_turf) //We place the plaque on the turf the user is standing, and pixel shift it to the target wall, as below.
	//This is to mimic how signs and other wall objects are usually placed by mappers, and so they're only visible from one side of a wall.
	var/dir = get_dir(user_turf, target_turf)
	if(dir & NORTH)
		placed_plaque.pixel_y = 32
	else if(dir & SOUTH)
		placed_plaque.pixel_y = -32
	if(dir & EAST)
		placed_plaque.pixel_x = 32
	else if(dir & WEST)
		placed_plaque.pixel_x = -32
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] крепит [declent_ru(ACCUSATIVE)] к стене."), \
		span_notice("Вы крепите [declent_ru(ACCUSATIVE)] к стене."))
	playsound(target_turf, 'sound/items/deconstruct.ogg', 50, TRUE)
	if(engraved)
		placed_plaque.name = name
		placed_plaque.desc = desc
		placed_plaque.engraved = engraved
	placed_plaque.icon_state = icon_state
	placed_plaque.update_integrity(get_integrity())
	placed_plaque.setDir(dir)
	qdel(src)
	return ITEM_INTERACT_SUCCESS
