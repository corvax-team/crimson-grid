/obj/structure/urinal
	name = "urinal"
	desc = "HU-452, экспериментальный писсуар. В комплекте экспериментальная таблетка для писсуара."
	icon = 'modular_darkpack/master_files/icons/obj/watercloset.dmi' // DARKPACK EDIT CHANGE
	icon_state = "urinal"
	density = FALSE
	anchored = TRUE
	/// Can you currently put an item inside
	var/exposed = FALSE
	/// What's in the urinal
	var/obj/item/hidden_item

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/urinal, 32)

/obj/structure/urinal/Initialize(mapload)
	. = ..()
	if(mapload)
		hidden_item = new /obj/item/food/urinalcake(src)
		find_and_mount_on_atom()

/obj/structure/urinal/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == hidden_item)
		hidden_item = null

/obj/structure/urinal/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(user.pulling && isliving(user.pulling))
		var/mob/living/grabbed_mob = user.pulling
		if(user.grab_state >= GRAB_AGGRESSIVE)
			if(grabbed_mob.loc != get_turf(src))
				to_chat(user, span_notice("Сначала подтащите жертву к писсуару."))
				return
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message(span_danger("[user] прикладывает [grabbed_mob.declent_ru(ACCUSATIVE)] о писсуар!"), span_danger("Вы прикладываете [grabbed_mob.declent_ru(ACCUSATIVE)] о писсуар!"))
			grabbed_mob.emote("scream")
			grabbed_mob.adjust_brute_loss(8)
		else
			to_chat(user, span_warning("Нужно ухватить покрепче!"))
		return

	if(exposed)
		if(hidden_item)
			to_chat(user, span_notice("Вы выуживаете из слива [hidden_item.declent_ru(ACCUSATIVE)]."))
			user.put_in_hands(hidden_item)
		else
			to_chat(user, span_warning("В сливе ничего нет!"))
		return
	return ..()

/obj/structure/urinal/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!exposed)
		return NONE

	if(hidden_item)
		to_chat(user, span_warning("В сливе уже что-то лежит!"))
		return ITEM_INTERACT_BLOCKING

	if(tool.w_class > WEIGHT_CLASS_TINY)
		to_chat(user, span_warning("[capitalize(tool.declent_ru(NOMINATIVE))] в слив не пролезет."))
		return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(tool, src))
		to_chat(user, span_warning("[capitalize(tool.declent_ru(NOMINATIVE))] не отлипает от руки, в слив не положить!"))
		return ITEM_INTERACT_BLOCKING

	hidden_item = tool
	to_chat(user, span_notice("Вы прячете [tool.declent_ru(ACCUSATIVE)] в слив."))
	return ITEM_INTERACT_SUCCESS

/obj/structure/urinal/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	to_chat(user, span_notice("Вы начинаете [exposed ? "прикручивать крышку слива на место" : "откручивать крышку слива"]..."))
	playsound(loc, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)
	if(I.use_tool(src, user, 20))
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] [exposed ? "прикручивает крышку слива на место" : "откручивает крышку слива"]!"),
			span_notice("Вы [exposed ? "прикрутили крышку слива на место" : "открутили крышку слива"]!"),
			span_hear("Слышны лязг и хлюпанье."))
		exposed = !exposed
	return TRUE

/obj/structure/urinal/wrench_act_secondary(mob/living/user, obj/item/tool)
	tool.play_tool_sound(user)
	deconstruct(TRUE)
	balloon_alert(user, "писсуар снят")
	return ITEM_INTERACT_SUCCESS

/obj/structure/urinal/atom_deconstruct(disassembled = TRUE)
	new /obj/item/wallframe/urinal(loc)
	hidden_item?.forceMove(drop_location())

/obj/item/wallframe/urinal
	name = "urinal frame"
	desc = "Писсуар без крепления. Чтобы пользоваться, повесьте на стену."
	icon = 'modular_darkpack/master_files/icons/obj/watercloset.dmi' // DARKPACK EDIT CHANGE
	icon_state = "urinal"
	result_path = /obj/structure/urinal
	pixel_shift = 32

/obj/item/food/urinalcake
	name = "urinal cake"
	desc = "Благородная таблетка для писсуара: бережёт городские трубы от городской мочи. Не есть."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinalcake"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/chlorine = 3,
		/datum/reagent/ammonia = 1,
	)
	foodtypes = TOXIC | GROSS
	preserved_food = TRUE

/obj/item/food/urinalcake/attack_self(mob/living/user)
	user.visible_message(span_notice("[user] сминает [declent_ru(ACCUSATIVE)]!"), span_notice("Вы сминаете [declent_ru(ACCUSATIVE)]."), "<i>Слышно хлюпанье.</i>")
	icon_state = "urinalcake_squish"
	addtimer(VARSET_CALLBACK(src, icon_state, "urinalcake"), 0.8 SECONDS)
