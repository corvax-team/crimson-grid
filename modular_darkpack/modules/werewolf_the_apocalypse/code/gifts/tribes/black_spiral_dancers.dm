/datum/storyteller_roll/gift/bane_protector
	bumper_text = "заключение договора"
	applicable_stats = list(STAT_MANIPULATION, STAT_LEADERSHIP)

/datum/action/cooldown/power/gift/bane_protector
	name = "Бейн-защитник"
	desc = "Танцор Чёрной Спирали связывает Бейна договором о взаимном союзе."
	button_icon_state = "bane_protector"

	click_to_activate = TRUE

	rank = 1
	rage_cost = 1

/datum/action/cooldown/power/gift/bane_protector/Activate(atom/target)
	var/mob/living/carbon/human/human_owner = astype(owner)
	var/mob/living/basic/basic_target = astype(target)
	if(!(human_owner?.can_tame_beastmaster_minion(basic_target, TRUE)))
		return FALSE

	. = ..()

	var/datum/storyteller_roll/gift/bane_protector/roll_datum = new()
	if(roll_datum.st_roll(owner, target) != ROLL_SUCCESS)
		return TRUE

	if(istype(basic_target, /mob/living/basic/bane))
		QDEL_NULL(basic_target.ai_controller)
		basic_target.ai_controller = new /datum/ai_controller/basic_controller/beastmaster_summon(basic_target)
		human_owner?.add_beastmaster_minion(target)
		return TRUE

	// Just summon a random shitter.
	human_owner.playsound_local(get_turf(human_owner), 'sound/effects/fire_puff.ogg')
	human_owner?.add_beastmaster_minion(/mob/living/basic/bane/religion/summoned)
	return TRUE


/mob/living/basic/bane/religion/summoned
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
