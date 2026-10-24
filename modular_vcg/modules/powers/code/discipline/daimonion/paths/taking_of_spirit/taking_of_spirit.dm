/datum/discipline/path/spirit
	name = "Лишение Духа"
	desc = "Путь Тёмной Тауматургии, дающий власть над чужой волей."
	icon = 'modular_vcg/modules/paths/icons/paths.dmi'
	icon_state = "spirit"
	power_type = /datum/discipline_power/daimonion/path/spirit
	//lazylists of weakrefs
	var/list/botched_targets
	var/list/drained_targets

/datum/discipline/path/spirit/post_gain()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))
	ADD_TRAIT(owner, TRAIT_TAKING_SPIRIT_KNOWLEDGE, TAKING_OF_SPIRIT_TRAIT)

/datum/discipline/path/spirit/proc/on_owner_death(mob/living/dead)
	SIGNAL_HANDLER

	if(LAZYLEN(drained_targets))
		for(var/datum/weakref/ref in drained_targets)
			var/mob/living/carbon/human/drained = ref.resolve()
			if(!drained)
				continue
			if(!CAN_THEY_SEE(drained, dead))
				continue
			var/willpower_amount = drained_targets[ref]
			drained.st_set_stat(STAT_TEMPORARY_WILLPOWER, drained.st_get_stat(STAT_TEMPORARY_WILLPOWER) + willpower_amount)
			to_chat(drained, span_notice("Похищенная Воля возвращается к вам, когда вы видите смерть [dead.declent_ru(GENITIVE)], его контроль над вами слабеет."))
	LAZYNULL(drained_targets)

/datum/discipline_power/daimonion/path/spirit
	name = "Тёмная Тауматургия: Лишение Духа"
	desc = "Высасывает Волю из жертвы."

	activate_sound = 'modular_darkpack/modules/powers/sounds/thaum.ogg'

	target_type = TARGET_PLAYER
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	aggravating = FALSE
	hostile = TRUE
	violates_masquerade = FALSE
	range = 1

	cooldown_length = 5 MINUTES
	var/success_count
	var/willpower_drain_amount

/datum/storyteller_roll/taking_of_spirit
	bumper_text = "высасывание воли"
	applicable_stats = list(STAT_PERMANENT_WILLPOWER)
	numerical = TRUE
	roll_output_type = ROLL_FLAG_ROLLER|ROLL_FLAG_TARGET

/datum/storyteller_roll/taking_of_spirit_resist
	bumper_text = "сопротивление высасыванию воли"
	applicable_stats = list(STAT_PERMANENT_WILLPOWER)
	numerical = TRUE
	roll_output_type = ROLL_FLAG_ROLLER|ROLL_FLAG_TARGET

/datum/discipline_power/daimonion/path/spirit/can_activate(mob/living/target, alert)
	. = ..()
	var/datum/discipline/path/spirit/parent_disc = discipline

	//someone has botched taking of spirit against this human
	if(LAZYLEN(parent_disc.botched_targets))
		for(var/datum/weakref/ref in parent_disc.botched_targets)
			var/mob/living/carbon/human/botched = ref.resolve()
			if(!botched)
				LAZYREMOVE(parent_disc.botched_targets, ref)
				continue
			if(botched == target)
				to_chat(owner, span_warning("Ваша предыдущая неудачная попытка сделала [target.declent_ru(ACCUSATIVE)] неуязвимым для вашего Лишения Духа."))
				return FALSE
	if(target.st_get_stat(STAT_TEMPORARY_WILLPOWER) == 0)
		to_chat(owner, span_warning("У [target.declent_ru(GENITIVE)] не осталось Воли, которую можно забрать!"))
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/path/spirit/activate(mob/living/target)
	. = ..()
	var/datum/discipline/path/spirit/parent_disc = discipline

	success_count = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/taking_of_spirit, difficulty = (level + 3))
	if(success_count < 0)
		owner.visible_message(span_danger("[owner.declent_ru(NOMINATIVE)] смотрит в пустоту, изо всех сил пытаясь сосредоточиться."), \
			span_notice("Вы смотрите в пустоту, изо всех сил пытаясь сосредоточиться."))
		to_chat(owner, span_danger("Вы чувствуете, как вашу Волю высасывают!"))
		spirit_botch_effect()
		return
	else if(success_count == 0)
		to_chat(owner, span_notice("Ваша магия угасает!"))
		return
	if(HAS_TRAIT(target, TRAIT_TAKING_SPIRIT_KNOWLEDGE))
		var/resist_count = SSroll.storyteller_roll_datum(target, owner, /datum/storyteller_roll/taking_of_spirit_resist, difficulty = 7)
		if(resist_count > success_count)
			LAZYADD(parent_disc.botched_targets, WEAKREF(target))
			to_chat(owner, span_warning("Ваша попытка Лишения Духа провалилась! [target.declent_ru(NOMINATIVE)] теперь неуязвим для вашего Лишения Духа."))
			return
	owner.visible_message(span_danger("[owner.declent_ru(NOMINATIVE)] тянется к голове [target.declent_ru(GENITIVE)], читая демоническое заклинание."), \
		span_notice("Вы начинаете читать демоническое заклинание над разумом [target.declent_ru(GENITIVE)]..."))
	if(do_after(owner, 15 SECONDS, target = target, timed_action_flags = (IGNORE_HELD_ITEM)))
		owner.visible_message(span_danger("[owner.declent_ru(NOMINATIVE)] успешно проводит мерзкое песнопение над разумом [target.declent_ru(GENITIVE)]."), \
			span_notice("Вы успешно проводите мерзкое песнопение над разумом [target.declent_ru(GENITIVE)]."))
		to_chat(target, span_danger("Вы чувствуете, как вашу Волю высасывают!"))
		var/actual_drain = min(target.st_get_stat(STAT_TEMPORARY_WILLPOWER), willpower_drain_amount)
		target.st_set_stat(STAT_TEMPORARY_WILLPOWER, target.st_get_stat(STAT_TEMPORARY_WILLPOWER) - actual_drain)
		if(target.st_get_stat(STAT_TEMPORARY_WILLPOWER) == 0)
			to_chat(target, span_hypnophrase("Когда вы теряете последние капли Воли, ваши эмоции тускнеют, и единственное, что остаётся — подчиняться [owner.declent_ru(DATIVE)]."))
			to_chat(target, span_info("Теперь вы бездушный автомат, и служение [owner.declent_ru(DATIVE)] должно быть вашим главным приоритетом."))
			target.visible_message(span_danger("[target.declent_ru(NOMINATIVE)] смотрит в пустоту, во взгляде нет жизни."), \
				span_notice("Вы смотрите в пустоту, в вашем взгляде нет жизни."))
		ADD_TRAIT(target, TRAIT_TAKING_SPIRIT_KNOWLEDGE, TAKING_OF_SPIRIT_TRAIT)
		if(LAZYLEN(parent_disc.drained_targets))
			for(var/datum/weakref/ref in parent_disc.drained_targets)
				var/mob/living/carbon/human/drained = ref.resolve()
				if(!drained)
					LAZYREMOVE(parent_disc.drained_targets, ref)
					continue
				if(drained == target)
					parent_disc.drained_targets[ref] += actual_drain
					return
		LAZYADDASSOC(parent_disc.drained_targets, WEAKREF(target), actual_drain)
	else
		to_chat(owner, span_notice("Ваша концентрация нарушена! Худшая часть отдачи, впрочем, уже позади."))

