/obj/item/reagent_containers/dropper
	name = "dropper"
	desc = "Пипетка. Вмещает до 5 единиц."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "dropper0"
	inhand_icon_state = "dropper"
	worn_icon_state = "pen"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(1, 2, 3, 4, 5)
	volume = 5
	initial_reagent_flags = TRANSPARENT
	custom_price = PAYCHECK_CREW
	custom_materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.1)

/obj/item/reagent_containers/dropper/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!target.reagents)
		return NONE

	if(reagents.total_volume > 0)
		if(target.reagents.holder_full())
			to_chat(user, span_notice("В [target.declent_ru(ACCUSATIVE)] больше не влезет."))
			return ITEM_INTERACT_BLOCKING

		if(!target.is_injectable(user))
			to_chat(user, span_warning("В [target.declent_ru(ACCUSATIVE)] ничего не закапать!"))
			return ITEM_INTERACT_BLOCKING

		var/trans = 0
		var/fraction = min(amount_per_transfer_from_this / reagents.total_volume, 1)

		if(ismob(target))
			user.changeNext_move(CLICK_CD_MELEE)
			if(ishuman(target))
				var/mob/living/carbon/human/victim = target
				var/obj/item/safe_thing = victim.is_eyes_covered()

				if(safe_thing)
					if(!safe_thing.reagents)
						safe_thing.create_reagents(100)

					trans = round(reagents.trans_to(safe_thing, amount_per_transfer_from_this, transferred_by = user, methods = TOUCH), CHEMICAL_VOLUME_ROUNDING)

					target.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] пытается закапать что-то в глаза [target.declent_ru(DATIVE)], но безуспешно!"), \
											span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] пытается закапать вам что-то в глаза, но безуспешно!"))
					if(trans)
						to_chat(user, span_notice("Вы выпускаете [trans] ед. раствора."))
					update_appearance()
					return ITEM_INTERACT_BLOCKING

			else if(isalien(target)) //hiss-hiss has no eyes!
				to_chat(target, span_danger("У [target.declent_ru(GENITIVE)], похоже, нет глаз!"))
				return ITEM_INTERACT_BLOCKING

			target.visible_message(
				span_danger("[capitalize(user.declent_ru(NOMINATIVE))] закапывает что-то в глаза [target.declent_ru(DATIVE)]!"),
				span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] закапывает вам что-то в глаза!"),
			)
			SEND_SIGNAL(target, COMSIG_MOB_REAGENTS_DROPPED_INTO_EYES, user, src, reagents, fraction)
			reagents.expose(target, TOUCH, fraction)
			var/mob/M = target
			log_combat(user, M, "squirted", reagents.get_reagent_log_string())

		trans = round(reagents.trans_to(target, amount_per_transfer_from_this, transferred_by = user), CHEMICAL_VOLUME_ROUNDING)
		if(trans)
			to_chat(user, span_notice("Вы выпускаете [trans] ед. раствора."))
		playsound(src, 'sound/effects/droplet.ogg', 70, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		update_appearance()
		target.update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(!target.is_drawable(user, FALSE)) //No drawing from mobs here
		to_chat(user, span_warning("Напрямую из [target.declent_ru(GENITIVE)] ничего не набрать!"))
		return ITEM_INTERACT_BLOCKING

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("В [target.declent_ru(PREPOSITIONAL)] пусто!"))
		return ITEM_INTERACT_BLOCKING

	var/trans = round(target.reagents.trans_to(src, amount_per_transfer_from_this, transferred_by = user), CHEMICAL_VOLUME_ROUNDING)
	if(trans)
		to_chat(user, span_notice("Вы набираете в пипетку [trans] ед. раствора."))

	update_appearance()
	target.update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/dropper/update_overlays()
	. = ..()
	if(!reagents.total_volume)
		return
	var/mutable_appearance/filling = mutable_appearance('icons/obj/medical/reagent_fillings.dmi', "dropper")
	filling.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling
