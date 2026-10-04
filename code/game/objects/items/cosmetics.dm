/obj/item/lipstick
	gender = PLURAL
	name = "red lipstick"
	desc = "Обычная губная помада, ничего особенного."
	icon = 'icons/obj/cosmetic.dmi'
	icon_state = "lipstick"
	base_icon_state = "lipstick"
	inhand_icon_state = "lipstick"
	w_class = WEIGHT_CLASS_TINY
	interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING
	var/open = FALSE
	/// Actual color of the lipstick, also gets applied to the human
	var/lipstick_color = COLOR_RED
	/// The style of lipstick. Upper, middle, or lower lip. Default is middle.
	var/style = "lipstick"
	/// A trait that's applied while someone has this lipstick applied, and is removed when the lipstick is removed
	var/lipstick_trait
	/// Can this lipstick spawn randomly
	var/random_spawn = TRUE

/obj/item/lipstick/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_appearance(UPDATE_ICON)

/obj/item/lipstick/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, open))
		update_appearance(UPDATE_ICON)

/obj/item/lipstick/examine(mob/user)
	. = ..()
	. += "Alt-клик, чтобы сменить способ нанесения."

/obj/item/lipstick/update_icon_state()
	icon_state = "[base_icon_state][open ? "_uncap" : null]"
	inhand_icon_state = "[base_icon_state][open ? "open" : null]"
	return ..()

/obj/item/lipstick/update_overlays()
	. = ..()
	if(!open)
		return
	var/mutable_appearance/colored_overlay = mutable_appearance(icon, "lipstick_uncap_color")
	colored_overlay.color = lipstick_color
	. += colored_overlay

/obj/item/lipstick/click_alt(mob/user)
	display_radial_menu(user)
	return CLICK_ACTION_SUCCESS

/obj/item/lipstick/proc/display_radial_menu(mob/living/carbon/human/user)
	var/style_options = list(
		UPPER_LIP = icon('icons/hud/radial.dmi', UPPER_LIP),
		MIDDLE_LIP = icon('icons/hud/radial.dmi', MIDDLE_LIP),
		LOWER_LIP = icon('icons/hud/radial.dmi', LOWER_LIP),
	)
	var/pick = show_radial_menu(user, src, style_options, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!pick)
		return TRUE

	switch(pick)
		if(MIDDLE_LIP)
			style = "lipstick"
		if(LOWER_LIP)
			style = "lipstick_lower"
		if(UPPER_LIP)
			style = "lipstick_upper"
	return TRUE

/obj/item/lipstick/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.is_holding(src))
		return FALSE
	return TRUE

/obj/item/lipstick/purple
	name = "purple lipstick"
	lipstick_color = COLOR_PURPLE

/obj/item/lipstick/jade
	name = "jade lipstick"
	lipstick_color = COLOR_JADE

/obj/item/lipstick/blue
	name = "blue lipstick"
	lipstick_color = COLOR_BLUE

/obj/item/lipstick/green
	name = "green lipstick"
	lipstick_color = COLOR_GREEN

/obj/item/lipstick/white
	name = "white lipstick"
	lipstick_color = COLOR_WHITE

/obj/item/lipstick/black
	name = "black lipstick"
	lipstick_color = COLOR_BLACK

/obj/item/lipstick/black/death
	name = "\improper Kiss of Death"
	desc = "An incredibly potent tube of lipstick made from the venom of the dreaded Yellow Spotted Space Lizard, as deadly as it is chic. Try not to smear it!"
	lipstick_trait = TRAIT_KISS_OF_DEATH
	random_spawn = FALSE

/obj/item/lipstick/syndie
	name = "syndie lipstick"
	desc = "Syndicate branded lipstick with a killer dose of kisses. Observe safety regulations!"
	icon_state = "slipstick"
	base_icon_state = "slipstick"
	lipstick_color = COLOR_SYNDIE_RED
	lipstick_trait = TRAIT_SYNDIE_KISS
	random_spawn = FALSE

/obj/item/lipstick/random
	name = "lipstick"
	icon_state = "random_lipstick"

/obj/item/lipstick/random/Initialize(mapload)
	. = ..()
	icon_state = "lipstick"
	var/static/list/possible_colors
	if(!possible_colors)
		possible_colors = list()
		for(var/obj/item/lipstick/lipstick_path as anything in (typesof(/obj/item/lipstick) - src.type))
			if(!initial(lipstick_path.lipstick_color) || !initial(lipstick_path.random_spawn))
				continue
			possible_colors[initial(lipstick_path.lipstick_color)] = initial(lipstick_path.name)
	lipstick_color = pick(possible_colors)
	name = possible_colors[lipstick_color]
	update_appearance()

