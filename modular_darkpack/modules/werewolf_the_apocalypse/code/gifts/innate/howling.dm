/datum/action/cooldown/power/gift/howling
	name = "Вой"
	desc = "Вой оборотня разносится далеко за пределы обычной слышимости и доносит до всех гару в городе одно слово или один смысл."
	button_icon_state = "call_of_the_wyld"
	rage_cost = 1
	check_flags = null
	innate_ability = TRUE
	var/static/list/howls = list(
		"attack" = list(
			"menu" = "Атака",
			SPLAT_GAROU = "Волк воет, яростно призывая к атаке",
			SPLAT_CORAX = "Ворон шипит, яростно призывая к атаке"
		),
		"retreat" = list(
			"menu" = "Отступление",
			SPLAT_GAROU = "Волк воем велит отступать",
			SPLAT_CORAX = "Ворон резким криком велит отступать"
		),
		"help" = list(
			"menu" = "Помощь",
			SPLAT_GAROU = "Волк отчаянно воет, моля о помощи",
			SPLAT_CORAX = "Ворон пронзительно кричит, моля о помощи"
		),
		"gather" = list(
			"menu" = "Сбор",
			SPLAT_GAROU = "Волк воем созывает стаю",
			SPLAT_CORAX = "Ворон созывает стаю"
		),
		"victory" = list(
			"menu" = "Победа",
			SPLAT_GAROU = "Волк воет, празднуя победу",
			SPLAT_CORAX = "Ворон каркает, празднуя победу"
		),
		"dying" = list(
			"menu" = "Гибель",
			SPLAT_GAROU = "Волк воет от боли и отчаяния",
			SPLAT_CORAX = "Ворон кричит от боли и отчаяния"
		),
		"mourning" = list(
			"menu" = "Скорбь",
			SPLAT_GAROU = "Волк воет, оплакивая павших",
			SPLAT_CORAX = "Ворон оплакивает павших"
		)
	)

/datum/action/cooldown/power/gift/howling/IsAvailable(feedback)
	. = ..()
	if(istype(get_area(owner), /area/vtm/interior/penumbra))
		if(feedback)
			to_chat(owner, span_warning("Ваш вой отдаётся эхом и тает в Умбре: его глушит духовная сила Бархатной Тени."))
		return FALSE

/datum/action/cooldown/power/gift/howling/Activate(atom/target)
	. = ..()

	var/mob/living/living_mob = owner
	var/datum/splat/werewolf/shifter/shifter = get_shifter_splat(owner)
	var/list/menu_options = list()
	for(var/howl_key in howls)
		menu_options += howls[howl_key]["menu"]

	var/choice = tgui_input_list(owner, "Какой вой издать?", "Выбор воя", menu_options)
	if(!choice)
		return

	var/howl
	for(var/howl_key in howls)
		if(howls[howl_key]["menu"] == choice)
			howl = howls[howl_key]
			break

	var/garou_message = howl[shifter.id]
	/*
	var/tribe = living_mob.auspice.tribe.name
	if (tribe)
		garou_message = replacetext(garou_message, "tribe", tribe)
	*/
	var/origin_turf = get_turf(living_mob)
	ADD_TRAIT(living_mob, TRAIT_LOUD_WARCRY, GIFT_TRAIT)
	living_mob.emote(shifter.warcry_emote)
	REMOVE_TRAIT(living_mob, TRAIT_LOUD_WARCRY, GIFT_TRAIT)

	var/howl_details
	var/final_message
	for(var/mob/living/howled_at in GLOB.player_list - owner)
		if(get_shifter_splat(howled_at))
			howl_details = get_message(howled_at, origin_turf)
			final_message = garou_message + howl_details
			to_chat(howled_at, span_boldnotice(final_message))


/datum/action/cooldown/power/gift/howling/proc/get_message(mob/living/howled_at, turf/origin_turf)
	var/distance = get_dist(howled_at, origin_turf)
	var/dirtext = get_direction_text(get_dir(howled_at, origin_turf))

	var/disttext
	switch(distance)
		if(0 to 20)
			disttext = "совсем близко"
		if(20 to 40)
			disttext = "в 20-40 шагах"
		if(40 to 80)
			disttext = "в 40-80 шагах"
		if(80 to 160)
			disttext = "далеко"
		else
			disttext = "очень далеко"

	var/place = get_area_name(origin_turf)

	var/returntext = " - [disttext], [dirtext]. Место: [place]."

	return returntext

/datum/action/cooldown/power/gift/howling/proc/get_direction_text(direction)
	switch(direction)
		if(NORTH)
			return "с севера"
		if(SOUTH)
			return "с юга"
		if(EAST)
			return "с востока"
		if(WEST)
			return "с запада"
		if(NORTHEAST)
			return "с северо-востока"
		if(SOUTHEAST)
			return "с юго-востока"
		if(NORTHWEST)
			return "с северо-запада"
		if(SOUTHWEST)
			return "с юго-запада"
	return "откуда именно, не разобрать"
