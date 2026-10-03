//SUITS

//SUITS

//SUITS

/obj/item/clothing/suit/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')

	body_parts_covered = CHEST
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	max_integrity = 250
	resistance_flags = NONE
	armor_type = /datum/armor/vampire_suit

/datum/armor/vampire_suit
	melee = 10
	laser = 10
	energy = 10
	bomb = 10
	acid = 10
	wound = 10

/obj/item/clothing/suit/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "suit", FALSE)

/obj/item/clothing/suit/vampire/trench/malkav
	icon_state = "malkav_coat"

/obj/item/clothing/suit/hooded/heisenberg
	name = "chemical costume"
	desc = "Костюм для защиты от химикатов."
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	icon_state = "heisenberg"
	body_parts_covered = CHEST | GROIN | ARMS
	cold_protection = CHEST | GROIN | ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	clothing_flags = THICKMATERIAL
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/chemical_costume
	hoodtype = /obj/item/clothing/head/hooded/heisenberg_hood

/datum/armor/chemical_costume
	laser = 10
	energy = 10
	bomb = 50
	fire = 50
	acid = 100
	wound = 10

/obj/item/clothing/head/hooded/heisenberg_hood
	name = "chemical hood"
	desc = "Капюшон от костюма химзащиты."
	icon_state = "heisenberg_helm"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR | HIDEEARS
	clothing_flags = THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/chemical_costume

//** SPOOOOKY ROBES FROM THE CAPPADOCIAN UPDATE **//
/obj/item/clothing/suit/hooded/robes
	name = "white robe"
	desc = "Мантия ангельской белизны."
	icon_state = "robes"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	flags_inv = HIDEJUMPSUIT
	body_parts_covered = CHEST | GROIN | LEGS | ARMS
	cold_protection = CHEST | GROIN | LEGS | ARMS
	hoodtype = /obj/item/clothing/head/hooded/robes_hood

/obj/item/clothing/head/hooded/robes_hood
	name = "white hood"
	desc = "Капюшон мантии ангельской белизны."
	icon_state = "robes_hood"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	body_parts_covered = HEAD
	cold_protection = HEAD
	flags_inv = HIDEHAIR | HIDEEARS

/obj/item/clothing/suit/hooded/robes/black
	name = "black robe"
	desc = "Жутковатая мантия."
	icon_state = "robes_black"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/black

/obj/item/clothing/head/hooded/robes_hood/black
	name = "black hood"
	desc = "Капюшон жутковатой мантии."
	icon_state = "robes_black_hood"

/obj/item/clothing/suit/hooded/robes/grey
	name = "grey robe"
	desc = "Скорбного вида мантия."
	icon_state = "robes_grey"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/grey

/obj/item/clothing/head/hooded/robes_hood/grey
	name = "grey hood"
	desc = "Капюшон мантии скорбного вида."
	icon_state = "robes_grey_hood"

/obj/item/clothing/suit/hooded/robes/darkred
	name = "dark red robe"
	desc = "Мантия истового ревнителя."
	icon_state = "robes_darkred"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/darkred

/obj/item/clothing/head/hooded/robes_hood/darkred
	name = "dark red hood"
	desc = "Капюшон мантии истового ревнителя."
	icon_state = "robes_darkred_hood"

/obj/item/clothing/suit/hooded/robes/yellow
	name = "yellow robe"
	desc = "Жизнерадостная мантия."
	icon_state = "robes_yellow"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/yellow

/obj/item/clothing/head/hooded/robes_hood/yellow
	name = "yellow hood"
	desc = "Капюшон жизнерадостной мантии."
	icon_state = "robes_yellow_hood"

/obj/item/clothing/suit/hooded/robes/green
	name = "green robe"
	desc = "Мантия землистых тонов."
	icon_state = "robes_green"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/green

/obj/item/clothing/head/hooded/robes_hood/green
	name = "green hood"
	desc = "Капюшон мантии землистых тонов."
	icon_state = "robes_green_hood"

/obj/item/clothing/suit/hooded/robes/red
	name = "red robe"
	desc = "Мантия яростно-красного цвета."
	icon_state = "robes_red"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/red

