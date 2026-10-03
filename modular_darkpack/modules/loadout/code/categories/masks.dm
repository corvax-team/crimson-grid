/datum/loadout_category/mask
	category_name = "Маски"
	category_ui_icon = FA_ICON_MASK
	type_to_generate = /datum/loadout_item/mask
	tab_order = /datum/loadout_category/head::tab_order + 4

/datum/loadout_item/mask
	abstract_type = /datum/loadout_item/mask

/datum/loadout_item/mask/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.mask)
		LAZYADD(outfit.backpack_contents, outfit.mask)
	outfit.mask = item_path

/datum/loadout_item/mask/work
	group = "Рабочие маски"
	abstract_type = /datum/loadout_item/mask/work

/datum/loadout_item/mask/work/balaclava
	name = "Балаклава"
	item_path = /obj/item/clothing/mask/vampire/balaclava

/datum/loadout_item/mask/work/respirator
	name = "Респиратор"
	item_path = /obj/item/clothing/mask/gas/vampire

/datum/loadout_item/mask/work/lucha
	name = "Маска лучадора (золотая)"
	item_path = /obj/item/clothing/mask/luchador

/datum/loadout_item/mask/work/lucha/green
	name = "Маска лучадора (зелёная)"
	item_path = /obj/item/clothing/mask/luchador/tecnicos

/datum/loadout_item/mask/work/lucha/Red
	name = "Маска лучадора (красная)"
	item_path = /obj/item/clothing/mask/luchador/rudos

/datum/loadout_item/mask/work/shemagh
	name = "Шемаг"
	item_path = /obj/item/clothing/mask/vampire/shemagh

/datum/loadout_item/mask/work/surgical
	name = "Медицинская маска"
	item_path = /obj/item/clothing/mask/surgical

//Animal Masks
/datum/loadout_item/mask/animal
	group = "Маски животных"
	abstract_type = /datum/loadout_item/mask/animal

/datum/loadout_item/mask/animal/policeofficer
	name = "Маска свиньи"
	item_path = /obj/item/clothing/mask/animal/pig

/datum/loadout_item/mask/animal/frog
	name = "Маска лягушки"
	item_path = /obj/item/clothing/mask/animal/frog

/datum/loadout_item/mask/animal/cow
	name = "Маска коровы"
	item_path = /obj/item/clothing/mask/animal/cowmask

/datum/loadout_item/mask/animal/honse
	name = "Маска лошади"
	item_path = /obj/item/clothing/mask/animal/horsehead

/datum/loadout_item/mask/animal/rat
	name = "Маска крысы"
	item_path = /obj/item/clothing/mask/animal/small/rat

/datum/loadout_item/mask/animal/fox
	name = "Маска лисы"
	item_path = /obj/item/clothing/mask/animal/small/fox

/datum/loadout_item/mask/animal/kitsune
	name = "Маска кицунэ"
	item_path = /obj/item/clothing/mask/kitsune

/datum/loadout_item/mask/animal/bee
	name = "Маска пчелы"
	item_path = /obj/item/clothing/mask/animal/small/bee

/datum/loadout_item/mask/animal/bear
	name = "Маска медведя"
	item_path = /obj/item/clothing/mask/animal/small/bear

/datum/loadout_item/mask/animal/man //Is he stupid?
	name = "Маска летучей мыши"
	item_path = /obj/item/clothing/mask/animal/small/bat

/datum/loadout_item/mask/animal/raven
	name = "Маска ворона"
	item_path = /obj/item/clothing/mask/animal/small/raven

/datum/loadout_item/mask/animal/jackal
	name = "Маска шакала"
	item_path = /obj/item/clothing/mask/animal/small/jackal

//Fancy dress masks that aren't costumes.

/datum/loadout_item/mask/fancy
	group = "Маскарадные маски"
	abstract_type = /datum/loadout_item/mask/fancy

/datum/loadout_item/mask/fancy/tragedy
	name = "Маска трагедии"
	item_path = /obj/item/clothing/mask/vampire/tragedy

/datum/loadout_item/mask/fancy/comedy
	name = "Маска комедии"
	item_path = /obj/item/clothing/mask/vampire/comedy

/datum/loadout_item/mask/fancy/venetian
	name = "Венецианская маска"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask

/datum/loadout_item/mask/fancy/venetian/fancy
	name = "Венецианская маска (нарядная)"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask/fancy

/datum/loadout_item/mask/fancy/venetian/jester
	name = "Маска шута"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask/jester

/datum/loadout_item/mask/fancy/venetian/bloody
	name = "Венецианская маска (окровавленная)"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask/scary

//Fancy dress masks that ARE costumes!

/datum/loadout_item/mask/costume
	group = "Карнавальные маски"
	abstract_type = /datum/loadout_item/mask/costume

/datum/loadout_item/mask/costume/scarecrow
	name = "Маска пугала"
	item_path = /obj/item/clothing/mask/scarecrow

/datum/loadout_item/mask/costume/mummy
	name = "Маска мумии"
	item_path = /obj/item/clothing/mask/mummy

// Bandanas
/datum/loadout_item/mask/bandana
	group = "Банданы"
	abstract_type = /datum/loadout_item/mask/bandana

/datum/loadout_item/mask/bandana/normal_greyscale
	name = "Бандана (перекрашиваемая)"
	item_path = /obj/item/clothing/mask/bandana/vampire

/datum/loadout_item/mask/bandana/striped_greyscale
	name = "Бандана (перекрашиваемая, в полоску)"
	item_path = /obj/item/clothing/mask/bandana/striped/vampire

/datum/loadout_item/mask/bandana/skull_greyscale
	name = "Бандана (перекрашиваемая, с черепом)"
	item_path = /obj/item/clothing/mask/bandana/skull/vampire

//Making this a bandana to group them together.
/datum/loadout_item/mask/bandana/facescarf_greyscale
	name = "Шарф на лицо (перекрашиваемый)"
	item_path = /obj/item/clothing/mask/facescarf/vampire
