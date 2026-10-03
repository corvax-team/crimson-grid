// Cannabis
/obj/item/seeds/cannabis
	name = "cannabis seed pack"
	desc = "Облагается налогом."
	icon = 'modular_darkpack/modules/drugs/icons/items.dmi' // DARKPACK EDIT CHANGE - DRUGS
	icon_state = "seed-cannabis"
	plant_icon_offset = 7 // DARKPACK EDIT CHANGE - DRUGS
	species = "cannabis"
	plantname = "Конопля"
	product = /obj/item/food/grown/cannabis
	maturation = 8
	potency = 20
	growthstages = 3 // DARKPACK EDIT CHANGE - DRUGS
	instability = 40
	growing_icon = 'modular_darkpack/modules/drugs/icons/growing.dmi' // DARKPACK EDIT CHANGE - DRUGS
	icon_grow = "cannabis-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "cannabis-dead" // Same for the dead icon
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	/* // DARKPACK EDIT REMOVAL START - DRUGS
	mutatelist = list(
		/obj/item/seeds/cannabis/anti,
		/obj/item/seeds/cannabis/death,
		/obj/item/seeds/cannabis/rainbow,
		/obj/item/seeds/cannabis/ultimate,
		/obj/item/seeds/cannabis/white,
	)
	*/
	reagents_add = list(/datum/reagent/drug/cannabis = 0.15)


/obj/item/seeds/cannabis/rainbow
	name = "rainbow weed seed pack"
	desc = "Из этих семян вырастет радужная трава. Кайфово... и вызывает сильнейшее привыкание."
	// icon_state = "seed-megacannabis" // DARKPACK EDIT REMOVAL - DRUGS
	// icon_grow = "megacannabis-grow" // DARKPACK EDIT REMOVAL - DRUGS
	// species = "megacannabis" // DARKPACK EDIT REMOVAL - DRUGS
	plantname = "Радужная конопля"
	product = /obj/item/food/grown/cannabis/rainbow
	mutatelist = null
	// reagents_add = list(/datum/reagent/colorful_reagent = 0.05, /datum/reagent/medicine/psicodine = 0.03, /datum/reagent/drug/happiness = 0.1, /datum/reagent/toxin/mindbreaker = 0.1, /datum/reagent/toxin/lipolicide = 0.15, /datum/reagent/drug/space_drugs = 0.15) // DARKPACK EDIT REMOVAL - DRUGS
	rarity = 40

/obj/item/seeds/cannabis/death
	name = "deathweed seed pack"
	desc = "Из этих семян вырастет смерть-трава. Совсем не кайфово."
	// icon_state = "seed-blackcannabis" // DARKPACK EDIT REMOVAL - DRUGS
	// icon_grow = "blackcannabis-grow" // DARKPACK EDIT REMOVAL - DRUGS
	// species = "blackcannabis" // DARKPACK EDIT REMOVAL - DRUGS
	plantname = "Смерть-трава"
	product = /obj/item/food/grown/cannabis/death
	mutatelist = null
	// reagents_add = list(/datum/reagent/toxin/cyanide = 0.35, /datum/reagent/drug/cannabis = 0.15) // DARKPACK EDIT REMOVAL - DRUGS
	rarity = 40

/obj/item/seeds/cannabis/white
	name = "lifeweed seed pack"
	desc = "Жаждущему дам даром от источника жора живого."
	// icon_state = "seed-whitecannabis" // DARKPACK EDIT REMOVAL - DRUGS
	// icon_grow = "whitecannabis-grow" // DARKPACK EDIT REMOVAL - DRUGS
	// species = "whitecannabis" // DARKPACK EDIT REMOVAL - DRUGS
	plantname = "Жизнь-трава"
	instability = 30
	product = /obj/item/food/grown/cannabis/white
	mutatelist = null
	// reagents_add = list(/datum/reagent/medicine/omnizine = 0.35, /datum/reagent/drug/cannabis = 0.15) // DARKPACK EDIT REMOVAL - DRUGS
	rarity = 40


/obj/item/seeds/cannabis/ultimate
	name = "omega weed seed pack"
	desc = "Из этих семян вырастет омега-трава."
	// icon_state = "seed-ocannabis" // DARKPACK EDIT REMOVAL - DRUGS
	// plant_icon_offset = 1 // DARKPACK EDIT REMOVAL - DRUGS
	// icon_grow = "ocannabis-grow" // DARKPACK EDIT REMOVAL - DRUGS
	// species = "ocannabis" // DARKPACK EDIT REMOVAL - DRUGS
	plantname = "Омега-трава"
	product = /obj/item/food/grown/cannabis/ultimate
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/green, /datum/plant_gene/trait/modified_volume/omega_weed)
	mutatelist = null
	/* // DARKPACK EDIT REMOVAL - DRUGS
	reagents_add = list(/datum/reagent/drug/cannabis = 0.3,
		/datum/reagent/toxin/mindbreaker = 0.3,
		/datum/reagent/mercury = 0.15,
		/datum/reagent/lithium = 0.15,
		/datum/reagent/medicine/atropine = 0.15,
		/datum/reagent/drug/methamphetamine = 0.15,
		/datum/reagent/drug/bath_salts = 0.15,
		/datum/reagent/drug/krokodil = 0.15,
		/datum/reagent/toxin/lipolicide = 0.15,
		/datum/reagent/drug/nicotine = 0.1,
	)*/
	rarity = 69
	graft_gene = /datum/plant_gene/trait/glow/green

