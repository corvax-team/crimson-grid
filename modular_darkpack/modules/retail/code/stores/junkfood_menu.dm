// Use /obj/structure/retail/gas_station unless you really only want junkfood
/obj/structure/retail/junkfood_menu
	desc = "Снеки, газировка и прочая дрянь."
	products_list = list(
		new /datum/data/vending_product("Шоколадный батончик", /obj/item/food/chocolatebar),
		new /datum/data/vending_product("Чипсы", /obj/item/food/chips),
		new /datum/data/vending_product("Бутылка воды", /obj/item/reagent_containers/cup/glass/vampirewater),
		new /datum/data/vending_product("Банка содовой", /obj/item/reagent_containers/cup/soda_cans/vampiresoda),
		new /datum/data/vending_product("Двухлитровая бутылка колы", /obj/item/reagent_containers/cup/glass/vampirecola),
		new /datum/data/vending_product("Банка колы", /obj/item/reagent_containers/cup/soda_cans/vampirecola),
		new /datum/data/vending_product("Газировка Summer Thaw", /obj/item/reagent_containers/cup/soda_cans/summer_thaw),
		new /datum/data/vending_product("Молоко", /obj/item/reagent_containers/condiment/milk),
		new /datum/data/vending_product("Бутылка пива", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire),
		new /datum/data/vending_product("Пиво Blue Stripe", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire/blue_stripe),
		new /datum/data/vending_product("Упаковка свечей", /obj/item/storage/fancy/candle_box),
		new /datum/data/vending_product("Набор от ушибов", /obj/item/stack/medical/bruise_pack),
		new /datum/data/vending_product("Респиратор", /obj/item/clothing/mask/gas/vampire)
	)
