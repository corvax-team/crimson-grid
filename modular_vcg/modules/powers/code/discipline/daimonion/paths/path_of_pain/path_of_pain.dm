/datum/discipline/path/pain
	name = "Путь Боли"
	desc = "Путь Тёмной Тауматургии, дающий власть над болью. Нарушает Маскарад."
	icon = 'modular_vcg/modules/paths/icons/paths.dmi'
	icon_state = "pain"
	power_type = /datum/discipline_power/daimonion/path/pain

/datum/discipline_power/daimonion/path/pain
	name = "Dark Thaumaturgy: Path of Pain Power Name"
	desc = "Dark Thaumaturgy: Path of Pain Power Description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = FALSE
	range = 7

	cooldown_length = 3 TURNS
	var/success_count

/datum/storyteller_roll/path_of_pain
	applicable_stats = list(STAT_PERMANENT_WILLPOWER)
	numerical = TRUE
	roll_output_type = ROLL_PRIVATE_AND_TARGET

/datum/discipline_power/daimonion/path/pain/activate(atom/target)
	. = ..()
	success_count = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/path_of_pain, difficulty = (level + 3))
	if(success_count < 0)
		owner.visible_message(span_notice("[owner] корчится от боли и раздирает себе кожу ногтями."), \
			span_notice("Вы корчитесь от боли и раздираете себе кожу ногтями."))
		pain_botch_effect()
		return TRUE
	else if(success_count == 0)
		to_chat(owner, span_notice("Ваша магия рассеивается впустую!"))
		return TRUE
	return FALSE

/datum/discipline_power/daimonion/path/pain/proc/pain_botch_effect()
	owner.apply_status_effect(/datum/status_effect/pain_botch)

/datum/discipline_power/daimonion/path/pain/numbing
	name = "Онемение"
	desc = "Слейтесь с болью воедино: раны больше не мешают вам действовать."

	level = 1
	aggravating = FALSE
	hostile = FALSE
	duration_length = 1 SCENES

/datum/discipline_power/daimonion/path/pain/numbing/activate(atom/target)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_PREVENT_HEALTH_UPDATES, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_AGEUSIA, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_IGNORESLOWDOWN, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_NOHARDCRIT, PATH_OF_PAIN_TRAIT)
	owner.visible_message(span_notice("[owner] вздрагивает от наслаждения!"), \
			span_notice("Вы вздрагиваете от наслаждения!"))

/datum/discipline_power/daimonion/path/pain/numbing/deactivate(atom/target)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PREVENT_HEALTH_UPDATES, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_AGEUSIA, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_IGNORESLOWDOWN, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NOSOFTCRIT, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NOHARDCRIT, PATH_OF_PAIN_TRAIT)

/datum/discipline_power/daimonion/path/pain/anguish
	name = "Мука"
	desc = "Причините боль другому - пусть корчится в муках."
	level = 2
	range = 1
	target_type = TARGET_MOB
	aggravating = FALSE
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/shattering,
		/datum/discipline_power/daimonion/path/pain/agony_within,
		/datum/discipline_power/daimonion/path/pain/hundred_deaths
	)

/datum/discipline_power/daimonion/path/pain/anguish/activate(mob/living/target)
	if(..())
		return
	var/stamina_loss = success_count TTRPG_DAMAGE
	target.apply_damage(stamina_loss, STAMINA)
	target.visible_message(span_notice("[target] хватается за грудь от боли!"), \
			span_notice("Вы хватаетесь за грудь: её жжёт болью!"))
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(stamina_loss, STAMINA)
		owner.visible_message(span_notice("[owner] хватается за грудь от боли!"), \
			span_notice("Вы хватаетесь за грудь: её жжёт болью!"))

/datum/discipline_power/daimonion/path/pain/shattering
	name = "Сокрушение"
	desc = "Нанесите другому тяжёлые раны - пусть познает настоящую боль."
	level = 3
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/anguish,
		/datum/discipline_power/daimonion/path/pain/agony_within,
		/datum/discipline_power/daimonion/path/pain/hundred_deaths
	)

