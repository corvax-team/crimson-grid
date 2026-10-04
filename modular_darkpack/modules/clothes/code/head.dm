//HATS

//HATS

//HATS

/obj/item/clothing/head/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	armor_type = /datum/armor/vampire_hat

/datum/armor/vampire_hat
	melee = 10
	laser = 10
	energy = 10
	bomb = 10
	acid = 10
	wound = 10

/obj/item/clothing/head/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 5, "headwear", FALSE)

/obj/item/clothing/head/vampire/malkav
	name = "weirdo hat"
	desc = "Смотрится то грозно, то соблазнительно, это уж как повернётся. Немного защищает."
	icon_state = "malkav_hat"
	armor_type = /datum/armor/malkavian_hat

/datum/armor/malkavian_hat
	melee = 25
	bullet = 25
	laser = 10
	energy = 10
	bomb = 10
	acid = 10
	wound = 10

/obj/item/clothing/head/vampire/bandana
	name = "brown bandana"
	desc = "Стильная бандана."
	icon_state = "bandana"

/obj/item/clothing/head/vampire/bandana/red
	name = "red bandana"
	icon_state = "bandana_red"

/obj/item/clothing/head/vampire/bandana/black
	name = "black bandana"
	icon_state = "bandana_black"

/obj/item/clothing/head/vampire/baseballcap
	name = "baseball cap"
	desc = "Мягкая кепка с круглой тульёй и жёстким козырьком. Бейсбол в исполнении \"Джайентс\" - с этим ничто не сравнится!"
	icon_state = "baseballcap"

/obj/item/clothing/head/vampire/ushanka
	name = "ushanka"
	desc = "Тяжёлая меховая шапка с опускающимися ушами."
	icon_state = "ushanka"

/obj/item/clothing/head/vampire/beanie
	name = "beanie"
	desc = "Стильная вязаная шапка."
	icon_state = "hat"

/obj/item/clothing/head/vampire/beanie/black
	name = "black beanie"
	icon_state = "hat_black"

/obj/item/clothing/head/vampire/beanie/homeless
	name = "raggedy beanie"
	icon_state = "hat_homeless"

/obj/item/clothing/head/vampire/wizard/blue
	name = "blue wizard hat"
	desc = "Шляпа волшебника цвета глубокой воды."
	icon_state = "wizardhat_blue"

/obj/item/clothing/head/vampire/wizard/black
	name = "black wizard hat"
	desc = "Зловещая на вид шляпа волшебника."
	icon_state = "wizardhat_black"

/obj/item/clothing/head/vampire/wizard/darkred
	name = "dark red wizard hat"
	desc = "Шляпа волшебника для истовых ревнителей."
	icon_state = "wizardhat_darkred"

/obj/item/clothing/head/vampire/wizard/green
	name = "green wizard hat"
	desc = "Шляпа волшебника землистых тонов."
	icon_state = "wizardhat_green"

/obj/item/clothing/head/vampire/wizard/grey
	name = "grey wizard hat"
	desc = "Скорбного вида шляпа волшебника."
	icon_state = "wizardhat_grey"

/obj/item/clothing/head/vampire/wizard/purple
	name = "purple wizard hat"
	desc = "Изысканная шляпа волшебника."
	icon_state = "wizardhat_purple"

/obj/item/clothing/head/vampire/wizard/red
	name = "red wizard hat"
	desc = "Шляпа волшебника яростно-красного цвета."
	icon_state = "wizardhat_red"

/obj/item/clothing/head/vampire/wizard/white
	name = "white wizard hat"
	desc = "Шляпа волшебника ангельской белизны."
	icon_state = "wizardhat_white"

/obj/item/clothing/head/vampire/wizard/yellow
	name = "yellow wizard hat"
	desc = "Жизнерадостная шляпа волшебника."
	icon_state = "wizardhat_yellow"

/obj/item/clothing/head/vampire/police
	name = "police hat"
	desc = "Смотрится то грозно, то соблазнительно, это уж как повернётся. Немного защищает."
	icon_state = "law"
	armor_type = /datum/armor/armored_hat
	custom_price = 20

/datum/armor/armored_hat
	melee = 20
	bullet = 20
	laser = 10
	energy = 10
	bomb = 10
	acid = 10
	wound = 10

