// A breach is list(breacher, witness). SSmasquerade ends it, never the witness itself.

/// Watches a breach party: both parties of a breach, or a player who reported without one
/datum/controller/subsystem/masquerade/proc/track_breach_party(datum/party)
	if(!istype(party))
		return
	RegisterSignal(party, COMSIG_QDELETING, PROC_REF(on_breach_party_deleted), override = TRUE)
	RegisterSignal(party, COMSIG_LIVING_DEATH, PROC_REF(on_breach_party_death), override = TRUE)
	RegisterSignal(party, COMSIG_MASQUERADE_REINFORCE, PROC_REF(on_breach_party_reinforce), override = TRUE)
	RegisterSignal(party, COMSIG_ALL_MASQUERADE_REINFORCE, PROC_REF(on_breach_party_forgets), override = TRUE)

/// Ends one breach of `breacher` held by `witness`. Returns TRUE if there was one
/datum/controller/subsystem/masquerade/proc/end_breach(atom/witness, mob/living/breacher)
	if(!masquerade_reinforce(witness, breacher))
		return FALSE
	if(witness)
		SEND_SIGNAL(witness, COMSIG_MASQUERADE_HUD_DELETE, breacher)
		witness.observe_masquerade_reinforce(breacher)
	return TRUE

/// Ends all breaches held by this witness
/datum/controller/subsystem/masquerade/proc/end_breaches_witnessed_by(atom/witness)
	for(var/list/breach as anything in masquerade_breachers.Copy())
		if(breach[MASQUERADE_BREACH_WITNESSES] == witness)
			end_breach(witness, breach[MASQUERADE_BREACH_BREACHER])

/// Ends all breaches of this breacher
/datum/controller/subsystem/masquerade/proc/end_breaches_of(mob/living/breacher)
	for(var/list/breach as anything in masquerade_breachers.Copy())
		if(breach[MASQUERADE_BREACH_BREACHER] == breacher)
			end_breach(breach[MASQUERADE_BREACH_WITNESSES], breacher)

/// The reinforcement link a mundane witness clicks
/datum/controller/subsystem/masquerade/proc/on_breach_party_reinforce(atom/witness, mob/living/breacher)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/human_witness = witness
	if(istype(human_witness))
		LAZYREMOVE(human_witness.masquerade_reports_without_breach, WEAKREF(breacher))
	return end_breach(witness, breacher)

/// A dead witness tells no one; a dead breacher is forgiven
/datum/controller/subsystem/masquerade/proc/on_breach_party_death(mob/living/party)
	SIGNAL_HANDLER
	end_breaches_witnessed_by(party)
	end_breaches_of(party)
	forget_reports_without_breach(party)

/// Dominate memory wipe, phone destroyed, round end
/datum/controller/subsystem/masquerade/proc/on_breach_party_forgets(atom/witness)
	SIGNAL_HANDLER
	end_breaches_witnessed_by(witness)
	forget_reports_without_breach(witness)

/// A deleted witness ends its breaches; a deleted breacher gives the city its level back, as on Matrix
/datum/controller/subsystem/masquerade/proc/on_breach_party_deleted(datum/source)
	SIGNAL_HANDLER
	end_breaches_witnessed_by(source)
	if(isliving(source))
		matrix_masquerade_breacher(source, update_preferences = FALSE)
	for(var/list/breach as anything in masquerade_breachers.Copy())
		var/list/witness_list = breach[MASQUERADE_BREACH_WITNESSES]
		if(!islist(witness_list))
			continue
		witness_list -= source
		if(!length(witness_list))
			masquerade_breachers -= list(breach)

/datum/controller/subsystem/masquerade/proc/forget_reports_without_breach(atom/witness)
	var/mob/living/carbon/human/human_witness = witness
	if(istype(human_witness))
		human_witness.masquerade_reports_without_breach = null
