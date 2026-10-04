/datum/action/item_action/adjust
	name = "Поправить предмет"

/datum/action/item_action/adjust/New(Target)
	..()
	var/obj/item/item_target = target
	name = "Поправить [item_target.declent_ru(ACCUSATIVE)]"

/datum/action/item_action/adjust/do_effect(trigger_flags)
	if(!isclothing(target))
		CRASH("adjust_visor action attempted to trigger on a non-clothing atom [target] ([target?.type]) owned by [owner] ([owner?.type]!")
	var/obj/item/clothing/as_clothing = target
	as_clothing.adjust_visor(owner)
	return TRUE

/datum/action/item_action/adjust_style
	name = "Сменить вид предмета"

/datum/action/item_action/adjust_style/New(Target)
	..()
	var/obj/item/item_target = target
	name = "Сменить вид [item_target.declent_ru(GENITIVE)]"

/datum/action/item_action/adjust_visor
	name = "Поправить визор"

/datum/action/item_action/adjust_visor/New(Target)
	..()
	var/obj/item/item_target = target
	name = "Поправить визор [item_target.declent_ru(GENITIVE)]"
