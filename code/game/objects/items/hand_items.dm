/// For all of the items that are really just the user's hand used in different ways, mostly (all, really) from emotes
/obj/item/hand_item
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "latexballoon"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/hand_item/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC)

/obj/item/hand_item/attack(mob/living/target_mob, mob/living/user)
	. = ..()
	SEND_SIGNAL(user, COMSIG_LIVING_HAND_ITEM_ATTACK, target_mob)

/obj/item/hand_item/circlegame
	name = "circled hand"
	desc = "Если кто-то посмотрит на это, пока вы держите руку ниже пояса, вы вправе дать ему щелбан."
	icon_state = "madeyoulook"
	attack_verb_continuous = list("bops")
	attack_verb_simple = list("bop")

/obj/item/hand_item/circlegame/Initialize(mapload)
	. = ..()
	var/mob/living/owner = loc
	if(!istype(owner))
		return
	RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(ownerExamined))

/obj/item/hand_item/circlegame/Destroy()
	var/mob/owner = loc
	if(istype(owner))
		UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)
	return ..()

/obj/item/hand_item/circlegame/dropped(mob/user)
	UnregisterSignal(user, COMSIG_ATOM_EXAMINE) //loc will have changed by the time this is called, so Destroy() can't catch it
	// this is a dropdel item.
	return ..()

/// Stage 1: The mistake is made
/obj/item/hand_item/circlegame/proc/ownerExamined(mob/living/owner, mob/living/sucker)
	SIGNAL_HANDLER

	if(!istype(sucker) || !in_range(owner, sucker))
		return
	addtimer(CALLBACK(src, PROC_REF(waitASecond), owner, sucker), 0.4 SECONDS)

/// Stage 2: Fear sets in
/obj/item/hand_item/circlegame/proc/waitASecond(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker) || QDELETED(src) || QDELETED(owner))
		return

	if(owner == sucker) // big mood
		to_chat(owner, span_danger("Минуточку... вы только что посмотрели на собственный \"кружок\"!"))
		addtimer(CALLBACK(src, PROC_REF(selfGottem), owner), 1 SECONDS)
	else
		to_chat(sucker, span_danger("Минуточку... это что, был..."))
		addtimer(CALLBACK(src, PROC_REF(GOTTEM), owner, sucker), 0.6 SECONDS)

/// Stage 3A: We face our own failures
/obj/item/hand_item/circlegame/proc/selfGottem(mob/living/owner)
	if(QDELETED(src) || QDELETED(owner))
		return

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	owner.visible_message(span_danger("[capitalize(owner.declent_ru(NOMINATIVE))] пристыженно отвешивает щелбан себе."), span_userdanger("Вы пристыженно отвешиваете щелбан самому себе."), \
		span_hear("Вы слышите глухой удар!"))
	log_combat(owner, owner, "bopped", src.name, "(self)")
	owner.do_attack_animation(owner)
	owner.apply_damage(100, STAMINA)
	owner.Knockdown(10)
	qdel(src)

/// Stage 3B: We face our reckoning (unless we moved away or they're incapacitated)
/obj/item/hand_item/circlegame/proc/GOTTEM(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker))
		return

	if(QDELETED(src) || QDELETED(owner))
		to_chat(sucker, span_warning("Да нет... показалось, наверное..."))
		return

	if(!in_range(owner, sucker) || !(owner.mobility_flags & MOBILITY_USE))
		to_chat(sucker, span_notice("Фух... вы успели отойти раньше, чем [owner.declent_ru(NOMINATIVE)] заметил[genderize_ru(owner.gender, "", "а", "о", "и")], что вы посмотрели..."))
		return

	to_chat(owner, span_warning("[capitalize(sucker.declent_ru(NOMINATIVE))] бросает взгляд на ваш \"кружок\" и пытается отвести глаза, но уже поздно!"))
	to_chat(sucker, span_danger("<b>Вы пытаетесь отвести взгляд, но [owner.declent_ru(NOMINATIVE)] уже видит страх в ваших глазах!</b>"))

	owner.face_atom(sucker)
	if(owner.client)
		owner.client.give_award(/datum/award/achievement/misc/gottem, owner) // then everybody clapped

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	owner.do_attack_animation(sucker)

	if(HAS_TRAIT(owner, TRAIT_HULK))
		owner.visible_message(span_danger("[capitalize(owner.declent_ru(NOMINATIVE))] отвешивает [sucker.declent_ru(DATIVE)] щелбан куда сильнее, чем собирал[genderize_ru(owner.gender, "ся", "ась", "ось", "ись")], и [sucker.declent_ru(NOMINATIVE)] отлетает в сторону!"), \
			span_danger("Вы отвешиваете [sucker.declent_ru(DATIVE)] щелбан куда сильнее, чем собирались, и [sucker.declent_ru(NOMINATIVE)] отлетает в сторону!"), span_hear("Вы слышите противный звук удара плоти о плоть!"), ignored_mobs=list(sucker))
		to_chat(sucker, span_userdanger("[capitalize(owner.declent_ru(NOMINATIVE))] отвешивает вам такой щелбан, что вы отлетаете в сторону!"))
		sucker.apply_damage(50, STAMINA)
		sucker.Knockdown(50)
		log_combat(owner, sucker, "bopped", src.name, "(setup- Hulk)")
		var/atom/throw_target = get_edge_target_turf(sucker, owner.dir)
		sucker.throw_at(throw_target, 6, 3, owner)
	else
		owner.visible_message(span_danger("[capitalize(owner.declent_ru(NOMINATIVE))] отвешивает [sucker.declent_ru(DATIVE)] щелбан!"), span_danger("Вы отвешиваете [sucker.declent_ru(DATIVE)] щелбан!"), \
			span_hear("Вы слышите глухой удар!"), ignored_mobs=list(sucker))
		sucker.apply_damage(15, STAMINA)
		log_combat(owner, sucker, "bopped", src.name, "(setup)")
		to_chat(sucker, span_userdanger("[capitalize(owner.declent_ru(NOMINATIVE))] отвешивает вам щелбан!"))
	qdel(src)


