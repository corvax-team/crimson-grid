/*
 * Runs an extended suite of eligibility checks to make sure the player can take the requested job.
 *
 * Checks:
 * * Species Availability
 * * Species Slots
 * * Whitelist - TODO
 * * Kindred Age
 * * Kindred Generation
 * * Kindred Clan
 *
 * Arguments:
 * * player - The player to check for job eligibility.
 * * possible_job - The job to check for eligibility against.
 * * debug_prefix - Logging prefix for the job_debug log entries. For example, GRJ during give_random_job or DO during divide_occupations.
 * * add_job_to_log - If TRUE, appends the job type to the log entry. If FALSE, does not. Set to FALSE when check is part of iterating over players for a specific job, set to TRUE when check is part of iterating over jobs for a specific player and you don't want extra log entry spam.
 */
/datum/controller/subsystem/job/proc/check_job_eligibility_darkpack(mob/dead/new_player/player, datum/job/possible_job, debug_prefix = "", add_job_to_log = FALSE)
	// CORVAX EDIT CHANGE START - JOB_SLOTS: character checks read the character that would actually join (the one assigned to the job at roundstart) and live in modular_corvax/modules/jobs/code/job_character_slots.dm, so the lobby menu can run them per saved character without logging
	var/client/player_client = GET_CLIENT(player)
	var/character_slot = player_client.prefs.get_job_character_slot(possible_job.title)
	var/unavailability = player_client.prefs.get_character_job_unavailability(possible_job, character_slot)
	if(unavailability != JOB_AVAILABLE)
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(unavailability, possible_job.title)], Player: [player], Slot: [character_slot][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return unavailability
	// CORVAX EDIT CHANGE END

	/*
	if(possible_job.whitelisted)
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_WHITELIST, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_WHITELIST
	*/

	return JOB_AVAILABLE

/*
* decrement the splat slot count for the job if the player has a splat pref selected
* stores their splat id on their mind so if they cryo we can check if this var is not null, if not, we can increment the splat slot count back up using their splat ID
*/
/datum/controller/subsystem/job/proc/take_splat_slot(mob/dead/new_player/player, datum/job/job)
	if(!job.splat_slots)
		return
	var/client/player_client = GET_CLIENT(player)
	if(!player_client)
		return
	var/splat_pref = player_client.prefs.read_preference(/datum/preference/choiced/splats)
	var/player_splat = splat_pref
	if(ispath(splat_pref))
		var/datum/splat/splat_prototype = GLOB.splat_prototypes[splat_pref]
		player_splat = splat_prototype.id
	if(job.splat_slots[player_splat] > 0)
		job.splat_slots[player_splat]--
		player.mind.splat_slot_id = player_splat

/datum/config_entry/flag/max_gen_limits //If you can be limited from a job for having too high a generation

// CORVAX EDIT REMOVE - JOB_SLOTS: check_kindred_prefs() and check_garou_prefs() moved to /datum/preferences/proc/get_kindred_job_unavailability() and get_garou_job_unavailability() in modular_corvax/modules/jobs/code/job_character_slots.dm
