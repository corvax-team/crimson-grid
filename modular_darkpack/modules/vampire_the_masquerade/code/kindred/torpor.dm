/mob/living/proc/torpor(source = DAMAGE_TRAIT, force)
	if(HAS_TRAIT(src, TRAIT_TORPOR))
		return

	fakedeath(source)

	to_chat(src, span_danger("Вы впали в торпор. Нажмите на значок в правом верхнем углу, чтобы узнать подробности или попытаться пробудиться."))
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

	// Heal to a tiny bit above crit, with less severe damage types being healed first
	var/amount_to_heal = HEALTH_THRESHOLD_CRIT + 5 - health
	if((amount_to_heal > 0) && !force)
		heal_ordered_damage(amount_to_heal, list(STAMINA, OXY, BRUTE, TOX, BURN))

	cure_fakedeath(source)
	clear_alert(ALERT_UNTORPOR)
	REMOVE_TRAIT(src, TRAIT_TORPOR, source)
	to_chat(src, span_notice("Вы пробудились от торпора."))

/mob/living/proc/untorpor()
	if(!HAS_TRAIT(src, TRAIT_TORPOR))
		return

	if(get_kindred_splat(src))
		if(bloodpool > 0)
			adjust_blood_pool(-1)
			cure_torpor(DAMAGE_TRAIT)
			to_chat(src, span_notice("Вы пробудились от торпора."))
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

	if(living_owner.stat == DEAD)
		to_chat(living_owner, span_warning("Вас настигла Окончательная смерть. Пробуждения не будет."))
		return

	if(get_kindred_splat(living_owner))
		var/mob/living/carbon/human/vampire = living_owner
		var/datum/splat/vampire/kindred/vampirism = get_kindred_splat(vampire)
		if(!COOLDOWN_STARTED(vampirism, torpor_timer))
			to_chat(owner, span_purple(span_italics("Вы в торпоре - мёртвом сне, в который вампиры впадают от ран, голода или истощения.")))
			to_chat(owner, span_danger(span_italics("Вы очнётесь, когда кто-нибудь вынет кол из вашего сердца.")))
			return
		if(COOLDOWN_FINISHED(vampirism, torpor_timer) && (vampire.bloodpool > 0))
			vampire.untorpor()
		else
			to_chat(owner, span_purple(span_italics("Вы в торпоре - мёртвом сне, в который вампиры впадают от ран, голода или истощения.")))
			if (vampire.bloodpool > 0)
				to_chat(owner, span_purple(span_italics("Пробудиться можно будет через <b>[DisplayTimeText(COOLDOWN_TIMELEFT(vampirism, torpor_timer))]</b>.")))
			else
				to_chat(owner, span_danger(span_italics("Пробудиться не выйдет: в вас не осталось ни капли крови.")))
