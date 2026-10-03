// For items that exist in stores already, my current plan is a bulk order of 5-10 items with a 20% discount.
// This means the supply has to peddle off spare goods.
/datum/supply_pack/local
	group = "Местный склад"

/datum/supply_pack/local/vegetable_supplies //behold, ordering legal things.
	name = "Набор овощных семян для общественного сада" //aimed at helping the poorest members of community.
	desc = "Подборка семян для общественных и личных огородов. Оптом дешевле. Ящики для рассады не входят."
	cost = 150
	contains = list(
		/obj/item/seeds/cabbage = 2,
		/obj/item/seeds/carrot = 2,
		/obj/item/seeds/corn = 2,
		/obj/item/seeds/onion = 2,
		/obj/item/seeds/carrot/parsnip = 2,
		/obj/item/seeds/peas = 2,
		/obj/item/seeds/potato = 2,
		/obj/item/seeds/pumpkin = 2,
		/obj/item/seeds/soya = 2,
		/obj/item/seeds/tomato = 2,
		/obj/item/seeds/apple = 2,
		/obj/item/seeds/wheat/rice = 2,
		/obj/item/seeds/wheat/oat = 2,
		/obj/item/seeds/aloe = 2,
	)
	crate_name = "ящик с овощными семенами"

/datum/supply_pack/local/flower_supplies
	name = "Набор цветочных семян для общественного сада" //verified as local, non-invasive from https://calscape.org/ & https://plants.usda.gov/
	desc = "Подборка семян цветов. Ящики для рассады не входят."
	cost = 150
	contains = list(
		/obj/item/seeds/poppy = 3,
		/obj/item/seeds/sunflower = 3,
		/obj/item/seeds/poppy/geranium = 3,
		/obj/item/seeds/poppy/lily = 3,
		// /obj/item/seeds/forgetmenot = 3,
	)
	crate_name = "ящик с цветочными семенами"

/*
/datum/supply_pack/local/hydro_tray
	name = "Hydroponics Tray"
	desc = "Everything you need to start your own hydroponics setup."
	cost = 1000
	contains = list(/obj/machinery/hydroponics/constructable)
	crate_name = "hydro crate"
*/

/datum/supply_pack/local/weed_tray
	name = "Пластиковый ящик для рассады"
	desc = "Ящик для выращивания растений."
	cost = 300
	contains = list(/obj/machinery/hydroponics/simple/plastic/unanchored)
	crate_name = "ящик с лотком для рассады"

/datum/supply_pack/local/hydro_supplies
	name = "Набор садового инвентаря"
	desc = "Всё, что нужно, чтобы выращивать растения дома."
	cost = 400
	contains = list(
		/obj/item/secateurs,
		/obj/item/cultivator/rake,
		/obj/item/cultivator,
		/obj/item/reagent_containers/spray/weedspray,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/shovel/spade,
		/obj/item/storage/bag/plants,
		/obj/item/reagent_containers/cup/bucket/wooden,
	)
	crate_name = "ящик садовода"

/datum/supply_pack/local/hydro_adv_supplies
	name = "Улучшенное удобрение"
	desc = "Особая смесь удобрений для тех, кто относится к домашнему садоводству всерьёз."
	cost = 500
	contains = list(
		/obj/item/reagent_containers/cup/bottle/nutrient/rh = 5,
		)
	crate_name = "ящик садовода"


/datum/supply_pack/local/weed_supplies
	name = "Всё для травки"
	desc = "Лейка и немного семян. Ящики для рассады не входят."
	cost = 100
	contains = list(
		/obj/item/reagent_containers/cup/watering_can/metal,
		/obj/item/seeds/cannabis = 5,
	)
	crate_name = "ящик садовода"

/* Does nothing atm
/datum/supply_pack/local/methlab
	name = "Lab Equipment"
	desc = "Contains lab equipment."
	cost = 4000
	contains = list(/obj/structure/methlab/movable)
*/

/datum/supply_pack/local/fixing
	name = "Ремкомплект (кусачки, лампочки)"
	desc = "Кусачки, лампочки и всё прочее, чтобы вернуть в округу свет."
	cost = 100
	contains = list(/obj/item/wirecutters, /obj/item/storage/box/lights/mixed)

/*
/datum/supply_pack/local/window_kit
	name = "Window Repair Kit"
	desc = "Contains a window repair kit, good for 10 window replacements."
	cost = 250
	contains = list(/obj/item/window_repair_kit)
*/

/datum/supply_pack/local/door_kit
	name = "Набор для ремонта двери"
	desc = "Набор, с которым можно заменить выбитую дверь."
	cost = 200 // CRIMSON EDIT - Shop Inventories Additions - Original: cost = 1000
	contains = list(/obj/item/door_repair_kit)

/datum/supply_pack/local/medicalsupplies
	name = "Медикаменты"
	desc = "Кое-что для первой помощи."
	cost = 500
	contains = list(
		/obj/item/stack/medical/wrap/gauze = 4,
		/obj/item/stack/medical/bruise_pack = 4,
		/obj/item/stack/medical/suture = 4,
		/obj/item/stack/medical/ointment = 4
	)

/datum/supply_pack/local/cuffs
	name = "Коробки наручников"
	desc = "Несколько коробок наручников."
	cost = 400
	contains = list(/obj/item/storage/box/handcuffs = 4)
	crate_name = "ящик с наручниками"

/datum/supply_pack/local/potassiodide
	name = "Йодид калия"
	desc = "Баночки с йодидом калия."
	cost = /obj/item/storage/pill_bottle/potassiodide::custom_price * 4
	contains = list(/obj/item/storage/pill_bottle/potassiodide = 5)

/datum/supply_pack/local/ephedrine
	name = "Эфедрин"
	desc = "Баночки с эфедрином."
	cost = /obj/item/storage/pill_bottle/ephedrine::custom_price * 4
	contains = list(/obj/item/storage/pill_bottle/ephedrine = 5)

/datum/supply_pack/local/gas_can
	name = "Канистры бензина"
	desc = "Канистры с бензином."
	cost = /obj/item/gas_can/full::custom_price * 4
	contains = list(/obj/item/gas_can/full = 5)

/datum/supply_pack/local/thermal_drill
	name = "Термобур"
	desc = "Термобур, одна штука."
	cost = 4000
	contains = list(/obj/structure/drill)
	crate_name = "ящик с термобуром"

/datum/supply_pack/medical/organs
	name = "Органы (добыты этично)"
	desc = "Ящик человеческих органов. \"Этично\" - это фамилия нашего хирурга. Скажите ему спасибо!"
	cost = 7500
	crate_type = /obj/structure/closet/crate/freezer
	crate_name = "морозильник с органами"
	contains = list(
		/obj/item/organ/heart,
		/obj/item/organ/lungs,
		/obj/item/organ/eyes,
		/obj/item/organ/ears,
		/obj/item/organ/tongue,
		/obj/item/organ/liver,
		/obj/item/organ/stomach,
		/obj/item/organ/appendix)

/datum/supply_pack/medical/organs/multi
	name = "Оптовый набор органов (добыты этично)"
	desc = "Ящик, под завязку набитый человеческими органами. \"Этично\" - это фамилия нашего хирурга. Скажите ему спасибо!"
	cost = 29500
	contains = list(
		/obj/item/organ/heart = 4,
		/obj/item/organ/lungs = 4,
		/obj/item/organ/eyes = 4,
		/obj/item/organ/ears = 4,
		/obj/item/organ/tongue = 4,
		/obj/item/organ/liver = 4,
		/obj/item/organ/stomach = 4,
		/obj/item/organ/appendix = 4)
