//Chain link fences
//Sprites ported from /VG/


#define CUT_TIME 100
#define CLIMB_TIME 150

#define NO_HOLE 0 //section is intact
#define MEDIUM_HOLE 1 //medium hole in the section - can climb through
#define LARGE_HOLE 2 //large hole in the section - can walk through
#define MAX_HOLE_SIZE LARGE_HOLE

/obj/structure/fence
	name = "fence"
	desc = "Забор из сетки-рабицы. Не стена, конечно, но посторонних обычно останавливает."
	density = TRUE
	anchored = TRUE

	icon = 'icons/obj/fence.dmi'
	icon_state = "straight"
	tacmap_color = TACMAP_FENCE

	var/cuttable = TRUE
	var/hole_size= NO_HOLE
	var/invulnerable = FALSE

/obj/structure/fence/Initialize(mapload)
	. = ..()

	update_cut_status()

/obj/structure/fence/examine(mob/user)
	. = ..()

	switch(hole_size)
		if(MEDIUM_HOLE)
			. += "В сетке зияет большая дыра."
		if(LARGE_HOLE)
			. += "Сетка прорезана насквозь."

/obj/structure/fence/end
	icon_state = "end"
	cuttable = FALSE

/obj/structure/fence/corner
	icon_state = "corner"
	cuttable = FALSE

/obj/structure/fence/post
	icon_state = "post"
	cuttable = FALSE

/obj/structure/fence/cut/medium
	icon_state = "straight_cut2"
	hole_size = MEDIUM_HOLE

/obj/structure/fence/cut/large
	icon_state = "straight_cut3"
	hole_size = LARGE_HOLE

/obj/structure/fence/wirecutter_act(mob/living/user, obj/item/tool)
	if(!cuttable)
		to_chat(user, span_warning("Эту секцию забора не разрезать!"))
		return ITEM_INTERACT_BLOCKING

	if(invulnerable)
		to_chat(user, span_warning("Этот забор слишком прочный, его не перекусить!"))
		return ITEM_INTERACT_BLOCKING

	var/current_stage = hole_size
	if(current_stage >= MAX_HOLE_SIZE)
		to_chat(user, span_warning("От этого забора и так почти ничего не осталось!"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_danger("[user] режет сетку забора."),\
						span_danger("Вы начинаете резать сетку забора."))

	if(!tool.use_tool(src, user, CUT_TIME))
		return ITEM_INTERACT_BLOCKING
	if(current_stage != hole_size)
		return ITEM_INTERACT_BLOCKING
	switch(++hole_size)
		if(MEDIUM_HOLE)
			visible_message(span_notice("[user] расширяет дыру в заборе."))
			to_chat(user, span_info("В такую дыру уже можно протиснуться. Но если расширить ещё, пролезать будет куда быстрее."))
			AddElement(/datum/element/climbable)
		if(LARGE_HOLE)
			visible_message(span_notice("[user] прорезает забор насквозь."))
			to_chat(user, span_info("Теперь через дыру в заборе можно спокойно пройти."))
			RemoveElement(/datum/element/climbable)
	update_cut_status()
	return ITEM_INTERACT_SUCCESS

/obj/structure/fence/proc/update_cut_status()
	if(!cuttable)
		return
	var/new_density = TRUE
	switch(hole_size)
		if(NO_HOLE)
			icon_state = initial(icon_state)
		if(MEDIUM_HOLE)
			icon_state = "straight_cut2"
		if(LARGE_HOLE)
			icon_state = "straight_cut3"
			new_density = FALSE
	set_density(new_density)

//FENCE DOORS

/obj/structure/fence/door
	name = "fence door"
	desc = "Без нормального замка толку от неё немного."
	icon_state = "door_closed"
	cuttable = FALSE

/obj/structure/fence/door/Initialize(mapload)
	. = ..()

	update_icon_state()

/obj/structure/fence/door/opened
	icon_state = "door_opened"
	density = FALSE

/obj/structure/fence/door/attack_hand(mob/user, list/modifiers)
	if(can_open(user))
		toggle(user)

	return TRUE

/obj/structure/fence/door/proc/toggle(mob/user)
	visible_message(span_notice("[user] [density ? "открывает" : "закрывает"] [declent_ru(ACCUSATIVE)]."))
	set_density(!density)
	update_icon_state()
	playsound(src, 'sound/machines/click.ogg', 100, TRUE)

/obj/structure/fence/door/update_icon_state()
	icon_state = density ? "door_closed" : "door_opened"
	return ..()

/obj/structure/fence/door/proc/can_open(mob/user)
	return TRUE

#undef CUT_TIME
#undef CLIMB_TIME

#undef NO_HOLE
#undef MEDIUM_HOLE
#undef LARGE_HOLE
#undef MAX_HOLE_SIZE
