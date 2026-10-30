/mob/living/proc/torpor(source = DAMAGE_TRAIT, force)
	// CORVAX EDIT CHANGE - ORIGINAL: if(HAS_TRAIT(src, TRAIT_TORPOR))
	if(HAS_TRAIT_FROM(src, TRAIT_TORPOR, source))
		return

	// CORVAX EDIT ADD
	var/was_in_torpor = HAS_TRAIT(src, TRAIT_TORPOR)

	fakedeath(source)

	// CORVAX EDIT CHANGE START
	if(!was_in_torpor)
		to_chat(src, span_danger("Вы впали в торпор. Нажмите на значок в правом верхнем углу, чтобы узнать подробности или попытаться пробудиться."))
	// CORVAX EDIT CHANGE END
	throw_alert(ALERT_UNTORPOR, /atom/movable/screen/alert/untorpor)
	ADD_TRAIT(src, TRAIT_TORPOR, source)
	if(get_kindred_splat(src) && !force)
		var/mob/living/carbon/human/vampire = src
		var/datum/splat/vampire/kindred/vampirism = get_kindred_splat(vampire)
		var/morality_score = st_get_stat(STAT_MORALITY)
		var/torpor_time = (14 - morality_score) MINUTES
		COOLDOWN_START(vampirism, torpor_timer, torpor_time)
//	RegisterSignal(new_kindred, COMSIG_PATH_HIT, PROC_REF(adjust_morality))

/mob/living/proc/cure_torpor(source, force)
	if(!HAS_TRAIT_FROM(src, TRAIT_TORPOR, source))
		return

	// CORVAX EDIT ADD START
	var/will_wake = HAS_TRAIT_FROM_ONLY(src, TRAIT_TORPOR, source)
	// CORVAX EDIT ADD END

	// Heal to a tiny bit above crit, with less severe damage types being healed first
	var/amount_to_heal = HEALTH_THRESHOLD_CRIT + 5 - health
	if(will_wake && (amount_to_heal > 0) && !force) // CORVAX EDIT CHANGE - ORIGINAL: if((amount_to_heal > 0) && !force)
		heal_ordered_damage(amount_to_heal, list(STAMINA, OXY, BRUTE, TOX, BURN))

	cure_fakedeath(source)
	REMOVE_TRAIT(src, TRAIT_TORPOR, source)

	// CORVAX EDIT CHANGE START
	if(!will_wake)
		return

	clear_alert(ALERT_UNTORPOR)
	to_chat(src, span_notice("Вы пробудились от торпора."))
	// CORVAX EDIT CHANGE END

/mob/living/proc/untorpor()
	if(!HAS_TRAIT(src, TRAIT_TORPOR))
		return

	// CORVAX EDIT ADD START
	if(HAS_TRAIT(src, TRAIT_STAKED))
		to_chat(src, span_warning("Кол в сердце не даёт вам пробудиться. Пусть его вынут."))
		return
	// CORVAX EDIT ADD END

	if(get_kindred_splat(src))
		// CORVAX EDIT ADD
		if(!HAS_TRAIT_FROM(src, TRAIT_TORPOR, DAMAGE_TRAIT))
			return
		if(bloodpool > 0)
			adjust_blood_pool(-1)
			cure_torpor(DAMAGE_TRAIT) // CORVAX EDIT CHANGE
		else
			to_chat(src, span_warning("В вас не осталось крови, чтобы пробудиться..."))

/atom/movable/screen/alert/untorpor
	name = "Пробуждение"
	desc = "Стряхнуть с себя торпор."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "awaken"

/atom/movable/screen/alert/untorpor/Click()
	. = ..()
	if(!.)
		return

	if(!isliving(owner))
		return
	var/mob/living/living_owner = owner

	// CORVAX EDIT ADD START
	if(HAS_TRAIT(living_owner, TRAIT_STAKED))
		to_chat(living_owner, span_purple(span_italics("Вы в торпоре - мёртвом сне, в который вампиры впадают от ран, голода или истощения.")))
		to_chat(living_owner, span_danger(span_italics("Кол в вашем сердце не даёт вам пробудиться. Вы очнётесь, когда его вынут.")))
		return
	// CORVAX EDIT ADD END

	if(living_owner.stat == DEAD)
		to_chat(living_owner, span_warning("Вас настигла Окончательная смерть. Пробуждения не будет."))
		return

	if(get_kindred_splat(living_owner))
		var/mob/living/carbon/human/vampire = living_owner
		var/datum/splat/vampire/kindred/vampirism = get_kindred_splat(vampire)
		if(!COOLDOWN_STARTED(vampirism, torpor_timer))
			// CORVAX EDIT CHANGE
			to_chat(owner, span_purple(span_italics("Вы в торпоре - мёртвом сне, в который вампиры впадают от ран, голода или истощения.")))
			return
		if(COOLDOWN_FINISHED(vampirism, torpor_timer) && (vampire.bloodpool > 0))
			vampire.untorpor()
		else
			to_chat(owner, span_purple(span_italics("Вы в торпоре - мёртвом сне, в который вампиры впадают от ран, голода или истощения.")))
			if (vampire.bloodpool > 0)
				to_chat(owner, span_purple(span_italics("Пробудиться можно будет через <b>[DisplayTimeText(COOLDOWN_TIMELEFT(vampirism, torpor_timer))]</b>.")))
			else
				to_chat(owner, span_danger(span_italics("Пробудиться не выйдет: в вас не осталось ни капли крови.")))
