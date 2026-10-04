/obj/item/organ/wings/functional/gargoyle
	name = "gargoyle wings"
	desc = "Каменные крылья горгульи. С виду как у статуи, но на ощупь они почти что... живые..."
	restyle_flags = EXTERNAL_RESTYLE_FLESH
	bodypart_overlay = /datum/bodypart_overlay/mutant/wings/functional/gargoyle
	sprite_accessory_override = /datum/sprite_accessory/wings/gargoyle
	var/datum/action/innate/toggle_gargoyle_wings/toggle

/datum/bodypart_overlay/mutant/wings/functional/gargoyle
	var/hidden = FALSE

//using parent's example with open or closed wings
/datum/bodypart_overlay/mutant/wings/functional/gargoyle/icon_render_key(obj/item/bodypart/limb)
	. = ..()
	. += hidden ? "hidden" : "visible"

/datum/bodypart_overlay/mutant/wings/functional/gargoyle/get_image(image_layer, obj/item/bodypart/limb)
	if(hidden)
		var/mutable_appearance/appearance = ..()
		appearance.alpha = 0
		return appearance
	// parent handles appearance we just need to offset
	var/mutable_appearance/appearance = ..()
	appearance.pixel_x = -16
	return appearance

/obj/item/organ/wings/functional/gargoyle/can_fly()
	var/datum/bodypart_overlay/mutant/wings/functional/gargoyle/overlay = bodypart_overlay
	if(overlay.hidden)
		to_chat(owner, span_warning("Ваши крылья сложены!"))
		return FALSE
	return ..()

/obj/item/organ/wings/functional/gargoyle/open_wings()
	. = ..()
	flap_sound_loop()

/obj/item/organ/wings/functional/gargoyle/proc/flap_sound_loop()
	if(!wings_open) // a little weird here but since garg wings can be tucked/untucked/flapping we're using parent type's wings_open and wings_closed for flapping and 'hidden' for tucked/untucked...
		return
	playsound(owner, 'modular_darkpack/modules/external_organs/sounds/wing_flap_flying.ogg', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(flap_sound_loop)), 2 SECONDS)

/obj/item/organ/wings/functional/gargoyle/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(!toggle)
		toggle = new
	toggle.Grant(organ_owner)

/obj/item/organ/wings/functional/gargoyle/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(wings_open)
		toggle_flight(organ_owner)
	toggle?.Remove(organ_owner)

/obj/item/organ/wings/functional/gargoyle/Destroy()
	QDEL_NULL(toggle)
	return ..()

/datum/action/innate/toggle_gargoyle_wings
	name = "Расправить или сложить крылья"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE|AB_CHECK_INCAPACITATED
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "wings"

/datum/action/innate/toggle_gargoyle_wings/Activate()
	var/mob/living/carbon/human/human = owner
	var/obj/item/organ/wings/functional/gargoyle/wings = human.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	if(!wings)
		return

	if(wings.wings_open) // if flying
		to_chat(human, span_warning("В полёте крылья не сложить!"))
		return

	var/datum/bodypart_overlay/mutant/wings/functional/gargoyle/overlay = wings.bodypart_overlay

	if(overlay.hidden) // if tucked
		to_chat(human, span_notice("Вы медленно расправляете крылья..."))
		if(!do_after(human, 4 SECONDS, human))
			return
		playsound(human, 'modular_darkpack/modules/external_organs/sounds/wing_close_open_wings.ogg', 50, TRUE)
		overlay.hidden = FALSE
		to_chat(human, span_notice("Крылья раскрываются во всю ширь!"))
	else // if untucked
		to_chat(human, span_notice("Вы медленно складываете крылья..."))
		if(!do_after(human, 4 SECONDS, human))
			return
		playsound(human, 'modular_darkpack/modules/external_organs/sounds/wing_close_open_wings.ogg', 50, TRUE)
		overlay.hidden = TRUE
		to_chat(human, span_notice("Крылья аккуратно прижимаются к спине."))

	human.update_body_parts()