/obj/item/clothing/head/vampire/cowboy
	name = "cowboy hat"
	desc = "Выглядит круто, как ни посмотри. Немного защищает."
	icon_state = "cowboy"
	armor_type = /datum/armor/armored_hat

/obj/item/clothing/head/vampire/cowboy/armorless
	name = "cowboy hat"
	desc = "Йи, и, говорю это нечасто, ха."
	armor_type = /datum/armor/none

/obj/item/clothing/head/vampire/british
	name = "british police hat"
	desc = "Чайку не желаете? Немного защищает."
	icon_state = "briish"
	armor_type = /datum/armor/armored_hat

/obj/item/clothing/head/vampire/napoleon
	name = "french admiral hat"
	desc = "Dans mon esprit tout divague, je me perds dans tes yeux... Je me noie dans la vague de ton regard amoureux..."
	icon_state = "french"
	armor_type = /datum/armor/none

/obj/item/clothing/head/vampire/top
	name = "top hat"
	desc = "Чайку не желаете? Немного защищает."
	icon_state = "top"
	armor_type = /datum/armor/none

/obj/item/clothing/head/vampire/skull
	name = "skull helmet"
	desc = "Жуть... Немного защищает."
	icon_state = "skull"
	armor_type = /datum/armor/armored_hat

/obj/item/clothing/head/vampire/helmet
	name = "police helmet"
	desc = "Выглядит грозно. Хорошо защищает."
	icon_state = "helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	armor_type = /datum/armor/police_helmet
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	masquerade_violating = TRUE
	custom_price = 50

/datum/armor/police_helmet
	melee = 40
	bullet = 40
	laser = 40
	energy = 40
	bomb = 20
	fire = 20
	acid = 40
	wound = 25

/obj/item/clothing/head/vampire/helmet/egorium
	name = "strange mask"
	desc = "Выглядит загадочно. Хорошо защищает."
	icon_state = "masque"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	masquerade_violating = FALSE

/obj/item/clothing/head/vampire/helmet/spain
	name = "spain helmet"
	desc = "Конкистадор! Хорошо защищает."
	icon_state = "spain"
	flags_inv = HIDEEARS
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	masquerade_violating = FALSE

/obj/item/clothing/head/vampire/army
	name = "army helmet"
	desc = "Выглядит грозно. Отлично защищает от ударов."
	icon_state = "viet"
	flags_inv = HIDEEARS|HIDEHAIR
	armor_type = /datum/armor/army_helmet
	masquerade_violating = TRUE

/datum/armor/army_helmet
	melee = 60
	bullet = 60
	laser = 60
	energy = 60
	bomb = 40
	fire = 20
	acid = 40
	wound = 25

/obj/item/clothing/head/vampire/hardhat
	name = "construction helmet"
	desc = "Жёсткая каска из термопластика, защищает голову от травм."
	icon_state = "hardhat"
	armor_type = /datum/armor/construction_helmet
	hair_mask = /datum/hair_mask/standard_hat_middle
	custom_price = 50

/datum/armor/construction_helmet
	melee = 20
	bullet = 5
	bomb = 10
	fire = 5
	wound = 15

/obj/item/clothing/head/vampire/eod
	name = "EOD helmet"
	desc = "Выглядит грозно. Защищает почти от всего, и лучше не бывает."
	icon_state = "bomb"
	armor_type = /datum/armor/eod_helmet
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	visor_flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	w_class = WEIGHT_CLASS_BULKY
	masquerade_violating = TRUE

/datum/armor/eod_helmet
	melee = 70
	bullet = 70
	laser = 90
	energy = 90
	bomb = 100
	fire = 50
	acid = 90
	wound = 40

/obj/item/clothing/head/vampire/bogatyr
	name = "bone helmet"
	desc = "Величественный шлем из неведомого материала."
	icon_state = "bogatyr_helmet_light"
	armor_type = /datum/armor/police_helmet
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	visor_flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/head/vampire/bogatyr/captain
	name = "golden bone helmet"
	icon_state = "bogatyr_captain_helmet"
	armor_type = /datum/armor/bogatyr_helmet

/obj/item/clothing/head/vampire/bogatyr/captain/heavy // ! Craftable only.
	name = "reinforced golden bone helmet"
	armor_type = /datum/armor/eod_helmet
	w_class = WEIGHT_CLASS_BULKY