/obj/item/hand_item/noogie
	name = "noogie"
	desc = "Возьмите кого-нибудь в крепкий захват и примените это, чтобы испортить человеку день."
	inhand_icon_state = "nothing"

/obj/item/hand_item/noogie/attack(mob/living/carbon/target, mob/living/carbon/human/user)
	if(!istype(target))
		to_chat(user, span_warning("Вряд ли этому можно натереть макушку!"))
		return

	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("У вас рука не поднимается тереть макушку [target.declent_ru(DATIVE)]! Вдруг кому-то будет больно..."))
		return

	if(!(target?.get_bodypart(BODY_ZONE_HEAD)) || user.pulling != target || user.grab_state < GRAB_AGGRESSIVE || user.get_stamina_loss() > 80)
		return FALSE

	var/obj/item/bodypart/head/the_head = target.get_bodypart(BODY_ZONE_HEAD)
	if(!(the_head.biological_state & (BIO_FLESH|BIO_CHITIN)))
		to_chat(user, span_warning("У [target.declent_ru(GENITIVE)] на голове нет кожи, тереть нечего!"))
		return

	// [user] gives [target] a [prefix_desc] noogie[affix_desc]!
	var/brutal_noogie = FALSE // was it an extra hard noogie?
	var/prefix_desc = "грубо"
	var/affix_desc = ""
	var/affix_desc_target = ""

	if(HAS_TRAIT(target, TRAIT_ANTENNAE))
		prefix_desc = "яростно"
		affix_desc = ", не щадя чувствительных усиков"
		affix_desc_target = ", не щадя ваших чувствительных усиков"
		brutal_noogie = TRUE
	if(HAS_TRAIT(user, TRAIT_HULK))
		prefix_desc = "с чудовищной силой"
		brutal_noogie = TRUE

	var/message_others = "[prefix_desc] тереть костяшками макушку[affix_desc]"
	var/message_target = "[prefix_desc] тереть вам костяшками макушку[affix_desc_target]"

	user.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] зажимает [target.declent_ru(ACCUSATIVE)] и начинает [message_others]!"), span_warning("Вы зажимаете [target.declent_ru(ACCUSATIVE)] и начинаете [message_others]!"), vision_distance=COMBAT_MESSAGE_RANGE, ignored_mobs=target)
	to_chat(target, span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] зажимает вас и начинает [message_target]!"))

	if(!do_after(user, 1.5 SECONDS, target))
		to_chat(user, span_warning("Натереть макушку [target.declent_ru(DATIVE)] не вышло!"))
		to_chat(target, span_danger("[capitalize(user.declent_ru(NOMINATIVE))] пытается натереть вам макушку, но ничего не выходит!"))
		return

	if(brutal_noogie)
		target.add_mood_event("noogie_harsh", /datum/mood_event/noogie_harsh)
	else
		target.add_mood_event("noogie", /datum/mood_event/noogie)

	noogie_loop(user, target, 0)

