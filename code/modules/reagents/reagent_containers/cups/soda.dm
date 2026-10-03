
//////////////////////////soda_cans//
//These are in their own group to be used as IED's in /obj/item/grenade/ghettobomb.dm
/// How much fizziness is added to the can of soda by throwing it, in percentage points
#define SODA_FIZZINESS_THROWN 15
/// How much fizziness is added to the can of soda by shaking it, in percentage points
#define SODA_FIZZINESS_SHAKE 5
/// At what atmospheric pressure do we burst a soda can? Empirical evidance (one googled experiment video) states that ~67.458 kPa is where a can bursts.
#define SODA_EXPLOSION_PRESSURE 67.458

/obj/item/reagent_containers/cup/soda_cans
	name = "soda can"
	icon = 'icons/obj/drinks/soda.dmi'
	icon_state = "cola"
	icon_state_preview = "cola"
	abstract_type = /obj/item/reagent_containers/cup/soda_cans
	initial_reagent_flags = NONE
	custom_price = 1 // DARKPACK EDIT CHANGE - ECONOMY
	obj_flags = CAN_BE_HIT
	possible_transfer_amounts = list(5, 10, 15, 25, 30)
	volume = 30
	throwforce = 12 // set to 0 upon being opened. Have you ever been domed by a soda can? Those things fucking hurt
	/// If the can hasn't been opened yet, this is the measure of how fizzed up it is from being shaken or thrown around. When opened, this is rolled as a percentage chance to burst
	var/fizziness = 0
	/// Have we been sealed with tape? And if so, what color is it?
	var/tape_color = null
	/// Color of our fuse, if any
	var/fuse_color = null
	/// Timer for our explosion
	var/fuse_timer = null

/obj/item/reagent_containers/cup/soda_cans/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/slapcrafting, string_list(list(/datum/crafting_recipe/improv_explosive)))
	AddElement(/datum/element/atmos_sensitive, mapload) //Enables soda cans to explode in vaccuum.

