#define MAX_RENOWN 10

/datum/splat/werewolf/proc/adjust_renown(attribute, amount)
	if(!renown[attribute])
		renown[attribute] = 0


	var/old_rank = renown_rank
	var/new_amount = clamp(renown[attribute] + amount, 0, MAX_RENOWN)

	renown[attribute] = new_amount
	if(amount < 0)
		to_chat(owner, span_userdanger("You feel [get_negative_emotion(attribute)]!"))
	else if(amount > 0)
		to_chat(owner, span_bold("You feel [get_positive_emotion(attribute)]!"))

	switch(attribute)
		if(RENOWN_HONOR)
			owner.write_preference_midround(/datum/preference/numeric/renown/honor, new_amount)
		if(RENOWN_GLORY)
			owner.write_preference_midround(/datum/preference/numeric/renown/glory, new_amount)
		if(RENOWN_WISDOM)
			owner.write_preference_midround(/datum/preference/numeric/renown/wisdom, new_amount)

	renown_rank = auspice_rank_check()
	if(old_rank != renown_rank)
		to_chat(owner, span_boldnotice("Теперь ваш ранг - [fera_rank_name(renown_rank, id)]."))

	// Not acctually used ANYWHERE rn. Its super easy to just calculate it from our renown anyway.
	// owner.write_preference_midround(/datum/preference/numeric/fera_rank, renown_rank)


/datum/splat/werewolf/proc/get_negative_emotion(attribute)
	switch(attribute)
		if(RENOWN_HONOR)
			return "ashamed"

		if(RENOWN_GLORY)
			return "humiliated"

		if(RENOWN_WISDOM)
			return "foolish"

	return "unsure"

/datum/splat/werewolf/proc/get_positive_emotion(attribute)
	switch(attribute)

		if(RENOWN_HONOR)
			return "vindicated"

		if(RENOWN_GLORY)
			return "brave"

		if(RENOWN_WISDOM)
			return "clever"

	return "confident"


/datum/splat/werewolf/proc/auspice_rank_check()
	if(!auspice)
		return RANK_CUB
	return auspice.rank_requirments(renown)

// Pretty iffy on this. This could likely just be moved onto the splat itself so corax and other breeds can override it.
/proc/fera_rank_name(rank, breed)
	switch(breed)
		if(SPLAT_CORAX)
			switch(rank)
				if(RANK_CUB)
					return "птенец"
				if(RANK_CLIATH)
					return "овикулум"
				if(RANK_FOSTERN)
					return "неокорникс"
				if(RANK_ADREN)
					return "алес"
				if(RANK_ATHRO)
					return "волукрис"
				if(RANK_ELDER)
					return "корвус"
				if(RANK_LEGEND)
					return "серый кардинал"
		else
			switch(rank)
				if(RANK_CUB)
					return "щенок"
				if(RANK_CLIATH)
					return "клиат"
				if(RANK_FOSTERN)
					return "фостерн"
				if(RANK_ADREN)
					return "адрен"
				if(RANK_ATHRO)
					return "атро"
				if(RANK_ELDER)
					return "старейшина"
				if(RANK_LEGEND)
					return "легенда"

#undef MAX_RENOWN
