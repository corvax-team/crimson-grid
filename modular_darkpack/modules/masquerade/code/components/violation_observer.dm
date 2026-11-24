/atom/movable
	var/violation_observer = FALSE
	COOLDOWN_DECLARE(masquerade_violation_cooldown)

/atom/movable/proc/toggle_masquerade_sensitivity(new_listening_state)
	// don't proceed if we're toggling to TRUE on something already listening
	if(!isnull(new_listening_state) && new_listening_state == violation_observer)
		return

	// if we don't pass an arg just flip the switch
	if(isnull(new_listening_state))
		violation_observer = !violation_observer
	else
		violation_observer = new_listening_state

	if(violation_observer)
		RegisterSignal(src, COMSIG_SEEN_MASQUERADE_VIOLATION, PROC_REF(on_observed_violation))
		// CORVAX EDIT REMOVAL - Masquerade breach tracking: SSmasquerade watches the parties of every breach (modular_corvax/modules/masquerade/code/breach_tracking.dm). A witness that stopped observing dropped these and its breaches could no longer be ended, admin verbs included. ORIGINAL: RegisterSignal(src, COMSIG_MASQUERADE_REINFORCE, PROC_REF(on_masquerade_violation_reinforced)) / RegisterSignals(src, list(COMSIG_LIVING_DEATH, COMSIG_ALL_MASQUERADE_REINFORCE), PROC_REF(on_masquerade_witness_death))
	else
		UnregisterSignal(src, COMSIG_SEEN_MASQUERADE_VIOLATION) // CORVAX EDIT CHANGE - Masquerade breach tracking. ORIGINAL: UnregisterSignal(src, list(COMSIG_SEEN_MASQUERADE_VIOLATION, COMSIG_MASQUERADE_REINFORCE, COMSIG_LIVING_DEATH, COMSIG_ALL_MASQUERADE_REINFORCE))

/atom/movable/proc/on_masquerade_violation(datum/source, violation_reason) // CORVAX EDIT CHANGE - Player Masquerade Witness - Original: /atom/movable/proc/on_masquerade_violation()
	if(!COOLDOWN_FINISHED(src, masquerade_violation_cooldown))
		return
	var/area/vtm/breacher_area = get_area(src)
	if(!istype(breacher_area, /area/vtm))
		return
	if(breacher_area.zone_type != ZONE_MASQUERADE)
		return
	for(var/atom/movable/moving_atom in view(7, loc))
		if(!moving_atom.violation_observer)
			continue
		SEND_SIGNAL(moving_atom, COMSIG_SEEN_MASQUERADE_VIOLATION, src)
	// CORVAX EDIT ADD START - Player Masquerade Witness
	if(isliving(src) && !ismundane(src))
		for(var/mob/living/carbon/human/witness in viewers(7, src))
			witness.notice_masquerade_violation(src, violation_reason)
			SEND_SIGNAL(witness, COMSIG_HUMAN_SAW_MASQUERADE_VIOLATION, src, violation_reason) // CORVAX EDIT ADD - Masquerade breach tracking: body cameras film what their wearer sees
	// CORVAX EDIT ADD END - Player Masquerade Witness
	COOLDOWN_START(src, masquerade_violation_cooldown, 1 TURNS)

/atom/movable/proc/on_observed_violation(atom/source, atom/movable/player_breacher)
	SIGNAL_HANDLER

	if(!source || !player_breacher || ismundane(player_breacher)) //Humans cant break the masquerade. Because reasons.
		return

	if(isnpc(source))
		var/mob/living/carbon/human/npc/npc_source = source
		if(npc_source.client)
			return

	if(isliving(source))
		var/mob/living/mob_parent = source
		if(mob_parent.stat == DEAD)
			return
		if(!INCAPACITATED_IGNORING(mob_parent, INCAPABLE_RESTRAINTS))
			mob_parent.face_atom(player_breacher)
	// CORVAX EDIT ADD START - Masquerade breach tracking: show the violation only when a breach was recorded. A breacher with no Masquerade left records none, and the mark left on the witness could never be cleared
	if(!SSmasquerade.masquerade_breach(source, player_breacher, (isliving(source) ? MASQUERADE_REASON_NPC : MASQUERADE_REASON_OBJECT)))
		return
	// CORVAX EDIT ADD END
	source.observe_masquerade_violation(player_breacher)

	var/mutable_appearance/alert = mutable_appearance('icons/obj/storage/closet.dmi', "cardboard_special")
	SET_PLANE_EXPLICIT(alert, ABOVE_LIGHTING_PLANE, source)
	var/atom/movable/flick_visual/exclamation = source.flick_overlay_view(alert, 1 SECONDS)
	exclamation.alpha = 0
	exclamation.pixel_x = -source.pixel_x
	animate(exclamation, pixel_z = 32, alpha = 255, time = 0.5 SECONDS, easing = ELASTIC_EASING)

	source.AddComponent(/datum/component/masquerade_hud, player_breacher)
	// CORVAX EDIT REMOVAL - Masquerade breach tracking: the breach is recorded above, and SSmasquerade watches the breacher's death. ORIGINAL: SSmasquerade.masquerade_breach(source, player_breacher, (isliving(source) ? MASQUERADE_REASON_NPC : MASQUERADE_REASON_OBJECT)) / RegisterSignal(player_breacher, COMSIG_LIVING_DEATH, PROC_REF(on_breacher_death), override = TRUE)

	return TRUE

// CORVAX EDIT REMOVAL - Masquerade breach tracking: on_masquerade_violation_reinforced(), on_masquerade_witness_death() and on_breacher_death() are SSmasquerade's end_breach(), end_breaches_witnessed_by() and end_breaches_of() now (modular_corvax/modules/masquerade/code/breach_tracking.dm). They lived on the witness, which dropped them when it stopped observing.

/atom/proc/observe_masquerade_violation(player_breacher)
	do_alert_animation()
	if(get_werewolf_splat(player_breacher))
		to_chat(player_breacher, span_userdanger(span_bold("НАРУШЕНИЕ ВУАЛИ")))
		playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/veil_violation.ogg', 50, FALSE, -5)
		return
	playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/masquerade_violation.ogg', 50, FALSE, -5)
	to_chat(player_breacher, span_userdanger(span_bold("НАРУШЕНИЕ МАСКАРАДА")))

/atom/proc/observe_masquerade_reinforce(player_breacher)
	if(get_werewolf_splat(player_breacher))
		to_chat(player_breacher, span_big(span_boldnicegreen("ВУАЛЬ ВОССТАНОВЛЕНА")))
		playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/humanity_gain.ogg', 50, FALSE, -5)
		return
	to_chat(player_breacher, span_big(span_boldnicegreen("МАСКАРАД ВОССТАНОВЛЕН")))
	playsound(player_breacher, 'modular_darkpack/modules/masquerade/sound/masquerade_reinforce.ogg', 50, FALSE, -5)
