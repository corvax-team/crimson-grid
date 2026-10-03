/obj/item/path_spellbook
	abstract_type = /obj/item/path_spellbook
	name = "path spellbook"
	desc = "Заготовка гримуара пути. Если вы видите это в игре, сообщите разработчикам."
	icon = 'modular_darkpack/modules/paths/icons/paths.dmi'
	icon_state = "spellbook_unfinished"
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound = 'sound/items/handling/book_pickup.ogg'
	var/activate_sound = 'modular_darkpack/modules/paths/sounds/open_book.ogg'
	var/deactivate_sound = 'modular_darkpack/modules/paths/sounds/close_book.ogg'

	var/datum/discipline/required_discipline = /datum/discipline/thaumaturgy // CRIMSON GRID ADD: DARK THAUMATURGY
	var/path_type = null
	var/path_level = 1
	var/do_after_time = 30 SECONDS

	var/identified = FALSE
	var/true_name = ""
	var/true_desc = ""

	var/datum/storyteller_roll/identify_occult/identify_roll

/obj/item/path_spellbook/Initialize(mapload)
	. = ..()
	if(!identified)
		true_name = name
		true_desc = desc
		name = "dusty forgotten tome"
		desc = "Книга вся в пыли, страницы истрёпаны. Вряд ли в ней что-то важное."
	AddComponent(/datum/component/selling, 100, "artifact", FALSE, 0, 10, TRUE)

/obj/item/path_spellbook/ru_names_rename(list/new_list)
	if(length(new_list))
		new_list["base"] = initial(name)
	return ..()

/obj/item/path_spellbook/examine(mob/user)
	. = ..()
	if(!identified)
		. += span_notice("Можно попробовать стереть пыль и посмотреть, что под ней.")

/obj/item/path_spellbook/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE

	if(!identified)
		if(do_after(user, 1 TURNS))
			if(!identify_roll)
				identify_roll = new()
				identify_roll.difficulty = path_level + 3
			var/roll = identify_roll.st_roll(user, src)
			switch(roll)
				if(ROLL_SUCCESS)
					to_chat(user, span_cult("Вы стираете пыль с книги, которая только что казалась никчёмной. Неужели кто-то вынес её из библиотеки и забыл?"))
					src.identified = TRUE
					ru_names_rename(ru_names_toml(true_name))
					name = true_name
					desc = true_desc
					return
				else
					to_chat(user, span_warning("Вам не удаётся понять, что это за книга, и вы отвлекаетесь на дела поважнее. Может, это поваренная книга?"))
					return
		return

	var/datum/splat/vampire/kindred/kindred = get_kindred_splat(user)
	var/datum/discipline/existing_path_discipline = kindred?.get_discipline(path_type)

	if(!path_type)
		to_chat(user, span_warning("Похоже, этот гримуар не дописан!"))
		return

	if(get_kindred_splat(user))
		// CRIMSON GRID ADD: DARK THAUMATURGY
		if(!user.get_discipline(required_discipline))
			to_chat(user, span_warning("Чтобы пользоваться этой книгой, нужно владеть дисциплиной \"[initial(required_discipline.name)]\"!"))
		// CRIMSON GRID ADD END: DARK THAUMATURGY
			return
		if(existing_path_discipline)
			//Then we check if the level can be learned
			if(path_level == existing_path_discipline.level)
				// User already knows this level
				to_chat(user, span_warning("Вы уже изучили эту книгу!"))
				return
			else if(path_level == existing_path_discipline.level + 1)
				// The book's level is one higher than the user's current level
				user.playsound_local(user, activate_sound, 50, FALSE)
			else if (path_level > existing_path_discipline.level + 1)
				// The book's level is too high for the user to learn
				to_chat(user, span_warning("Сначала нужно изучить предыдущие книги!"))
				return
			else if (path_level < existing_path_discipline.level)
				// The book's level is lower than the user's current level
				to_chat(user, span_warning("Вы уже постигли этот путь глубже!"))
				return
		// If we reach here, the user does not know this path at all
		if(path_level > 1 && !existing_path_discipline)
			to_chat(user, span_warning("Прежде чем браться за высшие уровни этого пути, нужно освоить первый!"))
			return
		else if(path_level == 1 && !existing_path_discipline)
			user.playsound_local(user, activate_sound, 50, FALSE)
	else
		to_chat(user, span_warning("Эта книга полна тарабарщины и бессмыслицы."))
		return

	var/original_icon_state = icon_state
	icon_state = "[original_icon_state]-opened"
	update_appearance()

	to_chat(user, span_notice("Вы погружаетесь в изучение древних текстов..."))

	if(do_after(user, do_after_time, target = src))
		// Now checking the level again to assign the correct path level
		if(!existing_path_discipline)
			user.give_st_power(path_type, path_level)
			to_chat(user, span_notice("Знания из [declent_ru(GENITIVE)] вливаются в ваш разум!"))
		else
			// If the user already knows the path, update the level
			to_chat(user, span_notice("Изучив [declent_ru(ACCUSATIVE)], вы углубили свои познания!"))

			user.remove_st_power(path_type)
			user.give_st_power(path_type, path_level)

		user.playsound_local(user, deactivate_sound, 50, FALSE)
		qdel(src)
	else
		icon_state = original_icon_state
		update_appearance()
		to_chat(user, span_warning("Вам не дали сосредоточиться!"))


