/obj/item/occult_artifact/werewolf/klaive
	name = "klaive"
	desc = "Ритуальное оружие, выкованное гару из серебра. Клинок отливает синевой: таков способ ковки."
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapon_onfloors.dmi')
	icon_state = "klaive"
	force = 2 LETHAL_TTRPG_DAMAGE
	// icon_angle = -45
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	armor_type = /datum/armor/item_claymore
	resistance_flags = FIRE_PROOF
	custom_materials = list(/datum/material/silver = (2 * SHEET_MATERIAL_AMOUNT))
	rank = 4
	spirit_type = SPIRIT_VENGEANCE
	var/stirred_spirit = FALSE
	var/silver_damage = 2
	var/awakened_force = 3 LETHAL_TTRPG_DAMAGE
	var/awakened_bonus_silver_damage = 1

/obj/item/occult_artifact/werewolf/klaive/Initialize(mapload)
	. = ..()
	spirit_name = generate_spirit_name(spirit_type)

/obj/item/occult_artifact/werewolf/klaive/identify()
	. = ..()
	say("Я - [spirit_name]... Обрати меня против своих врагов...")

/obj/item/occult_artifact/werewolf/klaive/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	fera_silver_damage(target, silver_damage, 1) // Copyed the other silver weapon. Not super accurate.

/obj/item/occult_artifact/werewolf/klaive/attack_self(mob/user, modifiers)
	if(!identified)
		return ..()

	var/datum/splat/werewolf/werewolf_splat = get_werewolf_splat(user)
	if(owner)
		if(stirred_spirit)
			to_chat(user, span_warning("Дух [declent_ru(GENITIVE)] уже пробуждён!"))
			return
		if(werewolf_splat)
			awaken(user, werewolf_splat)
	else
		to_chat(user, span_notice("[capitalize(declent_ru(NOMINATIVE))] - всего лишь мёртвый кусок серебра."))

/obj/item/occult_artifact/werewolf/klaive/proc/awaken(mob/living/carbon/human/user, datum/splat/werewolf/werewolf_splat)
	if(werewolf_splat.adjust_gnosis(-1))
		to_chat(user, span_notice("Вы взываете к духу [declent_ru(GENITIVE)] и чувствуете, как он откликается на зов."))
		stirred_spirit = TRUE
		force = awakened_force
		silver_damage += awakened_bonus_silver_damage
		addtimer(CALLBACK(src, PROC_REF(slumber), user), 1 TURNS)
	else
		to_chat(user, span_notice("Вы взываете к духу [declent_ru(GENITIVE)], но в ответ лишь молчание и безразличие."))

/obj/item/occult_artifact/werewolf/klaive/proc/slumber(mob/user)
	stirred_spirit = FALSE
	force = initial(force)
	silver_damage = initial(silver_damage)
	to_chat(user, span_notice("Дух [declent_ru(GENITIVE)] вновь погружается в сон."))


/obj/item/occult_artifact/werewolf/klaive/karambit
	name = "curved klaive"
	desc = "Ритуальное оружие, выкованное гару из серебра. У этого клайва костяная рукоять и изогнутый клинок."
	icon_state = "klaive_karambit"

/obj/item/occult_artifact/werewolf/klaive/bane
	name = "bane klaive"
	desc = "Ритуальное оружие, выкованное гару из серебра. Этот клайв на вид проржавел, но всё ещё очень остёр"
	icon_state = "klaive_bane"

/obj/item/occult_artifact/werewolf/klaive/grand
	name = "grand klaive"
	desc = "Ритуальное оружие, выкованное гару из серебра. Этот клайв просто ОГРОМЕН!"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/48x32weapons.dmi'
	icon_state = "klaive_grand"
	force = 5 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 7
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = list(/datum/material/silver = (4 * SHEET_MATERIAL_AMOUNT))
	rank = 5
	silver_damage = 3
	awakened_force = 6 LETHAL_TTRPG_DAMAGE