/obj/item/reagent_containers/cup/soda_cans/random/Initialize(mapload)
	..()
	var/T = pick(subtypesof(/obj/item/reagent_containers/cup/soda_cans) - /obj/item/reagent_containers/cup/soda_cans/random)
	new T(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/reagent_containers/cup/soda_cans/suicide_act(mob/living/user)
	if(!reagents.total_volume)
		user.visible_message(span_warning("[user] is trying to take a big sip from [src]... The can is empty!"))
		return SHAME
	if(!is_drainable())
		open_soda(user)
		sleep(1 SECONDS)
	user.visible_message(span_suicide("[user] takes a big sip from [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(user,'sound/items/drink.ogg', 80, TRUE)
	reagents.trans_to(user, src.reagents.total_volume, transferred_by = user) //a big sip
	sleep(0.5 SECONDS)
	user.say(pick(
		"Now, Outbomb Cuban Pete, THAT was a game.",
		"All these new fangled arcade games are too slow. I prefer the classics.",
		"They don't make 'em like Orion Trail anymore.",
		"You know what they say. Worst day of spess carp fishing is better than the best day at work.",
		"They don't make 'em like good old-fashioned singularity engines anymore.",
	))

	if(ishuman(user))
		var/mob/living/carbon/human/drinker = user
		if (drinker.age >= 30)
			drinker.Stun(50)
			sleep(5 SECONDS)
			playsound(drinker,'sound/items/drink.ogg', 80, TRUE)
			drinker.say(pick(
				"Another day, another dollar.",
				"I wonder if I should hold?",
				"Diversifying is for young'ns.",
				"Yeap, times were good back then.",
			))
			return MANUAL_SUICIDE_NONLETHAL

	sleep(2 SECONDS) //dramatic pause
	return TOXLOSS

/obj/item/reagent_containers/cup/soda_cans/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!iscarbon(target) || reagents.total_volume || !user.combat_mode || user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	if(target == user)
		user.visible_message(
			span_warning("[capitalize(user.declent_ru(NOMINATIVE))] сминает банку о собственный лоб!"),
			span_notice("Вы сминаете банку о собственный лоб."),
		)
	else
		user.visible_message(
			span_warning("[capitalize(user.declent_ru(NOMINATIVE))] сминает банку о лоб [target.declent_ru(GENITIVE)]!"),
			span_notice("Вы сминаете банку о лоб [target.declent_ru(GENITIVE)]."),
		)
	playsound(src, 'sound/items/weapons/pierce.ogg', rand(10, 50), TRUE)
	var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(target.drop_location())
	crushed_can.icon_state = icon_state
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/soda_cans/bullet_act(obj/projectile/proj)
	. = ..()
	if(QDELETED(src))
		return
	if(!proj.damage || proj.damage_type != BRUTE)
		return
	var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(loc)
	crushed_can.icon_state = icon_state
	var/atom/throw_target = get_edge_target_turf(crushed_can, pick(GLOB.alldirs))
	crushed_can.throw_at(throw_target, rand(1,2), 7)
	qdel(src)

/obj/item/reagent_containers/cup/soda_cans/proc/open_soda(mob/user)
	if(tape_color)
		to_chat(user, "Вы срываете ленту, которой заклеено отверстие банки.")
		playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)
		tape_color = null
		add_container_flags(OPENCONTAINER)
		update_appearance()
		return

	if(prob(fizziness))
		user.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] открывает банку, и оттуда бьёт шипящий фонтан!"), span_danger("Вы дёргаете за кольцо, и вас окатывает шипящим фонтаном! А-а-а!!"))
		burst_soda(user)
		return

	to_chat(user, "Вы дёргаете за кольцо, и банка открывается с приятным пшиком.") //Ahhhhhhhh
	add_container_flags(OPENCONTAINER)
	playsound(src, SFX_CAN_OPEN, 50, TRUE)
	throwforce = 0

/**
 * Burst the soda open on someone. Fun! Opens and empties the soda can, but does not crush it.
 *
 * Arguments:
 * * target - Who's getting covered in soda
 * * hide_message - Stops the generic fizzing message, so you can do your own
 */
/obj/item/reagent_containers/cup/soda_cans/proc/burst_soda(atom/target, hide_message = FALSE)
	if(!target)
		return

	if(ismob(target))
		var/mob/living/target_mob = target
		target_mob.add_mood_event("soda_spill", /datum/mood_event/soda_spill, src)
		for(var/mob/living/iter_mob in view(src, 7))
			if(iter_mob != target)
				iter_mob.add_mood_event("observed_soda_spill", /datum/mood_event/observed_soda_spill, target, src)

	playsound(src, 'sound/items/can/can_pop.ogg', 80, TRUE)
	if(!hide_message)
		visible_message(span_danger("[capitalize(declent_ru(NOMINATIVE))] с шипением заливает пеной [target.declent_ru(ACCUSATIVE)]!"))
	add_container_flags(OPENCONTAINER)
	reagents.expose(target, TOUCH)
	reagents.clear_reagents()
	throwforce = 0

/obj/item/reagent_containers/cup/soda_cans/wirecutter_act(mob/living/user, obj/item/tool)
	if (!fuse_color)
		return NONE
	to_chat(user, span_notice("You snip [src]'s fuse off."))
	tool.play_tool_sound(src, 50)
	add_fingerprint(user)
	fuse_color = null
	if (!isnull(fuse_timer))
		deltimer(fuse_timer)
		fuse_timer = null
		log_bomber(user, "has disarmed", src)
	if (heatable)
		AddElement(/datum/element/reagents_item_heatable)
	update_appearance()

/obj/item/reagent_containers/cup/soda_cans/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (istype(tool, /obj/item/stack/cable_coil))
		if (fuse_color)
			to_chat(user, span_warning("[src] already has a fuse attached to it!"))
			return ITEM_INTERACT_BLOCKING

		if (tape_color)
			to_chat(user, span_warning("[src]'s hole is covered up with tape!"))
			return ITEM_INTERACT_BLOCKING

		if (!is_drainable())
			to_chat(user, span_warning("Банка ещё не открыта!"))
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/cable_coil/coil = tool
		var/coil_color = GLOB.cable_colors[coil.cable_color]
		add_fingerprint(user)
		if (!coil.use(1))
			return ITEM_INTERACT_BLOCKING

		fuse_color = coil_color
		// Heating replaced with lighting the fuse
		RemoveElement(/datum/element/reagents_item_heatable)
		to_chat(user, span_notice("You attach a fuse to [src]."))
		log_bomber(user, "attached a fuse to", src)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if (istype(tool, /obj/item/stack/medical/wrap/sticky_tape))
		if (tape_color)
			to_chat(user, span_warning("Отверстие банки уже заклеено!"))
			return ITEM_INTERACT_BLOCKING

		if (!is_drainable())
			to_chat(user, span_warning("Банка ещё не открыта!"))
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/medical/wrap/sticky_tape/tape = tool
		var/list/tape_colors = SSgreyscale.ParseColorString(tape.greyscale_colors)
		add_fingerprint(user)
		if (!tape.use(1))
			return ITEM_INTERACT_BLOCKING

		tape_color = tape_colors[1]
		to_chat(user, span_notice("Вы заклеиваете отверстие банки лентой."))
		reset_container_flags()
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if (!fuse_color || tool.get_temperature() < FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ..()

	if (fuse_timer)
		to_chat(user, span_warning("[src] is already lit!"))
		return ITEM_INTERACT_BLOCKING

	add_fingerprint(user)
	log_bomber(user, "has primed a rigged", src)
	to_chat(user, span_warning("You light [src]'s fuse!"))
	fuse_timer = addtimer(CALLBACK(src, PROC_REF(try_detonate)), rand(2 SECONDS, 4 SECONDS))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/soda_cans/proc/try_detonate()
	var/spark_flags = SPARK_ACT_WEAKEN_COMMON
	if (tape_color)
		spark_flags |= SPARK_ACT_ENCLOSED

	playsound(src, 'sound/effects/sparks/sparks1.ogg', 50, TRUE)
	if (reagents.spark_act(0, spark_flags) & SPARK_ACT_DESTRUCTIVE)
		qdel(src)
		return

	// Was a dud
	fuse_color = null
	tape_color = null
	add_container_flags(OPENCONTAINER)
	if (heatable)
		AddElement(/datum/element/reagents_item_heatable)
	update_appearance()

/obj/item/reagent_containers/cup/soda_cans/update_overlays()
	. = ..()
	if (fuse_color)
		var/mutable_appearance/fuse_overlay = mutable_appearance('icons/obj/weapons/grenade.dmi', "improvised_grenade_fuse")
		fuse_overlay.color = fuse_color
		. += fuse_overlay

	if (tape_color)
		var/mutable_appearance/tape_overlay = mutable_appearance('icons/obj/weapons/grenade.dmi', "improvised_grenade_tape")
		tape_overlay.color = tape_color
		. += tape_overlay

	if (fuse_timer)
		. += mutable_appearance('icons/obj/weapons/grenade.dmi', "improvised_grenade_active")

/obj/item/reagent_containers/cup/soda_cans/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(. || is_open_container() || !reagents.total_volume || tape_color) // if it was caught, already opened, or has nothing in it
		return

	fizziness += SODA_FIZZINESS_THROWN
	if(!prob(fizziness))
		return

	burst_soda(hit_atom, hide_message = TRUE)
	visible_message(span_danger("[capitalize(declent_ru(NOMINATIVE))] лопается от удара о [hit_atom.declent_ru(ACCUSATIVE)], и содержимое разлетается во все стороны!"))
	var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(loc)
	crushed_can.icon_state = icon_state
	moveToNullspace()
	QDEL_IN(src, 1 SECONDS) // give it a second so it can still be logged for the throw impact

/obj/item/reagent_containers/cup/soda_cans/attack_self(mob/user)
	if(fuse_timer)
		balloon_alert(user, "the fuse is on fire!")
		return

	if(!is_drainable())
		open_soda(user)
		return

	return ..()

/obj/item/reagent_containers/cup/soda_cans/attack_self_secondary(mob/user)
	if(!is_drainable())
		playsound(src, 'sound/items/can/can_shake.ogg', 50, TRUE)
		user.visible_message(span_danger("[capitalize(user.declent_ru(NOMINATIVE))] трясёт [declent_ru(ACCUSATIVE)]!"), span_danger("Вы трясёте [declent_ru(ACCUSATIVE)]!"), vision_distance=2)
		fizziness += SODA_FIZZINESS_SHAKE
		return
	return ..()

/obj/item/reagent_containers/cup/soda_cans/examine_more(mob/user)
	. = ..()
	if(!in_range(user, src))
		return
	if(fizziness > 30 && prob(fizziness * 2))
		. += span_notice("<i>Вы присматриваетесь к [declent_ru(DATIVE)] и замечаете следующее...</i>")
		. += "\t[span_warning("От банки веет угрозой: внутри всё так и бурлит...")]"

/obj/item/reagent_containers/cup/soda_cans/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return ((air.return_pressure() <= SODA_EXPLOSION_PRESSURE) && !(reagents.flags & OPENCONTAINER))

/obj/item/reagent_containers/cup/soda_cans/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	if(reagents.total_volume && !(reagents.flags & OPENCONTAINER))
		burst_soda(loc)

#undef SODA_FIZZINESS_THROWN
#undef SODA_FIZZINESS_SHAKE
#undef SODA_EXPLOSION_PRESSURE

/obj/item/reagent_containers/cup/soda_cans/cola
	name = "Cola" // DARKPACK EDIT CHANGE
	desc = "Освежающая кола с кофеином." // DARKPACK EDIT CHANGE
	icon_state = "cola"
	list_reagents = list(/datum/reagent/consumable/space_cola = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/tonic
	name = "T-Bone's tonic water" // DARKPACK EDIT CHANGE
	desc = "Хинин на вкус так себе, зато малярия вам точно не грозит." // DARKPACK EDIT CHANGE
	icon_state = "tonic"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/tonic = 50)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/soda_cans/sodawater
	name = "soda water"
	desc = "A can of soda water. Why not make a scotch and soda?"
	icon_state = "sodawater"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/sodawater = 50)

/obj/item/reagent_containers/cup/soda_cans/lemon_lime
	name = "orange soda"
	desc = "You wanted ORANGE. It gave you Lemon Lime."
	icon_state = "lemon-lime"
	list_reagents = list(/datum/reagent/consumable/lemon_lime = 30)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/soda_cans/lemon_lime/Initialize(mapload)
	. = ..()
	name = "lemon-lime soda"

/obj/item/reagent_containers/cup/soda_cans/sol_dry
	name = "Sals Dry" // DARKPACK EDIT CHANGE
	desc = "Maybe this will help your tummy feel better. Maybe not."
	icon_state = "sol_dry"
	list_reagents = list(/datum/reagent/consumable/sol_dry = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/space_up
	name = "Six-Up!" // DARKPACK EDIT CHANGE
	desc = "Вдвое хуже и совсем без кофеина!" // DARKPACK EDIT CHANGE
	icon_state = "space-up"
	list_reagents = list(/datum/reagent/consumable/space_up = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/starkist
	name = "Star-kist"
	desc = "The taste of a star in liquid form. And, a bit of tuna...?"
	icon_state = "starkist"
	list_reagents = list(/datum/reagent/consumable/space_cola = 15, /datum/reagent/consumable/orangejuice = 15)
	drink_type = SUGAR | FRUIT | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind
	name = "Mountain Wind" // DARKPACK EDIT CHANGE
	desc = "Продувает насквозь, как ветер на горном склоне." // DARKPACK EDIT CHANGE
	icon_state = "space_mountain_wind"
	list_reagents = list(/datum/reagent/consumable/spacemountainwind = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/thirteenloko
	name = "Thirteen Loko"
	desc = "Управление по санитарному надзору предупреждает: употребление \"13 Локо\" может привести к судорогам, слепоте, опьянению и даже смерти. Пейте ответственно." // DARKPACK EDIT CHANGE
	icon_state = "thirteen_loko"
	list_reagents = list(/datum/reagent/consumable/ethanol/thirteenloko = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/dr_gibb
	name = "Dr. Gibb"
	desc = "A delicious mixture of 42 different flavors."
	icon_state = "dr_gibb"
	list_reagents = list(/datum/reagent/consumable/dr_gibb = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/pwr_game
	name = "Pwr Game"
	desc = "Единственный напиток с той самой PWR, которой жаждут настоящие геймеры. Когда геймер говорит про геймерское топливо, он имеет в виду буквально это."
	icon_state = "purple_can"
	list_reagents = list(/datum/reagent/consumable/pwr_game = 30)

/obj/item/reagent_containers/cup/soda_cans/shamblers
	name = "Shambler's juice"
	desc = "~Shake me up some of that Shambler's Juice!~"
	icon_state = "shamblers"
	list_reagents = list(/datum/reagent/consumable/shamblers = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/shamblers/eldritch
	name = "Shambler's juice Eldritch Energy!"
	desc = "~J'I'CE!~"
	icon_state = "shamblerseldritch"
	volume = 40
	list_reagents = list(/datum/reagent/consumable/shamblers = 30, /datum/reagent/eldritch = 5)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/wellcheers
	name = "Wellcheers Juice"
	desc = "A strange purple drink, smelling of saltwater. Somewhere in the distance, you hear seagulls."
	icon_state = "wellcheers"
	list_reagents = list(/datum/reagent/consumable/wellcheers = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/grey_bull
	name = "Red Bat" // DARKPACK EDIT CHANGE
	desc = "\"Ред Бэт\" окрыля-я-яет!" // DARKPACK EDIT CHANGE
	icon_state = "energy_drink"
	list_reagents = list(/datum/reagent/consumable/grey_bull = 20)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/monkey_energy
	name = "Monkey Energy"
	desc = "Unleash the ape!"
	icon_state = "monkey_energy"
	inhand_icon_state = "monkey_energy"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/monkey_energy = 50)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/volt_energy
	name = "24-Volt Energy"
	desc = "Recharge, with 24-Volt Energy!"
	icon_state = "volt_energy"
	list_reagents = list(/datum/reagent/consumable/volt_energy = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/melon_soda
	name = "Kansumi Melon Soda"
	desc = "Japan's favourite melon soda, now available in can form!"
	icon_state = "melon_soda"
	list_reagents = list(/datum/reagent/consumable/melon_soda = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/air
	name = "canned air"
	desc = "There is no air shortage. Do not drink."
	icon_state = "air"
	list_reagents = list(/datum/reagent/nitrogen = 24, /datum/reagent/oxygen = 6)

/obj/item/reagent_containers/cup/soda_cans/beer
	name = "beer" // DARKPACK EDIT CHANGE
	desc = "Баночное пиво." // DARKPACK EDIT CHANGE
	icon_state = "space_beer"
	volume = 40
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 40)
	drink_type = GRAIN

/obj/item/reagent_containers/cup/soda_cans/beer/rice
	name = "rice beer"
	desc = "Светлый рисовый лагер. По баварскому закону о чистоте пива 1516 года считается преступлением на почве ненависти к баварцам." // DARKPACK EDIT CHANGE
	icon_state = "ebisu"
	list_reagents = list(/datum/reagent/consumable/ethanol/rice_beer = 40)

/obj/item/reagent_containers/cup/soda_cans/beer/rice/Initialize(mapload)
	. = ..()
	var/brand = pick("Ebisu Super Dry", "Shimauma Ichiban", "Moonlabor Malt's")
	name = "[brand]"
	switch(brand)
		if("Ebisu Super Dry")
			icon_state = "ebisu"
			desc = "Самая любимая в Америке марка рисового пива вот уже двести лет подряд." // DARKPACK EDIT CHANGE
		if("Shimauma Ichiban")
			icon_state = "shimauma"
			desc = "Самая средненькая в Америке марка рисового пива. До популярности \"Эбису\" не дотягивает, но на втором месте ей вполне уютно." // DARKPACK EDIT CHANGE
		if("Moonlabor Malt's")
			icon_state = "moonlabor"
			desc = "Вечный аутсайдер среди американских марок рисового пива. Почему-то его очень любят якудза." // DARKPACK EDIT CHANGE
