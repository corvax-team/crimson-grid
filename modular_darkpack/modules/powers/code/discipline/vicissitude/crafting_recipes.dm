/datum/crafting_recipe/tzi_trench
	name = "Плащ из кожи и костей (броня)"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 50, /obj/item/spine = 1)
	result = /obj/item/clothing/suit/vampire/trench/tzi
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_heavyarmor // Requires 5 mulched humans and 3 blood points of vitae
	name = "Костяной доспех (кираса)"
	desc = "Царственная кираса из плоти и кости. Рецепт древний, и в наши ночи к нему прибегают редко: слишком уж непомерна цена. Зато защищает она превосходно. Требуется Преображение 3."
	time = 15 SECONDS
	reqs = list(/obj/item/stack/sheet/meat = 100, /obj/item/spine = 5, /datum/reagent/blood/vitae = 200, /datum/reagent/blood = 500)
	structures = list(/obj/structure/table)
	result = /obj/item/clothing/suit/vampire/bogatyr/heavy
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_SKIP_MATERIALS_PARITY // Maybe we fix this one day when our items are more sane

/datum/crafting_recipe/tzi_heavyarmor/helmet
	name = "Костяной доспех (шлем)"
	desc = "Царственный крылатый шлем из плоти и кости. Рецепт древний, и в наши ночи к нему прибегают редко: слишком высока цена. Зато защищает он превосходно. Требуется Преображение 3."
	time = 10 SECONDS
	reqs = list(/obj/item/stack/sheet/meat = 40, /obj/item/spine = 2, /datum/reagent/blood/vitae = 100, /datum/reagent/blood = 200)
	result = /obj/item/clothing/head/vampire/bogatyr/heavy

/datum/crafting_recipe/tzi_heavyarmor/check_requirements(mob/user, list/collected_requirements)
	var/mob/living/living_user = astype(user)
	var/datum/discipline/disc = living_user?.get_discipline(/datum/discipline/vicissitude)
	if(disc.level >= 3)
		return TRUE
	else
		return FALSE

/datum/crafting_recipe/tzi_upgrade_armor
	name = "Костяной доспех (улучшение)"
	desc = "Царственный золотой доспех, укреплённый Искусством тканей."
	time = 5 SECONDS
	reqs = list(/obj/item/clothing/suit/vampire/bogatyr/heavy = 1, /obj/item/clothing/suit/vampire/bogatyr/captain = 1)
	result = /obj/item/clothing/suit/vampire/bogatyr/captain/heavy
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_upgrade_armor/helmet
	name = "Костяной шлем (улучшение)"
	desc = "Царственный золотой шлем, укреплённый Искусством тканей."
	reqs = list(/obj/item/clothing/head/vampire/bogatyr/heavy = 1, /obj/item/clothing/head/vampire/bogatyr/captain = 1)
	result = /obj/item/clothing/head/vampire/bogatyr/captain/heavy

/datum/crafting_recipe/tzi_heart
	name = "Второе сердце (против оглушения)"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 25, /obj/item/organ/heart = 1)
	result = /obj/item/organ/cyberimp/brain/anti_stun/tzi
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_eyes
	name = "Улучшенные глаза (ночное зрение)"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 15, /obj/item/organ/eyes = 1)
	result = /obj/item/organ/eyes/night_vision/tzimisce
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_implant
	name = "Живой вживитель"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 10, /obj/item/knife/vamp = 1, /obj/item/reagent_containers/blood = 1)
	result = /obj/item/autosurgeon/vicissitude
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzicreature
	name = "Жалкая тварь"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 10, /obj/item/organ/brain = 1)
	result = /obj/item/toy/plush/tzi
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_floor
	name = "Пол из кишок"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 1, /obj/item/guts = 1)
	result = /obj/effect/decal/gut_floor
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_ON_SOLID_GROUND|CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzi_wall
	name = "Стена плоти"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 2)
	result = /obj/structure/fleshwall
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzijelly
	name = "Живой мясной узел"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 20, /obj/item/guts = 1, /obj/item/toy/plush/tzi = 1)
	result = /obj/structure/tzijelly
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzi_stool
	name = "Табурет из рук"
	time = 50
	reqs = list(/obj/item/stack/sheet/meat = 5, /obj/item/bodypart/arm/right = 2, /obj/item/bodypart/arm/left = 2)
	result = /obj/structure/chair/old/tzimisce
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_biter
	name = "Кусачее отродье"
	time = 100
	reqs = list(/obj/item/stack/sheet/meat = 2, /obj/item/bodypart/arm/right = 2, /obj/item/bodypart/arm/left = 2, /obj/item/spine = 1)
	result = /mob/living/basic/szlachta
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_fister
	name = "Отродье-кулачник"
	time = 100
	reqs = list(/obj/item/stack/sheet/meat = 5, /obj/item/bodypart/arm/right = 1, /obj/item/bodypart/arm/left = 1, /obj/item/spine = 1, /obj/item/guts = 1)
	result = /mob/living/basic/szlachta/fister
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY

/datum/crafting_recipe/tzi_tanker
	name = "Тучное отродье"
	time = 100
	reqs = list(/obj/item/stack/sheet/meat = 10, /obj/item/bodypart/arm/right = 1, /obj/item/bodypart/arm/left = 1, /obj/item/bodypart/leg/right = 1, /obj/item/bodypart/leg/left = 1, /obj/item/spine = 1, /obj/item/guts = 2)
	result = /mob/living/basic/szlachta/tanker
	category = CAT_TZIMISCE
	crafting_flags = CRAFT_CHECK_DENSITY