/obj/item/clothing/head/hooded/robes_hood/red
	name = "red hood"
	desc = "Капюшон мантии яростно-красного цвета."
	icon_state = "robes_red_hood"

/obj/item/clothing/suit/hooded/robes/purple
	name = "purple robe"
	desc = "Изысканная мантия."
	icon_state = "robes_purple"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/purple

/obj/item/clothing/head/hooded/robes_hood/purple
	name = "purple hood"
	desc = "Капюшон изысканной мантии."
	icon_state = "robes_purple_hood"

/obj/item/clothing/suit/hooded/robes/blue
	name = "blue robe"
	desc = "Мантия цвета глубокой воды."
	icon_state = "robes_blue"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/blue

/obj/item/clothing/head/hooded/robes_hood/blue
	name = "blue hood"
	desc = "Капюшон мантии цвета глубокой воды."
	icon_state = "robes_blue_hood"

/obj/item/clothing/suit/hooded/robes/tremere
	name = "tremere robes"
	desc = "Чёрная мантия с красной отделкой и с эмблемой Дома Тремер."
	icon_state = "tremere_robes"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/tremere

/obj/item/clothing/head/hooded/robes_hood/tremere
	name = "tremere hood"
	desc = "Чёрный капюшон с красной отделкой и с эмблемой Дома Тремер."
	icon_state = "tremere_hood"

/obj/item/clothing/suit/hooded/robes/magister
	name = "magister robes"
	desc = "Красная мантия с затейливой золотой каймой и с эмблемой Дома Тремер."
	icon_state = "magister_robes"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/magister

/obj/item/clothing/head/hooded/robes_hood/magister
	name = "magister hood"
	desc = "Красный капюшон с затейливой золотой каймой и с эмблемой Дома Тремер."
	icon_state = "magister_hood"

/obj/item/clothing/suit/hooded/robes/apprentice
	name = "apprentice robes"
	desc = "Фиолетовая мантия с затейливой каймой и с эмблемой Дома Тремер."
	icon_state = "apprentice_robes"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/apprentice

/obj/item/clothing/head/hooded/robes_hood/apprentice
	name = "apprentice hood"
	desc = "Фиолетовый капюшон с затейливой каймой и с эмблемой Дома Тремер."
	icon_state = "apprentice_hood"

/obj/item/clothing/suit/hooded/robes/tremere_capeless
	name = "capeless tremere robes"
	desc = "Чёрная мантия с красной отделкой и с эмблемой Дома Тремер."
	icon_state = "tremere_robes_capeless"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/tremere_capeless

/obj/item/clothing/head/hooded/robes_hood/tremere_capeless
	name = "tremere hood"
	desc = "Чёрный капюшон с красной отделкой и с эмблемой Дома Тремер."
	icon_state = "tremere_hood_capeless"

/obj/item/clothing/suit/hooded/robes/magister_capeless
	name = "capeless magister robes"
	desc = "Красная мантия с затейливой золотой каймой и с эмблемой Дома Тремер."
	icon_state = "magister_robes_capeless"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/magister_capeless

/obj/item/clothing/head/hooded/robes_hood/magister_capeless
	name = "magister hood"
	desc = "Красный капюшон с затейливой каймой и с эмблемой Дома Тремер."
	icon_state = "magister_hood_capeless"

/obj/item/clothing/suit/vampire/coat
	name = "brown coat"
	desc = "Тёплое и тяжёлое коричневое пальто."
	icon_state = "coat1"

/obj/item/clothing/suit/vampire/coat/alt
	name = "green coat"
	desc = "Тёплое и тяжёлое зелёное пальто."
	icon_state = "coat2"

/obj/item/clothing/suit/vampire/coat/winter
	name = "black fur coat"
	desc = "Тёплая и тяжёлая одежда."
	icon_state = "winter1"

/obj/item/clothing/suit/vampire/coat/winter/alt
	name = "brown fur coat"
	icon_state = "winter2"

/obj/item/clothing/suit/vampire/coat/leopard
	name = "leopard coat"
	desc = "Шуба из искусственного меха."
	icon_state = "leopard_coat"

