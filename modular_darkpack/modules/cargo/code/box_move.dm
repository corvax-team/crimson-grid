/obj/item/cargo_box
	name = "cargo box"
	desc = "Особая доставка."
	icon_state = "box"
	icon = 'modular_darkpack/modules/cargo/icons/box.dmi'
	lefthand_file = 'modular_darkpack/modules/cargo/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/cargo/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE

/obj/structure/cargo_take
	name = "cargo"
	desc = "Отсюда забирают ящики."
	icon = 'modular_darkpack/modules/cargo/icons/box.dmi'
	icon_state = "box_take"
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	COOLDOWN_DECLARE(take_box)

/obj/structure/cargo_take/attack_hand(mob/living/user, list/modifiers)
	if(!COOLDOWN_FINISHED(src, take_box))
		return ..()
	COOLDOWN_START(src, take_box, 3 SECONDS)

	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
	to_chat(user, span_notice("Вы забираете ящик."))

	var/obj/item/cargo_box/new_box = new(get_turf(user))
	new_box.pixel_x += rand(-2, 2)
	new_box.pixel_y += rand(-2, 2)

/obj/structure/cargo_put
	name = "cargo"
	desc = "Сюда сдают ящики."
	icon = 'modular_darkpack/modules/cargo/icons/box.dmi'
	icon_state = "box_put"
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/cargo_put/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/cargo_box))
		qdel(tool)
		playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
		to_chat(user, span_notice("Вы сдаёте ящик."))
		new /obj/item/stack/dollar/five(get_turf(user))
		return ITEM_INTERACT_SUCCESS
	return NONE
