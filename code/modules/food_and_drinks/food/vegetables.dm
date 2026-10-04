/obj/item/food/eggplantparm
	name = "eggplant parmigiana"
	desc = "The only good recipe for eggplant."
	icon_state = "eggplantparm"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("баклажана" = 3, "сыра" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/yakiimo
	name = "yaki imo"
	desc = "Made with roasted sweet potatoes!"
	icon_state = "yakiimo"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("батата" = 1)
	foodtypes = VEGETABLES | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/roastparsnip
	name = "roast parsnip"
	desc = "Sweet and crunchy."
	icon_state = "roastparsnip"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("пастернака" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

// Potatoes
/obj/item/food/tatortot
	name = "tator tot"
	desc = "A large fried potato nugget that may or may not try to valid you."
	icon_state = "tatortot"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("картошки" = 3, "лёгкой добычи" = 1)
	foodtypes = FRIED | VEGETABLES
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/tatortot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/mashed_potatoes
	name = "mashed potatoes"
	desc = "A creamy serving of mashed potatoes, a staple of many Thanksgiving dinners."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "mashed_potatoes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("creamy mashed potatoes" = 1, "чеснока" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/baked_potato
	name = "baked potato"
	desc = "A piping hot potato baked in an oven. A bit bland by itself."
	icon_state = "baked_potato"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("печёной картошки" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/buttered_baked_potato
	name = "buttered baked potato"
	desc = "A piping hot baked potato, now with a slice of butter mixed in. Perfection."
	icon_state = "buttered_baked_potato"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("печёной картошки" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/loaded_baked_potato
	name = "loaded baked potato"
	desc = "A piping hot baked potato, with the insides scooped out and mixed with bacon bits, cheese, and cabbage."
	icon_state = "loaded_baked_potato"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/nutriment/protein = 4)
	tastes = list("печёной картошки" = 1, "бекона" = 1, "сыра" = 1, "капусты" = 1)
	foodtypes = VEGETABLES | DAIRY | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Fries
/obj/item/food/fries
	name = "french fries" // DARKPACK EDIT CHANGE
	desc = "Она же \"картошка свободы\" и всё такое." // DARKPACK EDIT CHANGE
	icon_state = "fries"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("картошки фри" = 3, "соли" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/fries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/cheesyfries
	name = "cheesy fries"
	desc = "Fries. Covered in cheese. Duh."
	icon_state = "cheesyfries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("картошки фри" = 3, "сыра" = 1)
	foodtypes = VEGETABLES|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cheesyfries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/carrotfries
	name = "carrot fries"
	desc = "Tasty fries from fresh carrots."
	icon_state = "carrotfries"

	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("моркови" = 3, "соли" = 1)
	foodtypes = VEGETABLES|FRIED
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/carrotfries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/poutine
	name = "poutine"
	desc = "Fries covered in cheese curds and gravy."
	icon_state = "poutine"
	food_reagents = list(/datum/reagent/consumable/nutriment = 7)
	tastes = list("картошки" = 3, "подливки" = 1, "squeaky cheese" = 1)
	foodtypes = VEGETABLES|DAIRY|FRIED|MEAT
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/poutine/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/sauteed_eggplant
	name = "sauteed eggplant"
	desc = "Thick-cut slices of eggplant sauteed in oil and minced garlic, creating a soft, crispy, healthy snack."
	icon_state = "sauteed_eggplant"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fried eggplant" = 4, "чеснока" = 2, "оливкового масла" = 3)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/baba_ghanoush
	name = "baba ghanoush"
	desc = "A thick dip made from mashed eggplant, olive oil, garlic, and lemon juice with some pita bread for dipping. You'll either love it or hate it."
	icon_state = "baba_ghanoush"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("mashed eggplant" = 5, "питы" = 4, "чеснока" = 3, "оливкового масла" = 4, "lemon juice" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/falafel
	name = "falafel"
	desc = "Beans, herbs, onions, and garlic mashed together and formed into a ball, then deep-fried. The herbs give the interior a unique green color."
	icon_state = "falafel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fava beans" = 5, "чеснока" = 3, "лука" = 2, "fresh herbs" = 4)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