/// The actual meat and bones of the noogie'ing
/obj/item/hand_item/noogie/proc/noogie_loop(mob/living/carbon/human/user, mob/living/carbon/target, iteration)
	if(!(target?.get_bodypart(BODY_ZONE_HEAD)) || user.pulling != target)
		return FALSE

	if(user.get_stamina_loss() > 80)
		to_chat(user, span_warning("Вы слишком устали, чтобы и дальше тереть макушку [target.declent_ru(DATIVE)]!"))
		to_chat(target, span_danger("[capitalize(user.declent_ru(NOMINATIVE))] выдыхается и оставляет вашу макушку в покое!"))
		return

	var/damage = rand(1, 5)
	if(HAS_TRAIT(target, TRAIT_ANTENNAE))
		damage += rand(3,7)
	if(HAS_TRAIT(user, TRAIT_HULK))
		damage += rand(3,7)

	if(damage >= 5)
		target.emote("scream")

	log_combat(user, target, "given a noogie to", addition = "([damage] brute before armor)")
	target.apply_damage(damage, BRUTE, BODY_ZONE_HEAD)
	user.adjust_stamina_loss(iteration + 5)
	playsound(get_turf(user), SFX_RUSTLE, 50)

	if(prob(33))
		user.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] продолжает тереть макушку [target.declent_ru(DATIVE)]!"), span_warning("Вы продолжаете тереть макушку [target.declent_ru(DATIVE)]!"), vision_distance=COMBAT_MESSAGE_RANGE, ignored_mobs=target)
		to_chat(target, span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] продолжает тереть вам макушку!"))

	if(!do_after(user, 1 SECONDS + (iteration * 2), target))
		to_chat(user, span_warning("Натереть макушку [target.declent_ru(DATIVE)] не вышло!"))
		to_chat(target, span_danger("[capitalize(user.declent_ru(NOMINATIVE))] пытается натереть вам макушку, но ничего не выходит!"))
		return

	iteration++
	noogie_loop(user, target, iteration)


/obj/item/hand_item/slapper
	name = "slapper"
	desc = "Вот так дерутся настоящие мужчины."
	inhand_icon_state = "nothing"
	attack_verb_continuous = list("slaps")
	attack_verb_simple = list("slap")
	hitsound = 'sound/effects/snap.ogg'
	/// How many smaller table smacks we can do before we're out
	var/table_smacks_left = 3

/obj/item/hand_item/slapper/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/high_fiver)

/obj/item/hand_item/slapper/attack(mob/living/slapped, mob/living/carbon/human/user)
	. = ..()
	SEND_SIGNAL(user, COMSIG_LIVING_SLAP_MOB, slapped)
	SEND_SIGNAL(slapped, COMSIG_LIVING_SLAPPED, user)

	if(iscarbon(slapped))
		var/mob/living/carbon/potential_tailed = slapped
		potential_tailed.unwag_tail()
	user.do_attack_animation(slapped)

	var/slap_volume = 50
	var/datum/status_effect/offering/kiss_check = slapped.has_status_effect(/datum/status_effect/offering)
	if(kiss_check && istype(kiss_check.offered_item, /obj/item/hand_item/kisser) && (user in kiss_check.possible_takers))
		user.visible_message(
			span_danger("[capitalize(user.declent_ru(NOMINATIVE))] презрительно фыркает в ответ на приставания, замахивается и пощёчиной сбивает [slapped.declent_ru(ACCUSATIVE)] с ног!"),
			span_notice("Какая наглость! Вы замахиваетесь и отвешиваете [slapped.declent_ru(DATIVE)] такую пощёчину, что с ног валит!"),
			span_hear("Вы слышите, как кому-то прилетает оглушительная оплеуха!"),
			ignored_mobs = slapped,
		)
		to_chat(slapped, span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] фыркает и отводит руку для замаха, а в следующий миг вы уже лежите на земле с диким звоном в ушах!"))
		slap_volume = 120
		SEND_SOUND(slapped, sound('sound/items/weapons/flash_ring.ogg'))
		shake_camera(slapped, 2, 2)
		slapped.Paralyze(2.5 SECONDS)
		slapped.adjust_confusion(7 SECONDS)
		slapped.adjust_stamina_loss(40)
	else if(user.zone_selected == BODY_ZONE_HEAD || user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(user == slapped)
			user.visible_message(
				span_notice("[user] facepalms!"),
				span_notice("Вы закрываете лицо ладонью."),
				span_hear("Вы слышите шлепок."),
			)

		else
			if(IS_UNCONSCIOUS(slapped))
				user.visible_message(
					span_notice("[capitalize(user.declent_ru(NOMINATIVE))] хлопает [slapped.declent_ru(ACCUSATIVE)] по щекам, пытаясь привести в чувство!"),
					span_notice("Вы хлопаете [slapped.declent_ru(ACCUSATIVE)] по щекам, пытаясь привести в чувство!"),
					span_hear("Вы слышите шлепок."),
				)

				// Worse than just help intenting people.
				slapped.AdjustSleeping(-7.5 SECONDS)
				slapped.AdjustUnconscious(-5 SECONDS)

			else
				user.visible_message(
					span_danger("[capitalize(user.declent_ru(NOMINATIVE))] даёт [slapped.declent_ru(DATIVE)] пощёчину!"),
					span_notice("Вы даёте [slapped.declent_ru(DATIVE)] пощёчину!"),
					span_hear("Вы слышите шлепок."),
				)
	else if(user.zone_selected == BODY_ZONE_L_ARM || user.zone_selected == BODY_ZONE_R_ARM)
		user.visible_message(
			span_danger("[capitalize(user.declent_ru(NOMINATIVE))] шлёпает [slapped.declent_ru(ACCUSATIVE)] по руке!"),
			span_notice("Вы шлёпаете [slapped.declent_ru(ACCUSATIVE)] по руке!"),
			span_hear("Вы слышите шлепок."),
		)
	else
		user.visible_message(
			span_danger("[capitalize(user.declent_ru(NOMINATIVE))] шлёпает [slapped.declent_ru(ACCUSATIVE)]!"),
			span_notice("Вы шлёпаете [slapped.declent_ru(ACCUSATIVE)]!"),
			span_hear("Вы слышите шлепок."),
		)
	playsound(slapped, 'sound/items/weapons/slap.ogg', slap_volume, TRUE, -1)
	return

/obj/item/hand_item/slapper/pre_attack_secondary(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!loc.Adjacent(target) || !istype(target, /obj/structure/table))
		return ..()

	slam_table(target, user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/hand_item/slapper/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!loc.Adjacent(target) || !istype(target, /obj/structure/table))
		return ..()

	slap_table(target, user)
	return TRUE

/// Slap the table, get some attention
/obj/item/hand_item/slapper/proc/slap_table(obj/structure/table/table, mob/living/user)
	user.do_attack_animation(table)
	playsound(get_turf(table), 'sound/effects/tableslam.ogg', 40, TRUE)
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] хлопает ладонью по [table.declent_ru(DATIVE)]."), span_notice("Вы хлопаете ладонью по [table.declent_ru(DATIVE)]."), vision_distance=COMBAT_MESSAGE_RANGE)

	table_smacks_left--
	if(table_smacks_left <= 0)
		qdel(src)