/obj/item/lipstick/attack_self(mob/user)
	to_chat(user, span_notice("Вы [open ? "закручиваете" : "выкручиваете"] помаду."))
	open = !open
	update_appearance(UPDATE_ICON)

/obj/item/lipstick/attack(mob/M, mob/user)
	if(!open || !ismob(M))
		return

	if(!ishuman(M))
		to_chat(user, span_warning("И где у этого губы?"))
		return

	var/mob/living/carbon/human/target = M
	if(target.is_mouth_covered())
		to_chat(user, span_warning("Сначала нужно снять маску!"))
		return
	if(target.lip_style) //if they already have lipstick on
		to_chat(user, span_warning("Сначала сотрите старую помаду!"))
		return

	if(target == user)
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] красит губы помадой."), \
			span_notice("Вы не спеша красите губы. Идеально!"))
		target.update_lips(style, lipstick_color, lipstick_trait)
		return

	user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] начинает красить губы [target.declent_ru(DATIVE)]."), \
		span_notice("Вы начинаете красить губы [target.declent_ru(DATIVE)]..."))
	if(!do_after(user, 2 SECONDS, target = target))
		return
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] красит губы [target.declent_ru(DATIVE)]."), \
		span_notice("Вы красите губы [target.declent_ru(DATIVE)]."))
	target.update_lips(style, lipstick_color, lipstick_trait)

//you can wipe off lipstick with paper!
/obj/item/paper/attack(mob/M, mob/user)
	if(user.zone_selected != BODY_ZONE_PRECISE_MOUTH || !ishuman(M))
		return ..()

	var/mob/living/carbon/human/target = M
	if(target == user)
		to_chat(user, span_notice("Вы стираете помаду."))
		target.update_lips(null)
		return

	user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] начинает стирать помаду с губ [target.declent_ru(GENITIVE)]."), \
		span_notice("Вы начинаете стирать помаду с губ [target.declent_ru(GENITIVE)]..."))
	if(!do_after(user, 1 SECONDS, target = target))
		return
	user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] стирает помаду с губ [target.declent_ru(GENITIVE)]."), \
		span_notice("Вы стираете помаду с губ [target.declent_ru(GENITIVE)]."))
	target.update_lips(null)

/obj/item/razor
	name = "electric razor"
	desc = "Новейшая электробритва, последнее слово науки о бритье."
	icon = 'icons/obj/cosmetic.dmi'
	icon_state = "razor"
	inhand_icon_state = "razor"
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_TINY
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	custom_price = 50 // DARKPACK EDIT ADD - ECONOMY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.7)

/obj/item/razor/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] begins shaving [user.p_them()]self without the razor guard! Кажется, [user.ru_p_they()] пытается совершить самоубийство!"))
	if (ishuman(user))
		shave(user, BODY_ZONE_PRECISE_MOUTH)
		shave(user, BODY_ZONE_HEAD) //doesn't need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/razor/proc/shave(mob/living/carbon/human/skinhead, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		skinhead.set_facial_hairstyle("Shaved", update = TRUE)
	else
		skinhead.set_hairstyle("Skinhead", update = TRUE)
	playsound(loc, 'sound/items/hair-clippers.ogg', 20, TRUE)