/datum/discipline_power/daimonion/path/pain/shattering/activate(mob/living/target)
	if(..())
		return
	owner.apply_damage(1 TTRPG_DAMAGE, BRUTE)
	var/will_resist = SSroll.storyteller_roll_datum(target, target, /datum/storyteller_roll/path_of_pain, difficulty = 6)
	target.apply_damage(max(0, (success_count - will_resist)) TTRPG_DAMAGE, BRUTE)
	playsound(target, "sound/effects/wounds/crack1.ogg", 50)
	target.visible_message(span_warning("В теле [target.declent_ru(GENITIVE)] что-то жутко хрустит!"), \
			span_warning("В вашем теле что-то жутко хрустит!"))
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(success_count TTRPG_DAMAGE, BRUTE)
		playsound(owner, "sound/effects/wounds/crack2.ogg", 50)
		owner.visible_message(span_warning("В теле [owner.declent_ru(GENITIVE)] что-то жутко хрустит!"), \
			span_warning("В вашем теле что-то жутко хрустит!"))

/datum/discipline_power/daimonion/path/pain/agony_within
	name = "Внутренняя агония"
	desc = "Ценой собственных страданий причините другому страшную боль."
	level = 4
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/anguish,
		/datum/discipline_power/daimonion/path/pain/shattering,
		/datum/discipline_power/daimonion/path/pain/hundred_deaths
	)

/datum/discipline_power/daimonion/path/pain/agony_within/activate(mob/living/target)
	if(..())
		return
	var/list/damage_choices = list(0, 10, 20, 30, 40)
	var/self_mutilation_bonus = tgui_input_list(owner, "Сколько повреждений вы нанесёте себе? (Чем больше, тем сложнее проверка для цели)", "Внутренняя агония", damage_choices)
	if(!self_mutilation_bonus)
		self_mutilation_bonus = 0
	self_mutilation_bonus /= 10
	owner.apply_damage(self_mutilation_bonus TTRPG_DAMAGE, BRUTE)
	success_count += self_mutilation_bonus
	var/will_success_count = SSroll.storyteller_roll_datum(target, target, /datum/storyteller_roll/path_of_pain, difficulty = 6+self_mutilation_bonus)
	var/will_endure = floor(will_success_count / 2)
	target.apply_damage(max(0, (success_count - will_endure)) TTRPG_DAMAGE, BRUTE)
	playsound(target, 'sound/items/weapons/whip.ogg', 50)
	target.visible_message(span_warning("Нити кровавых шипов рвут плоть [target.declent_ru(GENITIVE)]!"), \
			span_warning("Нити кровавых шипов рвут вашу плоть!"))
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(success_count TTRPG_DAMAGE, BRUTE)
		playsound(owner, 'sound/items/weapons/whip.ogg', 50)
		owner.visible_message(span_warning("Нити кровавых шипов рвут плоть [owner.declent_ru(GENITIVE)]!"), \
			span_warning("Нити кровавых шипов рвут вашу плоть!"))
	// There should be fortitude soak too but it's not implemented on cg and I'm not coding it

/datum/discipline_power/daimonion/path/pain/hundred_deaths
	name = "Сотня смертей"
	desc = "Одним взглядом или словом сдирайте плоть с костей, дробите кости и рвите внутренности"
	level = 5
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/anguish,
		/datum/discipline_power/daimonion/path/pain/shattering,
		/datum/discipline_power/daimonion/path/pain/agony_within,
	)

/datum/discipline_power/daimonion/path/pain/hundred_deaths/activate(mob/living/target)
	var/will_success = SSroll.storyteller_roll_datum(owner, owner, /datum/storyteller_roll/path_of_pain, difficulty = 6)
	if(will_success <= 0)
		return
	owner.apply_damage(1 LETHAL_TTRPG_DAMAGE, AGGRAVATED)
	if(..())
		return
	target.apply_damage(success_count LETHAL_TTRPG_DAMAGE, AGGRAVATED)
	target.visible_message(span_warning("Всё тело [target.declent_ru(GENITIVE)] покрывается глубокими порезами!"), \
			span_warning("Всё ваше тело покрывается глубокими порезами. Боль невыносима!"))
	target.emote("scream")
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(success_count LETHAL_TTRPG_DAMAGE, AGGRAVATED)
		owner.visible_message(span_warning("Всё тело [owner.declent_ru(GENITIVE)] покрывается глубокими порезами!"), \
			span_warning("Всё ваше тело покрывается глубокими порезами. Боль невыносима!"))
		owner.emote("scream")
	// There should be fortitude soak too but it's not implemented on cg and I'm not coding it
