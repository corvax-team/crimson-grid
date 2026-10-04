/obj/item/clothing/suit/vampire/toggled
	var/toggle_noun = "застегнуть или расстегнуть молнию"

/obj/item/clothing/suit/vampire/toggled/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, toggle_noun)

/obj/item/clothing/suit/vampire/toggled/bomber_jacket
	name = "bomber jacket"
	desc = "Бомбер."
	icon = 'modular_vcg/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_vcg/modules/clothes/icons/worn.dmi'
	icon_state = "fur1"
	ONFLOOR_ICON_HELPER('modular_vcg/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/suit/vampire/toggled/bomber_jacket/inverted
	name = "bomber jacket"
	desc = "Нарядный бомбер."
	icon_state = "fur2"

/obj/item/clothing/suit/vampire/toggled/plain_jacket
	name = "plain brown jacket"
	desc = "Простая коричневая куртка."
	icon = 'modular_vcg/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_vcg/modules/clothes/icons/worn.dmi'
	icon_state = "plain1"
	ONFLOOR_ICON_HELPER('modular_vcg/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/suit/vampire/toggled/plain_jacket/black
	name = "plain black jacket"
	desc = "Простая чёрная куртка."
	icon_state = "plain2"

/obj/item/clothing/suit/vampire/toggled/military_jacket
	name = "military jacket"
	desc = "Военная куртка."
	icon = 'modular_vcg/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_vcg/modules/clothes/icons/worn.dmi'
	icon_state = "m65"
	ONFLOOR_ICON_HELPER('modular_vcg/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/suit/vampire/racing_jacket
	name = "Black and Yellow racing jacket"
	desc = "Чёрно-жёлтая японская гоночная куртка."
	icon = 'modular_vcg/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_vcg/modules/clothes/icons/worn.dmi'
	icon_state = "blackyellow_racejacket"
	ONFLOOR_ICON_HELPER('modular_vcg/modules/clothes/icons/clothing_onfloor.dmi')
	armor_type = /datum/armor/racing_jacket

/datum/armor/racing_jacket
	melee = 30
	bullet = 25
	laser = 5
	energy = 5
	bomb = 35
	fire = 35
	acid = 10
	wound = 35

/obj/item/clothing/suit/vampire/racing_jacket/blackblue
	name = "Black and Blue racing jacket"
	desc = "Чёрно-синяя японская гоночная куртка."
	icon_state = "blackblue_racejacket"

/obj/item/clothing/suit/vampire/racing_jacket/whitered
	name = "White and Red racing jacket"
	desc = "Бело-красная японская гоночная куртка."
	icon_state = "whitered_racejacket"

/obj/item/clothing/suit/vampire/racing_jacket/whiteyellow
	name = "White and Yellow racing jacket"
	desc = "Бело-жёлтая японская гоночная куртка."
	icon_state = "whiteyellow_racejacket"

/obj/item/clothing/suit/vampire/racing_jacket/bluewhite
	name = "Blue and White racing jacket"
	desc = "Сине-белая японская гоночная куртка."
	icon_state = "bluewhite_racejacket"

/obj/item/clothing/suit/vampire/racing_jacket/redwhite
	name = "Red and White racing jacket"
	desc = "Красно-белая японская гоночная куртка."
	icon_state = "redwhite_racejacket"
