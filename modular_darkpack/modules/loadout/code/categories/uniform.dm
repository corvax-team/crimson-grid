/datum/loadout_category/uniform
	category_name = "Одежда"
	category_ui_icon = FA_ICON_SHIRT
	type_to_generate = /datum/loadout_item/uniform
	tab_order = /datum/loadout_category/head::tab_order + 9

/datum/loadout_item/uniform
	abstract_type = /datum/loadout_item/uniform

/datum/loadout_item/uniform/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(outfit.uniform)
		LAZYADD(outfit.backpack_contents, outfit.uniform)
	outfit.uniform = item_path

// Suit and Suitskirts
/datum/loadout_item/uniform/suit
	abstract_type = /datum/loadout_item/uniform/suit

/datum/loadout_item/uniform/suit/fancy_gray
	name = "Костюм (элегантный, красный)"
	item_path = /obj/item/clothing/under/vampire/fancy_gray

/datum/loadout_item/uniform/suit/fancy_red
	name = "Костюм (элегантный, серый)"
	item_path = /obj/item/clothing/under/vampire/fancy_red

/datum/loadout_item/uniform/suit/fancy_black
	name = "Костюм (дорогой, чёрный)"
	item_path = /obj/item/clothing/under/vampire/ventrue

/datum/loadout_item/uniform/suit/fancy_black_skirt
	name = "Платье (дорогое, чёрное)"
	item_path = /obj/item/clothing/under/vampire/ventrue/female

/datum/loadout_item/uniform/suit/formal_white
	name = "Костюм (белый)"
	item_path = /obj/item/clothing/under/vampire/office

/datum/loadout_item/uniform/suit/plain_black
	name = "Костюм (простой, чёрный)"
	item_path = /obj/item/clothing/under/vampire/suit

/datum/loadout_item/uniform/suit/plain_black_skirt
	name = "Костюм с юбкой (простой, чёрный)"
	item_path = /obj/item/clothing/under/vampire/suit/female

/datum/loadout_item/uniform/suit/plain_red
	name = "Костюм (простой, красный)"
	item_path = /obj/item/clothing/under/vampire/sheriff

/datum/loadout_item/uniform/suit/plain_red_skirt
	name = "Костюм с юбкой (простой, красный)"
	item_path = /obj/item/clothing/under/vampire/sheriff/female

/datum/loadout_item/uniform/suit/plain_blue
	name = "Костюм (синий)"
	item_path = /obj/item/clothing/under/vampire/clerk

/datum/loadout_item/uniform/suit/plain_blue_skirt
	name = "Костюм с юбкой (синий)"
	item_path = /obj/item/clothing/under/vampire/clerk/female

/datum/loadout_item/uniform/suit/plain_brown
	name = "Костюм (коричневый)"
	item_path = /obj/item/clothing/under/vampire/archivist

/datum/loadout_item/uniform/suit/plain_brown_skirt
	name = "Костюм с юбкой (коричневый)"
	item_path = /obj/item/clothing/under/vampire/archivist/female

/datum/loadout_item/uniform/suit/prince
	name = "Костюм (как у Принца)"
	item_path = /obj/item/clothing/under/vampire/prince

/datum/loadout_item/uniform/suit/prince_skirt
	name = "Костюм с юбкой (как у Принца)"
	item_path = /obj/item/clothing/under/vampire/prince/female

// Skirts
/datum/loadout_item/uniform/skirt
	abstract_type = /datum/loadout_item/uniform/skirt

/datum/loadout_item/uniform/skirt/pentagram
	name = "Футболка с пентаграммой (с юбкой)"
	item_path = /obj/item/clothing/under/vampire/baali/female

// Turtleneck
/datum/loadout_item/uniform/turtleneck
	abstract_type = /datum/loadout_item/uniform/turtleneck

/datum/loadout_item/uniform/turtleneck/black
	name = "Водолазка (чёрная)"
	item_path = /obj/item/clothing/under/vampire/turtleneck_black

/datum/loadout_item/uniform/turtleneck/navy
	name = "Водолазка (тёмно-синяя)"
	item_path = /obj/item/clothing/under/vampire/turtleneck_navy

/datum/loadout_item/uniform/turtleneck/red
	name = "Водолазка (красная)"
	item_path = /obj/item/clothing/under/vampire/turtleneck_red

/datum/loadout_item/uniform/turtleneck/white
	name = "Водолазка (белая)"
	item_path = /obj/item/clothing/under/vampire/turtleneck_white

// Pants
/datum/loadout_item/uniform/pants
	abstract_type = /datum/loadout_item/uniform/pants

/datum/loadout_item/uniform/pants/leather
	name = "Штаны (кожаные)"
	item_path = /obj/item/clothing/under/vampire/leatherpants

// Bloodlines clan outfits
/datum/loadout_item/uniform/flamboyant
	name = "Рубашка (красная)"
	item_path = /obj/item/clothing/under/vampire/toreador

/datum/loadout_item/uniform/flamboyant_female
	name = "Кроп-топ (фиолетовый)"
	item_path = /obj/item/clothing/under/vampire/toreador/female

/datum/loadout_item/uniform/punk
	name = "Рубашка (серая)"
	item_path = /obj/item/clothing/under/vampire/brujah

