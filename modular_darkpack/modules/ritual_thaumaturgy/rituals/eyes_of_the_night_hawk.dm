// V20 core rulebook pg. 233
/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk
	name = "eyes of the night hawk"
	ru_name = "Глаза ночного ястреба"
	desc = "Если в ритуальном круге находится ворон или иная хищная птица, заклинатель может перенести свой разум в её тело. Закончив смотреть глазами птицы, он должен выколоть ей глаза и убить её, иначе ослепнет сам."
	icon_state = "rune7"
	word = ""
	level = 2

/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk/complete()
	. = ..()
	var/mob/living/basic/corvid/target = locate(/mob/living/basic/corvid) in get_turf(src) // expand beyond corvid when more bird types are added
	if(!target)
		to_chat(last_activator, span_warning("В ритуальном круге нет птицы."))
		return

	var/datum/action/return_to_body/return_to_body_action = new(last_activator)
	return_to_body_action.Grant(target)
	return_to_body_action.possessor_ckey = last_activator.ckey
	return_to_body_action.possessor_original_mob = last_activator
	return_to_body_action.possessed_bird = target
	target.PossessByPlayer(last_activator.ckey)

/datum/action/return_to_body
	name = "Вернуться в своё тело"
	desc = "Разорвите мысленную связь с вороном и вернитесь в собственное тело."
	button_icon = 'modular_darkpack/modules/powers/icons/actions.dmi'
	button_icon_state = "thaumaturgy"
	var/mob/living/possessor_original_mob
	var/possessor_ckey
	var/mob/living/possessed_bird

/datum/action/return_to_body/Trigger(mob/clicker, trigger_flags)
	. = ..()
	possessor_original_mob.PossessByPlayer(possessor_ckey)
	Remove(owner)
	to_chat(possessor_original_mob, span_cult("Ваше зрение понемногу мутнеет и меркнет..."))
	addtimer(CALLBACK(src, PROC_REF(check_bird_dead)), 1 SCENES, TIMER_STOPPABLE)

/datum/action/return_to_body/proc/check_bird_dead()
	if(!possessed_bird || QDELETED(possessed_bird) || possessed_bird.stat == DEAD)
		return // bird is dead, all good
	possessor_original_mob.become_blind(MAGIC_TRAIT)
	to_chat(possessor_original_mob, span_warning("Часть вашего разума осталась в вороне. Вы ослепли до следующего рассвета. Пожалуй, стоило изучить ритуал повнимательнее..."))