/// Slam the table, demand some attention
/obj/item/hand_item/slapper/proc/slam_table(obj/structure/table/table, mob/living/user)
	if(table_smacks_left < initial(table_smacks_left))
		return slap_table(table, user)
	user.do_attack_animation(table)

	transform = transform.Scale(5) // BIG slap
	if(HAS_TRAIT(user, TRAIT_HULK))
		transform = transform.Scale(2)
		color = COLOR_GREEN

	SEND_SIGNAL(user, COMSIG_LIVING_SLAM_TABLE, table)
	SEND_SIGNAL(table, COMSIG_TABLE_SLAMMED, user)

	playsound(get_turf(table), 'sound/effects/tableslam.ogg', 110, TRUE)
	user.visible_message("<b>[span_danger("[user] slams [user.p_their()] fist down on [table]!")]</b>", "<b>[span_danger("You slam your fist down on [table]!")]</b>")
	qdel(src)

// Successful takes will qdel our hand after
/obj/item/hand_item/slapper/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	. = ..()
	if(.)
		return

	qdel(src)


/obj/item/hand_item/hand
	name = "hand"
	desc = "Иногда просто хочется проявить галантность."
	inhand_icon_state = "nothing"

/obj/item/hand_item/hand/pre_attack(mob/living/carbon/help_target, mob/living/carbon/helper, list/modifiers, list/attack_modifiers)
	if(!loc.Adjacent(help_target) || !istype(helper) || !istype(help_target))
		return ..()

	if(helper.resting)
		to_chat(helper, span_warning("Лёжа галантность не проявишь!"))
		return TRUE


