/datum/splat/vampire/kindred/proc/adjust_morality(mob/living/carbon/human/owner, value, limit, forced, difficulty = 6)
	SIGNAL_HANDLER

	// "Enlightenment" is essentially the Path of Pure Evil. Inverts Humanity changes and limits.
	var/is_enlightenment = owner.is_enlightenment()
	var/path = is_enlightenment ? "Просветление" : "Человечность"
	if (is_enlightenment && !forced)
		value = -value
		limit = 10 - limit

	// Work out actual change in Humanity
	var/new_humanity
	var/humanity_change
	if (value > 0)
		new_humanity = clamp(owner.st_get_stat(STAT_MORALITY) + value, 0, limit)
		humanity_change = new_humanity - owner.st_get_stat(STAT_MORALITY)

		// Hit the limit for increase, no change
		if (humanity_change <= 0)
			return
	else if (value < 0)
		var/loss_modifier = HAS_TRAIT(owner, TRAIT_SENSITIVE_HUMANITY) ? 2 : 1
		value *= loss_modifier

		new_humanity = clamp(owner.st_get_stat(STAT_MORALITY) + value, limit, 10)
		humanity_change = new_humanity - owner.st_get_stat(STAT_MORALITY)

		// Hit the limit for decrease, no change
		if (humanity_change >= 0)
			return
	else
		return

	//before going any further, roll either conscience or conviction to determine if we actually lose path/humanity
	if(humanity_change < 0)
		var/stat_to_roll = is_enlightenment ? STAT_CONVICTION : STAT_CONSCIENCE
		var/datum/storyteller_roll/degeneration_roll = new()
		degeneration_roll.applicable_stats = list(stat_to_roll)
		degeneration_roll.difficulty = difficulty
		degeneration_roll.roll_output_type = ROLL_PRIVATE_ADMIN
		var/roll_result = degeneration_roll.st_roll(owner)

		if(roll_result == ROLL_SUCCESS)
			to_chat(owner, span_green("[is_enlightenment ? "Решимость" : "Совесть"] не даёт вам оступиться: вы находите оправдание своим поступкам, и [path] остаётся при вас!"))
			return
		else
			to_chat(owner, span_danger("Оправдать содеянное не удаётся, и Зверь внутри поднимает голову..."))

	var/signal_return = SEND_SIGNAL(owner, COMSIG_LIVING_CHANGING_HUMANITY, humanity_change)
	if (signal_return & BLOCK_HUMANITY_CHANGE)
		return

	// Change morality according to calculated values
	owner.st_set_stat(STAT_MORALITY, owner.st_get_stat(STAT_MORALITY) + humanity_change)
	if (humanity_change > 0)
		SEND_SOUND(owner, sound('modular_darkpack/modules/deprecated/sounds/humanity_gain.ogg', volume = 75))
		to_chat(owner, span_boldnicegreen("[is_enlightenment ? "ПРОСВЕТЛЕНИЕ ВОЗРОСЛО" : "ЧЕЛОВЕЧНОСТЬ ВОЗРОСЛА"]!"))

		// Gaining Path flavour text
		switch (owner.st_get_stat(STAT_MORALITY))
			if (10)
				to_chat(owner, span_green("[path] достигает вершины, и вы чувствуете, как Зверь [is_enlightenment ? "приходит с вами в полное согласие" : "погружается в глубокий сон и ждёт своего часа"]."))
	else if (humanity_change < 0)
		SEND_SOUND(owner, sound('modular_darkpack/modules/deprecated/sounds/humanity_loss.ogg', volume = 75))
		to_chat(owner, span_userdanger(span_bold("[is_enlightenment ? "ПРОСВЕТЛЕНИЕ УПАЛО" : "ЧЕЛОВЕЧНОСТЬ УПАЛА"]!")))

		// Losing Path flavour text
		switch (owner.st_get_stat(STAT_MORALITY))
			if (1)
				to_chat(owner, span_userdanger(span_bold("КРОВЬ. ЖРАТЬ. ГОЛОД.")))
			if (2)
				to_chat(owner, span_userdanger("Вы теряете рассудок. Вами повелевает [span_bold("ЗВЕРЬ")]."))
			if (3)
				to_chat(owner, span_danger("Разум рассыпается. Зверь берёт верх..."))
			if (4)
				to_chat(owner, span_danger("Вы чувствуете, как Зверь грызёт края вашего сознания..."))
			if (9)
				to_chat(owner, span_warning("Совершенство утрачено: вы чувствуете, как Зверь [is_enlightenment ? "забирает власть над тёмным уголком" : "вновь просыпается в тёмном уголке"] вашей души."))

	SEND_SIGNAL(owner, COMSIG_LIVING_CHANGED_HUMANITY, humanity_change)
