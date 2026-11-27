/// Medicine dots needed to notice how a Kindred body treats an injected substance
#define MEDICAL_EXAM_INJECTION_LEVEL 5

/// Watches one injection for a Kindred body destroying what was injected
/datum/substance_rejection_watch
	/// Whether the patient's body destroyed any of the injected reagents
	var/rejected = FALSE

/datum/substance_rejection_watch/New(mob/living/patient)
	RegisterSignal(patient, COMSIG_KINDRED_REAGENT_DESTROYED, PROC_REF(on_reagent_destroyed))

/datum/substance_rejection_watch/proc/on_reagent_destroyed(datum/source, reagent_type)
	SIGNAL_HANDLER
	rejected = TRUE

/**
 * Starts watching an injection into `target`, or returns null when nobody could notice anything
 *
 * * user - the one injecting
 */
/proc/watch_injection(mob/living/user, atom/target)
	if(!isliving(user) || !isliving(target) || !get_kindred_splat(target))
		return null
	if(user.st_get_stat(STAT_MEDICINE) < MEDICAL_EXAM_INJECTION_LEVEL)
		return null
	return new /datum/substance_rejection_watch(target)

/// Tells the injector what they noticed and stops watching
/proc/finish_injection_watch(datum/substance_rejection_watch/watch, mob/living/user, mob/living/target)
	if(isnull(watch))
		return
	if(watch.rejected && !QDELETED(target))
		var/whose_body = user == target ? "Ваше тело" : "Тело [target.declent_ru(GENITIVE)]"
		to_chat(user, span_warning("[whose_body] странно реагирует на вещество."))
	qdel(watch)

/obj/item/reagent_containers/syringe/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	var/datum/substance_rejection_watch/watch = watch_injection(user, target)
	. = ..()
	finish_injection_watch(watch, user, target)

/obj/item/reagent_containers/hypospray/inject(mob/living/affected_mob, mob/user)
	var/datum/substance_rejection_watch/watch = watch_injection(user, affected_mob)
	. = ..()
	finish_injection_watch(watch, user, affected_mob)

#undef MEDICAL_EXAM_INJECTION_LEVEL
