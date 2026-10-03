/obj/item/autosurgeon/vicissitude
	name = "little brother"
	desc = "Умелая тварь, вылепленная из плоти: она вживит хозяину имплант или орган без возни с долгой операцией. \
		Её пасть жадно ждёт импланта или органа. Тварь, впрочем, прожорлива, и то, что попало в неё по ошибке, придётся выковыривать отвёрткой."
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 10, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 6, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/structure/fleshwall
	name = "flesh wall"
	desc = "Стена из ПЛОТИ."
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "fleshwall"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/tzijelly
	name = "jelly thing"
	desc = "важная часть мясной матрицы."
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "tzijelly"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 30)

/obj/item/ground_heir
	name = "bag of ground"
	desc = "Здесь куётся богатырская сила..."
	icon_state = "dirt"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

// Why is this NOT a floor type.
/obj/effect/decal/gut_floor
	name = "gut floor"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "tzimisce_floor"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT)

/obj/effect/decal/gut_floor/Initialize(mapload)
	. = ..()
	if(isopenturf(get_turf(src)))
		var/turf/open/T = get_turf(src)
		if(T)
			T.slowdown = 1

/obj/effect/decal/gut_floor/Destroy()
	. = ..()
	var/turf/open/T = get_turf(src)
	if(T)
		T.slowdown = initial(T.slowdown)

/obj/structure/chair/old/tzimisce
	icon = 'modular_darkpack/modules/powers/icons/flesh_objects.dmi'
	icon_state = "tzimisce_stool"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/guts
	name = "guts"
	desc = "Кровь да кишки, ничего больше..."
	icon_state = "guts"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/spine
	name = "spine"
	desc = "Если бы только всё было в моих руках..."
	icon_state = "spine"
	icon = 'modular_darkpack/modules/powers/icons/flesh_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/powers/icons/flesh_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/suit/vampire/trench/tzi
	name = "fleshcoat"
	desc = "КУРТКА ИЗ ЧЕЛОВЕЧЕСКОЙ КОЖИ."
	icon_state = "trench_tzi"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 50)
	armor_type = /datum/armor/fleshcoat
	clothing_traits = list(TRAIT_UNMASQUERADE)

/datum/armor/fleshcoat
	melee = 50
	bullet = 50
	laser = 10
	energy = 10
	bomb = 25
	acid = 10
	wound = 50

/obj/item/organ/cyberimp/brain/anti_stun/tzi
	name = "secondary adrenal gland"
	desc = "При оглушении этот орган выбрасывает в кровь мощный коктейль стимуляторов, и вы быстрее приходите в себя. Вживляется в голову."
	icon_state = "tongueayylmao"
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 25)

/obj/item/organ/eyes/night_vision/tzimisce
	low_light_cutoff = list(15, 6, 8)
	medium_light_cutoff = list(35, 20, 25)
	high_light_cutoff = list(50, 40, 40)
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 15)
