//backpack item
#define HALFWAYCRITDEATH ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)
#define DEFIB_CAN_HURT(source) (source.combat || (source.req_defib && !source.defib.safety))

/obj/item/defibrillator
	name = "defibrillator"
	desc = "A device that delivers powerful shocks to detachable paddles that resuscitate incapacitated patients. \
	Has a rear bracket for attachments to wall mounts and medical cyborgs."
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "defibunit"
	inhand_icon_state = "defibunit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	actions_types = list(/datum/action/item_action/toggle_paddles)
	armor_type = /datum/armor/item_defibrillator

	var/obj/item/shockpaddles/paddle_type = /obj/item/shockpaddles
	/// If the paddles are equipped (1) or on the defib (0)
	var/on = FALSE
	/// If you can zap people with the defibs on harm mode
	var/safety = TRUE
	/// If there's a cell in the defib with enough power for a revive, blocks paddles from reviving otherwise
	var/powered = FALSE
	/// If the cell can be removed via screwdriver
	var/cell_removable = TRUE
	var/obj/item/shockpaddles/paddles
	var/obj/item/stock_parts/power_store/cell/cell
	/// If true, revive through space suits, allow for combat shocking
	var/combat = FALSE
	/// How long does it take to recharge
	var/cooldown_duration = 5 SECONDS
	/// The icon state for the paddle overlay, not applied if null
	var/paddle_state = "defibunit-paddles"
	/// The icon state for the powered on overlay, not applied if null
	var/powered_state = "defibunit-powered"
	/// The icon state for the charge bar overlay, not applied if null
	var/charge_state = "defibunit-charge"
	/// The icon state for the missing cell overlay, not applied if null
	var/nocell_state = "defibunit-nocell"
	/// The icon state for the emagged overlay, not applied if null
	var/emagged_state = "defibunit-emagged"

/datum/armor/item_defibrillator
	fire = 50
	acid = 50

/obj/item/defibrillator/get_cell()
	return cell

/obj/item/defibrillator/Initialize(mapload) //starts without a cell for rnd
	. = ..()
	paddles = new paddle_type(src)
	update_power()
	RegisterSignal(paddles, COMSIG_DEFIBRILLATOR_SUCCESS, PROC_REF(on_defib_success))
	AddElement(/datum/element/drag_pickup)

/obj/item/defibrillator/loaded/Initialize(mapload) //starts with hicap
	. = ..()
	cell = new(src)
	update_power()

/obj/item/defibrillator/examine(mob/user)
	. = ..()
	if(!cell_removable)
		return
	if(cell)
		. += span_notice("Батарею можно достать отвёрткой.")
	else
		. += span_warning("Внутри нет батареи!")

/obj/item/defibrillator/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(paddles?.loc == src)
		paddles.fire_act(exposed_temperature, exposed_volume)

/obj/item/defibrillator/extinguish()
	. = ..()
	if(paddles?.loc == src)
		paddles.extinguish()

/obj/item/defibrillator/proc/update_power()
	if(!QDELETED(cell))
		if(QDELETED(paddles) || cell.charge < paddles.revivecost)
			powered = FALSE
		else
			powered = TRUE
	else
		powered = FALSE
	update_appearance()
	if(istype(loc, /obj/machinery/defibrillator_mount))
		loc.update_appearance()

/obj/item/defibrillator/update_overlays()
	. = ..()

	if(!on && paddle_state)
		. += paddle_state
	if(powered && powered_state)
		. += powered_state
		if(!QDELETED(cell) && charge_state)
			var/ratio = cell.charge / cell.maxcharge
			ratio = ceil(ratio*4) * 25
			. += "[charge_state][ratio]"
	if(!cell && nocell_state)
		. += "[nocell_state]"
	if(!safety && emagged_state)
		. += emagged_state

/obj/item/defibrillator/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	cell = locate(/obj/item/stock_parts/power_store) in contents
	update_power()

/obj/item/defibrillator/ui_action_click(mob/user, actiontype)
	INVOKE_ASYNC(src, PROC_REF(toggle_paddles), user)

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/defibrillator/attack_hand(mob/user, list/modifiers)
	if(loc == user)
		if(user.get_slot_by_item(src) & slot_flags)
			ui_action_click(user, modifiers)
		else
			balloon_alert(user, "сначала наденьте дефибриллятор!")
		return
	else if(istype(loc, /obj/machinery/defibrillator_mount))
		ui_action_click(user, modifiers) //checks for this are handled in defibrillator.mount.dm
	return ..()

