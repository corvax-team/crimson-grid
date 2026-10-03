/datum/status_effect/dread_gaze //Used for extended effect of dreadgaze
	id = "dread_gaze"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/dread_gaze

/datum/status_effect/dread_gaze/on_creation(mob/living/new_owner, generation, time)
	. = ..()
	if(time)
		duration = time
	owner.st_add_stat_mod(STAT_DEXTERITY, -4)	//Nukes your dex temporarily

/atom/movable/screen/alert/status_effect/dread_gaze
	name = "Всепоглощающий ужас"
	desc = "Этот человек... нет, эта ТВАРЬ - чудовище! У меня нет ни единого шанса!"
	icon_state = "hypnosis"
