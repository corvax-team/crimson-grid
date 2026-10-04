/obj/item/clothing/shoes
	name = "shoes"
	icon = 'icons/obj/clothing/shoes.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/shoes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/shoes_righthand.dmi'
	abstract_type = /obj/item/clothing/shoes
	desc = "Comfortable-looking shoes."
	pickup_sound = 'sound/items/handling/shoes/sneakers_pickup1.ogg'
	drop_sound = 'sound/items/handling/shoes/sneakers_drop1.ogg'
	equip_sound = 'sound/items/equip/sneakers_equip1.ogg'
	sound_vary = TRUE
	gender = PLURAL //Carn: for grammarically correct text-parsing
	body_parts_covered = FEET
	slot_flags = ITEM_SLOT_FEET
	armor_type = /datum/armor/clothing_shoes
	slowdown = SHOES_SLOWDOWN
	strip_delay = 1 SECONDS
	article = "a pair of"

	var/offset = 0
	var/equipped_before_drop = FALSE
	/// How do these shoes stay on?
	var/fastening_type = SHOES_LACED

	///Are we currently tied? Can either be SHOES_UNTIED, SHOES_TIED, or SHOES_KNOTTED
	var/tied = SHOES_TIED
	///How long it takes to lace/unlace these shoes
	var/lace_time = 5 SECONDS
	///An active alert
	var/datum/weakref/our_alert_ref
	var/footprint_sprite = FOOTPRINT_SPRITE_SHOES

/obj/item/clothing/shoes/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/clothing/shoes/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_RMB] = "Toggle shoes under uniforms"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/shoes/click_alt_secondary(mob/user)
	alternate_worn_layer = (alternate_worn_layer == UNDER_UNIFORM_LAYER) ? NONE : UNDER_UNIFORM_LAYER

	update_slot_icon()
	balloon_alert(user, "теперь [alternate_worn_layer == UNDER_UNIFORM_LAYER ? "под одеждой" : "поверх одежды"]")
	return CLICK_ACTION_SUCCESS

/datum/armor/clothing_shoes
	bio = 50

/obj/item/clothing/shoes/suicide_act(mob/living/user)
	if(prob(50))
		user.visible_message(span_suicide("[user] begins fastening \the [src] up waaay too tightly! Кажется, [user.ru_p_they()] пытается совершить самоубийство!"))
		var/obj/item/bodypart/leg/left = user.get_bodypart(BODY_ZONE_L_LEG)
		var/obj/item/bodypart/leg/right = user.get_bodypart(BODY_ZONE_R_LEG)
		if(left)
			left.dismember()
		if(right)
			right.dismember()
		playsound(user, SFX_DESECRATION, 50, TRUE, -1)
		return BRUTELOSS
	else//didnt realize this suicide act existed (was in miscellaneous.dm) and didnt want to remove it, so made it a 50/50 chance. Why not!
		user.visible_message(span_suicide("[capitalize(user.declent_ru(NOMINATIVE))] разбивает себе голову [declent_ru(INSTRUMENTAL)]! Вот это, что называется, дать себе пинка."))
		for(var/i in 1 to 3)
			sleep(0.3 SECONDS)
			playsound(user, 'sound/items/weapons/genhit2.ogg', 50, TRUE)
		return BRUTELOSS

/obj/item/clothing/shoes/worn_overlays(mutable_appearance/standing, isinhands = FALSE, icon_file, bodyshape = NONE)
	. = ..()
	if(isinhands)
		return
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedshoe")

/obj/item/clothing/shoes/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands = FALSE, icon_file, bodyshape = NONE)
	. = ..()
	if (isinhands)
		return
	var/blood_overlay = get_blood_overlay("shoe", bodyshape)
	if (blood_overlay)
		. += blood_overlay

/obj/item/clothing/shoes/examine(mob/user)
	. = ..()

	if(!ishuman(loc))
		return

	if(tied == SHOES_UNTIED)
		. += "[capitalize(fastening_ru(NOMINATIVE))] [untied_adjective()]."
	else if(tied == SHOES_KNOTTED)
		. += "[capitalize(fastening_ru(NOMINATIVE))] связаны между собой."

/obj/item/clothing/shoes/visual_equipped(mob/user, slot)
	. = ..()
	if(offset && (slot_flags & slot))
		user.pixel_z += offset
		worn_y_dimension -= (offset * 2)
		user.update_worn_shoes()
		equipped_before_drop = TRUE

/obj/item/clothing/shoes/equipped(mob/user, slot)
	. = ..()
	if(fastening_type != SHOES_SLIPON && tied == SHOES_UNTIED)
		our_alert_ref = WEAKREF(user.throw_alert(ALERT_SHOES_KNOT, /atom/movable/screen/alert/shoes/untied))
		RegisterSignal(src, COMSIG_SHOES_STEP_ACTION, PROC_REF(check_trip), override=TRUE)

