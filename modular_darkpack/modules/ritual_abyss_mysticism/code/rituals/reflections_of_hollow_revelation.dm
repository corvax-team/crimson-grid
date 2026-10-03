/datum/storyteller_roll/reflections_of_hollow
	difficulty = 7
	applicable_stats = list(STAT_PERCEPTION, STAT_OCCULT)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation
	name = "reflections of hollow revelation"
	ru_name = "Отражения пустого откровения"
	desc = "Сотворённый Ноктюрн позволяет следить за целью через тени рядом с ней."
	icon_state = "teleport"
	word = ""
	level = 4
	cost = 1
	var/datum/action/close_window/end_action
	var/mob/living/nocturne_user
	var/obj/shadow_window/shadow_window
	var/mob/living/carbon/human/window_target
	var/isactive = FALSE

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/complete()
	. = ..()
	var/mob/living/user = usr
	if(!user)
		return

	if(isactive)
		to_chat(user, span_warning("Этот Ноктюрн уже занят!"))
		return

	// Target input
	var/target_name = tgui_input_text(user, "Назовите имя цели:", "Отражения пустого откровения")
	if(!target_name || !user.Adjacent(src))
		to_chat(user, span_warning("Нужно назвать цель и не отходить от руны!"))
		return

	user.say("VISTA'DE'SOMBRA")

	// Find the target
	for(var/mob/living/carbon/human/targ in GLOB.player_list)
		if(targ.real_name == target_name)
			window_target = targ
			break

	if(!window_target)
		to_chat(user, span_warning("Не удалось найти никого по имени [target_name]."))
		return

	var/roll_result = SSroll.storyteller_roll_datum(user, roll_datum = /datum/storyteller_roll/reflections_of_hollow)
	switch(roll_result)
		if(ROLL_SUCCESS)
			scry_target(window_target, user)
			playsound(user, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
			isactive = TRUE
		if(ROLL_FAILURE)
			qdel(src)
			to_chat(user, span_warning("Ноктюрн схлопывается!"))
		if(ROLL_BOTCH)
			qdel(src)
			to_chat(user, span_warning("Силы покидают вас..."))
			for(var/datum/st_stat/stat as anything in subtypesof(/datum/st_stat))
				user.st_add_stat_mod(stat, -2, "reflections_of_hollow_revelation")
			addtimer(CALLBACK(src, PROC_REF(restore_stats), user), 1 SCENES)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/restore_stats(mob/living/user)
	for(var/datum/st_stat/stat as anything in subtypesof(/datum/st_stat))
		user.st_remove_stat_mod(stat, "reflections_of_hollow_revelation")

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/scry_target(mob/living/carbon/human/target, mob/living/user)
	// If the target has Obtenebration or Auspex, roll to see if they detect the shadows
	if(get_kindred_splat(target))
		var/datum/splat/vampire/vampire = get_splat_with_discipline(target)
		if(vampire?.get_discipline(/datum/discipline/obtenebration) || vampire?.get_discipline(/datum/discipline/auspex))
			if(SSroll.storyteller_roll_datum(target, roll_datum = /datum/storyteller_roll/reflections_of_hollow, difficulty = 8) == ROLL_SUCCESS)
				to_chat(target, span_warning("Вы замечаете, как дрогнули тени рядом... Что-то наблюдает за вами."))

	shadowview(target, user)
	to_chat(user, span_notice("Вы всматриваетесь в мир через тени рядом с [target.declent_ru(INSTRUMENTAL)]..."))

	addtimer(CALLBACK(src, PROC_REF(on_end),user), 1 SCENES) // 3 minute timer, AKA 1 Scene

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/shadowview(mob/living/target, mob/user)
	nocturne_user = user
	//user.notransform = TRUE

	// Create camera
	shadow_window = new(get_turf(target), src)
	user.reset_perspective(shadow_window)

	// Give button to end viewing
	end_action = new(src)
	end_action.Grant(user)

	RegisterSignal(user, COMSIG_MOB_RESET_PERSPECTIVE, PROC_REF(on_end))
	RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(check_target_distance))

	to_chat(user, span_notice("Вы смотрите сквозь тени. Чтобы прекратить, воспользуйтесь действием \"Прервать наблюдение\"."))

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/check_target_distance()
	SIGNAL_HANDLER
	if(!window_target || !shadow_window)
		return

	// Window closes when target leaves range
	if(get_dist(window_target, shadow_window) > 7)
		if(nocturne_user)
			to_chat(nocturne_user, span_warning("Окно закрывается: [window_target.declent_ru(NOMINATIVE)] уходит от теней."))
		on_end(nocturne_user)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/on_end(mob/user)
	SIGNAL_HANDLER
	if(user == nocturne_user)
		close_window(user)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/close_window(mob/user)
	if(!user)
		return

	//user.notransform = FALSE

	if(user.client?.eye != user)
		user.reset_perspective()

	if(end_action)
		end_action.Remove(user)
		QDEL_NULL(end_action)

	if(window_target)
		UnregisterSignal(window_target, COMSIG_MOVABLE_MOVED)

	QDEL_NULL(shadow_window)
	qdel(src)
	UnregisterSignal(user, COMSIG_MOB_RESET_PERSPECTIVE)

	nocturne_user = null
	to_chat(user, span_notice("Вы перестаёте смотреть сквозь призванный Ноктюрн."))
	playsound(user, 'sound/effects/magic/ethereal_exit.ogg', 50, FALSE)

// Camera object
/obj/shadow_window
	name = "Shadow"
	desc = "Тень..."
	icon = 'icons/effects/effects.dmi'
	icon_state = ""
	invisibility = INVISIBILITY_ABSTRACT
	layer = CAMERA_STATIC_PLANE
	var/obj/ritual_rune/abyss/reflections_of_hollow_revelation/parent_rune

/obj/shadow_window/Initialize(mapload, obj/ritual_rune/abyss/reflections_of_hollow_revelation/rune)
	. = ..()
	parent_rune = rune

/obj/shadow_window/Destroy()
	if(parent_rune && parent_rune.shadow_window == src)
		parent_rune.shadow_window = null
	parent_rune = null
	return ..()

// Action button
/datum/action/close_window
	name = "Прервать наблюдение"
	desc = "Перестаньте смотреть сквозь тени."
	button_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "camera_off"
	var/obj/ritual_rune/abyss/reflections_of_hollow_revelation/parent_rune

/datum/action/close_window/New(obj/ritual_rune/abyss/reflections_of_hollow_revelation/rune)
	..()
	parent_rune = rune

/datum/action/close_window/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	if(!parent_rune || !usr)
		return
	parent_rune.close_window(usr)

/datum/action/close_window/Remove(mob/user)
	if(parent_rune && parent_rune.end_action == src)
		parent_rune.end_action = null
	parent_rune = null
	. = ..()
	qdel(src)
