/**
 * Players can revive simplemobs with this.
 *
 * In-game item that can be used to revive a simplemob once. This makes the mob friendly.
 * Becomes useless after use.
 * Becomes malfunctioning when EMP'd.
 * If a hostile mob is revived with a malfunctioning injector, it will be hostile to everyone except whoever revived it and gets robust searching enabled.
 */
/obj/item/lazarus_injector
	name = "lazarus injector"
	desc = "Инъектор с коктейлем из наномашин и химикатов. Похоже, он способен поднимать животных из мёртвых и делать их дружелюбными к тому, кто сделал укол. Увы, на высшие формы жизни он не действует, да и стоит безумных денег, так что инъекторы пылились на складе, пока кто-то из руководства не решил, что это отличная мотивация для сотрудников."
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "lazarus_hypo"
	inhand_icon_state = "hypo"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	///Can this still be used?
	var/loaded = TRUE
	///Injector malf?
	var/malfunctioning = FALSE
	///So you can't revive boss monsters or robots with it
	var/revive_type = SENTIENCE_ORGANIC

	///make it so taming is optional // DARKPACK EDIT ADD START - MEDICAL
	var/should_tame = TRUE	// DARKPACK EDIT ADD END - MEDICAL

/obj/item/lazarus_injector/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!loaded)
		return NONE
	if(SEND_SIGNAL(target, COMSIG_ATOM_ON_LAZARUS_INJECTOR, src, user) & LAZARUS_INJECTOR_USED)
		return ITEM_INTERACT_SUCCESS
	if(!isliving(target))
		return NONE

	var/mob/living/target_animal = target
	if(!target_animal.compare_sentience_type(revive_type)) // Will also return false if not a basic or simple mob, which are the only two we want anyway
		balloon_alert(user, "на это существо не подействует!")
		return ITEM_INTERACT_BLOCKING
	if(target_animal.stat != DEAD)
		balloon_alert(user, "оно ещё живо!")
		return ITEM_INTERACT_BLOCKING
	if(should_tame) // DARKPACK EDIT ADD START - MEDICAL
		target_animal.lazarus_revive(user, malfunctioning)
	else
		target_animal.revive(HEAL_ALL) // DARKPACK EDIT ADD END - MEDICAL
	expend(target_animal, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/lazarus_injector/proc/expend(atom/revived_target, mob/user)
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] вкалывает [revived_target.declent_ru(DATIVE)] [declent_ru(ACCUSATIVE)] и возвращает к жизни."))
	SSblackbox.record_feedback("tally", "lazarus_injector", 1, revived_target.type)
	loaded = FALSE
	playsound(src,'sound/effects/refill.ogg',50,TRUE)
	icon_state = "lazarus_empty"

/obj/item/lazarus_injector/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!malfunctioning)
		malfunctioning = TRUE

/obj/item/lazarus_injector/examine(mob/user)
	. = ..()
	if(!loaded)
		. += span_info("Инъектор пуст.")
	if(malfunctioning)
		. += span_info("Дисплей инъектора странно мерцает.")