/obj/item/clothing/shoes/proc/restore_offsets(mob/user)
	equipped_before_drop = FALSE
	user.pixel_z -= offset
	worn_y_dimension = ICON_SIZE_Y

/obj/item/clothing/shoes/dropped(mob/user)
	var/atom/movable/screen/alert/our_alert = our_alert_ref?.resolve()
	if(!our_alert)
		our_alert_ref = null
	if(our_alert?.owner == user)
		user.clear_alert(ALERT_SHOES_KNOT)
	if(offset && equipped_before_drop)
		restore_offsets(user)
	. = ..()

/obj/item/clothing/shoes/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_worn_shoes()

/obj/item/clothing/shoes/generate_digitigrade_icons(icon/base_icon, greyscale_colors)
	return icon(SSgreyscale.GetColoredIconByType(/datum/greyscale_config/digitigrade, greyscale_colors), "boots_worn")

/**
 * adjust_laces adjusts whether our shoes (assuming they can be tied) and tied, untied, or knotted
 *
 * In addition to setting the state, it will deal with getting rid of alerts if they exist, as well as registering and unregistering the stepping signals
 *
 * Arguments:
 * *
 * * state: SHOES_UNTIED, SHOES_TIED, or SHOES_KNOTTED, depending on what you want them to become
 * * user: used to check to see if we're the ones unknotting our own laces
 * * force_lacing: boolean. if TRUE, ignores whether we actually have laces
 */
/obj/item/clothing/shoes/proc/adjust_laces(state, mob/user, force_lacing = FALSE)
	if(fastening_type == SHOES_SLIPON && !force_lacing)
		return

	var/mob/living/carbon/human/our_guy
	if(ishuman(loc))
		our_guy = loc

	tied = state
	if(tied == SHOES_TIED)
		if(our_guy)
			our_guy.clear_alert(ALERT_SHOES_KNOT)
		UnregisterSignal(src, COMSIG_SHOES_STEP_ACTION)
	else
		if(tied == SHOES_UNTIED && our_guy && user == our_guy)
			our_alert_ref = WEAKREF(our_guy.throw_alert(ALERT_SHOES_KNOT, /atom/movable/screen/alert/shoes/untied)) // if we're the ones unknotting our own laces, of course we know they're untied
		RegisterSignal(src, COMSIG_SHOES_STEP_ACTION, PROC_REF(check_trip), override=TRUE)

/**
 * handle_tying deals with all the actual tying/untying/knotting, inferring your intent from who you are in relation to the state of the laces
 *
 * If you're the wearer, you want them to move towards tied-ness (knotted -> untied -> tied). If you're not, you're pranking them, so you're moving towards knotted-ness (tied -> untied -> knotted)
 *
 * Arguments:
 * *
 * * user: who is the person interacting with the shoes?
 */