/obj/item/defibrillator/screwdriver_act(mob/living/user, obj/item/tool)
	if(!cell || !cell_removable)
		return FALSE

	cell.forceMove(get_turf(src))
	balloon_alert(user, "removed [cell]")
	cell = null
	tool.play_tool_sound(src, 50)
	update_power()
	return TRUE

/obj/item/defibrillator/item_interaction(mob/living/user, obj/item/item, list/modifiers)
	if(item == paddles)
		toggle_paddles(user)
		return NONE
	if(!istype(item, /obj/item/stock_parts/power_store/cell))
		return NONE

	var/obj/item/stock_parts/power_store/cell/new_cell = item
	if(!isnull(cell))
		to_chat(user, span_warning("Батарея уже стоит!"))
		return ITEM_INTERACT_BLOCKING

	if(new_cell.maxcharge < paddles.revivecost)
		to_chat(user, span_notice("Нужна батарея большей ёмкости."))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(new_cell, src))
		return NONE
	cell = new_cell
	to_chat(user, span_notice("Вы вставляете батарею в [declent_ru(ACCUSATIVE)]."))
	update_power()
	return ITEM_INTERACT_SUCCESS

/obj/item/defibrillator/emag_act(mob/user, obj/item/card/emag/emag_card)

	safety = !safety

	var/enabled_or_disabled = (safety ? "включены" : "отключены")
	balloon_alert(user, "предохранители [enabled_or_disabled]")

	return TRUE

/obj/item/defibrillator/emp_act(severity)
	. = ..()
	if(cell && !(. & EMP_PROTECT_CONTENTS))
		deductcharge(STANDARD_CELL_CHARGE / severity)
	if (. & EMP_PROTECT_SELF)
		return

	update_power()

/obj/item/defibrillator/proc/toggle_paddles(mob/living/user)
	on = !on
	if(on)
		//Detach the paddles into the user's hands
		if(!user.put_in_hands(paddles))
			on = FALSE
			to_chat(user, span_warning("Чтобы взять электроды, нужна свободная рука!"))
			update_power()
			return
	else
		//Remove from their hands and back onto the defib unit
		remove_paddles(user)

	update_power()
	update_item_action_buttons()


/obj/item/defibrillator/equipped(mob/user, slot)
	..()
	if(!(slot_flags & slot))
		remove_paddles(user)
		update_power()

/obj/item/defibrillator/proc/remove_paddles(mob/user) //this fox the bug with the paddles when other player stole you the defib when you have the paddles equiped
	if(ismob(paddles.loc))
		var/mob/M = paddles.loc
		M.dropItemToGround(paddles, TRUE)
	return

/obj/item/defibrillator/Destroy()
	if(on)
		var/M = get(paddles, /mob)
		remove_paddles(M)
	QDEL_NULL(paddles)
	QDEL_NULL(cell)
	return ..()

/obj/item/defibrillator/proc/deductcharge(chrgdeductamt)
	if(QDELETED(cell))
		return

	if(cell.charge < (paddles.revivecost + chrgdeductamt))
		powered = FALSE
	if(!cell.use(chrgdeductamt))
		powered = FALSE

	update_power()

/obj/item/defibrillator/proc/cooldowncheck()
	addtimer(CALLBACK(src, PROC_REF(finish_charging)), cooldown_duration)

/obj/item/defibrillator/proc/finish_charging()
	if(cell)
		if(cell.charge >= paddles.revivecost)
			visible_message(span_notice("[capitalize(declent_ru(NOMINATIVE))] пищит: \"Прибор готов\"."))
			playsound(src, 'sound/machines/defib/defib_ready.ogg', 50, FALSE)
		else
			visible_message(span_notice("[capitalize(declent_ru(NOMINATIVE))] пищит: \"Заряд исчерпан\"."))
			playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
	paddles.cooldown = FALSE
	paddles.update_appearance()
	update_power()

/obj/item/defibrillator/proc/on_defib_success(obj/item/shockpaddles/source)
	deductcharge(source.revivecost)
	source.cooldown = TRUE
	cooldowncheck()
	return COMPONENT_DEFIB_STOP