/obj/item/hand_item/hand/pre_attack_secondary(mob/living/carbon/help_target, mob/living/carbon/helper, list/modifiers, list/attack_modifiers)
	if(!loc.Adjacent(help_target) || !istype(helper) || !istype(help_target))
		return ..()

	if(helper.resting)
		to_chat(helper, span_warning("Лёжа галантность не проявишь!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	return SECONDARY_ATTACK_CALL_NORMAL


/obj/item/hand_item/hand/attack(mob/living/carbon/target_mob, mob/living/carbon/user, list/modifiers, list/attack_modifiers)
	if(!loc.Adjacent(target_mob) || !istype(user) || !istype(target_mob))
		return TRUE

	user.give(target_mob)
	return TRUE


/obj/item/hand_item/hand/on_offered(mob/living/carbon/offerer, mob/living/carbon/offered)
	. = TRUE

	if(!istype(offerer))
		return

	if(offerer.body_position == LYING_DOWN)
		to_chat(offerer, span_warning("Лёжа галантность не проявишь!"))
		return

	if(!offered)
		offered = locate(/mob/living/carbon) in orange(1, offerer)

	if(offered && istype(offered) && offered.body_position == LYING_DOWN)
		offerer.visible_message(span_notice("[capitalize(offerer.declent_ru(NOMINATIVE))] протягивает [offered.declent_ru(DATIVE)] руку, предлагая помочь подняться!"),
			span_notice("Вы протягиваете [offered.declent_ru(DATIVE)] руку, предлагая помочь подняться!"), null, 2)

		offerer.apply_status_effect(/datum/status_effect/offering/no_item_received/needs_resting, src, /atom/movable/screen/alert/give/hand/helping, offered)
		return

	offerer.visible_message(span_notice("[capitalize(offerer.declent_ru(NOMINATIVE))] протягивает руку."),
		span_notice("Вы протягиваете руку."), null, 2)

	offerer.apply_status_effect(/datum/status_effect/offering/no_item_received, src, /atom/movable/screen/alert/give/hand)
	return


/obj/item/hand_item/hand/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	. = ..()
	if(!offerer || !taker)
		return TRUE // this doesn't make sense unless both are carbons
	if(.)
		return

	if(taker.body_position == LYING_DOWN)
		taker.help_shake_act(offerer)

		if(taker.body_position == LYING_DOWN)
			return // That didn't help them. Awkwaaaaard.

		offerer.visible_message(span_notice("[capitalize(offerer.declent_ru(NOMINATIVE))] помогает [taker.declent_ru(DATIVE)] подняться!"), span_nicegreen("Вы помогаете [taker.declent_ru(DATIVE)] подняться!"), span_hear("Вы слышите, как кто-то кому-то помогает подняться!"), ignored_mobs = taker)
		to_chat(taker, span_nicegreen("Вы берётесь за протянутую руку, и [offerer.declent_ru(NOMINATIVE)] помогает вам подняться! Как мило!"))

		offerer.add_mob_memory(/datum/memory/helped_up, protagonist = offerer, deuteragonist = taker)
		taker.add_mob_memory(/datum/memory/helped_up, protagonist = offerer, deuteragonist = taker)

		offerer.add_mood_event("helping_up", /datum/mood_event/helped_up, taker, TRUE) // Different IDs because you could be helped up and then help someone else up.
		taker.add_mood_event("helped_up", /datum/mood_event/helped_up, offerer, FALSE)

		qdel(src)
		return

	if(taker.buckled?.buckle_prevents_pull)
		return // Can't start pulling them if they're buckled and that prevents pulls.

	// We do a little switcheroo to ensure that it displays the pulling message that mentions
	// taking taker by their hands.
	var/offerer_zone_selected = offerer.zone_selected
	offerer.zone_selected = "r_arm"
	var/did_we_pull = offerer.start_pulling(taker) // Will return either null or FALSE. We only want to silence FALSE.
	offerer.zone_selected = offerer_zone_selected

	if(did_we_pull == FALSE)
		return // That didn't work for one reason or the other. No need to display anything.

	to_chat(offerer, span_notice("[capitalize(taker.declent_ru(NOMINATIVE))] берёт вас за руку и позволяет вести за собой."))
	to_chat(taker, span_notice("Вы берёте [offerer.declent_ru(ACCUSATIVE)] за руку и позволяете вести себя. Какая учтивость!"))

	qdel(src)


/obj/item/hand_item/stealer
	name = "steal"
	desc = "Ваши шаловливые пальчики готовы к преступлениям."
	inhand_icon_state = "nothing"
	attack_verb_continuous = list("steals")
	attack_verb_simple = list("steal")

/obj/item/hand_item/stealer/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if (!ishuman(target_mob))
		return
	var/mob/living/carbon/human/target_human = target_mob
	if(target_human == user)
		to_chat(user, span_notice("Зачем вам красть собственную обувь?"))
		return
	if (!target_human.shoes)
		return
	if (user.body_position != LYING_DOWN)
		return
	var/obj/item/item_to_strip = target_human.shoes
	user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] пытается стащить [item_to_strip.declent_ru(ACCUSATIVE)] с [target_human.declent_ru(GENITIVE)]!"), \
		span_danger("Вы пытаетесь стащить [item_to_strip.declent_ru(ACCUSATIVE)] с [target_human.declent_ru(GENITIVE)]..."))
	to_chat(target_human, span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] пытается стащить с вас [item_to_strip.declent_ru(ACCUSATIVE)]!"))
	if (!do_after(user, item_to_strip.strip_delay, target_human))
		return
	if(!target_human.dropItemToGround(item_to_strip))
		return
	user.put_in_hands(item_to_strip)
	user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] стаскивает [item_to_strip.declent_ru(ACCUSATIVE)] с [target_human.declent_ru(GENITIVE)]!"), \
		span_notice("Вы стащили [item_to_strip.declent_ru(ACCUSATIVE)] с [target_human.declent_ru(GENITIVE)]!"))
	to_chat(target_human, span_userdanger("[capitalize(user.declent_ru(NOMINATIVE))] стаскивает с вас [item_to_strip.declent_ru(ACCUSATIVE)]!"))