/obj/item/clothing/suit/vampire/coat/milparka
	name = "military parka"
	desc = "Толстая парка в ночном пустынном камуфляже."
	icon_state = "desertnightparka"


/obj/item/clothing/suit/hooded/hoodie
	name = "hoodie"
	desc = "Простое худи."
	icon_state = "hoodie"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	hoodtype = /obj/item/clothing/head/hooded/hood_hood

/obj/item/clothing/head/hooded/hood_hood
	name = "hoodie hood"
	desc = "Худишный капюшон от худи."
	icon_state = "hoodie_hood"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	// You should not expect this to have an onfloor
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEEARS
	hair_mask = /datum/hair_mask/winterhood

/obj/item/clothing/suit/hooded/hoodie/hoodie_pim
	name = "intruder zim hoodie"
	desc = "Худи с любимым персонажем \"Вторженца Зима\", Гером."
	icon_state = "hoodie_zim"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/hood_pim

/obj/item/clothing/head/hooded/hood_hood/hood_pim
	name = "intruder zim hoodie hood"
	desc = "Капюшон в виде любимого персонажа \"Вторженца Зима\", Гера."
	icon_state = "hoodie_zim_hood"


/obj/item/clothing/suit/vampire/slickbackcoat
	name = "opulent coat"
	desc = "Пышное, роскошное и насквозь фиолетовое. Slickback Clothing Co. От него так и прёт мощной энергетикой."
	icon_state = "slickbackcoat"
	armor_type = /datum/armor/opulent_coat

/datum/armor/opulent_coat
	melee = 5
	bullet = 5
	wound = 5

/obj/item/clothing/suit/vampire/jacket
	name = "black leather jacket"
	desc = "Настоящая одежда любого панка. Немного защищает."
	icon_state = "jacket1"
	armor_type = /datum/armor/vampire_jacket

/datum/armor/vampire_jacket
	melee = 25
	bullet = 25
	laser = 10
	energy = 10
	bomb = 25
	fire = 25
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/jacket/fbi
	name = "Federal Bureau of Investigation jacket"
	desc = "\"ФБР, ОТКРЫВАЙТЕ!!\""
	icon_state = "fbi"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/cropped
	name = "cropped black leather jacket"
	desc = "Чуть более откровенная версия панковской классики. Немного защищает."
	icon_state = "jacket1_cut"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/red
	name = "red leather jacket"
	desc = "Настоящая одежда любого панка. Немного защищает."
	icon_state = "jacket3"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/cropped/red
	name = "cropped red leather jacket"
	desc = "Чуть более откровенная версия панковской классики. Немного защищает."
	icon_state = "jacket3_cut"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/punk
	icon_state = "punk"
	armor_type = /datum/armor/punk_jacket

/datum/armor/punk_jacket
	melee = 50
	bullet = 50
	laser = 10
	energy = 10
	bomb = 50
	fire = 25
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/jacket/better
	name = "brown leather jacket"
	icon_state = "jacket2"
	armor_type = /datum/armor/brown_leather_jacket

/datum/armor/brown_leather_jacket
	melee = 35
	bullet = 35
	laser = 10
	energy = 10
	bomb = 35
	fire = 35
	acid = 10
	wound = 35

/obj/item/clothing/suit/vampire/jacket/better/armored
	name = "armored leather jacket"
	armor_type = /datum/armor/armored_jackets

/datum/armor/armored_jackets
	melee = 50
	bullet = 50
	laser = 50
	energy = 10
	bomb = 40
	bio = 0
	fire = 40
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/trench/alt/armored
	name = "armored brown trenchcoat"
	icon_state = "trench2"
	max_integrity = 400
	armor_type = /datum/armor/armored_jackets

/obj/item/clothing/suit/vampire/trench/armored
	name = "armored black trenchcoat"
	max_integrity = 400
	armor_type = /datum/armor/armored_jackets

/obj/item/clothing/suit/vampire/trench
	name = "trenchcoat"
	desc = "Лучшая нуарная одежда для ночи. Немного защищает."
	icon_state = "trench1"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/trench/alt
	name = "brown trenchcoat"
	icon_state = "trench2"