/obj/item/defibrillator/compact
	name = "compact defibrillator"
	desc = "Поясной дефибриллятор, который можно пустить в ход за считаные секунды."
	icon_state = "defibcompact"
	inhand_icon_state = null
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE|ITEM_SLOT_DEX_STORAGE
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "defibcompact"
	w_class = WEIGHT_CLASS_NORMAL
	paddle_state = "defibcompact-paddles"
	powered_state = "defibcompact-powered"
	charge_state = "defibcompact-charge"
	nocell_state = "defibcompact-nocell"
	emagged_state = "defibcompact-emagged"

/obj/item/defibrillator/compact/loaded/Initialize(mapload)
	. = ..()
	cell = new(src)
	update_power()

/obj/item/defibrillator/compact/loaded/cmo // subtype for the spy steal objective
	name = "chief medical officer's compact defibrillator"
	icon_state = "defibcmo"
	resistance_flags = INDESTRUCTIBLE // So no cheesy getting rid of like other steal/head items

/obj/item/defibrillator/compact/combat
	name = "combat defibrillator"
	desc = "A belt-equipped blood-red defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, and can be utilized as a weapon via applying the paddles while in a combat stance."
	icon_state = "defibcombat" //needs defib inhand sprites
	inhand_icon_state = null
	worn_icon_state = "defibcombat"
	combat = TRUE
	safety = FALSE
	cooldown_duration = 2.5 SECONDS
	paddle_type = /obj/item/shockpaddles/syndicate
	paddle_state = "defibcombat-paddles"
	powered_state = null
	emagged_state = null

/obj/item/defibrillator/compact/combat/loaded
	cell_removable = FALSE // Don't let people just have an infinite power cell

/obj/item/defibrillator/compact/combat/loaded/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/infinite(src)
	update_power()

/obj/item/defibrillator/compact/combat/loaded/nanotrasen
	name = "elite Nanotrasen defibrillator"
	desc = "A belt-equipped state-of-the-art defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, and can be utilized as a weapon via applying the paddles while in a combat stance."
	icon_state = "defibnt" //needs defib inhand sprites
	inhand_icon_state = null
	worn_icon_state = "defibnt"
	paddle_type = /obj/item/shockpaddles/syndicate/nanotrasen
	paddle_state = "defibnt-paddles"

//paddles

/obj/item/shockpaddles
	name = "defibrillator paddles"
	desc = "Пара электродов с пластиковыми ручками и плоскими металлическими пластинами. Бьют мощным разрядом."
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	spawn_blacklisted = TRUE

	force = 0
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = INDESTRUCTIBLE
	base_icon_state = "defibpaddles"

	var/revivecost = STANDARD_CELL_CHARGE * 0.1
	var/cooldown = FALSE
	var/busy = FALSE
	var/obj/item/defibrillator/defib
	var/req_defib = TRUE // Whether or not the paddles require a defibrilator object
	var/recharge_time = 6 SECONDS // Only applies to defibs that do not require a defibrilator. See: do_success()
	var/combat = FALSE //If it penetrates armor and gives additional functionality

/obj/item/shockpaddles/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_BACK)
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12)
	RegisterSignal(src, COMSIG_HUMAN_NON_STORAGE_HOTKEY, PROC_REF(on_non_storage_hotkey))

/obj/item/shockpaddles/Destroy()
	defib = null
	return ..()

/obj/item/shockpaddles/equipped(mob/user, slot)
	. = ..()
	if(!req_defib)
		return
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))
	RegisterSignal(defib, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))

/obj/item/shockpaddles/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	check_range()

/obj/item/shockpaddles/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if((req_defib && defib) && loc != defib)
		defib.fire_act(exposed_temperature, exposed_volume)

/obj/item/shockpaddles/proc/check_range()
	SIGNAL_HANDLER

	if(!req_defib || !defib)
		return
	if(!in_range(src,defib))
		if(isliving(loc))
			var/mob/living/user = loc
			to_chat(user, span_warning("Провод натягивается, и электроды вырываются у вас из рук!"))
		else
			visible_message(span_notice("Электроды защёлкиваются обратно в корпус."))
		snap_back()

/obj/item/shockpaddles/proc/recharge(time = 0)
	if(req_defib)
		return
	cooldown = TRUE
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(finish_recharge)), time)

