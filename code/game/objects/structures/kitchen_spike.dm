#define MEATSPIKE_IRONROD_REQUIREMENT 4

/obj/structure/kitchenspike_frame
	name = "meatspike frame"
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "spikeframe"
	desc = "Каркас для мясного крюка."
	density = TRUE
	anchored = FALSE
	max_integrity = 200
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/structure/kitchenspike_frame/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/kitchenspike_frame/examine(mob/user)
	. = ..()
	. += "Можно <b>разрезать сваркой</b>."
	. += "Если добавить железных стержней (<b>[MEATSPIKE_IRONROD_REQUIREMENT]</b>), получится <b>мясной крюк</b>."

/obj/structure/kitchenspike_frame/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(isnull(held_item))
		return NONE

	var/message = ""
	if(held_item.tool_behaviour == TOOL_WELDER)
		message = "Deconstruct"
	else if(held_item.tool_behaviour == TOOL_WRENCH)
		message = "Bolt Down Frame"

	if(!message)
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = message
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/kitchenspike_frame/welder_act(mob/living/user, obj/item/tool)
	if(!tool.tool_start_check(user, amount = 0, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return FALSE
	to_chat(user, span_notice("Вы начинаете разрезать [declent_ru(ACCUSATIVE)]..."))
	if(!tool.use_tool(src, user, 5 SECONDS, volume = 50))
		return TRUE
	visible_message(span_notice("[user] разрезает [declent_ru(ACCUSATIVE)]."),
		span_notice("Вы разрезали [declent_ru(ACCUSATIVE)]."),
		span_hear("Слышно шипение сварки."))
	new /obj/item/stack/sheet/iron(loc, MEATSPIKE_IRONROD_REQUIREMENT)
	qdel(src)
	return TRUE

/obj/structure/kitchenspike_frame/wrench_act(mob/living/user, obj/item/tool)
	default_unfasten_wrench(user, tool)
	return TRUE

/obj/structure/kitchenspike_frame/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	add_fingerprint(user)
	if(!istype(tool, /obj/item/stack/rods))
		return NONE

	var/obj/item/stack/rods/used_rods = tool
	if(used_rods.get_amount() < MEATSPIKE_IRONROD_REQUIREMENT)
		balloon_alert(user, "нужно стержней: [MEATSPIKE_IRONROD_REQUIREMENT]!")
		return ITEM_INTERACT_BLOCKING

	used_rods.use(MEATSPIKE_IRONROD_REQUIREMENT)
	var/obj/structure/new_meatspike = new /obj/structure/kitchenspike(loc)
	new_meatspike.balloon_alert(user, "мясной крюк готов")
	transfer_fingerprints_to(new_meatspike)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/kitchenspike
	name = "meat spike"
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "spike"
	desc = "Крюк, на котором разделывают туши."
	density = TRUE
	anchored = TRUE
	buckle_lying = 180
	buckle_dir = SOUTH
	can_buckle = TRUE
	max_integrity = 250
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7)
	buckle_delay = 10 SECONDS

/obj/structure/kitchenspike/Initialize(mapload)
	. = ..()
	register_context()
	ADD_TRAIT(src, TRAIT_DANGEROUS_BUCKLE, INNATE_TRAIT)

/obj/structure/kitchenspike/examine(mob/user)
	. = ..()
	. += "<b>Перетащите на него тело</b>, чтобы насадить на крюк."
	. += "Крючья можно снять <b>ломом</b>."

/obj/structure/kitchenspike/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(isnull(held_item))
		return NONE

	if(held_item.tool_behaviour == TOOL_CROWBAR)
		context[SCREENTIP_CONTEXT_LMB] = "Снять крючья"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/structure/kitchenspike/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/kitchenspike/crowbar_act(mob/living/user, obj/item/tool)
	if(has_buckled_mobs())
		to_chat(user, span_warning("Сначала снимите то, что висит на крюке!"))
		return TRUE

	if(tool.use_tool(src, user, 2 SECONDS, volume = 100))
		to_chat(user, span_notice("Вы выламываете крючья из каркаса."))
		deconstruct(TRUE)
		return TRUE
	return FALSE

/obj/structure/kitchenspike/user_buckle_mob(mob/living/target, mob/user, check_loc = TRUE)
	if(!iscarbon(target) && !isanimal_or_basicmob(target))
		return
	if(target != user || target.loc == loc)
		return ..()
	if(!do_after(user, 10 SECONDS, target))
		return
	if(!is_user_buckle_possible(target, user, check_loc))
		return FALSE
	return ..()

/obj/structure/kitchenspike/post_buckle_mob(mob/living/target)
	playsound(src.loc, 'sound/effects/splat.ogg', 25, TRUE)
	target.emote("scream")
	target.add_splatter_floor()
	target.adjust_brute_loss(30)
	target.add_offsets(type, x_add = -1)
	target.set_lying_angle(buckle_lying)
	ADD_TRAIT(target, TRAIT_MOVE_UPSIDE_DOWN, REF(src))
	// So you can butcher people too
	target.AddComponentFrom(REF(src), /datum/component/free_operation)

/obj/structure/kitchenspike/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(buckled_mob != user)
		buckled_mob.visible_message(span_notice("[user] пытается снять [buckled_mob.declent_ru(ACCUSATIVE)] с крюка!"),\
			span_notice("[user] пытается снять вас с крюка, и раны расходятся ещё сильнее!"),\
			span_hear("Слышен влажный чавкающий звук."))
		if(!do_after(user, 30 SECONDS, target = src))
			if(buckled_mob?.buckled)
				buckled_mob.visible_message(span_notice("[user] не может снять [buckled_mob.declent_ru(ACCUSATIVE)] с крюка!"),\
					span_notice("[user] не может снять вас с крюка."))
			return

	else
		buckled_mob.visible_message(span_warning("[buckled_mob] рвётся с крюка!"),\
		span_notice("Вы рвётесь с крюка, раздирая раны ещё сильнее! (Не двигайтесь две минуты.)"),\
		span_hear("Слышен влажный чавкающий звук..."))
		buckled_mob.adjust_brute_loss(30)
		if(!do_after(buckled_mob, 2 MINUTES, target = src, cog_icon = null))
			if(buckled_mob?.buckled)
				to_chat(buckled_mob, span_warning("Освободиться не получилось!"))
			return
	return ..()

/obj/structure/kitchenspike/post_unbuckle_mob(mob/living/buckled_mob)
	buckled_mob.adjust_brute_loss(30)
	INVOKE_ASYNC(buckled_mob, TYPE_PROC_REF(/mob, emote), "scream")
	buckled_mob.AdjustParalyzed(20)
	buckled_mob.remove_offsets(type)
	REMOVE_TRAIT(buckled_mob, TRAIT_MOVE_UPSIDE_DOWN, REF(src))
	buckled_mob.RemoveComponentSource(REF(src), /datum/component/free_operation)

/obj/structure/kitchenspike/atom_deconstruct(disassembled = TRUE)
	if(disassembled)
		var/obj/structure/meatspike_frame = new /obj/structure/kitchenspike_frame(src.loc)
		transfer_fingerprints_to(meatspike_frame)
	else
		new /obj/item/stack/sheet/iron(src.loc, 4)
	new /obj/item/stack/rods(loc, MEATSPIKE_IRONROD_REQUIREMENT)

#undef MEATSPIKE_IRONROD_REQUIREMENT