/obj/item/clothing/head/vampire/bogatyr/heavy
	name = "heavy bone greathelm"
	icon_state = "bogatyr_helmet"
	armor_type = /datum/armor/eod_helmet
	w_class = WEIGHT_CLASS_BULKY

/datum/armor/bogatyr_helmet
	melee = 55
	bullet = 50
	laser = 60
	energy = 60
	bomb = 20
	fire = 40
	acid = 70
	wound = 30

/obj/item/clothing/head/vampire/bahari_mask
	name = "Dark mother's mask"
	desc = "Когда я впервые вкусила плод Древ \
			и ощутила, как семена Жизни и Знания жгут меня изнутри, \
			в тот день я поклялась, что не поверну назад..."
	icon_state = "bahari_mask"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR

/obj/item/clothing/head/vampire/straw_hat
	name = "straw hat"
	desc = "Шляпа из соломы."
	icon_state = "strawhat"

/obj/item/clothing/head/vampire/hijab
	name = "hijab"
	desc = "Традиционный головной платок мусульманок."
	icon_state = "hijab"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/vampire/taqiyah
	name = "taqiyah"
	desc = "Традиционная шапочка мусульман."
	icon_state = "taqiyah"

/obj/item/clothing/head/vampire/noddist_mask
	name = "Noddist mask"
	desc = "Чёрным, солнце, воссияй! Кровью, месяц, запылай! Геенна близко, так и знай."
	icon_state = "noddist_mask"

/obj/item/clothing/head/vampire/kalimavkion
	name = "Kalimavkion"
	desc = "Традиционный головной убор православных священников."
	icon_state = "kalimavkion"

/obj/item/clothing/head/vampire/prayer_veil
	name = "Prayer veil"
	desc = "Традиционное покрывало для молитвы."
	icon_state = "prayer_veil"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/vampire/hardhat/pentex_yellow
	name = "\improper " + MAIN_EVIL_COMPANY + " hardhat"
	desc = "Жёлтая каска. С логотипом \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_hardhat_yellow"

/obj/item/clothing/head/vampire/hardhat/pentex_white
	name = "\improper " + MAIN_EVIL_COMPANY + " hardhat"
	desc = "Белая каска. С логотипом \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_hardhat_white"

/obj/item/clothing/head/vampire/pentex_beret
	name = "First Team beret"
	desc = "Чёрный берет с загадочной золотой эмблемой в виде спирали."
	icon_state = "pentex_beret"
	armor_type = /datum/armor/armored_hat
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/vampire/blackbag
	name = "black bag"
	desc = "В ходу у похитителей, садистов и ведомств из трёх букв. Легко надевается на голову и закрывает обзор."
	icon_state = "black_bag"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR

	flash_protect = FLASH_PROTECTION_WELDER
	tint = 3

/obj/item/clothing/head/vampire/blackbag/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HEAD)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/clothing/head/vampire/blackbag/dropped(mob/living/carbon/human/user)
	. = ..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/clothing/head/vampire/blackbag/attack(mob/living/target, mob/living/user)
	var/obj/item/clothing/head/H = target.get_item_by_slot(ITEM_SLOT_HEAD)
	if(H?.clothing_flags & SNUG_FIT)
		to_chat(user, span_warning("Мешок не налезет поверх головного убора!"))
		return
	if(do_after(user, 0.5 SECONDS, target)) //Mainly to prevent black_bagging mid combat.
		target.visible_message(span_warning("[capitalize(user.declent_ru(NOMINATIVE))] натягивает [declent_ru(ACCUSATIVE)] на голову [target.declent_ru(DATIVE)]!"))
		to_chat(target, span_bolddanger("[capitalize(user.declent_ru(NOMINATIVE))] натягивает вам на голову [declent_ru(ACCUSATIVE)]!"))
		target.emote("scream")
		target.Stun(0.5 SECONDS)

		H = target.get_item_by_slot(ITEM_SLOT_HEAD) // Refetch it if it changes between do_after
		target.dropItemToGround(H)
		target.equip_to_slot_if_possible(src, ITEM_SLOT_HEAD)

/obj/item/clothing/head/beret/black
	name = "black beret"
	desc = "Чёрный берет: то, что нужно ветеранам войн и мрачным, задумчивым мимам-антигероям."
	greyscale_colors = "#3f3c40"
