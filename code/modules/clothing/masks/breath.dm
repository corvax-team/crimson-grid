/obj/item/clothing/mask/breath
	desc = "Плотно прилегающая маска, которую можно подключить к баллону с воздухом."
	name = "breath mask"
	icon_state = "breath"
	inhand_icon_state = "m_mask"
	body_parts_covered = 0
	clothing_flags = MASKINTERNALS
	visor_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/mask_breath
	actions_types = list(/datum/action/item_action/adjust)
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING
	/// Can this mask be adjusted?
	var/adjustable = TRUE

/datum/armor/mask_breath
	bio = 50

/obj/item/clothing/mask/breath/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is wrapping \the [src]'s tube around [user.p_their()] neck! Кажется, [user.ru_p_they()] пытается совершить самоубийство!"))
	return OXYLOSS

/obj/item/clothing/mask/breath/attack_self(mob/user)
	if(adjustable)
		adjust_visor(user)

/obj/item/clothing/mask/breath/click_alt(mob/user)
	if(!adjustable)
		return
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/breath/examine(mob/user)
	. = ..()
	if(adjustable)
		. += span_notice("Alt-клик, чтобы поправить.")

/obj/item/clothing/mask/breath/medical
	desc = "Плотно прилегающая стерильная маска, которую можно подключить к баллону с воздухом."
	name = "medical mask"
	icon_state = "medical"
	inhand_icon_state = "m_mask"
	armor_type = /datum/armor/breath_medical
	equip_delay_other = 1 SECONDS

/datum/armor/breath_medical
	bio = 90

/obj/item/clothing/mask/breath/muzzle
	name = "surgery mask"
	desc = "Чтобы надоедливый пациент замолчал ещё до наркоза."
	icon_state = "breathmuzzle"
	inhand_icon_state = "breathmuzzle"
	lefthand_file = 'icons/mob/inhands/clothing/masks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/masks_righthand.dmi'
	body_parts_covered = NONE
	flags_cover = NONE
	actions_types = null
	armor_type = /datum/armor/breath_muzzle
	equip_delay_other = 2.5 SECONDS // my sprite has 4 straps, a-la a head harness. takes a while to equip, longer than a muzzle
	adjustable = FALSE

/obj/item/clothing/mask/breath/muzzle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/muffles_speech)

/obj/item/clothing/mask/breath/muzzle/attack_paw(mob/user, list/modifiers)
	if(user.get_item_by_slot(ITEM_SLOT_MASK) == src)
		to_chat(user, span_warning("Без посторонней помощи это не снять!"))
		return
	return ..()

/obj/item/clothing/mask/breath/muzzle/examine_tags(mob/user)
	. = ..()
	.["surgical"] = "Does not block surgery on covered bodyparts."

/datum/armor/breath_muzzle
	bio = 100