/datum/discipline_power/daimonion/path/spirit/proc/spirit_botch_effect()
	owner.st_set_stat(STAT_TEMPORARY_WILLPOWER, owner.st_get_stat(STAT_TEMPORARY_WILLPOWER) - willpower_drain_amount)

/datum/discipline_power/daimonion/path/spirit/one
	name = "Тёмная Тауматургия: Лишение Духа I"
	desc = "Высасывает Волю из жертвы."

	level = 1
	willpower_drain_amount = 1

	grouped_powers = list(
		/datum/discipline_power/daimonion/path/spirit/two,
		/datum/discipline_power/daimonion/path/spirit/three,
		/datum/discipline_power/daimonion/path/spirit/four,
		/datum/discipline_power/daimonion/path/spirit/five,
	)

/datum/discipline_power/daimonion/path/spirit/two
	name = "Тёмная Тауматургия: Лишение Духа II"
	desc = "Высасывает Волю из жертвы."

	level = 2
	willpower_drain_amount = 2

	grouped_powers = list(
		/datum/discipline_power/daimonion/path/spirit/one,
		/datum/discipline_power/daimonion/path/spirit/three,
		/datum/discipline_power/daimonion/path/spirit/four,
		/datum/discipline_power/daimonion/path/spirit/five,
	)

/datum/discipline_power/daimonion/path/spirit/three
	name = "Тёмная Тауматургия: Лишение Духа III"
	desc = "Высасывает Волю из жертвы."

	level = 3
	willpower_drain_amount = 4

	grouped_powers = list(
		/datum/discipline_power/daimonion/path/spirit/one,
		/datum/discipline_power/daimonion/path/spirit/two,
		/datum/discipline_power/daimonion/path/spirit/four,
		/datum/discipline_power/daimonion/path/spirit/five,
	)

/datum/discipline_power/daimonion/path/spirit/four
	name = "Тёмная Тауматургия: Лишение Духа IV"
	desc = "Высасывает Волю из жертвы."

	level = 4
	willpower_drain_amount = 6

	grouped_powers = list(
		/datum/discipline_power/daimonion/path/spirit/one,
		/datum/discipline_power/daimonion/path/spirit/two,
		/datum/discipline_power/daimonion/path/spirit/three,
		/datum/discipline_power/daimonion/path/spirit/five,
	)

/datum/discipline_power/daimonion/path/spirit/five
	name = "Тёмная Тауматургия: Лишение Духа V"
	desc = "Высасывает Волю из жертвы."

	level = 5
	willpower_drain_amount = 8

	grouped_powers = list(
		/datum/discipline_power/daimonion/path/spirit/one,
		/datum/discipline_power/daimonion/path/spirit/two,
		/datum/discipline_power/daimonion/path/spirit/three,
		/datum/discipline_power/daimonion/path/spirit/four,
	)
