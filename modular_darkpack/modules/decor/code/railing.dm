/obj/structure/railing/darkpack
	icon_state = null
	icon = 'modular_darkpack/modules/decor/icons/railings.dmi'
	abstract_type = /obj/structure/railing/darkpack

/obj/structure/railing/darkpack/metal
	name = "guard rail"
	desc = "Крепкие перила на все случаи жизни. В частности, не дадут слететь с крыши четырёхэтажки."
	icon_state = "civ_full"

/obj/structure/railing/darkpack/metal/solo
	icon_state = "civ_solo"

/obj/structure/railing/darkpack/metal/industrial
	desc = "Крепкие перила на все случаи жизни. В частности, не дадут слететь с крыши четырёхэтажки. Выкрашены в бодрый оранжевый - значит, всё по технике безопасности."
	icon_state = "indus_full"

/obj/structure/railing/darkpack/metal/industrial/solo
	icon_state = "indus_solo"

/obj/structure/railing/darkpack/sewer
	name = "guard rail"
	desc = "Ржавые перила, которые не дают свалиться в местные нечистоты. Слава богу, что они есть."
	icon_state = "railings_sewer"

/obj/structure/railing/darkpack/wood
	name = "wooden fence"
	desc = "Классический деревянный забор. Уютнее не бывает."
	icon_state = "wood_full"
	base_icon_state = "wood_full"
	item_deconstruct = /obj/item/stack/sheet/mineral/wood
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/railing/darkpack/wood/Initialize(mapload)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[base_icon_state]_snow"

/obj/structure/railing/darkpack/wood/ending
	icon_state = "wood_end"
	base_icon_state = "wood_end"

/obj/structure/railing/darkpack/wood/single
	icon_state = "wood_solo"
	base_icon_state = "wood_solo"

/obj/structure/railing/darkpack/wood/snow
	icon_state = "wood_snow_full"

/obj/structure/railing/darkpack/wood/snow/ending
	icon_state = "wood_snow_end"

/obj/structure/railing/darkpack/wood/snow/single
	icon_state = "wood_snow_solo"
