#define HEAL_BASHING_LETHAL_DAMAGE 30
#define HEAL_AGGRAVATED_DAMAGE 6

/datum/discipline/bloodheal
	name = "Исцеление кровью"
	desc = {"Сила витэ заживляет вашу плоть.
● Исцеление кровью: Выносливость + Выживание (сложность 8) - проверка нужна, только если вас прервали"}
	icon_state = "bloodheal"
	power_type = /datum/discipline_power/bloodheal
	selectable = FALSE

/datum/storyteller_roll/bloodheal
	bumper_text = "исцеление кровью"
	difficulty = 8
	applicable_stats = list(STAT_STAMINA, STAT_SURVIVAL)
	roll_output_type = ROLL_PRIVATE

/datum/discipline_power/bloodheal
	name = "Bloodheal power name"
	desc = "Bloodheal power description"

	activate_sound = 'modular_darkpack/modules/vampire_the_masquerade/sounds/bloodhealing.ogg'

	level = 1
	check_flags = DISC_CHECK_TORPORED
	vitae_cost = 1

	violates_masquerade = FALSE

	cooldown_length = 1 TURNS

	grouped_powers = list(
		/datum/discipline_power/bloodheal/one,
		/datum/discipline_power/bloodheal/two,
		/datum/discipline_power/bloodheal/three,
		/datum/discipline_power/bloodheal/four,
		/datum/discipline_power/bloodheal/five,
		/datum/discipline_power/bloodheal/six,
		/datum/discipline_power/bloodheal/seven,
		/datum/discipline_power/bloodheal/eight,
		/datum/discipline_power/bloodheal/nine,
		/datum/discipline_power/bloodheal/ten,
	)

	var/datum/storyteller_roll/bloodheal/bloodheal_roll

#define BLOODHEAL_INTERACTION_KEY "bloodheal_key"

/datum/discipline_power/bloodheal/pre_activation_checks(atom/target)
	. = ..()
	if(do_after(owner, 1 TURNS, timed_action_flags = DO_AFTER_CHECK_NEXT_MOVE | IGNORE_INCAPACITATED, interaction_key = BLOODHEAL_INTERACTION_KEY))
		return TRUE
	if(!bloodheal_roll)
		bloodheal_roll = new()
	var/roll_result = bloodheal_roll.st_roll(owner, src)
	to_chat(owner, span_warning("Вы теряете сосредоточенность..."))
	switch(roll_result)
		if(ROLL_SUCCESS)
			to_chat(owner, span_notice("Но раны всё-таки затягиваются."))
			return TRUE
		if(ROLL_FAILURE)
			to_chat(owner, span_warning("И кровь перестаёт вам подчиняться."))
			return FALSE
		if(ROLL_BOTCH)
			to_chat(owner, span_danger("И раны становятся только хуже."))
			owner.adjust_blood_pool(-1)
			owner.apply_damage(1 TTRPG_DAMAGE, BRUTE)
			return FALSE

#undef BLOODHEAL_INTERACTION_KEY

/datum/discipline_power/bloodheal/activate()
	. = ..()

	//normal bashing/lethal damage
	owner.heal_ordered_damage(HEAL_BASHING_LETHAL_DAMAGE * vitae_cost, list(BRUTE, TOX, OXY, STAMINA))

	if(length(owner.all_wounds))
		for (var/i in 1 to min(vitae_cost, length(owner.all_wounds)))
			var/datum/wound/wound = owner.all_wounds[i]
			wound.remove_wound()

	//aggravated damage
	owner.heal_ordered_damage(HEAL_AGGRAVATED_DAMAGE * vitae_cost, list(BURN, AGGRAVATED))

	//brain damage and traumas healing
	var/obj/item/organ/brain/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (brain)
		brain.apply_organ_damage(-HEAL_BASHING_LETHAL_DAMAGE * vitae_cost)

		for (var/i in 1 to min(vitae_cost, length(brain.get_traumas_type())))
			var/datum/brain_trauma/healing_trauma = pick(brain.get_traumas_type())
			brain.cure_trauma_type(healing_trauma, resilience = TRAUMA_RESILIENCE_WOUND)

	// Let core species logic handle restoring/healing organs so missing eyes are rebuilt correctly.
	owner.regenerate_organs()
	var/obj/item/organ/eyes/eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	if (!eyes)
		var/eyes_type = owner.dna?.species?.get_mutant_organ_type_for_slot(ORGAN_SLOT_EYES) || /obj/item/organ/eyes
		eyes = new eyes_type()
		eyes.Insert(owner, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	owner.cure_blind(NO_EYES)
	if(!owner.has_quirk(/datum/quirk/item_quirk/blindness))
		owner.cure_blind(QUIRK_TRAIT)
	owner.cure_blind(EYE_DAMAGE)
	owner.cure_blind(EYE_SCARRING_TRAIT)
	owner.cure_nearsighted(QUIRK_TRAIT)
	owner.cure_nearsighted(EYE_DAMAGE)
	if (eyes)
		eyes.fix_scar(LEFT_EYE_SCAR)
		eyes.fix_scar(RIGHT_EYE_SCAR)
	owner.remove_status_effect(/datum/status_effect/temporary_blindness)
	owner.remove_status_effect(/datum/status_effect/eye_blur)

	if(get_kindred_splat(owner) && length(owner.get_missing_limbs()))
		owner.regenerate_limbs()
		violates_masquerade = TRUE

	//healing too quickly attracts attention
	if (violates_masquerade)
		owner.visible_message(
			span_warning("Раны [owner.declent_ru(GENITIVE)] затягиваются с неестественной быстротой!"),
			span_warning("Ваши раны на глазах затягиваются с неестественной быстротой!")
		)

	//update UI
	owner.update_damage_overlays()
	owner.update_health_hud()

/datum/discipline_power/bloodheal/spend_resources()
	adjust_vitae_cost()

	. = ..()

/datum/discipline_power/bloodheal/proc/adjust_vitae_cost()
	vitae_cost = initial(vitae_cost)
	//tally up damage
	var/total_bashing_lethal_damage = owner.get_brute_loss() + owner.get_tox_loss() + owner.get_oxy_loss()
	var/total_aggravated_damage = owner.get_agg_loss() + owner.get_fire_loss()

	//lower blood expenditure to what's necessary
	var/vitae_to_heal_bashing_lethal = ceil(total_bashing_lethal_damage / HEAL_BASHING_LETHAL_DAMAGE)
	var/vitae_to_heal_aggravated = ceil(total_aggravated_damage / HEAL_AGGRAVATED_DAMAGE)

	var/vitae_needed = max(vitae_to_heal_bashing_lethal, vitae_to_heal_aggravated)

	//vitae used to heal is the smaller of max vitae expenditure and what's needed to heal the damage
	vitae_cost = max(min(vitae_cost, vitae_needed), 1)

	//healing is a masquerade breach if it's done at level 3 and above
	if (vitae_cost > 2)
		violates_masquerade = TRUE
	else
		violates_masquerade = FALSE

//BLOODHEAL 1
/datum/discipline_power/bloodheal/one
	name = "Малое исцеление кровью"
	desc = "Медленно заживляет вашу мёртвую плоть."

	level = 1
	vitae_cost = 1

	violates_masquerade = FALSE

//BLOODHEAL 2
/datum/discipline_power/bloodheal/two
	name = "Исцеление кровью"
	desc = "Заживляет вашу мёртвую плоть."

	level = 2
	vitae_cost = 2

	violates_masquerade = FALSE

//BLOODHEAL 3
/datum/discipline_power/bloodheal/three
	name = "Быстрое исцеление кровью"
	desc = "Заживляет вашу мёртвую плоть с неестественной быстротой."

	level = 3
	vitae_cost = 3

	violates_masquerade = TRUE

//BLOODHEAL 4
/datum/discipline_power/bloodheal/four
	name = "Сильное исцеление кровью"
	desc = "В два счёта исцеляет даже самые страшные раны."

	level = 4
	vitae_cost = 4

	violates_masquerade = TRUE

//BLOODHEAL 5
/datum/discipline_power/bloodheal/five
	name = "Большое исцеление кровью"
	desc = "Без малейшего труда отращивает заново целые части тела."

	level = 5
	vitae_cost = 5

	violates_masquerade = TRUE

//BLOODHEAL 6
/datum/discipline_power/bloodheal/six
	name = "Великое исцеление кровью"
	desc = "Без малейшего труда отращивает заново целые части тела."

	level = 6
	vitae_cost = 6

	violates_masquerade = TRUE

//BLOODHEAL 7
/datum/discipline_power/bloodheal/seven
	name = "Великое исцеление кровью"
	desc = "Воссоздаёт ваше тело почти из ничего."

	level = 7
	vitae_cost = 7

	violates_masquerade = TRUE

//BLOODHEAL 8
/datum/discipline_power/bloodheal/eight
	name = "Божественное исцеление кровью"
	desc = "На пороге Окончательной смерти ваша кровь вырывается наружу и воссоздаёт вас заново."

	level = 8
	vitae_cost = 8

	violates_masquerade = TRUE

//BLOODHEAL 9
/datum/discipline_power/bloodheal/nine
	name = "Непревзойдённое исцеление кровью"
	desc = "Даже будь вы исполинским чудовищем, тело восстановилось бы в два счёта."

	level = 9
	vitae_cost = 9

	violates_masquerade = TRUE

//BLOODHEAL 10
/datum/discipline_power/bloodheal/ten
	name = "Высшее исцеление кровью"
	desc = "Пока у вас есть кровь, умереть вы не можете. Проклятие не позволит."

	level = 10
	vitae_cost = 10

	violates_masquerade = TRUE

#undef HEAL_BASHING_LETHAL_DAMAGE
#undef HEAL_AGGRAVATED_DAMAGE