/obj/item/clothing/shoes/proc/handle_tying(mob/living/user)
	///our_guy here is the wearer, if one exists (and he must exist, or we don't care)
	var/mob/living/carbon/human/our_guy = loc
	if(!istype(our_guy))
		return

	if (!isliving(user) || !(user.mobility_flags & MOBILITY_USE))
		return

	if(!in_range(user, our_guy))
		to_chat(user, span_warning("Отсюда до [fastening_ru(GENITIVE)] не дотянуться!"))
		return

	if(user == loc && tied != SHOES_TIED) // if they're our own shoes, go tie-wards
		if(DOING_INTERACTION_WITH_TARGET(user, our_guy))
			to_chat(user, span_warning("Вы уже возитесь с [declent_ru(INSTRUMENTAL)]!"))
			return
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] [tied ? "распутывает" : fastening_verb()] [fastening_ru(ACCUSATIVE)] на своей обуви."), span_notice("Вы [tied ? "распутываете" : fasten_verb()] [fastening_ru(ACCUSATIVE)] на своей обуви..."))

		if(do_after(user, lace_time, target = our_guy, extra_checks = CALLBACK(src, PROC_REF(still_shoed), our_guy)))
			to_chat(user, span_notice("Готово: [fastening_ru(NOMINATIVE)] [tied ? "распутаны" : fastened_adjective()]."))
			if(tied == SHOES_UNTIED)
				adjust_laces(SHOES_TIED, user)
			else
				adjust_laces(SHOES_UNTIED, user)

	else // if they're someone else's shoes, go knot-wards
		if(user.body_position == STANDING_UP)
			to_chat(user, span_warning("Чтобы добраться до чужой обуви, нужно лечь на пол!"))
			return
		if(tied == SHOES_KNOTTED)
			to_chat(user, span_warning("[capitalize(fastening_ru(NOMINATIVE))] на этой обуви и так спутаны в безнадёжный узел!"))
			return
		if(DOING_INTERACTION_WITH_TARGET(user, our_guy))
			to_chat(user, span_warning("Вы уже возитесь с [declent_ru(INSTRUMENTAL)]!"))
			return

		var/mod_time = lace_time
		to_chat(user, span_notice("Вы тихонько [tied ? fasten_verb(TRUE) : "связываете между собой"] [fastening_ru(ACCUSATIVE)] на обуви [our_guy.declent_ru(GENITIVE)]..."))
		if(HAS_TRAIT(user, TRAIT_CLUMSY)) // based clowns trained their whole lives for this
			mod_time *= 0.75

		if(do_after(user, mod_time, target = our_guy, extra_checks = CALLBACK(src, PROC_REF(still_shoed), our_guy), cog_icon = null))
			to_chat(user, span_notice("Готово: [fastening_ru(NOMINATIVE)] на обуви [our_guy.declent_ru(GENITIVE)] [tied ? untied_adjective() : "связаны между собой"]."))
			if(tied == SHOES_UNTIED)
				adjust_laces(SHOES_KNOTTED, user)
			else
				adjust_laces(SHOES_UNTIED, user)
		else // if one of us moved
			user.visible_message(span_danger("[capitalize(our_guy.declent_ru(NOMINATIVE))] наступает [user.declent_ru(DATIVE)] на руку, не дав закончить с [fastening_ru(INSTRUMENTAL)]!"), span_userdanger("Ай! [capitalize(our_guy.declent_ru(NOMINATIVE))] наступает вам на руку!"), list(our_guy))
			to_chat(our_guy, span_userdanger("Вы наступаете [user.declent_ru(DATIVE)] на руку! Какого... Да тут кто-то возился с вашими [fastening_ru(INSTRUMENTAL)]!"))
			user.emote("scream")
			user.apply_damage(10, BRUTE, user.get_active_hand(), wound_bonus = CANT_WOUND)
			user.apply_damage(40, STAMINA)
			user.Paralyze(1 SECONDS)

///checking to make sure we're still on the person we're supposed to be, for lacing do_after's
/obj/item/clothing/shoes/proc/still_shoed(mob/living/carbon/our_guy)
	return (loc == our_guy)

///check_trip runs on each step to see if we fall over as a result of our lace status. Knotted laces are a guaranteed trip, while untied shoes are just a chance to stumble
/obj/item/clothing/shoes/proc/check_trip()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/our_guy = loc
	if(!istype(our_guy)) // are they REALLY /our guy/?
		return

	if(tied == SHOES_KNOTTED)
		our_guy.Paralyze(5)
		our_guy.Knockdown(10)
		our_guy.visible_message(span_danger("[capitalize(our_guy.declent_ru(NOMINATIVE))] запутывается в связанных [fastening_ru(PREPOSITIONAL)] и падает! Вот растяпа!"), span_userdanger("Вы запутываетесь в связанных [fastening_ru(PREPOSITIONAL)] и падаете!"))
		our_guy.add_mood_event("trip", /datum/mood_event/tripped) // well we realized they're knotted now!
		our_alert_ref = WEAKREF(our_guy.throw_alert(ALERT_SHOES_KNOT, /atom/movable/screen/alert/shoes/knotted))

	else if(tied == SHOES_UNTIED)
		var/wiser = TRUE // did we stumble and realize our laces are undone?
		switch(rand(1, 1000))
			if(1) // .1% chance to trip and fall over (note these are per step while our laces are undone)
				our_guy.Paralyze(5)
				our_guy.Knockdown(10)
				our_guy.add_mood_event("trip", /datum/mood_event/tripped) // well we realized they're knotted now!
				our_guy.visible_message(span_danger("[capitalize(our_guy.declent_ru(NOMINATIVE))] наступает на собственные [fastening_ru(ACCUSATIVE)] и падает! Вот растяпа!"), span_userdanger("Вы наступаете на собственные [fastening_ru(ACCUSATIVE)] и падаете!"))

			if(2 to 5) // .4% chance to stumble and lurch forward
				our_guy.throw_at(get_step(our_guy, our_guy.dir), 3, 2)
				to_chat(our_guy, span_danger("Вы наступаете на собственные [fastening_ru(ACCUSATIVE)], и вас бросает вперёд!"))

			if(6 to 13) // .7% chance to stumble and fling what we're holding
				var/have_anything = FALSE
				for(var/obj/item/I in our_guy.held_items)
					have_anything = TRUE
					our_guy.accident(I)
				to_chat(our_guy, span_danger("Вы цепляетесь ногой за [fastening_ru(ACCUSATIVE)][have_anything ? " и роняете всё, что держали" : ""]!"))

			if(14 to 25) // 1.3ish% chance to stumble and be a bit off balance (like being disarmed)
				to_chat(our_guy, span_danger("Вы спотыкаетесь о собственные [fastening_ru(ACCUSATIVE)]!"))
				our_guy.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH, 10 SECONDS)

			if(26 to 1000)
				wiser = FALSE
		if(wiser)
			our_guy.add_mood_event("untied", /datum/mood_event/untied) // well we realized they're untied now!
			our_alert_ref = WEAKREF(our_guy.throw_alert(ALERT_SHOES_KNOT, /atom/movable/screen/alert/shoes/untied))


