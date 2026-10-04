/datum/loadout_category/suits
	category_name = "Верхняя одежда"
	category_ui_icon = FA_ICON_USER_SECRET
	type_to_generate = /datum/loadout_item/suit
	tab_order = /datum/loadout_category/head::tab_order + 10

/*
/datum/loadout_item/suit
	abstract_type = /datum/loadout_item/suit

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(outfit.suit)
		LAZYADD(outfit.backpack_contents, outfit.suit)
	outfit.suit = item_path
*/

// Coats
/datum/loadout_item/suit/coat
	abstract_type = /datum/loadout_item/suit/coat

/datum/loadout_item/suit/coat/slickbackcoat
	name = "Пальто (фиолетовое, с мехом)"
	item_path = /obj/item/clothing/suit/vampire/slickbackcoat

/datum/loadout_item/suit/coat/labcoat
	name = "Лабораторный халат"
	item_path = /obj/item/clothing/suit/vampire/labcoat

/datum/loadout_item/suit/coat/brown
	name = "Пальто (коричневое)"
	item_path = /obj/item/clothing/suit/vampire/coat

/datum/loadout_item/suit/coat/green
	name = "Пальто (зелёное)"
	item_path = /obj/item/clothing/suit/vampire/coat/alt

/datum/loadout_item/suit/coat/black
	name = "Шуба (чёрная)"
	item_path = /obj/item/clothing/suit/vampire/coat/winter

/datum/loadout_item/suit/coat/red
	name = "Шуба (красная)"
	item_path = /obj/item/clothing/suit/vampire/coat/winter/alt

/datum/loadout_item/suit/coat/leopardcoat
	name = "Шуба (леопардовая)"
	item_path = /obj/item/clothing/suit/vampire/coat/leopard

//CRIMSON GRID ADDITION START: MILPARKA TO LOADOUT
/datum/loadout_item/suit/jacket/military_parka
	name = "Военная парка"
	item_path = /obj/item/clothing/suit/vampire/coat/milparka
//CRIMSON GRID ADDITION END

/datum/loadout_item/suit/jacket/oversizedjacket
	name = "Куртка оверсайз"
	item_path = /obj/item/clothing/suit/jacket/oversized

/datum/loadout_item/suit/jacket/fancyfurcoat
	name = "Нарядная шуба"
	item_path = /obj/item/clothing/suit/jacket/fancy

/datum/loadout_item/suit/jacket/trenchcoatalt
	name = "Тренч (другой фасон)"
	item_path = /obj/item/clothing/suit/toggle/jacket/trenchcoat

// Jackets
/datum/loadout_item/suit/jacket
	abstract_type = /datum/loadout_item/suit/jacket

/datum/loadout_item/suit/jacket/majima_jacket
	name = "Пиджак (как у Мадзимы)"
	item_path = /obj/item/clothing/suit/vampire/majima_jacket

/datum/loadout_item/suit/jacket/fancy_gray
	name = "Элегантный пиджак (серый)"
	item_path = /obj/item/clothing/suit/vampire/fancy_gray

/datum/loadout_item/suit/jacket/fancy_red
	name = "Элегантный пиджак (красный)"
	item_path = /obj/item/clothing/suit/vampire/fancy_red

/datum/loadout_item/suit/jacket/black_leather
	name = "Кожаная куртка (чёрная)"
	item_path = /obj/item/clothing/suit/vampire/jacket

/datum/loadout_item/suit/jacket/black_leather_cut
	name = "Укороченная кожаная куртка (чёрная)"
	item_path = /obj/item/clothing/suit/vampire/jacket/cropped

/datum/loadout_item/suit/jacket/red_leather
	name = "Кожаная куртка (красная)"
	item_path = /obj/item/clothing/suit/vampire/jacket/red

/datum/loadout_item/suit/jacket/red_leather_cut
	name = "Укороченная кожаная куртка (красная)"
	item_path = /obj/item/clothing/suit/vampire/jacket/cropped/red

/datum/loadout_item/suit/jacket/military
	name = "Куртка (военная)"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/jacket/black_suit
	name = "Пиджак (чёрный)"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/jacket/bomber_classic
	name = "Бомбер (классический)"
	item_path = /obj/item/clothing/suit/vampire/bomber_jacket_classic

