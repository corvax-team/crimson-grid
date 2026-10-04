/obj/item/toy/plush/argemia
	name = "strange plushie"
	desc = "Пустота..."
	icon_state = "argemia"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/toys/icons/toys_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/plush/argemia/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	. = ..()
	playsound(microwave_source.loc, 'modular_darkpack/modules/toys/sounds/aeaeae.ogg', 100, FALSE)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/toy/plush/argemia, microwave_explode), microwave_source), 5 SECONDS)

/obj/item/toy/plush/argemia/proc/microwave_explode(obj/machinery/microwave/microwave_source)
	explosion(microwave_source.loc, 0, 1, 2)

// Not made by us, but a readditon because TG removed it in https://github.com/tgstation/tgstation/pull/92311
/obj/item/toy/plush/goatplushie
	name = "strange goat plushie"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	icon_state = "goat"
	desc = "Он хоть и плюшевый, и с виду милашка, а отделает вас как настоящий. Козлы не меняются."
	squeak_override = list('sound/items/weapons/punch1.ogg' = 1)
	/// Whether or not this goat is currently taking in a monsterous doink
	var/going_hard = FALSE
	/// Whether or not this goat has been flattened like a funny pancake
	var/splat = FALSE

/obj/item/toy/plush/goatplushie/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_TURF_INDUSTRIAL_LIFT_ENTER = PROC_REF(splat),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/plush/goatplushie/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	var/obj/item/cigarette/rollie/fat_dart = tool
	if(!istype(fat_dart))
		return ..()
	if(splat)
		to_chat(user, span_notice("Похоже, [declent_ru(NOMINATIVE)] сейчас не в состоянии отжигать."))
		return ITEM_INTERACT_BLOCKING
	if(going_hard)
		to_chat(user, span_notice("[capitalize(declent_ru(NOMINATIVE))] и так отжигает по полной!"))
		return ITEM_INTERACT_BLOCKING
	if(!fat_dart.lit)
		to_chat(user, span_notice("Сначала надо прикурить!"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("Вы вставляете [fat_dart.declent_ru(ACCUSATIVE)] в рот [declent_ru(DATIVE)]."))
	qdel(fat_dart)
	going_hard = TRUE
	update_icon(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/goatplushie/proc/splat(datum/source)
	SIGNAL_HANDLER
	if(splat)
		return
	if(going_hard)
		going_hard = FALSE
		update_icon(UPDATE_OVERLAYS)
	icon_state = "goat_splat"
	playsound(src, SFX_DESECRATION, 50, TRUE)
	visible_message(span_danger("[capitalize(declent_ru(ACCUSATIVE))] расплющивает в лепёшку!"))
	splat = TRUE

/obj/item/toy/plush/goatplushie/examine(mob/user)
	. = ..()
	if(splat)
		. += span_notice("[capitalize(declent_ru(DATIVE))], кажется, нужен врач.")
	if(going_hard)
		. += span_notice("[capitalize(declent_ru(NOMINATIVE))] так отжигает, что можно и сфотографировать.")

/obj/item/toy/plush/goatplushie/update_overlays()
	. = ..()
	if(going_hard)
		. += "goat_dart"


/obj/item/toy/plush/tzi
	name = "wretched creature"
	desc = "Омерзительный комок плоти с ещё работающим мозгом. Идеально подходит для управления хитроумными мясными механизмами!"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	icon_state = "plushtzi"
	attack_verb_continuous = list("tortures", "scourges")
	attack_verb_simple = list("torture", "scourge")
	squeak_override = list('modular_darkpack/modules/toys/sounds/femurbreaker.ogg'=1)
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 10)
