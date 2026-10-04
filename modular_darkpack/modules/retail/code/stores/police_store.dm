/obj/structure/retail/police_equipment
	product_types = list(
		/obj/item/clothing/under/vampire/police,
		/obj/item/clothing/under/vampire/police/long,
		/obj/item/clothing/under/vampire/police/turtleneck,
		/obj/item/clothing/under/vampire/police/pants,
		/obj/item/clothing/under/vampire/police/utility,
		/obj/item/clothing/gloves/tackler/combat/insulated,
		/obj/item/clothing/head/vampire/police,
		/obj/item/clothing/head/vampire/helmet,
		/obj/item/clothing/suit/vampire/vest/police,
		/obj/item/clothing/suit/vampire/coat/police,
		/obj/item/storage/belt/holster/detective/darkpack,
		/obj/item/storage/belt/security/police,
		/obj/item/camera/detective,
		/obj/item/taperecorder,
		/obj/item/toy/crayon/white,
		/obj/item/storage/box/evidence,
		/obj/item/flashlight/seclite,
		/obj/item/detective_scanner/darkpack,
		/obj/item/storage/box/bodybags,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/medkit/darkpack/ifak,
		/obj/item/radio/headset/darkpack/police,
		/obj/item/melee/baton/security/handtaser,
		/obj/item/gun/energy/taser/darkpack,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/melee/baton/vamp,
		/obj/item/holosign_creator/police_tape,
	)
	products_list = list(
		new /datum/data/vending_product("Бинокль", /obj/item/binoculars, 20),
		new /datum/data/vending_product("Перцовый баллончик", /obj/item/reagent_containers/spray/pepper, 20),

		//Sidearms
		new /datum/data/vending_product("Glock 19", /obj/item/gun/ballistic/automatic/pistol/darkpack/glock19, 50),
		new /datum/data/vending_product("Магазин для Glock, 9 мм", /obj/item/ammo_box/magazine/glock9mm, 10),

		//Long guns
		new /datum/data/vending_product("Помповый дробовик", /obj/item/gun/ballistic/shotgun/vampire, 200),
		new /datum/data/vending_product("MP5", /obj/item/gun/ballistic/automatic/darkpack/mp5, 200),
		new /datum/data/vending_product("Магазин для MP5", /obj/item/ammo_box/magazine/darkpack9mp5, 20),
		new /datum/data/vending_product("MP7", /obj/item/gun/ballistic/automatic/darkpack/mp7, 200),
		new /datum/data/vending_product("Увеличенный магазин для MP7", /obj/item/ammo_box/magazine/darkpack/c46pdw/ext, 20),
		new /datum/data/vending_product("AR-15", /obj/item/gun/ballistic/automatic/darkpack/ar15, 200),
		new /datum/data/vending_product("Магазин 5.56", /obj/item/ammo_box/magazine/darkpack556, 20),
		new /datum/data/vending_product("Автоматический дробовик", /obj/item/gun/ballistic/automatic/darkpack/autoshotgun, 200),
		new /datum/data/vending_product("Магазин для автоматического дробовика", /obj/item/ammo_box/magazine/darkpackautoshot, 20),
		new /datum/data/vending_product("Самозарядная снайперская винтовка", /obj/item/gun/ballistic/automatic/darkpack/autosniper, 200),
		new /datum/data/vending_product("Магазин для PSG1, 7.62", /obj/item/ammo_box/magazine/vamp762x51PSG1, 20),
		new /datum/data/vending_product("Снайперская винтовка", /obj/item/gun/ballistic/automatic/darkpack/sniper, 200),

		//Ammo
		new /datum/data/vending_product("Коробка патронов .50", /obj/item/ammo_box/darkpack/c50, 80),
		new /datum/data/vending_product("Коробка патронов 7.62x51 мм", /obj/item/ammo_box/darkpack/c762x51mm, 80),
		new /datum/data/vending_product("Коробка патронов 12-го калибра", /obj/item/ammo_box/darkpack/c12g, 80),
		new /datum/data/vending_product("Коробка картечи 12-го калибра", /obj/item/ammo_box/darkpack/c12g/buck, 80),
		new /datum/data/vending_product("Коробка травматических патронов 12-го калибра", /obj/item/ammo_box/darkpack/c12g/incap, 80),
		new /datum/data/vending_product("Коробка резиновых пуль 12-го калибра", /obj/item/ammo_box/darkpack/c12g/rubber, 80),
		new /datum/data/vending_product("Коробка патронов 9 мм", /obj/item/ammo_box/darkpack/c9mm, 80),
		new /datum/data/vending_product("Коробка патронов 5.56", /obj/item/ammo_box/darkpack/c556, 80),
		new /datum/data/vending_product("Коробка патронов 4.6 мм", /obj/item/ammo_box/darkpack/c46pdw, 80),
	)

/obj/structure/retail/police_equipment/can_shop(mob/user)
	var/datum/job/vampire/assigned_role = user.mind?.assigned_role
	if(assigned_role && (/datum/job_department/police in assigned_role.departments_list))
		return TRUE
