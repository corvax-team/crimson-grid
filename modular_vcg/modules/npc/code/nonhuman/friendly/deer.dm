/mob/living/basic/deer
	name = "deer"
	desc = "Кроткое и мирное лесное животное."
	icon = 'modular_vcg/modules/npc/icons/32x32small.dmi'
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	bloodpool = 3 //nerfs deer blood from being beyond 5 to 3 like in the tabletop
	maxbloodpool = 3

/mob/living/basic/deer/Initialize(mapload)
	. = ..()
	if(gender == MALE)
		ru_names_rename(ru_names_toml("buck", override_base = initial(name)))
		name = "buck"
		if(prob(90))
			antlers = TRUE
	else
		ru_names_rename(ru_names_toml("doe", override_base = initial(name)))
		name = "doe"

	update_appearance(UPDATE_OVERLAYS)

/mob/living/basic/deer/update_overlays()
	. = ..()

	if(antlers)
		. += "antlers[(stat == DEAD) ? "_dead" : ""]_overlay"

	if(in_headlights && (stat != DEAD))
		. += "headlights_overlay"
