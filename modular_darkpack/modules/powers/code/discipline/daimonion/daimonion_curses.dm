/datum/movespeed_modifier/daimonion_curse
	multiplicative_slowdown = 0.4

/datum/status_effect/condemnation
	abstract_type = /datum/status_effect/condemnation
	id = null
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/daimonion_condemnation
	var/name = "Проклятие"
	var/genrequired = 13
	var/bloodcost = 1

/datum/status_effect/condemnation/lying_weakness
	id = "lying_weakness"
	name = "Язык без лжи"
	genrequired = 13
	bloodcost = 1

/datum/status_effect/condemnation/lying_weakness/on_apply()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.gain_trauma(/datum/brain_trauma/mild/mind_echo, TRAUMA_RESILIENCE_ABSOLUTE)
	to_chat(owner, span_userdanger(span_bold("Вы чувствуете, что на вас легло страшное проклятие!")))

/datum/status_effect/condemnation/physical_weakness
	id = "physical_weakness"
	name = "Младенческая сила"
	genrequired = 12
	bloodcost = 2

/datum/status_effect/condemnation/physical_weakness/on_apply()
	. = ..()
	owner.st_add_stat_mod(STAT_STRENGTH, -1, "physical_weakness")
	var/mob/living/carbon/human/vampire = owner
	for (var/datum/action/cooldown/blood_power/blood_power in vampire.actions)
		blood_power.Remove(vampire)
	to_chat(owner, span_userdanger(span_bold("Вы чувствуете, что на вас легло страшное проклятие!")))

/datum/status_effect/condemnation/mental_weakness
	id = "mental_weakness"
	name = "Жатва разума"
	genrequired = 11
	bloodcost = 3

/datum/status_effect/condemnation/mental_weakness/on_apply()
	. = ..()
	owner.st_add_stat_mod(STAT_CHARISMA, -1, "mental_weakness")
	owner.st_add_stat_mod(STAT_TEMPORARY_WILLPOWER, -1, "mental_weakness")
	to_chat(owner, span_userdanger(span_bold("Вы чувствуете, что на вас легло страшное проклятие!")))

/datum/status_effect/condemnation/offspring_weakness
	id = "offspring_weakness"
	name = "Бесплодная витэ"
	genrequired = 10
	bloodcost = 4

/datum/status_effect/condemnation/offspring_weakness/on_apply()
	. = ..()
	var/mob/living/carbon/human/vampire = owner
	for (var/datum/action/cooldown/mob_cooldown/give_vitae/give_vitae in vampire.actions)
		give_vitae.Remove(vampire)
	to_chat(owner, span_userdanger(span_bold("Вы чувствуете, что на вас легло страшное проклятие!")))

/datum/status_effect/condemnation/success_weakness
	id = "success_weakness"
	name = "Печать рока"
	genrequired = 10
	bloodcost = 5

/datum/status_effect/condemnation/success_weakness/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/daimonion_curse)
	to_chat(owner, span_userdanger(span_bold("Вы чувствуете, что на вас легло страшное проклятие!")))

/atom/movable/screen/alert/status_effect/daimonion_condemnation
	name = "Проклятие"
	desc = "Вас прокляли адской магией, и ваше тело ослаблено навсегда."
	icon_state = "crucible"
