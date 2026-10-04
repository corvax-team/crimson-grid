/obj/effect/decal/cleanable/food
	icon = 'icons/effects/tomatodecal.dmi'
	gender = NEUTER
	beauty = -100

/obj/effect/decal/cleanable/food/tomato_smudge
	name = "tomato smudge"
	desc = "Красное."
	icon_state = "tomato_floor1"
	random_icon_states = list("tomato_floor1", "tomato_floor2", "tomato_floor3")

/obj/effect/decal/cleanable/food/tomato_smudge/can_bloodcrawl_in()
	return TRUE // why? why not.

/obj/effect/decal/cleanable/food/plant_smudge
	name = "plant smudge"
	desc = "Хлорофилл? Скорее уж скукофилл!"
	icon_state = "smashed_plant"

/obj/effect/decal/cleanable/food/egg_smudge
	name = "smashed egg"
	desc = "Из этого уже никто не вылупится."
	icon_state = "smashed_egg1"
	random_icon_states = list("smashed_egg1", "smashed_egg2", "smashed_egg3")

/obj/effect/decal/cleanable/food/pie_smudge //honk
	name = "smashed pie"
	desc = "Крем от кремового пирога."
	icon_state = "smashed_pie"

/obj/effect/decal/cleanable/food/salt
	name = "salt pile"
	desc = "Внушительная горка поваренной соли. Кто-то явно расстроен."
	icon_state = "salt_pile"
	var/safepasses = 3 //how many times can this salt pile be passed before dissipating
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered)
	)

/obj/effect/decal/cleanable/food/salt/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/decal/cleanable/food/salt/Destroy(force)
	// connect_loc only unregisters via COMSIG_MOVABLE_MOVED, which never fires when the turf we're on gets replaced by ChangeTurf()
	RemoveElement(/datum/element/connect_loc, loc_connections)
	return ..()

/obj/effect/decal/cleanable/food/salt/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(is_species(mover, /datum/species/snail))
		return FALSE

/obj/effect/decal/cleanable/food/salt/Bumped(atom/movable/AM)
	. = ..()
	if(is_species(AM, /datum/species/snail))
		to_chat(AM, span_danger("Путь вам преграждает [span_phobia("соль")]."))

/obj/effect/decal/cleanable/food/salt/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	if(!isliving(AM))
		return

	if(iscarbon(AM))
		var/mob/living/carbon/C = AM
		if(C.move_intent == MOVE_INTENT_WALK)
			return

	safepasses--
	if(safepasses <= 0 && !QDELETED(src))
		qdel(src)

/obj/effect/decal/cleanable/food/flour
	name = "flour"
	desc = "Ещё можно есть. Быстро поднятое не считается упавшим!"
	icon_state = "flour"

/obj/effect/decal/cleanable/food/squid_ink
	name = "ink smear"
	desc = "Пятно от чего-то чернильного..."
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	color = COLOR_DARK

/obj/effect/decal/cleanable/food/squid_ink/Initialize(mapload, list/datum/disease/diseases)
	icon_state = "floor[rand(1, 7)]"
	return ..()
