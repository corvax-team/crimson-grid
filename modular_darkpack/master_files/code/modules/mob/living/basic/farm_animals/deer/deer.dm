/mob/living/basic/deer
	name = "deer"
	desc = "Кроткое и мирное лесное животное."
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	icon = 'modular_darkpack/modules/npc/icons/deer.dmi'
	gender = PLURAL
	var/antlers = FALSE
	var/in_headlights = FALSE

/mob/living/basic/deer/Initialize(mapload)
	. = ..()
	if(gender == MALE)
		name = "buck"
		if(prob(90))
			antlers = TRUE
	else
		name = "doe"
	ru_names_rename(ru_names_toml(name))

	update_appearance(UPDATE_OVERLAYS)

/mob/living/basic/deer/ru_names_rename(list/new_list)
	if(length(new_list))
		new_list["base"] = initial(name)
	return ..()

/mob/living/basic/deer/update_overlays()
	. = ..()

	if(antlers)
		. += "antlers[(stat == DEAD) ? "_dead" : ""]_overlay"

	if(in_headlights && (stat != DEAD))
		. += "headlights_overlay"
