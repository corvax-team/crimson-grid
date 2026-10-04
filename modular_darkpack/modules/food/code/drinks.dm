//---------DRINKS---------//

/obj/item/reagent_containers/cup/glass/coffee/vampire
	name = "coffee"
	desc = "Осторожно: напиток, которым вы собираетесь насладиться, очень горячий."
	icon_state = "coffee"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	//foodtype = BREAKFAST

/obj/item/reagent_containers/cup/glass/coffee/vampire/robust
	name = "robust coffee"
	icon_state = "coffee-alt"

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire
	name = "beer"
	desc = "Пиво."
	icon_state = "beer"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/blue_stripe
	name = "blue stripe"
	desc = "Пиво Blue Stripe. Сварено для вас компанией \"Кинг Брюэрис\"!"
	icon_state = "beer_blue"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/light = 25, /datum/reagent/toxin/amatoxin = 5)

// DARKPACK TODO - (Typhon's Beer needs an audit of its handling. This looks ass.)
/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/typhon
	name = "Typhon's Beer"
	desc = "Напиток с кровью для ценителей с вампирскими вкусами."
	icon_state = "typhon"
	//foodtype = SANGUINE
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/typhon = 30)

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/typhon/attack(mob/living/M, mob/user, def_zone)
	. = ..()
	reagents.trans_to(M, gulp_size, transferred_by = user)

/datum/reagent/consumable/ethanol/beer/typhon
	name = "Typhon's Beer"
	description = "Хмельной напиток с привкусом крови, от которого до тошноты трудно оторваться."
	color = "#660000"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 50
	taste_description = "сладкой крови"
	//glass_name = "glass of sanquine beer"
	//glass_desc = "A freezing pint of vitae."

/datum/reagent/consumable/ethanol/beer/typhon/on_mob_life(mob/living/carbon/M)
	if(get_kindred_splat(M))
		M.adjust_blood_pool(0.25)
	if(get_ghoul_splat(M))
		M.adjust_blood_pool(1)
	return ..()

/obj/item/reagent_containers/cup/glass/vampirecola
	name = "two liter cola bottle"
	desc = "Кока-кола эспума..."
	icon_state = "colared"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/space_cola = 100)
	volume = 100
	age_restricted = FALSE
	custom_price = 2 // ECONOMY

/obj/item/reagent_containers/cup/glass/vampirecola/blue
	desc = "Pep Cola. Добавь бодрости в каждый шаг!"
	list_reagents = list(/datum/reagent/consumable/space_up = 100)
	icon_state = "colablue"

/obj/item/reagent_containers/cup/glass/vampirewater
	name = "water bottle"
	desc = "H2O."
	icon_state = "water1"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	isGlass = FALSE
	list_reagents = list(/datum/reagent/water = 50)
	age_restricted = FALSE
	custom_price = 2 // ECONOMY

/obj/item/reagent_containers/cup/soda_cans/vampirecola
	name = "cola"
	desc = "Кока-кола эспума..."
	icon_state = "colared2"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/space_cola = 30)

/obj/item/reagent_containers/cup/soda_cans/vampirecola/blue
	desc = "Pep Cola. Добавь бодрости в каждый шаг!"
	icon_state = "colablue2"
	list_reagents = list(/datum/reagent/consumable/space_up = 30)

/obj/item/reagent_containers/cup/soda_cans/vampiresoda
	name = "soda"
	desc = "Опять вода..."
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/sodawater = 30)

/obj/item/reagent_containers/cup/soda_cans/summer_thaw
	name = "summer thaw"
	desc = "Освежающий напиток. Произведено для вас компанией \"Кинг Брюэрис\"!"
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/space_cola = 20, /datum/reagent/medicine/muscle_stimulant = 5, /datum/reagent/toxin/amatoxin = 5)

/obj/item/reagent_containers/cup/soda_cans/thaw_club
	name = "thaw club soda"
	desc = "Заряд энергии на весь день. Произведено для вас компанией \"Кинг Брюэрис\"!"
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/monkey_energy = 30)

/obj/item/reagent_containers/condiment/milk
	name = "milk"
	desc = "Опять молоко..."
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 4 // ECONOMY

/obj/item/reagent_containers/condiment/milk/malk
	desc = "Пакет молока с рыбой на этикетке. Дочерний бренд корпорации Malk."

/obj/item/reagent_containers/cup/mixing_bowl
	name = "mixing bowl"
	desc = "Миска для замеса. Вмещает до 50 единиц. Незаменима на кухне."
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	icon_state = "mixingbowl"
	spillable = TRUE
	custom_materials = list(/datum/material/glass=500)
	custom_price = 10 // ECONOMY

// CRIMSON EDIT ADD START - Shop Inventories Additions
/obj/item/reagent_containers/cup/glass/mug/tea/jasmine
	name = "jasmine tea"
	desc = "Листовой жасминовый чай. Подаётся горячим в простой керамической кружке."
// CRIMSON EDIT ADD END - Shop Inventories Additions
