/// Ignites matches swiped over it.
/datum/element/ignites_matches

/datum/element/ignites_matches/Attach(datum/target)
	. = ..()
	RegisterSignal(target, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_interact))

/datum/element/ignites_matches/Detach(datum/source)
	UnregisterSignal(source, COMSIG_ATOM_ITEM_INTERACTION)
	return ..()

/datum/element/ignites_matches/proc/on_interact(atom/source, mob/living/user, obj/item/match/match, ...)
	SIGNAL_HANDLER
	if(!istype(match) || match.lit || match.burnt || match.broken)
		return NONE
	if(SHOULD_SKIP_INTERACTION(source, match, user))
		return NONE
	var/over_what_tp = source.declent_ru(DATIVE)
	var/over_what_fp = source.declent_ru(DATIVE)
	if(prob(10))
		user.visible_message(
			span_warning("[capitalize(user.declent_ru(NOMINATIVE))] чиркает спичкой по [over_what_tp], но ничего не происходит."),
			span_warning("Вы чиркаете спичкой по [over_what_fp], но она не загорается."),
		)
		return ITEM_INTERACT_SUCCESS
	if(prob((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_HULK)) ? 33 : 2))
		user.visible_message(
			span_warning("[capitalize(user.declent_ru(NOMINATIVE))] чиркает спичкой по [over_what_tp] и нечаянно её ломает."),
			span_warning("Вы слишком резко чиркаете спичкой по [over_what_fp] и ломаете её пополам."),
		)
		match.snap()
		return ITEM_INTERACT_SUCCESS

	user.visible_message(
		span_rose("[capitalize(user.declent_ru(NOMINATIVE))] чиркает спичкой по [over_what_tp], и та загорается."),
		span_rose("Вы чиркаете спичкой по [over_what_fp], и она загорается."),
	)
	match.matchignite()
	return ITEM_INTERACT_SUCCESS