/obj/item/hand_item/kisser
	name = "kiss"
	desc = "Пусть знают все и каждый: это надо скрепить поцелуем."
	icon = 'icons/mob/simple/animal.dmi'
	icon_state = "heart"
	inhand_icon_state = "nothing"
	/// The kind of projectile this version of the kiss blower fires
	var/kiss_type = /obj/projectile/kiss
	/// TRUE if the user was aiming anywhere but the mouth when they offer the kiss, if it's offered
	var/cheek_kiss

/obj/item/hand_item/kisser/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/hand_item/kisser/ranged_interact_with_atom(atom/target, mob/living/user, list/modifiers)
	var/obj/projectile/blown_kiss = new kiss_type(get_turf(user))
	user.visible_message("<b>[capitalize(user.declent_ru(NOMINATIVE))]</b> отправляет [blown_kiss.declent_ru(ACCUSATIVE)] [target.declent_ru(DATIVE)]!", span_notice("Вы отправляете [blown_kiss.declent_ru(ACCUSATIVE)] [target.declent_ru(DATIVE)]!"))

	//Shooting Code:
	blown_kiss.original = target
	blown_kiss.fired_from = user
	blown_kiss.firer = user // don't hit ourself that would be really annoying
	blown_kiss.impacted = list(WEAKREF(user) = TRUE) // just to make sure we don't hit the wearer
	blown_kiss.aim_projectile(target, user)
	blown_kiss.fire()
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/hand_item/kisser/on_offered(mob/living/carbon/offerer, mob/living/carbon/offered)
	if(!(locate(/mob/living/carbon) in orange(1, offerer)))
		return TRUE

	cheek_kiss = (offerer.zone_selected != BODY_ZONE_PRECISE_MOUTH)
	offerer.visible_message(span_notice("[capitalize(offerer.declent_ru(NOMINATIVE))] слегка подаётся вперёд, предлагая поцелуй[cheek_kiss ? " в щёку" : ""]!"),
		span_notice("Вы слегка подаётесь вперёд, предлагая поцелуй[cheek_kiss ? " в щёку" : ""]!"), null, 2)
	offerer.apply_status_effect(/datum/status_effect/offering/no_item_received, src)
	return TRUE

/obj/item/hand_item/kisser/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	. = ..()
	if(.)
		return

	var/obj/projectile/blown_kiss = new kiss_type(get_turf(offerer))
	offerer.visible_message("<b>[capitalize(offerer.declent_ru(NOMINATIVE))]</b> целует [taker.declent_ru(ACCUSATIVE)][cheek_kiss ? " в щёку" : ""]!", span_notice("Вы целуете [taker.declent_ru(ACCUSATIVE)][cheek_kiss ? " в щёку" : ""]!"), ignored_mobs = taker)
	to_chat(taker, span_nicegreen("[capitalize(offerer.declent_ru(NOMINATIVE))] целует вас[cheek_kiss ? " в щёку" : ""]!"))
	offerer.face_atom(taker)
	taker.face_atom(offerer)
	offerer.do_item_attack_animation(taker, used_item = src, animation_type = ATTACK_ANIMATION_BLUNT)
	//We're still firing a shot here because I don't want to deal with some weird edgecase where direct impacting them with the projectile causes it to freak out because there's no angle or something
	blown_kiss.original = taker
	blown_kiss.fired_from = offerer
	blown_kiss.firer = offerer // don't hit ourself that would be really annoying
	blown_kiss.impacted = list(WEAKREF(offerer) = TRUE) // just to make sure we don't hit the wearer
	blown_kiss.aim_projectile(taker, offerer)
	blown_kiss.suppressed = SUPPRESSED_VERY // this also means it's a direct offer
	blown_kiss.fire()
	qdel(src)
	return TRUE // so the core offering code knows to halt

/obj/item/hand_item/kisser/death
	name = "kiss of death"
	desc = "Если бы взглядом можно было убить, он выглядел бы так."
	color = COLOR_BLACK
	kiss_type = /obj/projectile/kiss/death

/obj/item/hand_item/kisser/syndie
	name = "syndie kiss"
	desc = "oooooo you like syndicate ur a syndiekisser"
	color = COLOR_SYNDIE_RED
	kiss_type = /obj/projectile/kiss/syndie

