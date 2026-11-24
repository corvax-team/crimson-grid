// The surveillance machine witnesses what phones overhear and body cameras film.

/obj/machinery/logging_machine
	/// Last breacher recorded, so both phones of one call give one breach
	var/datum/weakref/last_breacher_ref
	var/last_breach_time

/// Records a breach with the machine as witness. Returns TRUE if one was recorded
/obj/machinery/logging_machine/proc/record_breach(mob/living/breacher)
	var/datum/weakref/breacher_ref = WEAKREF(breacher)
	if(last_breacher_ref == breacher_ref && last_breach_time == world.time)
		return FALSE
	last_breacher_ref = breacher_ref
	last_breach_time = world.time
	return on_observed_violation(src, breacher) || FALSE

/**
 * Logs a line on every surveillance machine; the first machine records the breach, if any.
 * Returns TRUE if a breach was recorded.
 *
 * * breacher - Who gave themselves away in the line. Named in the record only when a breach was recorded
 * * breach_only - Log nothing without a breach, for sources that repeat themselves
 */
/datum/controller/subsystem/masquerade/proc/log_surveillance(message, atom/movable/breacher, breach_only = FALSE)
	var/obj/machinery/logging_machine/witness = length(GLOB.logging_machines) ? GLOB.logging_machines[1] : null
	var/datum/weakref/breacher_ref
	if(witness && isliving(breacher) && witness.record_breach(breacher))
		breacher_ref = WEAKREF(breacher)
	else if(breach_only)
		return FALSE
	for(var/obj/machinery/logging_machine/logging_machine as anything in GLOB.logging_machines)
		logging_machine.saved_logs += list(list(message, (logging_machine == witness) ? breacher_ref : null))
	return !isnull(breacher_ref)
