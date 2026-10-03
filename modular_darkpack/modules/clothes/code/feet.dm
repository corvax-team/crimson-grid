//SHOES

//SHOES

//SHOES

/obj/item/clothing/shoes/vampire
	name = "shoes"
	desc = "Удобные на вид ботинки."
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon_state = "shoes"
	gender = PLURAL
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/shoes/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 5, "shoes", FALSE)

/obj/item/clothing/shoes/vampire/brown
	icon_state = "shoes_brown"

/obj/item/clothing/shoes/vampire/white
	icon_state = "shoes_white"

/obj/item/clothing/shoes/vampire/jackboots
	name = "jackboots"
	desc = "Крепкие на вид ботинки."
	icon_state = "jackboots"

/obj/item/clothing/shoes/vampire/jackboots/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes)

/obj/item/clothing/shoes/vampire/jackboots/high
	name = "high boots"
	desc = "Высокие сапоги. А вы чего ждали?"
	icon_state = "tall_boots"

/obj/item/clothing/shoes/vampire/jackboots/punk
	icon_state = "daboots"

/obj/item/clothing/shoes/vampire/jackboots/work
	icon_state = "jackboots_work"

/obj/item/clothing/shoes/vampire/sneakers
	name = "sneakers"
	desc = "Спортивные кроссовки."
	icon_state = "sneakers"

/obj/item/clothing/shoes/vampire/sneakers/red
	icon_state = "sneakers_red"

/obj/item/clothing/shoes/vampire/blackfur
	name = "black fur boots"
	desc = "Пара пушистых чёрно-белых сапог"
	icon_state = "furboots_black"

/obj/item/clothing/shoes/vampire/brownfur
	name = "brown fur boots"
	desc = "Пара пушистых коричневых сапог"
	icon_state = "furboots_brown"

/obj/item/clothing/shoes/vampire/pumped
	name = "knee-high sneakers"
	desc = "Кеды популярной марки \"Конверты\""
	icon_state = "pumped_up_kicks"

/obj/item/clothing/shoes/vampire/heels
	name = "heels"
	desc = "Дорогие на вид туфли на каблуках."
	icon_state = "heels"

/obj/item/clothing/shoes/vampire/heels/red
	icon_state = "heels_red"

/obj/item/clothing/shoes/vampire/businessscaly
	name = "scaly shoes"
	desc = "Туфли, покрытые чешуёй."
	icon_state = "scales_shoes"

/obj/item/clothing/shoes/vampire/businessblack
	name = "black shoes"
	desc = "Классические чёрные ботинки."
	icon_state = "business_shoes"

/obj/item/clothing/shoes/vampire/businesstip
	name = "metal tip shoes"
	desc = "Туфли с металлическими носами."
	icon_state = "metal_shoes"