/obj/item/hand_item/kisser/ink
	name = "ink kiss"
	desc = "Is that a blot of ink in your pocket or are you just happy to see me?"
	color = COLOR_ALMOST_BLACK
	kiss_type = /obj/projectile/kiss/ink

/obj/item/hand_item/kisser/french
	name = "french kiss"
	desc = "Вам правда стоит почистить зубы."
	color = COLOR_GRAY
	kiss_type = /obj/projectile/kiss/french

/obj/item/hand_item/kisser/chef
	name = "chef's kiss"
	desc = "Секретный ингредиент: любовь. И опиум, но в основном любовь."
	color = COLOR_LIGHT_PINK
	kiss_type = /obj/projectile/kiss/chef

/obj/projectile/kiss
	name = "kiss"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state = "heart"
	hitsound = 'sound/effects/emotes/kiss.ogg'
	hitsound_wall = 'sound/effects/emotes/kiss.ogg'
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	speed = 0.66
	damage_type = BRUTE
	damage = 0 // love can't actually hurt you
	armour_penetration = 100 // but if it could, it would cut through even the thickest plate
	var/silent_blown = FALSE

/obj/projectile/kiss/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/parriable_projectile)

/obj/projectile/kiss/fire(angle, atom/direct_target)
	if(firer && !silent_blown)
		ru_names_rename(ru_names_toml(name, prefix = "воздушный ", suffix = " от [firer.declent_ru(GENITIVE)]", override_base = "[name] blown by [firer]"))
		name = "[name] blown by [firer]"

	return ..()

/obj/projectile/kiss/impact(atom/A)
	def_zone = BODY_ZONE_HEAD // let's keep it PG, people

	if(damage > 0 || !isliving(A)) // if we do damage or we hit a nonliving thing, we don't have to worry about a harmless hit because we can't wrongly do damage anyway
		return ..()

	harmless_on_hit(A)
	qdel(src)
	return FALSE

/**
 * To get around shielded modsuits & such being set off by kisses when they shouldn't, we take a page from hallucination projectiles
 * and simply fake our on hit effects. This lets kisses remain incorporeal without having to make some new trait for this one niche situation.
 * This fake hit only happens if we can deal damage and if we hit a living thing. Otherwise, we just do normal on hit effects.
 */
/obj/projectile/kiss/proc/harmless_on_hit(mob/living/living_target)
	playsound(get_turf(living_target), hitsound, 100, TRUE)
	if(!suppressed)  // direct
		living_target.visible_message(span_danger("[capitalize(declent_ru(NOMINATIVE))] попадает по [living_target.declent_ru(DATIVE)]."), span_userdanger("[capitalize(declent_ru(NOMINATIVE))] попадает по вам!"), vision_distance=COMBAT_MESSAGE_RANGE)

	living_target.add_mob_memory(/datum/memory/kissed, deuteragonist = firer)
	living_target.add_mood_event("kiss", /datum/mood_event/kiss, firer, suppressed)
	if(isliving(firer))
		var/mob/living/kisser = firer
		kisser.add_mob_memory(/datum/memory/kissed, protagonist = living_target, deuteragonist = firer)
	try_fluster(living_target)

/obj/projectile/kiss/proc/try_fluster(mob/living/living_target)
	// people with the social anxiety quirk can get flustered when hit by a kiss
	if(!HAS_TRAIT(living_target, TRAIT_ANXIOUS) || IS_UNCONSCIOUS_OR_CRIT(living_target) || living_target.is_blind())
		return
	if(HAS_TRAIT(living_target, TRAIT_FEARLESS) || prob(50)) // 50% chance for it to apply, also immune while on meds
		return

	var/other_msg
	var/self_msg
	var/roll = rand(1, 3)
	switch(roll)
		if(1)
			other_msg = "stumbles slightly, turning a bright red!"
			self_msg = "You lose control of your limbs for a moment as your blood rushes to your face, turning it bright red!"
			living_target.adjust_confusion(rand(5 SECONDS, 10 SECONDS))
		if(2)
			other_msg = "stammers softly for a moment before choking on something!"
			self_msg = "You feel your tongue disappear down your throat as you fight to remember how to make words!"
			addtimer(CALLBACK(living_target, TYPE_PROC_REF(/atom/movable, say), pick("Uhhh...", "O-oh, uhm...", "I- uhhhhh??", "You too!!", "What?")), rand(0.5 SECONDS, 1.5 SECONDS))
			living_target.adjust_stutter(rand(10 SECONDS, 30 SECONDS))
		if(3)
			other_msg = "locks up with a stunned look on [living_target.p_their()] face, staring at [firer ? firer : "the ceiling"]!"
			self_msg = "Your brain completely fails to process what just happened, leaving you rooted in place staring at [firer ? "[firer]" : "the ceiling"] for what feels like an eternity!"
			living_target.face_atom(firer)
			living_target.Stun(rand(3 SECONDS, 8 SECONDS))

	living_target.visible_message("<b>[living_target]</b> [other_msg]", span_userdanger("Whoa! [self_msg]"))