/obj/item/seeds/cannabis/anti
	name = "anti weed seed pack"
	desc = "Из этих семян вырастет антитрава."
	// icon_state = "seed-ocannabis" // DARKPACK EDIT REMOVAL - DRUGS
	// plant_icon_offset = 0 // DARKPACK EDIT REMOVAL - DRUGS
	// icon_grow = "ocannabis-grow" // DARKPACK EDIT REMOVAL - DRUGS
	// species = "ocannabis" // DARKPACK EDIT REMOVAL - DRUGS
	plantname = "Антитрава"
	product = /obj/item/food/grown/cannabis/anti
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/shadow)
	mutatelist = null
	// reagents_add = list(/datum/reagent/medicine/naloxone = 0.3, /datum/reagent/medicine/antihol = 0.2, /datum/reagent/medicine/synaphydramine = 0.1) // DARKPACK EDIT REMOVAL - DRUGS
	rarity = 40
	instability = 0

/obj/item/seeds/cannabis/anti/Initialize(mapload, nogenes)
	. = ..()
	add_atom_colour(COLOR_MATRIX_INVERT, FIXED_COLOUR_PRIORITY)
	transform = transform.Turn(180)

/obj/item/seeds/cannabis/anti/get_tray_overlay(age, status)
	var/mutable_appearance/plant = ..()
	plant.color = COLOR_MATRIX_INVERT
	return plant

// ---------------------------------------------------------------

/obj/item/food/grown/cannabis
	seed = /obj/item/seeds/cannabis
	icon = 'modular_darkpack/modules/drugs/icons/items.dmi' // DARKPACK EDIT CHANGE - DRUGS
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/drugs/icons/onfloor.dmi')// DARKPACK EDIT ADD - DRUGS
	name = "cannabis leaf"
	desc = "Говорят, в следующем году её попробуют легализовать." // DARKPACK EDIT CHANGE
	icon_state = "cannabis"
	bite_consumption_mod = 4
	foodtypes = VEGETABLES //i dont really know what else weed could be to be honest
	tastes = list("cannabis" = 1)
	wine_power = 20

// DARKPACK EDIT ADD START
/obj/item/food/grown/cannabis/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	AddComponent(/datum/component/selling, 100, "weed", TRUE, -1, 7)
	//In 2015 Cannabis was only legally distributed in California by medical dispensary. https://web.archive.org/web/20161109220853/http://www.times-standard.com/article/NJ/20161107/NEWS/161109826
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)
// DARKPACK EDIT ADD END

/obj/item/food/grown/cannabis/rainbow
	seed = /obj/item/seeds/cannabis/rainbow
	name = "rainbow cannabis leaf"
	desc = "Оно и должно так светиться?.."
	// icon_state = "megacannabis" // DARKPACK EDIT REMOVAL - DRUGS
	wine_power = 60

/obj/item/food/grown/cannabis/death
	seed = /obj/item/seeds/cannabis/death
	name = "death cannabis leaf"
	desc = "Темноват на вид. Ну да ладно."
	// icon_state = "blackcannabis" // DARKPACK EDIT REMOVAL - DRUGS
	wine_power = 40

/obj/item/food/grown/cannabis/white
	seed = /obj/item/seeds/cannabis/white
	name = "white cannabis leaf"
	desc = "Гладкий и приятный на ощупь."
	// icon_state = "whitecannabis" // DARKPACK EDIT REMOVAL - DRUGS
	wine_power = 10

/obj/item/food/grown/cannabis/ultimate
	seed = /obj/item/seeds/cannabis/ultimate
	name = "omega cannabis leaf"
	desc = "От одного взгляда на него кружится голова. Какого хрена?"
	// icon_state = "ocannabis" // DARKPACK EDIT REMOVAL - DRUGS
	bite_consumption_mod = 2 // Ingesting like 40 units of drugs in 1 bite at 100 potency
	wine_power = 90

/obj/item/food/grown/cannabis/anti
	seed = /obj/item/seeds/cannabis/anti
	name = "anti cannabis leaf"
	desc = "От одного взгляда на него вам становится нормально. Какого хрена?"
	// icon_state = "ocannabis" // DARKPACK EDIT REMOVAL - DRUGS

/obj/item/food/grown/cannabis/anti/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	add_atom_colour(COLOR_MATRIX_INVERT, FIXED_COLOUR_PRIORITY)
	transform = transform.Turn(180)
	if(prob(0.05))
		name = "evil cannabis leaf"
