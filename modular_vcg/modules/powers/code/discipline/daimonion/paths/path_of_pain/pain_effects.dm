/datum/status_effect/pain_botch
	id = "pain_botch"
	duration = 1 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/pain_botch
	var/botches_total = 0

/atom/movable/screen/alert/status_effect/pain_botch
	name = "Провал на Пути Боли"
	desc = "Вы раздираете собственную кожу: вам хочется боли."
	icon_state = "blooddrunk"

/datum/status_effect/pain_botch/on_apply()
	. = ..()
	botches_total++
	if(botches_total >= 3)
		qdel(src)

/datum/status_effect/pain_botch/on_creation(mob/living/carbon/new_owner)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PAIN_BOTCH, PATH_OF_PAIN_TRAIT)

/datum/status_effect/pain_botch/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PAIN_BOTCH, PATH_OF_PAIN_TRAIT)

// HUNDRED DEATHS STATUS EFFECT
/datum/status_effect/hundred_deaths
	id = "hundred_deaths"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/hundred_deaths

/atom/movable/screen/alert/status_effect/hundred_deaths
	name = "Сотня смертей"
	desc = "Тяжесть сотни смертей давит на ваши тело и душу."
	icon_state = "blooddrunk"

/datum/status_effect/hundred_deaths/on_creation(mob/living/carbon/new_owner)
	. = ..()
	owner.maxHealth = owner.maxHealth - 50

/datum/status_effect/hundred_deaths/on_remove()
	. = ..()
	owner.maxHealth = owner.maxHealth + 50
