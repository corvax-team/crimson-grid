/obj/structure/retail/general
	desc = "Хозяйственный магазин: всего понемногу на все случаи жизни."
	products_list = list(
		new /datum/data/vending_product("Влажная тряпка", /obj/item/rag),
		new /datum/data/vending_product("Аудиокассеты", /obj/item/tape),
		new /datum/data/vending_product("Фонарик", /obj/item/flashlight),
		new /datum/data/vending_product("Швабра", /obj/item/mop),
		new /datum/data/vending_product("Пластиковое ведро", /obj/item/reagent_containers/cup/bucket),
		new /datum/data/vending_product("Щётка для пола", /obj/item/pushbroom),
		new /datum/data/vending_product("Мусорные пакеты", /obj/item/storage/bag/trash),
		new /datum/data/vending_product("Отвёртка", /obj/item/screwdriver),
		new /datum/data/vending_product("Монтировка", /obj/item/crowbar),
		new /datum/data/vending_product("Гаечный ключ", /obj/item/wrench),
		new /datum/data/vending_product("Кусачки", /obj/item/wirecutters),
		new /datum/data/vending_product("Ручной сварочный аппарат", /obj/item/weldingtool),
		new /datum/data/vending_product("Картридж с тонером", /obj/item/toner/large),
		new /datum/data/vending_product("Строительная каска", /obj/item/clothing/head/vampire/hardhat),
		new /datum/data/vending_product("Бритва", /obj/item/razor),
		new /datum/data/vending_product("Диктофон", /obj/item/taperecorder),
		new /datum/data/vending_product("Бейсбольная бита", /obj/item/melee/baseball_bat/vamp),
		new /datum/data/vending_product("Мобильник с предоплатой", /obj/item/smartphone),
		new /datum/data/vending_product("Коробка лампочек", /obj/item/storage/box/lights/mixed, 100), // price is different between hardware and general store
		new /datum/data/vending_product("Диэлектрические перчатки", /obj/item/clothing/gloves/color/yellow),
// CRIMSON EDIT ADD START - Shop Inventories Additions
		new /datum/data/vending_product("Набор от ушибов", /obj/item/stack/medical/bruise_pack),
		new /datum/data/vending_product("Уголь", /obj/item/stack/sheet/mineral/coal, 10),
		new /datum/data/vending_product("Ткань", /obj/item/stack/sheet/cloth, 5),
		new /datum/data/vending_product("Набор для ремонта двери", /obj/item/door_repair_kit, 300),
		new /datum/data/vending_product("Доска", /obj/item/stack/sheet/mineral/wood, 10),
		new /datum/data/vending_product("Лист железа", /obj/item/stack/sheet/iron, 10),
		new /datum/data/vending_product("Лист стекла", /obj/item/stack/sheet/glass, 10),
		new /datum/data/vending_product("Лист пластика", /obj/item/stack/sheet/plastic, 10),
		new /datum/data/vending_product("Лист картона", /obj/item/stack/sheet/cardboard, 10),
		new /datum/data/vending_product("Железные прутья", /obj/item/stack/rods/ten, 30),
		new /datum/data/vending_product("Моток кабеля", /obj/item/stack/cable_coil/thirty, 30),
		new /datum/data/vending_product("Городская рация", /obj/item/radio, 25),
// CRIMSON EDIT ADD END - Shop Inventories Additions
	)
