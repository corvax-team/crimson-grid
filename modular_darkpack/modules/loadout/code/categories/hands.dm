/datum/loadout_category/hands
	category_name = "Руки"
	category_ui_icon = FA_ICON_HANDS
	type_to_generate = /datum/loadout_item/hands
	tab_order = 1

/datum/loadout_item/hands
	abstract_type = /datum/loadout_item/hands

/datum/loadout_item/hands/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.gloves)
		LAZYADD(outfit.backpack_contents, outfit.gloves)
	outfit.gloves = item_path

/datum/loadout_item/hands/leather_gloves
	name = "Перчатки (кожаные)"
	item_path = /obj/item/clothing/gloves/vampire/leather

/datum/loadout_item/hands/work_gloves
	name = "Перчатки (рабочие)"
	item_path = /obj/item/clothing/gloves/vampire/work

/datum/loadout_item/hands/cleaning_gloves
	name = "Перчатки (хозяйственные)"
	item_path = /obj/item/clothing/gloves/vampire/cleaning

/datum/loadout_item/hands/latex_gloves
	name = "Перчатки (латексные)"
	item_path = /obj/item/clothing/gloves/vampire/latex
