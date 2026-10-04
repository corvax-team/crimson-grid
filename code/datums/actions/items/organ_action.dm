/datum/action/item_action/organ_action
	name = "Organ Action"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/organ_action/IsAvailable(feedback = FALSE)
	var/obj/item/organ/attached_organ = target
	if(!attached_organ.owner)
		return FALSE
	return ..()

/datum/action/item_action/organ_action/toggle
	name = "Переключить орган"

/datum/action/item_action/organ_action/toggle/New(Target)
	..()
	var/obj/item/organ/organ_target = target
	name = "Переключить [organ_target.declent_ru(ACCUSATIVE)]"

/datum/action/item_action/organ_action/use
	name = "Использовать орган"

/datum/action/item_action/organ_action/use/New(Target)
	..()
	var/obj/item/organ/organ_target = target
	name = "Использовать [organ_target.declent_ru(ACCUSATIVE)]"

/datum/action/item_action/organ_action/go_feral
	name = "Go Feral"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "feral_mode_off"
	var/list/ability_name = list("Go Feral", "Bite the Hand that Feeds", "Unleash Id", "Activate Catbrain", "Gremlin Mode", "Nom Mode", "Dehumanize Yourself", "Misbehave")

/datum/action/item_action/organ_action/go_feral/New(Target)
	..()
	name = pick(ability_name)

/datum/action/item_action/organ_action/go_feral/do_effect(trigger_flags)
	var/obj/item/organ/tongue/cat/cat_tongue = target
	cat_tongue.toggle_feral()
	if(!cat_tongue.feral_mode)
		background_icon_state = "bg_default"
		button_icon_state = "feral_mode_off"
		to_chat(cat_tongue.owner, span_notice("Теперь без оружия вы бьёте как обычно."))
	else
		background_icon_state = "bg_default_on"
		button_icon_state = "feral_mode_on"
		to_chat(cat_tongue.owner, span_notice("Теперь без оружия вы будете кусаться."))
	build_all_button_icons()
	return TRUE
