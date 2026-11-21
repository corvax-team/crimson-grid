/// Which saved character joins as this job right now.
/// At roundstart that is the character assigned to the job, if any; once the round is running, joining always uses the active character.
/datum/preferences/proc/get_job_character_slot(job_title)
	if(SSticker.current_state >= GAME_STATE_PLAYING)
		return default_slot
	var/assigned_slot = LAZYACCESS(job_assigned_profiles, job_title)
	if(has_character_in_slot(assigned_slot))
		return assigned_slot
	return default_slot

/// Whether the slot holds a saved character.
/datum/preferences/proc/has_character_in_slot(slot)
	if(!isnum(slot) || slot < 1 || slot > max_save_slots)
		return FALSE
	return slot == default_slot || !isnull(savefile.get_entry("character[slot]"))

/// Reads a character preference of any saved slot without loading it. Missing values fall back to the default, nothing is written.
/datum/preferences/proc/read_slot_preference(slot, preference_type)
	if(slot == default_slot)
		return read_preference(preference_type)
	var/datum/preference/preference_entry = GLOB.preference_entries[preference_type]
	var/value = preference_entry.read(savefile.get_entry("character[slot]"), src)
	return isnull(value) ? preference_entry.create_informed_default_value(src) : value

/**
 * The job restrictions that depend on the character rather than the player: age, splat, and the splat's own limits.
 * Player-level checks (bans, playtime, account age) stay in SSjob.check_job_eligibility.
 *
 * Returns JOB_AVAILABLE or a JOB_UNAVAILABLE_* code.
 */
/datum/preferences/proc/get_character_job_unavailability(datum/job/job, slot)
	if(isnum(job.required_character_age) && job.required_character_age > read_slot_preference(slot, /datum/preference/numeric/age))
		return JOB_UNAVAILABLE_AGE

	var/splat_pref = read_slot_preference(slot, /datum/preference/choiced/splats)
	var/splat_id = splat_pref
	if(ispath(splat_pref))
		var/datum/splat/splat = GLOB.splat_prototypes[splat_pref]
		splat_id = splat.id

	if(job.allowed_splats && !(splat_id in job.allowed_splats))
		return JOB_UNAVAILABLE_SPLAT
	if(job.splat_slots && (job.splat_slots[splat_id] == 0))
		return JOB_UNAVAILABLE_SPLAT_SLOTS

	switch(splat_id)
		if(SPLAT_KINDRED)
			return get_kindred_job_unavailability(job, slot)
		if(SPLAT_GAROU)
			return get_garou_job_unavailability(job, slot)
	return JOB_AVAILABLE

/datum/preferences/proc/get_kindred_job_unavailability(datum/job/job, slot)
	var/immortal_age = read_slot_preference(slot, /datum/preference/numeric/immortal_age)
	if(immortal_age < job.minimum_immortal_age)
		return JOB_UNAVAILABLE_KINDRED_AGE_MIN
	if(CONFIG_GET(flag/max_gen_limits) && !isnull(job.maximum_immortal_age) && immortal_age > job.maximum_immortal_age)
		return JOB_UNAVAILABLE_KINDRED_AGE_MAX

	var/generation = read_slot_preference(slot, /datum/preference/numeric/generation)
	if(generation > job.minimal_generation)
		return JOB_UNAVAILABLE_KINDRED_GENERATION_MIN
	if(CONFIG_GET(flag/max_gen_limits) && generation < job.maximal_generation)
		return JOB_UNAVAILABLE_KINDRED_GENERATION_MAX

	var/datum/subsplat/vampire_clan/clan = get_vampire_clan(read_slot_preference(slot, /datum/preference/choiced/subsplat/vampire_clan))
	if(job.allowed_clans && !(clan.id in job.allowed_clans))
		return JOB_UNAVAILABLE_KINDRED_CLAN
	if(job.disallowed_clans && (clan.id in job.disallowed_clans))
		return JOB_UNAVAILABLE_KINDRED_CLAN
	return JOB_AVAILABLE

/datum/preferences/proc/get_garou_job_unavailability(datum/job/job, slot)
	var/datum/subsplat/werewolf/auspice/auspice = get_fera_auspice(read_slot_preference(slot, /datum/preference/choiced/subsplat/fera_auspice/garou))
	if(job.allowed_auspice && !(auspice.name in job.allowed_auspice))
		return JOB_UNAVAILABLE_FERA_AUSPICE
	if(job.disallowed_auspice && (auspice.name in job.disallowed_auspice))
		return JOB_UNAVAILABLE_FERA_AUSPICE

	var/datum/subsplat/werewolf/tribe/tribe = get_fera_tribe(read_slot_preference(slot, /datum/preference/choiced/subsplat/fera_tribe/garou))
	if(job.allowed_tribes && !(tribe.name in job.allowed_tribes))
		return JOB_UNAVAILABLE_FERA_TRIBE
	if(job.disallowed_tribes && (tribe.name in job.disallowed_tribes))
		return JOB_UNAVAILABLE_FERA_TRIBE
	return JOB_AVAILABLE

/// An assignment is refused unless the character in that slot may take the job.
/datum/preference_middleware/jobs/set_job_to_profile(list/params, mob/user)
	var/profile_slot = params["profile"]
	if(isnum(profile_slot) && profile_slot != -1)
		var/datum/job/job = SSjob.get_job(params["job"])
		if(isnull(job) || !preferences.has_character_in_slot(profile_slot))
			return FALSE
		if(preferences.get_character_job_unavailability(job, profile_slot) != JOB_AVAILABLE)
			return FALSE
	return ..()

/datum/preference_middleware/jobs/get_ui_data(mob/user)
	. = ..()
	var/list/character_slots = list()
	for(var/slot in 1 to preferences.max_save_slots)
		if(preferences.has_character_in_slot(slot))
			character_slots += slot

	// Job title => why the character who would join cannot take it.
	var/list/job_unavailable = list()
	// Job title => slots whose characters cannot take it, greyed out in the slot dropdown.
	var/list/job_unavailable_slots = list()
	for(var/datum/job/job as anything in SSjob.joinable_occupations)
		var/list/unavailable_slots = list()
		for(var/slot in character_slots)
			if(preferences.get_character_job_unavailability(job, slot) != JOB_AVAILABLE)
				unavailable_slots += slot
		if(length(unavailable_slots))
			job_unavailable_slots[job.title] = unavailable_slots

		var/join_slot = preferences.get_job_character_slot(job.title)
		if(join_slot in unavailable_slots)
			job_unavailable[job.title] = get_job_unavailable_error_message(preferences.get_character_job_unavailability(job, join_slot), job.title)

	.["job_unavailable"] = job_unavailable
	.["job_unavailable_slots"] = job_unavailable_slots
