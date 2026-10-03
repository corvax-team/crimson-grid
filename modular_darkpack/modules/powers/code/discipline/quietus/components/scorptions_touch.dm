//SCORPION'S TOUCH
//The Scoprion's Touch venom from Quietus 2
//It is designed to lower the target's stamina by poison_potency for poison_duration
//If the kindred reaches Stamina 0, they instantly enter torpor
//The target rolls does a contested roll to lower the poison_duration. if it reaches zero, they resist the poison.
//It is qdeleted after one strike, pass or fail.
/obj/item/melee/touch_attack/quietus
	name = "\improper poison touch"
	desc = "Примерно как пошаркать ногами по ковру, чтобы ударить приятеля током, только куда опаснее."
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	hitsound = 'sound/effects/magic/disintegrate.ogg'
	icon_state = "quietus"
	inhand_icon_state = "mansus"

/obj/item/melee/touch_attack/quietus/Initialize(mapload, potency = 1, duration = 0)
	. = ..()
	AddComponent(/datum/component/scorpions_touch_poison, potency, duration)
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

//COMPONENT FOR WEAPON
/datum/component/scorpions_touch_poison
	var/poison_potency = 1
	var/poison_duration = 0

/datum/component/scorpions_touch_poison/Initialize(potency = 1, duration = 0)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	poison_potency = potency
	poison_duration = duration

/datum/component/scorpions_touch_poison/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(apply_poison))

/datum/component/scorpions_touch_poison/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_AFTERATTACK)


/datum/storyteller_roll/scorpions_touch_poison
	applicable_stats = list(STAT_STAMINA)
	numerical = TRUE


/datum/component/scorpions_touch_poison/proc/apply_poison(obj/item/source, atom/target, mob/user, list/modifiers, list/attack_modifiers)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/victim = astype(target)
	if(!victim)
		return

	// victim resists the posion with stamina + fortitude
	var/resistance = SSroll.storyteller_roll_datum(victim, roll_datum = /datum/storyteller_roll/scorpions_touch_poison, bonus = victim.get_discipline_dots(/datum/discipline/fortitude))

	// each resistance success subtracts from the duration
	var/effective_duration = max(0, poison_duration - resistance)

	if(effective_duration <= 0)
		to_chat(victim, span_notice("Яд на вас не подействовал!"))
		to_chat(user, span_warning("Яд не подействовал на [victim.declent_ru(ACCUSATIVE)]!"))
		qdel(src)
		return

	// stamina stat mod reduction goes here
	victim.st_add_stat_mod(STAT_STAMINA, -poison_potency, "quietus")
	addtimer(CALLBACK(src, PROC_REF(remove_poison), victim), poison_duration MINUTES)

	if(victim.st_get_stat(STAT_STAMINA) <= 0)
		if(get_kindred_splat(victim))
			victim.torpor(DAMAGE_TRAIT)
			to_chat(victim, span_userdanger("Яд вытягивает из вас саму жизненную силу, и тело отказывает! Вы впадаете в торпор!"))
			to_chat(user, span_boldwarning("[victim] впадает в торпор!"))
		else
			// apply non transmittable disease to the mortal victim if they reach zero stamina
			to_chat(victim, span_userdanger("Яд разрушает ваше тело - вам смертельно плохо!"))

	victim.adjust_fire_loss(2 * poison_potency)
	//victim.AdjustKnockdown(3 SECONDS) this is from the old code?

	to_chat(user, span_warning("Ваше ядовитое прикосновение обжигает [victim.declent_ru(ACCUSATIVE)]!"))
	to_chat(victim, span_userdanger("Жгучий яд высасывает из вас силы!"))
	var/obj/item/weapon = parent
	if(istype(weapon, /obj/item/melee/touch_attack/quietus))
		qdel(src)
		qdel(weapon)
	else
		qdel(src)

/datum/component/scorpions_touch_poison/proc/remove_poison(mob/living/carbon/human/victim)
	if(!victim || QDELETED(victim))
		return

	victim.st_remove_stat_mod(STAT_STAMINA, "quietus")
	to_chat(victim, span_notice("Действие яда сходит на нет."))