/obj/projectile/kiss/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.add_mood_event("kiss", /datum/mood_event/kiss, firer, suppressed)
		try_fluster(living_target)

/obj/projectile/kiss/death
	name = "kiss of death"
	damage = 35 // okay i kinda lied about love not being able to hurt you
	wound_bonus = 0
	sharpness = SHARP_POINTY
	color = COLOR_BLACK

/obj/projectile/kiss/death/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(!iscarbon(target))
		return
	var/mob/living/carbon/heartbreakee = target
	var/obj/item/organ/heart/dont_go_breakin_my_heart = heartbreakee.get_organ_slot(ORGAN_SLOT_HEART)
	dont_go_breakin_my_heart.apply_organ_damage(999)

/obj/projectile/kiss/ink
	name = "ink kiss"
	color = COLOR_ALMOST_BLACK
	damage = /obj/projectile/ink_spit::damage
	damage_type = /obj/projectile/ink_spit::damage_type
	armor_flag = /obj/projectile/ink_spit::armor_flag
	armour_penetration = /obj/projectile/ink_spit::armour_penetration
	impact_effect_type = /obj/projectile/ink_spit::impact_effect_type
	hitsound = /obj/projectile/ink_spit::hitsound
	hitsound_wall = /obj/projectile/ink_spit::hitsound_wall

/obj/projectile/kiss/ink/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/obj/projectile/ink_spit/ink_spit =  new (target)
	ink_spit.on_hit(target)
	if(!QDELETED(ink_spit)) // in case it somehow remains around
		qdel(ink_spit)

// Based on energy gun characteristics
/obj/projectile/kiss/syndie
	name = "syndie kiss"
	color = COLOR_SYNDIE_RED
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	damage_type = BURN
	armor_flag = LASER
	armour_penetration = 0
	damage = 25
	wound_bonus = -20
	exposed_wound_bonus = 40
	silent_blown = TRUE

/obj/projectile/kiss/french
	name = "french kiss (is that a hint of garlic?)"
	color = "#f2e9d2" //Scientifically proven to be the colour of garlic

/obj/projectile/kiss/french/harmless_on_hit(mob/living/living_target)
	. = ..()
	if(isnull(living_target.reagents))
		return
	//Don't stack the garlic
	if(!living_target.has_reagent(/datum/reagent/consumable/garlic))
		//Phwoar
		living_target.reagents.add_reagent(/datum/reagent/consumable/garlic, 1)
	living_target.visible_message("[capitalize(living_target.declent_ru(NOMINATIVE))] как-то странно морщится.", "Ого, ну и чесночное послевкусие!", vision_distance=COMBAT_MESSAGE_RANGE)

/obj/projectile/kiss/chef
	name = "chef's kiss"

// If our chef's kiss hits a food item, we will improve it with love.
/obj/projectile/kiss/chef/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(!IS_EDIBLE(target) || !target.reagents)
		return
	if(!firer || !target.Adjacent(firer) || !ismob(firer))
		return

	var/mob/kisser = firer

	// From here on, no message
	suppressed = SUPPRESSED_VERY
	if(!(kisser.mind && HAS_TRAIT_FROM(target, TRAIT_HANDMADE, REF(kisser.mind))))
		to_chat(firer, span_warning("Постойте, это блюдо готовили не вы. Как можно выдавать его за своё?"))
		return
	if(target.reagents.has_reagent(/datum/reagent/love))
		to_chat(firer, span_warning("Вы уже вложили в это блюдо всю душу."))
		return

	var/amount_nutriment = target.reagents.get_reagent_amount(/datum/reagent/consumable/nutriment, type_check = REAGENT_PARENT_TYPE)
	if(amount_nutriment <= 0)
		to_chat(firer, span_warning("Тут слишком мало питательного, чтобы считать это полноценным блюдом."))
		return

	to_chat(firer, span_green("Вы целуете кончики пальцев над блюдом: само совершенство."))
	target.visible_message(span_notice("[capitalize(firer.declent_ru(NOMINATIVE))] целует кончики пальцев над блюдом: само совершенство."), ignored_mobs = firer)
	target.reagents.add_reagent(/datum/reagent/love, clamp(amount_nutriment / 4, 1, 10)) // clamped to about half of the most dense food I think we have (super bite burger)
