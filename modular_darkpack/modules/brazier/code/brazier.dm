/obj/structure/brazier
	name = "brazier"
	desc = "Металлическая чаша для огня на каменной кладке. Работает на газе; вокруг вентиля выбит странный знак."
	icon = 'modular_darkpack/modules/brazier/icons/brazier.dmi'
	icon_state = "brazier"
	layer = OBJ_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	light_range = 0
	light_power = 0
	light_color = "null"
	var/lit = FALSE

/obj/structure/brazier/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(lit)
		turn_off(user)
	else
		turn_on(user)

/obj/structure/brazier/proc/turn_on(mob/user)
	if(lit)
		return

	lit = TRUE
	icon_state = "brazier_lit"
	light_range = 5
	light_power = 3
	light_color = "#ffa35c"
	playsound(src, 'modular_darkpack/modules/brazier/sounds/pilotlight.ogg', 75, TRUE)
	set_light(light_range, light_power, light_color)

	if(user)
		to_chat(user, span_notice("Вы поворачиваете вентиль и зажигаете [declent_ru(ACCUSATIVE)]."))
		user.visible_message(span_notice("[user] поворачивает вентиль и зажигает [declent_ru(ACCUSATIVE)]."), null, null, 3)

/obj/structure/brazier/proc/turn_off(mob/user)
	if(!lit)
		return

	lit = FALSE
	icon_state = "brazier"
	set_light(0)

	if(user)
		to_chat(user, span_notice("Вы закручиваете вентиль, и [declent_ru(NOMINATIVE)] гаснет."))
		user.visible_message(span_notice("[user] гасит [declent_ru(ACCUSATIVE)]."), null, null, 3)
