// Use /obj/structure/retail/gas_station unless you really only want smokes
/obj/structure/retail/smoke_menu
	products_list = list(
		new /datum/data/vending_product("Malboro", /obj/item/storage/fancy/cigarettes/cigpack_robust, 50),
		new /datum/data/vending_product("Malboro Gold", /obj/item/storage/fancy/cigarettes/cigpack_robustgold),
		new /datum/data/vending_product("Newport", /obj/item/storage/fancy/cigarettes/cigpack_xeno, 30),
		new /datum/data/vending_product("Camel", /obj/item/storage/fancy/cigarettes/dromedaryco, 30),
		new /datum/data/vending_product("Футляр премиальных сигар", /obj/item/storage/fancy/cigarettes/cigars),
		new /datum/data/vending_product("Футляр премиальных сигар Cohiba Robusto", /obj/item/storage/fancy/cigarettes/cigars/cohiba),
		new /datum/data/vending_product("Футляр премиальных гаванских сигар", /obj/item/storage/fancy/cigarettes/cigars/havana),
		new /datum/data/vending_product("Бумага для самокруток", /obj/item/rollingpaper, 10),
		// CRIMSON EDIT ADD START - vapes!! why cant i buy vapes from the smoke store?!!
		new /datum/data/vending_product("Вейп", /obj/item/vape, 150),
		new /datum/data/vending_product("Красный вейп", /obj/item/vape/red, 170), // special colors are gonna cost ya more
		new /datum/data/vending_product("Синий вейп", /obj/item/vape/blue, 170),
		new /datum/data/vending_product("Фиолетовый вейп", /obj/item/vape/purple, 170),
		new /datum/data/vending_product("Зелёный вейп", /obj/item/vape/green, 170),
		new /datum/data/vending_product("Жёлтый вейп", /obj/item/vape/yellow, 170),
		new /datum/data/vending_product("Оранжевый вейп", /obj/item/vape/orange, 170), // Ja- ORANGE!
		new /datum/data/vending_product("Чёрный вейп", /obj/item/vape/black, 170),
		new /datum/data/vending_product("Белый вейп", /obj/item/vape/white, 170),
		// CRIMSON EDIT ADD END
		new /datum/data/vending_product("\"Ваза\"", /obj/item/bong, 50),
		new /datum/data/vending_product("Зажигалка Zippo", /obj/item/lighter, 20),
		new /datum/data/vending_product("Зажигалка", /obj/item/lighter/greyscale, 10),
		new /datum/data/vending_product("Спичечный коробок",/obj/item/storage/box/matches),
		new /datum/data/vending_product("Пепельница",/obj/item/storage/ashtray),
	)