/obj/item/occult_book
	abstract_type = /obj/item/occult_book
	name = "occult book"
	desc = "Заготовка оккультной книги. Если вы видите это в игре, сообщите разработчикам."
	icon = 'modular_darkpack/modules/paths/icons/paths.dmi'
	icon_state = "spellbook_unfinished"
	var/do_after_time = 30 SECONDS
	var/activate_sound = 'modular_darkpack/modules/paths/sounds/open_book.ogg'
	var/deactivate_sound = 'modular_darkpack/modules/paths/sounds/close_book.ogg'
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound = 'sound/items/handling/book_pickup.ogg'

	// research vars overriden by subtypes
	var/research_value = 10
	var/study_cooldown = 30 MINUTES
	var/study_research_value = 50
	var/required_discipline = /datum/discipline/thaumaturgy
	var/no_trait_message = "Без должных познаний этот текст для вас непостижим."
	var/cooldown_message = "Вы совсем недавно обстоятельно изучали этот том. Прежде чем вы почерпнёте из него что-то новое, должно пройти время: %TIME%."
	var/study_start_message = "Вы погружаетесь в изучение оккультного текста..."
	var/study_interrupted_message = "Вам не дали сосредоточиться. Ничего стоящего из текста вы не вынесли."
	var/research_gain_message = "Изучение этого тома приносит вам очки исследований: %POINTS%!"

	// Flavor texts, must be overriden by subtypes
	var/list/study_flavor_texts = list(
		"Вы изучаете тайный текст и глубже проникаете в оккультные мистерии.",
		"Древнее знание перетекает со страниц в ваш разум.",
		"Текст открывает тайны сверхъестественной силы и ритуала."
	)

/obj/item/occult_book/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "artifact", FALSE, 0, 10, TRUE)

/obj/item/occult_book/attack_self(mob/living/carbon/human/user)
	if(!can_study(user))
		return ..()

	if(!check_cooldown(user))
		return

	begin_study(user)
	return ..()

/obj/item/occult_book/proc/can_study(mob/living/carbon/human/user)
	if(required_discipline && !user.get_discipline(required_discipline))
		to_chat(user, span_warning(no_trait_message))
		return FALSE
	return TRUE

/obj/item/occult_book/proc/check_cooldown(mob/living/carbon/human/user)
	if(!COOLDOWN_FINISHED(src, study_cooldown))
		var/replaced_text_cooldown_message = replacetext(cooldown_message, "%TIME%", DisplayTimeText(COOLDOWN_TIMELEFT(src, study_cooldown)))
		to_chat(user, span_warning(replaced_text_cooldown_message))
		return FALSE
	return TRUE

/obj/item/occult_book/proc/begin_study(mob/living/carbon/human/user)
	var/original_icon_state = icon_state
	icon_state = "[original_icon_state]-opened"
	update_appearance()

	to_chat(user, span_notice(study_start_message))
	user.playsound_local(user, activate_sound, 50, FALSE)

	if(do_after(user, do_after_time, target = src))
		complete_study(user)
	else
		to_chat(user, span_warning(study_interrupted_message))

	icon_state = original_icon_state
	update_appearance()

/obj/item/occult_book/proc/complete_study(mob/living/carbon/human/user)
	user.research_points += study_research_value
	var/flavor_text = pick(study_flavor_texts)
	to_chat(user, span_cult(flavor_text))

	var/formatted_message = replacetext(research_gain_message, "%POINTS%", "[study_research_value]")
	to_chat(user, span_green(formatted_message))

	COOLDOWN_START(src, study_cooldown, study_cooldown)
	user.playsound_local(user, deactivate_sound, 50, FALSE)