/obj/item/shockpaddles/proc/finish_recharge()
	var/turf/current_turf = get_turf(src)
	current_turf.audible_message(span_notice("[capitalize(declent_ru(NOMINATIVE))] пищат: \"Прибор заряжен\"."))
	playsound(src, 'sound/machines/defib/defib_ready.ogg', 50, FALSE)
	cooldown = FALSE
	update_appearance()

/obj/item/shockpaddles/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC) //stops shockpaddles from being inserted in BoH
	if(!req_defib)
		return //If it doesn't need a defib, just say it exists
	if (!loc || !istype(loc, /obj/item/defibrillator)) //To avoid weird issues from admin spawns
		return INITIALIZE_HINT_QDEL
	defib = loc
	busy = FALSE
	update_appearance()

/obj/item/shockpaddles/suicide_act(mob/living/user)
	user.visible_message(span_danger("[user] is putting the live paddles on [user.p_their()] chest! Кажется, [user.ru_p_they()] пытается совершить самоубийство!"))
	if(req_defib)
		defib.deductcharge(revivecost)
	playsound(src, 'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
	return OXYLOSS

/obj/item/shockpaddles/update_icon_state()
	icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	inhand_icon_state = icon_state
	if(cooldown)
		icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]_cooldown"
	return ..()

/obj/item/shockpaddles/dropped(mob/user)
	if(!req_defib)
		return ..()
	UnregisterSignal(defib, COMSIG_MOVABLE_MOVED)
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("Электроды защёлкиваются обратно в корпус."))
	snap_back()
	return ..()

/obj/item/shockpaddles/proc/snap_back()
	if(!defib)
		return
	defib.on = FALSE
	forceMove(defib)
	defib.update_power()

/obj/item/shockpaddles/attack(mob/M, mob/living/user, list/modifiers, list/attack_modifiers)
	if(busy)
		return
	defib?.update_power()
	if(req_defib && !defib.powered)
		user.visible_message(span_warning("[capitalize(defib.declent_ru(NOMINATIVE))] пищит: \"Недостаточно заряда!\""))
		playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
		return
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		if(iscyborg(user))
			to_chat(user, span_warning("You must activate the paddles in your active module before you can use them on someone!"))
		else
			to_chat(user, span_warning("Сначала возьмите электроды в обе руки!"))
		return
	if(cooldown)
		if(req_defib)
			to_chat(user, span_warning("[capitalize(defib.declent_ru(NOMINATIVE))] ещё заряжается!"))
		else
			to_chat(user, span_warning("Электроды ещё заряжаются!"))
		return

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		do_disarm(M, user)
		return

	if(!iscarbon(M))
		if(req_defib)
			to_chat(user, span_warning("В инструкции на корпусе не сказано, как оживлять такое..."))
		else
			to_chat(user, span_warning("Вы не представляете, как оживлять такое..."))
		return
	var/mob/living/carbon/H = M

	if(user.zone_selected != BODY_ZONE_CHEST)
		to_chat(user, span_warning("Электроды нужно прикладывать к груди пациента!"))
		return

	if(user.combat_mode)
		do_harm(H, user)
		return

	if(H.can_defib() == DEFIB_POSSIBLE)
		H.notify_revival("Your heart is being defibrillated!")
		H.grab_ghost() // Shove them back in their body.

	do_help(H, user)

/// Called whenever the paddles successfully shock something
/obj/item/shockpaddles/proc/do_success()
	if(busy)
		busy = FALSE

	update_appearance()
	if(SEND_SIGNAL(src, COMSIG_DEFIBRILLATOR_SUCCESS) & COMPONENT_DEFIB_STOP)
		return
	recharge(recharge_time)

/// Called whenever the paddles fail to shock something after a do_x proc
/obj/item/shockpaddles/proc/do_cancel()
	if(busy)
		busy = FALSE

	update_appearance()

/obj/item/shockpaddles/proc/shock_pulling(dmg, mob/H)
	if(isliving(H.pulledby)) //CLEAR!
		var/mob/living/M = H.pulledby
		if(M.electrocute_act(dmg, H))
			M.visible_message(span_danger("[capitalize(M.declent_ru(NOMINATIVE))] получает удар током, касаясь [H.declent_ru(GENITIVE)]!"))
			M.emote("scream")

