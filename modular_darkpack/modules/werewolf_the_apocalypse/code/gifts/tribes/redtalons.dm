/datum/storyteller_roll/gift/hidden_killer
	bumper_text = "тайный убийца"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_LARCENY)

/datum/action/cooldown/power/gift/hidden_killer
	name = "Тайный убийца"
	desc = "Красные Когти не прожили бы так долго, не научись они заметать следы. С этим Даром оборотень не оставляет на месте убийства ни одной улики, которая выдала бы его руку (или когти, или клыки)."
	button_icon_state = "hidden_killer"

	click_to_activate = TRUE

	rank = 1

/datum/action/cooldown/power/gift/hidden_killer/Activate(atom/target)
	var/mob/living/carbon/human/human_owner = astype(owner)
	var/mob/living/dead_guy = astype(target)
	if(!dead_guy || dead_guy.stat != DEAD)
		return FALSE
	if(!(target in range(1, owner)))
		return FALSE

	. = ..()

	owner.visible_message("[capitalize(owner.declent_ru(NOMINATIVE))] прикладывает ладонь к телу [dead_guy.declent_ru(GENITIVE)]")

	var/datum/storyteller_roll/gift/hidden_killer/roll_datum = new()
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result != ROLL_SUCCESS)
		return TRUE

	var/list/owner_blood_dna = human_owner?.get_blood_dna_list()
	var/full_print = md5(human_owner.dna.unique_identity)

	for(var/obj/effect/decal/cleanable/blood/blood_spot in range(12, owner))
		for(var/blood_dna in GET_ATOM_BLOOD_DNA(blood_spot))
			if(blood_dna in owner_blood_dna)
				qdel(blood_spot)
				break

	for(var/atom/nearby_atom in range(8, owner))
		var/datum/forensics/atom_forensics = nearby_atom.forensics
		if(!atom_forensics)
			continue

		for(var/fingerprint in atom_forensics.fingerprints)
			if(fingerprint == full_print)
				atom_forensics.fingerprints -= fingerprint

		for(var/bloodprint in atom_forensics.blood_DNA)
			if(bloodprint in owner_blood_dna)
				atom_forensics.blood_DNA -= bloodprint

	return TRUE
