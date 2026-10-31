/datum/job/proc/get_job_restriction_lines()
	var/list/lines = list()

	// Splats
	if(length(allowed_splats))
		var/list/splat_names = list()
		for(var/splat_id in allowed_splats)
			splat_names += get_job_restriction_splat_name(splat_id)
		lines += "Вид: [english_list(splat_names)]"

	// Splat slots
	if(length(splat_slots))
		var/list/slot_names = list()
		for(var/splat_id in splat_slots)
			var/slots = splat_slots[splat_id]
			if(!isnum(slots) || slots <= 0)
				continue
			slot_names += "[get_job_restriction_splat_name(splat_id)] — [slots]"
		if(length(slot_names))
			lines += "Слоты видов: [english_list(slot_names)]"

	// Clans
	var/list/allowed_clan_names = list()
	for(var/clan_id in allowed_clans)
		allowed_clan_names += get_job_restriction_clan_name(clan_id)
	if(length(allowed_clan_names))
		lines += "Клан: [english_list(allowed_clan_names)]"

	var/list/disallowed_clan_names = list()
	for(var/clan_id in disallowed_clans)
		disallowed_clan_names += get_job_restriction_clan_name(clan_id)
	if(length(disallowed_clan_names))
		lines += "Запрещённые кланы: [english_list(disallowed_clan_names)]"

	// Generation
	var/max_generation_active = CONFIG_GET(flag/max_gen_limits)
	var/min_generation_set = isnum(minimal_generation) && minimal_generation < HIGHEST_GENERATION_LIMIT
	var/max_generation_set = max_generation_active && isnum(maximal_generation) && maximal_generation > LOWEST_GENERATION_LIMIT
	if(min_generation_set && max_generation_set)
		lines += "Поколение: [maximal_generation]–[minimal_generation]"
	else if(min_generation_set)
		lines += "Поколение: не выше [minimal_generation]"
	else if(max_generation_set)
		lines += "Поколение: не ниже [maximal_generation]"

	// Immortal age
	var/min_age = minimum_immortal_age
	var/max_age = max_generation_active ? maximum_immortal_age : null
	if((isnum(min_age) && min_age > 0) || !isnull(max_age))
		if(isnum(min_age) && min_age > 0 && !isnull(max_age))
			lines += "Возраст бессмертия: [min_age]–[max_age] лет"
		else if(isnum(min_age) && min_age > 0)
			lines += "Возраст бессмертия: от [min_age] лет"
		else
			lines += "Возраст бессмертия: до [max_age] лет"

	// Character age
	if(isnum(required_character_age) && required_character_age > 0)
		lines += "Возраст персонажа: от [required_character_age] лет"

	// Playtime. Show only while the config actually enforces these limits.
	if(CONFIG_GET(flag/use_exp_tracking) && has_playtime_requirement())
		var/requirement = get_exp_req_amount()
		if(requirement > 0)
			lines += "Наиграно: [CEILING(requirement / 60, 1)] ч."

	// Account age
	if(CONFIG_GET(flag/use_age_restriction_for_jobs) && isnum(minimal_player_age) && minimal_player_age > 0)
		lines += "Возраст аккаунта: от [minimal_player_age] дн."

	// Garou
	if(isnum(minimal_renown_rank) && minimal_renown_rank > 0)
		lines += "Ранг репутации: [minimal_renown_rank]"

	var/list/tribe_names = list()
	for(var/tribe in allowed_tribes)
		tribe_names += get_job_restriction_tribe_name(tribe)
	if(length(tribe_names))
		if(length(tribe_names) <= 8)
			lines += "Племя: [english_list(tribe_names)]"
		else
			lines += "Племя: любое из [length(tribe_names)] племён"

	var/list/disallowed_tribe_names = list()
	for(var/tribe in disallowed_tribes)
		disallowed_tribe_names += get_job_restriction_tribe_name(tribe)
	if(length(disallowed_tribe_names))
		lines += "Запрещённые племена: [english_list(disallowed_tribe_names)]"

	var/list/auspice_names = list()
	for(var/auspice in allowed_auspice)
		auspice_names += get_job_restriction_auspice_name(auspice)
	if(length(auspice_names))
		lines += "Покровительство: [english_list(auspice_names)]"

	var/list/disallowed_auspice_names = list()
	for(var/auspice in disallowed_auspice)
		disallowed_auspice_names += get_job_restriction_auspice_name(auspice)
	if(length(disallowed_auspice_names))
		lines += "Запрещённые покровительства: [english_list(disallowed_auspice_names)]"

	return lines

/// Whether this job's playtime requirement is currently enforced by config.
/datum/job/proc/has_playtime_requirement()
	if(!exp_requirements)
		return FALSE
	if(exp_required_type_department && CONFIG_GET(flag/use_exp_restrictions_heads))
		return TRUE
	if(exp_required_type && CONFIG_GET(flag/use_exp_restrictions_other))
		return TRUE
	return FALSE

/// Human-readable splat name for job tooltips.
/proc/get_job_restriction_splat_name(splat_id)
	if(splat_id == SPLAT_NONE)
		return "Люди"
	var/splat_type = GLOB.splat_list[splat_id]
	var/datum/splat/splat = GLOB.splat_prototypes[splat_type]
	return splat ? splat.get_display_name() : splat_id

/// Human-readable clan name for job tooltips.
/proc/get_job_restriction_clan_name(clan_id)
	for(var/datum/subsplat/vampire_clan/clan as anything in GLOB.vampire_clans)
		if(clan::id == clan_id)
			return clan::ru_name || clan::name
	return clan_id

/// Human-readable tribe name for job tooltips.
/proc/get_job_restriction_tribe_name(tribe_name)
	var/datum/subsplat/werewolf/tribe/tribe = get_fera_tribe(tribe_name)
	return tribe ? tribe.get_display_name() : tribe_name

/// Human-readable auspice name for job tooltips.
/proc/get_job_restriction_auspice_name(auspice_name)
	var/datum/subsplat/werewolf/auspice/auspice = get_fera_auspice(auspice_name)
	return auspice ? auspice.get_display_name() : auspice_name