/obj/item/shockpaddles/proc/do_disarm(mob/living/M, mob/living/user)
	if(!DEFIB_CAN_HURT(src))
		return
	busy = TRUE
	M.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] прикладывает электроды к [M.declent_ru(DATIVE)]!"), \
			span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] прикладывает к вам электроды!"))
	M.adjust_stamina_loss(60)
	M.Knockdown(75)
	M.set_jitter_if_lower(100 SECONDS)
	M.apply_status_effect(/datum/status_effect/convulsing)
	playsound(src,  'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
	if(HAS_TRAIT(M,MOB_ORGANIC))
		M.emote("gasp")
	log_combat(user, M, "zapped", src)
	do_success()

/obj/item/shockpaddles/proc/do_harm(mob/living/carbon/H, mob/living/user)
	if(!DEFIB_CAN_HURT(src))
		return
	user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] подносит электроды к груди [H.declent_ru(GENITIVE)]."),
		span_warning("Вы выкручиваете заряд выше нормы и подносите электроды к груди [H.declent_ru(GENITIVE)]..."))
	busy = TRUE
	update_appearance()
	if(do_after(user, 1.5 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded))))
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] прижимает электроды к груди [H.declent_ru(GENITIVE)]."),
			span_warning("Вы прижимаете электроды к груди [H.declent_ru(GENITIVE)] и набираете заряд."))
		var/turf/T = get_turf(defib)
		playsound(src, 'sound/machines/defib/defib_charge.ogg', 50, FALSE)
		if(req_defib)
			T.audible_message(span_warning("[capitalize(defib.declent_ru(NOMINATIVE))] тревожно пищит, и гул нарастает..."))
		else
			user.audible_message(span_warning("Электроды тревожно пищат."))
		if(do_after(user, 1.5 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded)))) //Takes longer due to overcharging
			if(!H)
				do_cancel()
				return
			if(H && H.stat == DEAD)
				to_chat(user, span_warning("[capitalize(H.declent_ru(NOMINATIVE))] не подаёт признаков жизни."))
				playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
				do_cancel()
				return
			user.visible_message(span_bolddanger("<i>[capitalize(user.declent_ru(NOMINATIVE))] бьёт [H.declent_ru(ACCUSATIVE)] разрядом!"), span_warning("Вы бьёте [H.declent_ru(ACCUSATIVE)] разрядом!"))
			playsound(src, 'sound/machines/defib/defib_zap.ogg', 100, TRUE, -1)
			playsound(src, 'sound/items/weapons/egloves.ogg', 100, TRUE, -1)
			H.emote("scream")
			shock_pulling(45, H)
			if(H.can_heartattack() && !H.undergoing_cardiac_arrest())
				if(!IS_UNCONSCIOUS_OR_CRIT(H))
					H.visible_message(span_warning("[capitalize(H.declent_ru(NOMINATIVE))] бьётся в судорогах, хватаясь за грудь!"),
						span_userdanger("Грудь пронзает чудовищная боль!"))
				H.set_heartattack(TRUE)
			H.apply_damage(50, BURN, BODY_ZONE_CHEST)
			log_combat(user, H, "overloaded the heart of", defib)
			H.Paralyze(100)
			H.set_jitter_if_lower(200 SECONDS)
			do_success()
			return
	do_cancel()