/obj/item/clothing/suit/vampire/trench/archive
	name = "rich trenchcoat"
	desc = "Лучший выбор для приятной жизни... или нет."
	icon_state = "trench3"

/obj/item/clothing/suit/vampire/trench/strauss
	name = "red trenchcoat"
	desc = "Истинная сила не в богатстве, а в том, что оно позволяет."
	icon_state = "strauss_coat"

/obj/item/clothing/suit/vampire/trench/voivode
	name = "regal coat"
	desc = "Красивая вещь. Её владелец наверняка важная птица."
	icon_state = "voicoat"
	armor_type = /datum/armor/regal_coat

/datum/armor/regal_coat
	melee = 60
	bullet = 60
	laser = 10
	energy = 10
	bomb = 55
	fire = 45
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/vest
	name = "bulletproof vest"
	desc = "Прочный и лёгкий жилет, надёжно защищающий от большинства угроз."
	icon_state = "vest"
	armor_type = /datum/armor/bulletproof_vest
	allowed = list(
		/obj/item/card/id,
		/obj/item/flashlight,
		/obj/item/melee/baton,
		/obj/item/restraints/handcuffs
	)

/datum/armor/bulletproof_vest
	melee = 55
	bullet = 55
	laser = 10
	energy = 10
	bomb = 55
	fire = 45
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/vest/medieval
	name = "medieval vest"
	desc = "Наверное, испанская. Хорошо защищает."
	icon_state = "medieval"

//Police + Army

/obj/item/clothing/suit/vampire/coat/police
	name = "police raincoat"
	icon_state = "policecoat"
	desc = "Прочный дождевик со светоотражающими полосами для патрулей в сырую погоду."
	custom_price = 20

/obj/item/clothing/suit/vampire/vest/police
	name = "police duty vest"
	icon_state = "pdvest"
	desc = "Лёгкий бронежилет с маркировкой SFPD для несения службы."
	custom_price = 50

/obj/item/clothing/suit/vampire/vest/police/fbivest
	name = "FBI duty vest"
	icon_state = "fbivest"
	desc = "Лёгкий бронежилет с жёлтой маркировкой ФБР для несения службы. На этом знаки различия специального агента."

/obj/item/clothing/suit/vampire/vest/police/sergeant
	name = "police sergeant vest"
	icon_state = "sgtvest"
	desc = "Лёгкий бронежилет с маркировкой SFPD для несения службы. На этом сержантские знаки различия."

// They got an Army vest post-PD update. I am just giving them the same, instead coded into their equipment instead of mapped.
/obj/item/clothing/suit/vampire/vest/police/captain
	name = "police captain duty vest"
	icon_state = "capvest"
	desc = "Композитный бронежилет с маркировкой SFPD и усиленной защитой. На этом капитанские знаки различия."
	armor_type = /datum/armor/highly_protective_vest

/datum/armor/highly_protective_vest
	melee = 70
	bullet = 70
	laser = 10
	energy = 10
	bomb = 60
	fire = 50
	acid = 10
	wound = 30

/obj/item/clothing/suit/vampire/vest/army
	name = "army vest"
	desc = "Армейское снаряжение. Отлично защищает от ударов."
	icon_state = "army"
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/highly_protective_vest
	masquerade_violating = TRUE

/obj/item/clothing/suit/vampire/eod
	name = "EOD suit"
	desc = "Снаряжение подрывника. Защищает почти от всего, и лучше не бывает."
	icon_state = "eod"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 2
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/eod_suit
	masquerade_violating = TRUE

/datum/armor/eod_suit
	melee = 90
	bullet = 90
	laser = 50
	energy = 50
	bomb = 100
	fire = 70
	acid = 90
	wound = 50

/obj/item/clothing/suit/vampire/bogatyr
	name = "bone armor"
	desc = "Величественный доспех из неведомого материала."
	icon_state = "bogatyr_armor_light"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.5
	w_class = WEIGHT_CLASS_NORMAL
	armor_type = /datum/armor/bulletproof_vest

/obj/item/clothing/suit/vampire/bogatyr/captain
	name = "golden bone armor"
	icon_state = "bogatyr_captain_armor"
	armor_type = /datum/armor/highly_protective_vest