/datum/loadout_item/suit/jacket/bomber_gray
	name = "Бомбер (серый)"
	item_path = /obj/item/clothing/suit/vampire/bomber_jacket_gray

// Trenchcoats
/datum/loadout_item/suit/trenchcoat
	abstract_type = /datum/loadout_item/suit/trenchcoat

/datum/loadout_item/suit/trenchcoat/black
	name = "Тренч (чёрный)"
	item_path = /obj/item/clothing/suit/vampire/trench

/datum/loadout_item/suit/trenchcoat/brown
	name = "Тренч (коричневый)"
	item_path = /obj/item/clothing/suit/vampire/trench/alt

/datum/loadout_item/suit/trenchcoat/burgundy
	name = "Тренч (бордовый)"
	item_path = /obj/item/clothing/suit/vampire/trench/archive

// Hoodies
/datum/loadout_item/suit/hoodie
	name = "Худи"
	item_path = /obj/item/clothing/suit/hooded/hoodie

/datum/loadout_item/suit/hoodiezim
	name = "Худи с Вторженцем Зимом"
	item_path = /obj/item/clothing/suit/hooded/hoodie/hoodie_pim

// Misc
/datum/loadout_item/suit/kasaya
	name = "Кашая"
	item_path = /obj/item/clothing/suit/vampire/kasaya

// CRIMSON GRID ADDITION START: HAZARD VEST TO LOADOUT
/datum/loadout_item/suit/hazard_vest
	name = "Сигнальный жилет"
	item_path = /obj/item/clothing/suit/hazardvest
//CRIMSON GRID ADDITION END

/datum/loadout_item/suit/imam
	name = "Одеяние имама"
	item_path = /obj/item/clothing/suit/vampire/imam

/datum/loadout_item/suit/orthodox
	name = "Православная ряса"
	item_path = /obj/item/clothing/suit/vampire/orthodox

/datum/loadout_item/suit/letterman_red
	name = "Университетская куртка (красная)"
	item_path = /obj/item/clothing/suit/jacket/letterman_syndie

// Robes
/datum/loadout_item/suit/robes
	abstract_type = /datum/loadout_item/suit/robes

/datum/loadout_item/suit/robes/white
	name = "Мантия (белая)"
	item_path = /obj/item/clothing/suit/hooded/robes

/datum/loadout_item/suit/robes/black
	name = "Мантия (чёрная)"
	item_path = /obj/item/clothing/suit/hooded/robes/black

/datum/loadout_item/suit/robes/grey
	name = "Мантия (серая)"
	item_path = /obj/item/clothing/suit/hooded/robes/grey

/datum/loadout_item/suit/robes/darkred
	name = "Мантия (тёмно-красная)"
	item_path = /obj/item/clothing/suit/hooded/robes/darkred

/datum/loadout_item/suit/robes/yellow
	name = "Мантия (жёлтая)"
	item_path = /obj/item/clothing/suit/hooded/robes/yellow

/datum/loadout_item/suit/robes/green
	name = "Мантия (зелёная)"
	item_path = /obj/item/clothing/suit/hooded/robes/green

/datum/loadout_item/suit/robes/Red
	name = "Мантия (красная)"
	item_path = /obj/item/clothing/suit/hooded/robes/red

/datum/loadout_item/suit/robes/purple
	name = "Мантия (фиолетовая)"
	item_path = /obj/item/clothing/suit/hooded/robes/purple

/datum/loadout_item/suit/robes/blue
	name = "Мантия (синяя)"
	item_path = /obj/item/clothing/suit/hooded/robes/blue


/// Shawls
/datum/loadout_item/suit/shawl
	abstract_type = /datum/loadout_item/suit/shawl

/datum/loadout_item/suit/shawl/black
	name = "Шаль (чёрная)"
	item_path = /obj/item/clothing/suit/vampire/shawl_black

/datum/loadout_item/suit/shawl/white
	name = "Шаль (белая)"
	item_path = /obj/item/clothing/suit/vampire/shawl_white