/obj/item/shockpaddles/proc/do_help(mob/living/carbon/H, mob/living/user)
	user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] подносит электроды к груди [H.declent_ru(GENITIVE)]."), span_warning("Вы подносите электроды к груди [H.declent_ru(GENITIVE)]..."))
	busy = TRUE
	update_appearance()
	if(do_after(user, 3 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded)))) //beginning to place the paddles on patient's chest to allow some time for people to move away to stop the process
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] прижимает электроды к груди [H.declent_ru(GENITIVE)]."), span_warning("Вы прижимаете электроды к груди [H.declent_ru(GENITIVE)]."))
		playsound(src, 'sound/machines/defib/defib_charge.ogg', 75, FALSE)
		var/obj/item/organ/heart = H.get_organ_by_type(/obj/item/organ/heart)
		if(do_after(user, 2 SECONDS, H, extra_checks = CALLBACK(src, PROC_REF(is_wielded)))) //placed on chest and short delay to shock for dramatic effect, revive time is 5sec total
			if((!combat && !req_defib) || (req_defib && !defib.combat))
				for(var/obj/item/clothing/C in H.get_equipped_items())
					if((C.body_parts_covered & CHEST) && (C.clothing_flags & THICKMATERIAL)) //check to see if something is obscuring their chest.
						user.audible_message(span_warning("[req_defib ? "Дефибриллятор" : "Прибор"] гудит: \"Грудь пациента закрыта. Операция прервана\"."))
						playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
						do_cancel()
						return
			if(SEND_SIGNAL(H, COMSIG_DEFIBRILLATOR_PRE_HELP_ZAP, user, src) & COMPONENT_DEFIB_STOP)
				do_cancel()
				return
			if(H.stat == DEAD)
				H.visible_message(span_warning("Тело [H.declent_ru(GENITIVE)] слегка вздрагивает."))
				playsound(src, SFX_BODYFALL, 50, TRUE)
				playsound(src, 'sound/machines/defib/defib_zap.ogg', 75, TRUE, -1)
				shock_pulling(30, H)

				var/defib_result = H.can_defib()
				var/fail_reason

				switch (defib_result)
					if (DEFIB_FAIL_SUICIDE)
						fail_reason = "Реанимация невозможна. Дальнейшие попытки бессмысленны."
					if (DEFIB_FAIL_NO_HEART)
						fail_reason = "У пациента отсутствует сердце."
					if (DEFIB_FAIL_FAILING_HEART)
						fail_reason = "Сердце пациента слишком повреждено. Замените или восстановите его и повторите попытку."
					if (DEFIB_FAIL_TISSUE_DAMAGE)
						fail_reason = "Слишком тяжёлые повреждения тканей. Устраните их и повторите попытку."
					if (DEFIB_FAIL_HUSK)
						fail_reason = "От тела пациента осталась одна оболочка. Восстановите ткани и повторите попытку."
					if (DEFIB_FAIL_FAILING_BRAIN)
						fail_reason = "Мозг пациента слишком повреждён. Восстановите его и повторите попытку."
					if (DEFIB_FAIL_NO_INTELLIGENCE)
						fail_reason = "Мозговая активность не обнаружена. Дальнейшие попытки бессмысленны."
					if (DEFIB_FAIL_NO_BRAIN)
						fail_reason = "У пациента отсутствует мозг. Дальнейшие попытки бессмысленны."
					if (DEFIB_FAIL_BLACKLISTED)
						fail_reason = "Реанимация этого пациента запрещена. Дальнейшие попытки бессмысленны."
					// DARKPACK EDIT START
					if (DEFIB_FAIL_STAKED)
						fail_reason = "В сердце пациента инородный предмет. Извлеките его и повторите попытку."
					// DARKPACK EDIT END
					if (DEFIB_FAIL_GOLEM)
						fail_reason = "Пациент состоит из неорганических материалов. Дальнейшие попытки бессмысленны, но возможна ручная реконструкция."

				if(fail_reason)
					user.visible_message(span_warning("[req_defib ? "Дефибриллятор" : "Прибор"] гудит: \"Реанимация не удалась. [fail_reason]\""))
					playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
				else
					var/total_brute = H.get_brute_loss()
					var/total_burn = H.get_fire_loss()

					var/need_mob_update = FALSE
					//If the body has been fixed so that they would not be in crit when defibbed, give them oxyloss to put them back into crit
					if (H.health > HALFWAYCRITDEATH)
						need_mob_update += H.adjust_oxy_loss(H.health - HALFWAYCRITDEATH, updating_health = FALSE)
					else
						var/overall_damage = total_brute + total_burn + H.get_tox_loss() + H.get_oxy_loss()
						var/mobhealth = H.health
						need_mob_update += H.adjust_oxy_loss((mobhealth - HALFWAYCRITDEATH) * (H.get_oxy_loss() / overall_damage), updating_health = FALSE)
						need_mob_update += H.adjust_tox_loss((mobhealth - HALFWAYCRITDEATH) * (H.get_tox_loss() / overall_damage), updating_health = FALSE, forced = TRUE) // force tox heal for toxin lovers too
						need_mob_update += H.adjust_fire_loss((mobhealth - HALFWAYCRITDEATH) * (total_burn / overall_damage), updating_health = FALSE)
						need_mob_update += H.adjust_brute_loss((mobhealth - HALFWAYCRITDEATH) * (total_brute / overall_damage), updating_health = FALSE)
					if(need_mob_update)
						H.updatehealth() // Previous "adjust" procs don't update health, so we do it manually.
					user.visible_message(span_notice("[req_defib ? "Дефибриллятор" : "Прибор"] сигналит: \"Реанимация прошла успешно\"."))
					playsound(src, 'sound/machines/defib/defib_success.ogg', 50, FALSE)
					H.set_heartattack(FALSE)
					if(defib_result == DEFIB_POSSIBLE)
						H.grab_ghost()
					H.revive()
					H.emote("gasp")
					H.set_jitter_if_lower(200 SECONDS)
					SEND_SIGNAL(H, COMSIG_LIVING_MINOR_SHOCK)
					if(HAS_MIND_TRAIT(user, TRAIT_MORBID))
						user.add_mood_event("morbid_saved_life", /datum/mood_event/morbid_saved_life)
					else
						user.add_mood_event("saved_life", /datum/mood_event/saved_life)
					log_combat(user, H, "revived", defib)
				do_success()
				return
			else if (!H.get_organ_by_type(/obj/item/organ/heart))
				user.visible_message(span_warning("[req_defib ? "Дефибриллятор" : "Прибор"] гудит: \"У пациента отсутствует сердце. Операция прервана\"."))
				playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
			else if(H.undergoing_cardiac_arrest())
				playsound(src, 'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
				if(!(heart.organ_flags & ORGAN_FAILING))
					H.set_heartattack(FALSE)
					do_success()
					user.visible_message(span_notice("[req_defib ? "Дефибриллятор" : "Прибор"] сигналит: \"Сердцебиение пациента восстановлено\"."))
				else
					user.visible_message(span_warning("[req_defib ? "Дефибриллятор" : "Прибор"] гудит: \"Реанимация не удалась, обнаружено повреждение сердца\"."))
			else if(H.has_status_effect(/datum/status_effect/heart_attack))
				user.visible_message(span_notice("[req_defib ? "Дефибриллятор" : "Прибор"] сигналит: \"Сердечный ритм стабилизирован, может потребоваться повторный разряд\"."))
				SEND_SIGNAL(H, COMSIG_HEARTATTACK_DEFIB)
				playsound(src, 'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)
				do_success()
			else
				user.visible_message(span_warning("[req_defib ? "Дефибриллятор" : "Прибор"] гудит: \"Состояние пациента не допускает процедуру. Операция прервана\"."))
				playsound(src, 'sound/machines/defib/defib_failed.ogg', 50, FALSE)
	do_cancel()

/obj/item/shockpaddles/proc/is_wielded()
	return HAS_TRAIT(src, TRAIT_WIELDED)

/obj/item/shockpaddles/proc/on_non_storage_hotkey(datum/source,  mob/living/carbon/human/user, obj/item/possible_storage)
	SIGNAL_HANDLER
	if(possible_storage == defib)
		user.dropItemToGround(src)
		return COMPONENT_STORAGE_HOTKEY_HANDLED
	return NONE

/obj/item/shockpaddles/cyborg
	name = "cyborg defibrillator paddles"
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "defibpaddles0"
	inhand_icon_state = "defibpaddles0"
	req_defib = FALSE

/obj/item/shockpaddles/cyborg/attack(mob/M, mob/user)
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user
		if(R.emagged)
			combat = TRUE
		else
			combat = FALSE
	else
		combat = FALSE

	. = ..()

/obj/item/shockpaddles/syndicate
	name = "syndicate defibrillator paddles"
	desc = "A pair of paddles used to revive deceased operatives. They possess both the ability to penetrate armor and to deliver powerful or disabling shocks offensively."
	combat = TRUE
	icon = 'icons/obj/medical/defib.dmi'
	icon_state = "syndiepaddles0"
	inhand_icon_state = "syndiepaddles0"
	base_icon_state = "syndiepaddles"

/obj/item/shockpaddles/syndicate/nanotrasen
	name = "elite Nanotrasen defibrillator paddles"
	desc = "A pair of paddles used to revive deceased ERT members. They possess both the ability to penetrate armor and to deliver powerful or disabling shocks offensively."
	icon_state = "ntpaddles0"
	inhand_icon_state = "ntpaddles0"
	base_icon_state = "ntpaddles"

/obj/item/shockpaddles/syndicate/cyborg
	req_defib = FALSE

#undef HALFWAYCRITDEATH
#undef DEFIB_CAN_HURT
