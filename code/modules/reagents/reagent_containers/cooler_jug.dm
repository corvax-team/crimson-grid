/obj/item/reagent_containers/cooler_jug
	name = "cooler jug"
	desc = "Огромная неудобная бутыль, источник жизни для кулеров. Пахнет холодным пластиком."
	icon = 'icons/obj/medical/chemical_tanks.dmi'
	icon_state = "cooler_jug"
	volume = 200
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4)
	initial_reagent_flags = REFILLABLE | DRAINABLE | INJECTABLE | DRAWABLE | TRANSPARENT | NO_SPLASH
	spillable = TRUE
	has_variable_transfer_amount = FALSE
	interaction_flags_click = NEED_DEXTERITY
	fill_icon_state = "cooler_jug_overlay"
	fill_icon_thresholds = list(25, 50, 75, 100)
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY

/obj/item/reagent_containers/cooler_jug/water
	name = "water jug"
	desc = "Изящная бутыль для кулера. Где-то там её ждёт кулер, мечтающий о воссоединении. От горлышка упоительно пахнет затхлостью и металлом."
	list_reagents = list(/datum/reagent/water = 200)

/obj/item/reagent_containers/cooler_jug/punch
	name = "punch jug"
	desc = "Бутыль для фруктового пунша. Вся в предупреждающих наклейках и пугающих значках, которых вы раньше не видели. Горлышко пропахло сладким пуншем."
	list_reagents = list(/datum/reagent/consumable/fruit_punch = 200)
