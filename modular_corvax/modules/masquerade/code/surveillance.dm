// The surveillance machine (/obj/machinery/logging_machine) is the witness of everything the city's devices catch:
// what phones overhear in a call and what body cameras film. Wiping its records or destroying it ends those breaches.

/obj/machinery/logging_machine
	/// Who the machine last recorded a breach of, and when. Both phones of a call hear the same words at once, and that is one violation
	var/datum/weakref/last_breacher_ref
	var/last_breach_time

/// Records a breach of `breacher`, with the machine as its witness. Returns TRUE if a breach was recorded
/obj/machinery/logging_machine/proc/record_breach(mob/living/breacher)
	var/datum/weakref/breacher_ref = WEAKREF(breacher)
	if(last_breacher_ref == breacher_ref && last_breach_time == world.time)
		return FALSE
	last_breacher_ref = breacher_ref
	last_breach_time = world.time
	return on_observed_violation(src, breacher) || FALSE

/**
 * Logs a line on every surveillance machine. When `breacher` gave themselves away in it, the machine records their breach.
 * Returns TRUE if a breach was recorded.
 *
 * The first machine in the city is the witness: each map has one. Its record names the breacher only when it stands for a breach,
 * so wiping records ends exactly as many breaches as were recorded.
 *
 * * breach_only - Log nothing unless a breach was recorded. For sources that repeat themselves, like a camera pointed at a monster.
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