/obj/item/razor/attack(mob/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!ishuman(target_mob))
		return ..()
	var/mob/living/carbon/human/human_target = target_mob
	var/obj/item/bodypart/head/noggin =  human_target.get_bodypart(BODY_ZONE_HEAD)
	var/location = user.zone_selected
	var/static/list/head_zones = list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)
	if(!noggin && (location in head_zones))
		to_chat(user, span_warning("У [human_target.declent_ru(GENITIVE)] нет головы!"))
		return
	if(location == BODY_ZONE_PRECISE_MOUTH)
		if(!user.combat_mode)
			if(human_target.gender == MALE)
				if(human_target == user)
					to_chat(user, span_warning("Чтобы как следует оформить себе бороду, нужно зеркало!"))
					return
				if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
					return
				var/new_style = tgui_input_list(user, "Выберите фасон бороды", "Стрижка", SSaccessories.facial_hairstyles_list)
				if(isnull(new_style))
					return
				var/covering = human_target.is_mouth_covered()
				if(covering)
					to_chat(user, span_warning("Сначала нужно открыть лицо!"))
					return
				if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
					to_chat(user, span_warning("На лице нет волос, оформлять нечего!"))
					return
				if(HAS_TRAIT(human_target, TRAIT_SHAVED))
					to_chat(user, span_warning("Тут всё выбрито слишком гладко. Ну то есть совсем-совсем гладко."))
					return
				user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] берётся подровнять бороду [human_target.declent_ru(DATIVE)]."), span_notice("Вы берётесь подровнять бороду [human_target.declent_ru(DATIVE)]."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(new_style && do_after(user, 6 SECONDS, target = human_target))
					user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] придаёт бороде [human_target.declent_ru(GENITIVE)] новую форму."), span_notice("Вы придаёте бороде [human_target.declent_ru(GENITIVE)] новую форму."))
					human_target.set_facial_hairstyle(new_style, update = TRUE)
					return
			else
				return
		else
			var/covering = human_target.is_mouth_covered()
			if(covering)
				to_chat(user, span_warning("Сначала нужно открыть лицо!"))
				return
			if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
				to_chat(user, span_warning("На лице нет волос, брить нечего!"))
				return
			if(human_target.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("И так гладко выбрито!"))
				return

			if(human_target == user) //shaving yourself
				user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает бриться."), \
					span_notice("Вы начинаете бриться..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = user))
					user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начисто сбривает щетину."), \
						span_notice("Вы заканчиваете бриться. Быстро и чисто!"))
					shave(user, location)
				return
			else
				user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] начинает брить лицо [human_target.declent_ru(DATIVE)]."), \
					span_notice("Вы начинаете брить лицо [human_target.declent_ru(DATIVE)]..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = human_target))
					user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] начисто сбривает [human_target.declent_ru(DATIVE)] бороду."), \
						span_notice("Вы начисто сбриваете [human_target.declent_ru(DATIVE)] бороду."))
					shave(human_target, location)
				return
	else if(location == BODY_ZONE_HEAD)
		if(!user.combat_mode)
			if(human_target == user)
				to_chat(user, span_warning("Чтобы как следует подстричь себя, нужно зеркало!"))
				return
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return
			var/new_style = tgui_input_list(user, "Выберите причёску", "Стрижка", SSaccessories.hairstyles_list)
			if(isnull(new_style))
				return
			if(!human_target.is_location_accessible(location))
				to_chat(user, span_warning("Головной убор мешает!"))
				return
			if(!(noggin.head_flags & HEAD_HAIR))
				to_chat(user, span_warning("Волос нет, стричь нечего!"))
				return
			if(HAS_TRAIT(human_target, TRAIT_BALD))
				to_chat(user, span_warning("Тут слишком лысо. Ну то есть совсем-совсем лысо."))
				return
			user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] берётся за причёску [human_target.declent_ru(GENITIVE)]."), span_notice("Вы берётесь за причёску [human_target.declent_ru(GENITIVE)]."))
			playsound(src, 'sound/items/hair-clippers.ogg', 50)
			if(new_style && do_after(user, 6 SECONDS, target = human_target))
				user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] делает [human_target.declent_ru(DATIVE)] новую причёску."), span_notice("Вы делаете [human_target.declent_ru(DATIVE)] новую причёску."))
				human_target.set_hairstyle(new_style, update = TRUE)
				return
		else
			if(!human_target.is_location_accessible(location))
				to_chat(user, span_warning("Головной убор мешает!"))
				return
			if(!(noggin.head_flags & HEAD_HAIR))
				to_chat(user, span_warning("Волос нет, брить нечего!"))
				return
			if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Balding Hair" || human_target.hairstyle == "Skinhead")
				to_chat(user, span_warning("Волос осталось слишком мало, брить нечего!"))
				return

			if(human_target == user) //shaving yourself
				user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает брить себе голову."), \
					span_notice("Вы начинаете брить себе голову..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = user))
					user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] бреет себе голову."), \
						span_notice("Вы заканчиваете брить голову."))
					shave(user, location)
				return
			else
				user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] начинает брить голову [human_target.declent_ru(DATIVE)]!"), \
					span_notice("Вы начинаете брить голову [human_target.declent_ru(DATIVE)]..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = human_target))
					user.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] бреет [human_target.declent_ru(ACCUSATIVE)] наголо!"), \
						span_notice("Вы бреете [human_target.declent_ru(ACCUSATIVE)] наголо."))
					shave(human_target, location)
				return
	return ..()

/obj/item/razor/surgery
	name = "surgical razor"
	desc = "Медицинская бритва. Точные лезвия чисто выбривают кожу перед операцией."
	icon = 'icons/obj/cosmetic.dmi'
	icon_state = "medrazor"

/obj/item/razor/surgery/get_surgery_tool_overlay(tray_extended)
	return "razor"
