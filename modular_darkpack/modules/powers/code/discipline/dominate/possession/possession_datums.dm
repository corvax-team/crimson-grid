/datum/possession_controller
	var/datum/weakref/vampire_original
	var/datum/weakref/mortal_body
	var/datum/weakref/mortal_observer
	var/possession_active = FALSE

/datum/possession_controller/New(mob/living/carbon/human/vampire, mob/living/carbon/human/mortal)
	vampire_original = WEAKREF(vampire)
	mortal_body = WEAKREF(mortal)
	start_possession()

/datum/possession_controller/proc/start_possession()
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()

	var/mob/living/possession_observer/observer = new(mortal, src)
	mortal_observer = WEAKREF(observer)
	observer.ckey = mortal.ckey
	observer.name = mortal.real_name
	observer.real_name = mortal.real_name
	if(mortal.mind)
		observer.mind = mortal.mind

	mortal.ckey = vamp.ckey
	mortal.mind = vamp.mind

	var/datum/action/end_possession/end_action = new(src)
	end_action.Grant(mortal)

	vamp.toggle_resting()
	vamp.visible_message(span_warning("У [vamp.declent_ru(GENITIVE)] закатываются глаза, и тело обмякает в кататоническом ступоре!"))
	possession_active = TRUE
	RegisterSignal(mortal, COMSIG_LIVING_DEATH, PROC_REF(handle_death_during_possession))

/datum/possession_controller/proc/end_possession()
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()

	if(mortal.stat == DEAD)
		handle_death_during_possession()
		return

	to_chat(vamp, span_warning("Вы покидаете чужой разум ([mortal.real_name]) и возвращаетесь в собственное тело."))

	vamp.ckey = mortal.ckey
	if(mortal.mind)
		vamp.mind = mortal.mind

	var/mob/living/possession_observer/observer = mortal_observer?.resolve()
	if(observer?.ckey)
		mortal.ckey = observer.ckey
		if(observer.mind)
			mortal.mind = observer.mind
		to_chat(mortal, span_notice("Чужое присутствие отступает, и ваше сознание возвращается в собственное тело."))
	log_combat(vamp, mortal, "Has ended their Possession ")
	mortal.possessed = FALSE
	cleanup()
	UnregisterSignal(mortal, COMSIG_LIVING_DEATH)

/datum/possession_controller/proc/handle_death_during_possession()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()
	var/mob/living/possession_observer/observer = mortal_observer?.resolve()

	to_chat(vamp, span_boldwarning("Тело-носитель погибает, и вас с силой вышвыривает из чужого разума!"))
	vamp.ckey = mortal.ckey
	if(mortal.mind)
		vamp.mind = mortal.mind

	vamp.adjust_brute_loss(50)
	vamp.visible_message(span_danger("[capitalize(vamp.declent_ru(NOMINATIVE))] вдруг бьётся в жестоких судорогах и впадает в состояние, похожее на кому!"))
	to_chat(vamp, span_boldwarning("Психическое потрясение от гибели носителя повергает вас в торпор!"))
	vamp.torpor(DAMAGE_TRAIT)

	if(observer)
		to_chat(observer, span_boldwarning("Ваше тело погибло, пока вы были из него вытеснены. Вы растворяетесь в небытии..."))
		observer.ghostize()

	cleanup()

/datum/possession_controller/proc/cleanup()
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()
	var/mob/living/possession_observer/observer = mortal_observer?.resolve()
	possession_active = FALSE
	if(vamp)
		for(var/datum/action/end_possession/action in vamp.actions)
			action.controller = null
			action.Remove(action.owner)
			qdel(action)
	if(mortal)
		UnregisterSignal(mortal, COMSIG_LIVING_DEATH)
		for(var/datum/action/end_possession/action in mortal.actions)
			action.controller = null
			action.Remove(action.owner)
			qdel(action)
	if(observer)
		observer.controller = null
		qdel(observer)
	qdel(src)

/mob/living/possession_observer
	name = "displaced consciousness"
	real_name = "displaced consciousness"
	var/datum/weakref/possessed_body
	var/datum/weakref/controller

/mob/living/possession_observer/Initialize(mapload, datum/possession_controller/possessor)
	if(iscarbon(loc))
		possessed_body = WEAKREF(loc)
		controller = WEAKREF(possessor)
	return ..()

/mob/living/possession_observer/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_warning("Сверхъестественная сила вытеснила ваше сознание из тела. Вам остаётся только наблюдать, как вашей плотью распоряжается чужой разум."))
	to_chat(src, span_notice("Сделать вы ничего не можете, но по-прежнему видите и мыслите. Молитесь, чтобы захватчик поскорее отпустил вас..."))

/mob/living/possession_observer/say(message,bubble_type,list/spans = list(),sanitize = TRUE,datum/language/language,ignore_spam = FALSE,forced,filterproof = FALSE,message_range = 7,datum/saymode/saymode,list/message_mods = list())
	to_chat(src, span_warning("Пока вы вытеснены из тела, у вас нет голоса!"))
	return FALSE

/mob/living/possession_observer/emote(act, m_type = null, message = null, intentional = FALSE)
	to_chat(src, span_warning("Пока вы вытеснены из тела, вы ничем не можете себя выразить!"))
	return FALSE

/datum/action/end_possession
	name = "Прервать Вселение"
	desc = "Отпустить захваченное тело и вернуться в собственное."
	button_icon_state = "possession_end"
	check_flags = NONE
	var/datum/weakref/controller

/datum/action/end_possession/New(datum/possession_controller/possessor)
	controller = WEAKREF(possessor)
	..()

/datum/action/end_possession/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	var/datum/possession_controller/possessor = controller?.resolve()
	if(!possessor)
		Remove(owner)
		qdel(src)
		return FALSE
	possessor.end_possession()