/obj/item/clothing/shoes/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(!istype(user))
		return ..()
	if(loc == user && tied != SHOES_TIED && (user.mobility_flags & MOBILITY_USE))
		handle_tying(user)
		return
	..()

/obj/item/clothing/shoes/attack_self(mob/user)
	. = ..()

	if (fastening_type == SHOES_SLIPON)
		return

	if(DOING_INTERACTION_WITH_TARGET(user, src))
		to_chat(user, span_warning("Вы уже возитесь с [declent_ru(INSTRUMENTAL)]!"))
		return

	to_chat(user, span_notice("Вы [fasten_verb(tied)] [fastening_ru(ACCUSATIVE)] на [declent_ru(PREPOSITIONAL)]..."))

	if(do_after(user, lace_time, target = src,extra_checks = CALLBACK(src, PROC_REF(still_shoed), user)))
		to_chat(user, span_notice("Готово: [fastening_ru(NOMINATIVE)] [tied ? untied_adjective() : fastened_adjective()]."))
		adjust_laces(tied ? SHOES_UNTIED : SHOES_TIED, user)

/obj/item/clothing/shoes/apply_fantasy_bonuses(bonus)
	. = ..()
	slowdown = modify_fantasy_variable("slowdown", slowdown, -bonus * 0.1, 0)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()

/obj/item/clothing/shoes/remove_fantasy_bonuses(bonus)
	slowdown = reset_fantasy_variable("slowdown", slowdown)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()
	return ..()

/// Returns appropriate description for unfastened shoes
/obj/item/clothing/shoes/proc/untied_adjective()
	switch(fastening_type)
		if (SHOES_LACED)
			return "развязаны"
		if (SHOES_VELCRO, SHOES_STRAPS)
			return "расстёгнуты"

	return "отсутствуют"

/// Returns appropriate verb for how to fasten shoes
/obj/item/clothing/shoes/proc/fasten_verb(undo = FALSE) // CORVAX EDIT CHANGE - ORIGINAL: /obj/item/clothing/shoes/proc/fasten_verb()
	switch(fastening_type)
		if (SHOES_LACED)
			return undo ? "развязываете" : "завязываете"
		if (SHOES_VELCRO, SHOES_STRAPS)
			return undo ? "расстёгиваете" : "застёгиваете"

	return "теребите"

/// Returns appropriate verb for fastening shoes
/obj/item/clothing/shoes/proc/fastening_verb(undo = FALSE) // CORVAX EDIT CHANGE - ORIGINAL: /obj/item/clothing/shoes/proc/fastening_verb()
	switch(fastening_type)
		if (SHOES_LACED)
			return undo ? "развязывает" : "завязывает"
		if (SHOES_VELCRO, SHOES_STRAPS)
			return undo ? "расстёгивает" : "застёгивает"

	return "теребит"

// CORVAX EDIT ADD START
/obj/item/clothing/shoes/proc/fastened_adjective()
	switch(fastening_type)
		if (SHOES_LACED)
			return "завязаны"
		if (SHOES_VELCRO, SHOES_STRAPS)
			return "застёгнуты"

	return "на месте"

/obj/item/clothing/shoes/proc/fastening_ru(declent = NOMINATIVE)
	var/static/list/forms = list(
		SHOES_LACED = list(NOMINATIVE = "шнурки", GENITIVE = "шнурков", DATIVE = "шнуркам", ACCUSATIVE = "шнурки", INSTRUMENTAL = "шнурками", PREPOSITIONAL = "шнурках"),
		SHOES_VELCRO = list(NOMINATIVE = "липучки", GENITIVE = "липучек", DATIVE = "липучкам", ACCUSATIVE = "липучки", INSTRUMENTAL = "липучками", PREPOSITIONAL = "липучках"),
		SHOES_STRAPS = list(NOMINATIVE = "ремешки", GENITIVE = "ремешков", DATIVE = "ремешкам", ACCUSATIVE = "ремешки", INSTRUMENTAL = "ремешками", PREPOSITIONAL = "ремешках"),
	)
	var/list/found = forms[fastening_type] || forms[SHOES_LACED]
	return found[declent]
// CORVAX EDIT ADD END
