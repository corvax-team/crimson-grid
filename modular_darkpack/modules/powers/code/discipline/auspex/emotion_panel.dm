///Shows a tgui window with memories
GAME_VERB_DESC(/mob, emotion_panel, "Эмоции персонажа", "Изменить эмоции вашего персонажа.", "IC")
	if(HAS_TRAIT(src, TRAIT_FORCED_EMOTION))
		to_chat(src, span_warning("Сейчас сменить эмоцию не получится."))
		return FALSE

	// This really shouldnt be using aura here. it needs to be detached and made unrelenient on aura/auspex. - Fallcon
	var/list/emotion_labels = aura_emotion_labels()
	var/new_emotion = emotion_labels[tgui_input_list(src, "Что вы сейчас чувствуете?", "Чувства", emotion_labels)]
	if(isnull(new_emotion))
		return FALSE
	set_emotion(new_emotion)

/mob/proc/set_emotion(new_emotion)
	if(current_emotion == new_emotion)
		return

	current_emotion = new_emotion
	SEND_SIGNAL(src, COMSIG_MOB_EMOTION_CHANGED, new_emotion)

/datum/status_effect/question_emotion
	id = "question_emotion"
	// Nothing says it needs to be a scene, I just like using our defines to create nice standards of time.
	duration = 1 SCENES

	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/question_emotion

/atom/movable/screen/alert/status_effect/question_emotion
	name = "Взгляд в себя"
	desc = "Что-то заставляет вас прислушаться к собственным чувствам."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "riddle"
	click_master = FALSE
	clickable_glow = TRUE

/atom/movable/screen/alert/status_effect/question_emotion/Click()
	. = ..()
	if(!.)
		return FALSE

	attached_effect.owner.emotion_panel()
	// Regardless if they acctually end up setting anything, clear the status effect
	qdel(attached_effect)

/datum/status_effect/forced_emotion
	id = "question_emotion"
	// Nothing says it needs to be a scene, I just like using our defines to create nice standards of time.
	duration = 1 SCENES

	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/forced_emotion

/atom/movable/screen/alert/status_effect/forced_emotion
	name = "Навязанное чувство"
	desc = "Что-то насильно навязывает вашему разуму определённое чувство."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "in_love"