/datum/loadout_item/uniform/punk_female
	name = "Кроп-топ (белый)"
	item_path = /obj/item/clothing/under/vampire/brujah/female

/datum/loadout_item/uniform/gimp
	name = "Костюм гимпа"
	item_path = /obj/item/clothing/under/vampire/nosferatu

/datum/loadout_item/uniform/gimp_female
	name = "Костюм гимпа (с лифом)"
	item_path = /obj/item/clothing/under/vampire/nosferatu/female

/datum/loadout_item/uniform/gangrel
	name = "Поношенная одежда (красная)"
	item_path = /obj/item/clothing/under/vampire/gangrel

/datum/loadout_item/uniform/gangrel_female
	name = "Поношенная одежда (синяя)"
	item_path = /obj/item/clothing/under/vampire/gangrel/female

/datum/loadout_item/uniform/pants/grimey
	name = "Штаны (засаленные)"
	item_path = /obj/item/clothing/under/vampire/malkavian

/datum/loadout_item/uniform/schoolgirl
	name = "Костюм школьницы-готки"
	item_path = /obj/item/clothing/under/vampire/malkavian/female

/datum/loadout_item/uniform/suit/formal_burgundy
	name = "Костюм (бордовый)"
	item_path = /obj/item/clothing/under/vampire/tremere

/datum/loadout_item/uniform/suit/formal_burgundy_skirt
	name = "Костюм с юбкой (бордовый)"
	item_path = /obj/item/clothing/under/vampire/tremere/female


//Dresses
/datum/loadout_item/uniform/dress
	name = "Платье (чёрное)"
	item_path = /obj/item/clothing/under/vampire/business

/datum/loadout_item/uniform/dress_red
	name = "Платье (красное)"
	item_path = /obj/item/clothing/under/vampire/primogen_toreador/female

/datum/loadout_item/uniform/maid
	name = "Костюм горничной"
	item_path = /obj/item/clothing/under/costume/maid

//Dress Shirts
/datum/loadout_item/uniform/emo
	name = "Рубашка (чёрная)"
	item_path = /obj/item/clothing/under/vampire/emo

/datum/loadout_item/uniform/messy
	name = "Рубашка (белая)"
	item_path = /obj/item/clothing/under/vampire/bouncer

/datum/loadout_item/uniform/biker
	name = "Рубашка (коричневая)"
	item_path = /obj/item/clothing/under/vampire/biker

//Scene
/datum/loadout_item/uniform/scenepink
	name = "Наряд популярной девчонки"
	item_path = /obj/item/clothing/under/vampire/scenepink

/datum/loadout_item/uniform/scenemoody
	name = "Мрачный прикид"
	item_path = /obj/item/clothing/under/vampire/scenemoody

/datum/loadout_item/uniform/sceneleopard
	name = "Откровенный наряд"
	item_path = /obj/item/clothing/under/vampire/sceneleopard

/datum/loadout_item/uniform/scenezim
	name = "Топ с Вторженцем Зимом"
	item_path = /obj/item/clothing/under/vampire/scenezim

//Other
/datum/loadout_item/uniform/baron
	name = "Костюм бармена"
	item_path = /obj/item/clothing/under/vampire/bar

/datum/loadout_item/uniform/baron_female
	name = "Костюм бармена (с юбкой)"
	item_path = /obj/item/clothing/under/vampire/bar/female

/datum/loadout_item/uniform/sleeveless_yellow
	name = "Майка (жёлтая)"
	item_path = /obj/item/clothing/under/vampire/larry

/datum/loadout_item/uniform/sleeveless_white
	name = "Майка (белая)"
	item_path = /obj/item/clothing/under/vampire/bandit

/datum/loadout_item/uniform/hipster
	name = "Кроп-топ (красный)"
	item_path = /obj/item/clothing/under/vampire/red

/datum/loadout_item/uniform/black_grunge
	name = "Кроп-топ (чёрный)"
	item_path = /obj/item/clothing/under/vampire/black


/datum/loadout_item/uniform/burlesque
	name = "Наряд для бурлеска"
	item_path = /obj/item/clothing/under/vampire/burlesque

/datum/loadout_item/uniform/daisyd
	name = "Короткие джинсовые шорты"
	item_path = /obj/item/clothing/under/vampire/burlesque/daisyd

/datum/loadout_item/uniform/overalls
	name = "Комбинезон"
	item_path = /obj/item/clothing/under/vampire/mechanic

//CRIMSON GRID ADDITION START: BLACK OVERALLS TO LOADOUT
/datum/loadout_item/uniform/black_overalls
	name = "Комбинезон (чёрный)"
	item_path = /obj/item/clothing/under/vampire/graveyard
//CRIMSON GRID ADDITION END

/datum/loadout_item/uniform/black_overcoat
	name = "Пальто (чёрное)"
	item_path = /obj/item/clothing/under/vampire/rich

/datum/loadout_item/uniform/gown_black
	name = "Вечернее платье (чёрное)"
	item_path = /obj/item/clothing/under/vampire/gown_black

/datum/loadout_item/uniform/gown_white
	name = "Вечернее платье (белое)"
	item_path = /obj/item/clothing/under/vampire/gown_white
