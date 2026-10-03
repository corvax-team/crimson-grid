/datum/status_effect/blood_bond
	id = "circulation"
	duration = INFINITY
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/blood_bond

/datum/status_effect/blood_bond/on_creation(mob/living/new_owner, mob/living/regnant)
	. = ..()
	if(.)
		linked_alert.desc = "Вы связаны узами крови. Ваш сюзерен - [regnant.real_name]!"

/atom/movable/screen/alert/status_effect/blood_bond
	name = "Узы крови"
	desc = "Вы связаны узами крови!"
	icon_state = "blood_bond"
	icon = 'modular_darkpack/modules/vitae/icons/blood_bond.dmi'
