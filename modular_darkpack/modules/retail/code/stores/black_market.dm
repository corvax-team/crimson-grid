// DARKPACK TODO: you should not be able to use credit here. -Fallcon
/obj/structure/retail/black_market
	products_list = list(
		new /datum/data/vending_product("Зажигалка", /obj/item/lighter/greyscale, 10),
		new /datum/data/vending_product("Бумага для самокруток", /obj/item/rollingpaper, 10), // CRIMSON EDIT ADD - Shop Inventories Additions
		new /datum/data/vending_product("Зажигалка Zippo", /obj/item/lighter, 20),
		new /datum/data/vending_product("Лейка", /obj/item/reagent_containers/cup/watering_can/metal, 20),
		new /datum/data/vending_product("Семена конопли", /obj/item/seeds/cannabis, 20),
		new /datum/data/vending_product("Косяк", /obj/item/cigarette/rollie/cannabis, 40), // CRIMSON EDIT - Shop Inventories Additions - Original: "cannabis puff"
		new /datum/data/vending_product("Бонг", /obj/item/bong, 50),
		new /datum/data/vending_product("Отмычка", /obj/item/vamp/keys/hack, 50),
		new /datum/data/vending_product("Баночка с ЛСД", /obj/item/storage/pill_bottle/lsd, 50),
		new /datum/data/vending_product("Нож", /obj/item/knife/vamp, 85),
		new /datum/data/vending_product("Выкидной нож", /obj/item/switchblade/vamp, 85),
		new /datum/data/vending_product("Кастет", /obj/item/clothing/gloves/vampire/brassknuckles, 100),
		new /datum/data/vending_product("Кол", /obj/item/vampire_stake, 100),
		new /datum/data/vending_product("Спортивная сумка", /obj/item/storage/backpack/duffelbag,	100), // CRIMSON EDIT ADD - Adds Duffelbags to Black Market
		new /datum/data/vending_product("Сумка с хирургическим набором", /obj/item/storage/backpack/duffelbag/sec/surgery, 100),
		new /datum/data/vending_product("Наручники", /obj/item/restraints/handcuffs, 50),
		new /datum/data/vending_product("Чёрный мешок на голову", /obj/item/clothing/head/vampire/blackbag, 50),
		new /datum/data/vending_product("Короткоствольный револьвер", /obj/item/gun/ballistic/revolver/darkpack/snub, 100),
		new /datum/data/vending_product("Пистолет-пулемёт Braddock .45", /obj/item/gun/ballistic/automatic/darkpack/mac10, 1200),
		new /datum/data/vending_product("Магазин для Braddock .45", /obj/item/ammo_box/magazine/darkpack45smg, 300), // CRIMSON EDIT ADD - Braddock Mags Buyable
		new /datum/data/vending_product("Обрез Remington 11-87", /obj/item/gun/ballistic/shotgun/vamp_remington/sawnoff, 1600),
		new /datum/data/vending_product("Глушитель из масляного фильтра для 11-87", /obj/item/suppressor/darkpack_oil, 400),
		new /datum/data/vending_product("Пакет травы", /obj/item/food/grown/cannabis, 700),
		new /datum/data/vending_product("Шприц с морфином", /obj/item/reagent_containers/syringe/contraband/morphine, 800),
		new /datum/data/vending_product("Пакет мета", /obj/item/reagent_containers/cup/glass/baggie/meth, 800),
		new /datum/data/vending_product("Пакет кокаина", /obj/item/reagent_containers/cup/glass/baggie/meth/cocaine, 800),
// CRIMSON EDIT ADD START - Medkit to Pharmacy
		new /datum/data/vending_product("Компактная аптечка", /obj/item/storage/medkit/tactical_lite, 1125),
		new /datum/data/vending_product("Хирургический набор коронера", /obj/item/storage/medkit/coroner, 750),
// CRIMSON EDIT ADD END - Medkit to Pharmacy
		new /datum/data/vending_product("Серебряные патроны 9 мм", /obj/item/ammo_box/darkpack/c9mm/silver, 5000),
		new /datum/data/vending_product("Серебряные патроны .45 ACP", /obj/item/ammo_box/darkpack/c45acp/silver, 6000),
		new /datum/data/vending_product("Серебряные патроны .44", /obj/item/ammo_box/darkpack/c44/silver, 7000),
		new /datum/data/vending_product("Серебряные патроны 5.56", /obj/item/ammo_box/darkpack/c556/silver, 8000),
		new /datum/data/vending_product("Зажигательные патроны 5.56", /obj/item/ammo_box/darkpack/c556/incendiary, 9000)
	)
