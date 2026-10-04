/obj/structure/dresser
	name = "dresser"
	desc = "Добротный деревянный комод. Набит нижним бельём."
	icon = 'modular_darkpack/master_files/icons/obj/fluff/general.dmi' // DARKPACK EDIT CHANGE
	icon_state = "dresser"
	resistance_flags = FLAMMABLE
	density = TRUE
	anchored = TRUE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/structure/dresser/wrench_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("Вы начинаете [anchored ? "откручивать" : "прикручивать"] [declent_ru(ACCUSATIVE)]."))
	if(!tool.use_tool(src, user, 20, volume=50))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Вы [anchored ? "открутили" : "прикрутили"] [declent_ru(ACCUSATIVE)]."))
	set_anchored(!anchored)
	return ITEM_INTERACT_SUCCESS

/obj/structure/dresser/atom_deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)

/obj/structure/dresser/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))//no tele-grooming
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/dressing_human = user
	if(HAS_TRAIT(dressing_human, TRAIT_NO_UNDERWEAR))
		to_chat(dressing_human, span_warning("Вам бельё ни к чему."))
		return

	var/choice = tgui_input_list(user, "Бельё, майка или носки?", "Переодевание", list("Underwear","Underwear Color","Undershirt","Socks"))
	if(isnull(choice))
		return

	if(!Adjacent(user))
		return
	switch(choice)
		if("Underwear")
			var/new_undies = tgui_input_list(user, "Выберите нижнее бельё", "Переодевание", SSaccessories.underwear_list)
			if(new_undies)
				dressing_human.underwear = new_undies
		if("Underwear Color")
			var/new_underwear_color = tgui_color_picker(dressing_human, "Выберите цвет белья", "Цвет белья", dressing_human.underwear_color)
			if(new_underwear_color)
				dressing_human.underwear_color = sanitize_hexcolor(new_underwear_color)
		if("Undershirt")
			var/new_undershirt = tgui_input_list(user, "Выберите майку", "Переодевание", SSaccessories.undershirt_list)
			if(new_undershirt)
				dressing_human.undershirt = new_undershirt
		if("Socks")
			var/new_socks = tgui_input_list(user, "Выберите носки", "Переодевание", SSaccessories.socks_list)
			if(new_socks)
				dressing_human.socks = new_socks

	add_fingerprint(dressing_human)
	dressing_human.update_body()
