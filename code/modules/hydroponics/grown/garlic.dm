/obj/item/seeds/garlic
	name = "garlic seed pack"
	desc = "Пакетик невероятно пахучих семян."
	icon_state = "seed-garlic"
	species = "garlic"
	plantname = "Garlic Sprouts"
	product = /obj/item/food/grown/garlic
	yield = 6
	potency = 25
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/garlic = 0.15, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/garlic
	seed = /obj/item/seeds/garlic
	name = "garlic"
	desc = "Вкусно, но запах может сбить с ног."
	icon_state = "garlic"
	tastes = list("чеснока" = 1)
	wine_power = 10
	foodtypes = VEGETABLES