/obj/item/clothing/suit/vampire/bogatyr/captain/heavy // ! Craftable only.
	name = "reinforced golden bone armor"
	armor_type = /datum/armor/eod_suit
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 1

/obj/item/clothing/suit/vampire/bogatyr/heavy
	name = "heavy bone harness"
	icon_state = "bogatyr_armor"
	armor_type = /datum/armor/eod_suit
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 1

/obj/item/clothing/suit/vampire/labcoat
	name = "labcoat"
	desc = "Для медицины и исследований."
	icon_state = "labcoat"
	armor_type = /datum/armor/labcoat

/datum/armor/labcoat
	acid = 90
	wound = 10

/obj/item/clothing/suit/vampire/labcoat/director
	name = "clinic director's labcoat"
	desc = "Особый халат директора с эмблемами клиники Святого Иоанна."
	icon_state = "director"

/obj/item/clothing/suit/vampire/fancy_gray
	name = "fancy gray jacket"
	desc = "Пиджак серого цвета"
	icon_state = "fancy_gray_jacket"

/obj/item/clothing/suit/vampire/fancy_red
	name = "fancy red jacket"
	desc = "Пиджак красного цвета"
	icon_state = "fancy_red_jacket"

/obj/item/clothing/suit/vampire/majima_jacket
	name = "too much fancy jacket"
	desc = "Ого-о, вы только гляньте! Два мачо мутузят друг друга нагишом!? Я и не знал, что на свете бывает такое дерьмо..."
	icon_state = "majima_jacket"

/obj/item/clothing/suit/vampire/bahari
	name = "dark mother's suit"
	desc = "Когда я впервые вкусила плод Древ \
			и ощутила, как семена Жизни и Знания жгут меня изнутри, в тот день я поклялась, что не поверну назад..."
	icon_state = "bahari"

/obj/item/clothing/suit/vampire/kasaya
	name = "kasaya"
	desc = "Традиционное одеяние буддийских монахов и монахинь."
	icon_state = "kasaya"

/obj/item/clothing/suit/vampire/imam
	name = "imam robe"
	desc = "Традиционное одеяние мусульманских имамов."
	icon_state = "imam"

/obj/item/clothing/suit/vampire/noddist
	name = "noddist robe"
	desc = "Чёрным, солнце, воссияй! Кровью, месяц, запылай! Геенна близко, так и знай."
	icon_state = "noddist"

/obj/item/clothing/suit/vampire/orthodox
	name = "orthodox robe"
	desc = "Традиционное облачение православных священников."
	icon_state = "vestments"

/obj/item/clothing/suit/vampire/dutch
	name = "dutch's jacket"
	desc = "Для долгих ночей на пляже Таити."
	icon_state = "DutchJacket"

//Pentex Overwear
/obj/item/clothing/suit/vampire/pentex_labcoat
	name = "\improper " + MAIN_EVIL_COMPANY + " labcoat"
	desc = "Белоснежный накрахмаленный халат. На груди вышит логотип \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_closedlabcoat"
	armor_type = /datum/armor/labcoat

/obj/item/clothing/suit/vampire/pentex_labcoat_alt
	name = "\improper " + MAIN_EVIL_COMPANY + " labcoat"
	desc = "Белоснежный накрахмаленный халат с зелёной отделкой. На груди вышит логотип \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_labcoat_alt"
	armor_type = /datum/armor/labcoat

/obj/item/clothing/suit/vampire/bomber_jacket_classic
	name = "classic bomber jacket"
	desc = "Классический бомбер."
	icon_state = "bomber_classic"

/obj/item/clothing/suit/vampire/bomber_jacket_gray
	name = "gray bomber jacket"
	desc = "Серый бомбер."
	icon_state = "bomber_gray"

/obj/item/clothing/suit/vampire/shawl_black
	name = "black shawl"
	desc = "Чёрная шаль."
	icon_state = "shawl_black"

/obj/item/clothing/suit/vampire/shawl_white
	name = "white shawl"
	desc = "Белая шаль."
	icon_state = "shawl_white"
