/obj/item/reagent_containers/cup/silver_goblet
	name = "silver goblet"
	desc = "Сверкающий кубок для древних вампирских обрядов."
	icon = 'modular_darkpack/modules/sabbat/icons/vaulderie_goblet.dmi'
	icon_state = "pewter_cup"
	base_icon_state = "pewter_cup"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT)
	possible_transfer_amounts = list(1, 5)
	volume = 80
	spillable = TRUE
	resistance_flags = FIRE_PROOF
	var/list/blood_donors = list()

/obj/item/reagent_containers/cup/silver_goblet/is_drainable()
	return TRUE

/obj/item/reagent_containers/cup/silver_goblet/Initialize(mapload)
	. = ..()
	blood_donors = list()

/obj/item/reagent_containers/cup/silver_goblet/update_icon_state()
	. = ..()
	if(reagents && (reagents.has_reagent(/datum/reagent/blood)))
		icon_state = "[base_icon_state]_filled_blood"
	else
		icon_state = base_icon_state

/obj/item/reagent_containers/cup/silver_goblet/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return ..()

	if(!get_kindred_splat(user))
		to_chat(user, span_warning("Вас ничуть не тянет проливать сюда свою кровь."))
		return

	if(reagents.total_volume >= volume)
		to_chat(user, span_warning("В [declent_ru(ACCUSATIVE)] больше не поместится ни капли!"))
		return

	if(user.bloodpool < 2)
		to_chat(user, span_warning("У вас нет лишней крови!"))
		return

	user.visible_message(span_notice("[user.declent_ru(NOMINATIVE)] готовится вскрыть себе запястье и пролить кровь в [declent_ru(ACCUSATIVE)]."), span_notice("Вы готовитесь вскрыть себе запястье и пролить кровь в [declent_ru(ACCUSATIVE)]."))

	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_warning("Вы решаете не проливать свою кровь в [declent_ru(ACCUSATIVE)]."))
		return

	user.visible_message(span_notice("[user.declent_ru(NOMINATIVE)] режет себе запястье, и кровь капает в [declent_ru(ACCUSATIVE)]."), span_notice("Вы режете себе запястье, и ваша кровь стекает в [declent_ru(ACCUSATIVE)]."))

	playsound(user, 'sound/items/weapons/bladeslice.ogg', 30, TRUE)
	user.adjust_brute_loss(5)

	reagents.add_reagent(/datum/reagent/blood/vitae, 10)
	user.adjust_blood_pool(-2)

	if(!(user in blood_donors))
		blood_donors += user

	update_appearance()

/obj/item/reagent_containers/cup/silver_goblet/try_drink(mob/living/target_mob, mob/living/user)
	if(!reagents.has_reagent(/datum/reagent/blood) && !reagents.has_reagent(/datum/reagent/blood/vitae))
		return ..()

	if(!get_kindred_splat(target_mob))
		return ..()

	if(length(blood_donors) >= 2)
		var/choice = tgui_alert(target_mob, "Хотите принять участие в обряде Братания? Он свяжет вас с остальными участниками и разорвёт все прежние узы... (Ваш персонаж перейдёт в секту Шабаш!)", "Обряд Братания", list("Да", "Нет"), 10 SECONDS)
		if(choice != "Да")
			to_chat(target_mob, span_cult("Вы решаете не участвовать в обряде Братания."))
			return ITEM_INTERACT_BLOCKING

	if(length(blood_donors) > 0 && (reagents.has_reagent(/datum/reagent/blood/vitae) || reagents.has_reagent(/datum/reagent/blood)))
		for(var/mob/living/carbon/human/donor in blood_donors)
			if(target_mob != donor)
				to_chat(target_mob, span_warning("Кровь <b>[donor.declent_ru(GENITIVE)]</b> смешивается с вашей, и вы чувствуете, как между вами возникает странная связь!"))
				to_chat(donor, span_notice("Вы чувствуете: <b>[target_mob.declent_ru(NOMINATIVE)]</b> пьёт вашу кровь, и теперь вы связаны."))
				target_mob.visible_message(span_notice("Глаза [target_mob.declent_ru(GENITIVE)] на миг вспыхивают: узы с [donor.declent_ru(INSTRUMENTAL)] скреплены."), span_notice("Ваши глаза вспыхивают: узы крови скреплены."))
				playsound(target_mob, 'sound/effects/magic/smoke.ogg', 20, TRUE)

	if(length(blood_donors) > 1)
		if(!is_sabbatist(target_mob.mind?.assigned_role))
			to_chat(target_mob, span_cult("Вы проходите обряд Братания и вступаете в Шабаш. Прежние узы крови тают..."))
			target_mob.mind.set_assigned_role(SSjob.get_job_type(/datum/job/vampire/sabbatpack))
			target_mob.mind.add_antag_datum(/datum/antagonist/sabbatist) // CRIMSON EDIT ADD - Sabbat Identifier Fix
			//var/datum/antagonist/temp_antag = new()
			//qdel(temp_antag)
	else
		var/antag_transferred = FALSE

		for(var/mob/living/carbon/human/donor in blood_donors)
			if(donor.mind && is_sabbatist(donor.mind.assigned_role))
				if(target_mob.mind && !is_sabbatist(target_mob.mind.assigned_role))
					to_chat(target_mob, span_warning("Вы пьёте кровь [donor.declent_ru(GENITIVE)] и чувствуете, как между вами возникает странная связь..."))
					target_mob.mind.set_assigned_role(SSjob.get_job_type(/datum/job/vampire/sabbatpack))
					target_mob.mind.add_antag_datum(/datum/antagonist/sabbatist) // CRIMSON EDIT ADD - Sabbat Identifier Fix
					//var/datum/antagonist/temp_antag = new()
					//qdel(temp_antag)
					antag_transferred = TRUE
					break

		if(antag_transferred)
			to_chat(target_mob, span_cult("Ваш разум захлёстывают чужие мысли и убеждения. Отныне вы служите Шабашу!"))

	return ..()

/obj/item/reagent_containers/cup/silver_goblet/on_reagent_change()
	. = ..()
	if(reagents.total_volume == 0)
		blood_donors.Cut()
	update_appearance()

/obj/item/reagent_containers/cup/silver_goblet/afterattack(obj/target, mob/user, proximity)
	if(!proximity || !check_allowed_items(target, 1))
		return

	if(target.is_refillable() && !istype(target, /obj/item/reagent_containers/cup/silver_goblet))
		if(reagents.total_volume > 0 && target.reagents.total_volume < target.reagents.maximum_volume)
			blood_donors.Cut()

	return ..()

/obj/item/reagent_containers/cup/silver_goblet/vaulderie_goblet
	name = "Vaulderie Goblet"
	desc = "Чёрная, как обсидиан, чаша для древних вампирских обрядов."
	icon_state = "vaulderie_goblet"
	base_icon_state = "vaulderie_goblet"
