/obj/item/clothing/mask/gas/vampire
	name = "respirator"
	desc = "Маска на всё лицо, которую можно подключить к баллону с воздухом. Личность скрывает хорошо, а вот газ задерживает так себе." //More accurate
	icon_state = "respirator"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACE | HIDEFACIALHAIR|HIDESNOUT
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH | PEPPERPROOF
	resistance_flags = NONE
	custom_price = 30

/obj/item/clothing/mask/vampire
	// This USED to be the default resperatior for wod13 moved that to /obj/item/clothing/mask/gas/vampire
	abstract_type = /obj/item/clothing/mask/vampire
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE

/obj/item/clothing/mask/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 15, "mask", FALSE)

/obj/item/clothing/mask/vampire/balaclava
	name = "balaclava"
	desc = "БАБЛА НАВАЛОМ"
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/pentex_balaclava
	name = "Thick balaclava"
	desc = "Чёрная балаклава. Эта особенно плотная."
	icon_state = "pentex_balaclava"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/tragedy
	name = "tragedy"
	desc = "Греческая маска трагедии."
	icon_state = "tragedy"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/comedy
	name = "comedy"
	desc = "Греческая маска комедии."
	icon_state = "comedy"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/shemagh
	name = "shemagh"
	desc = "Отлично закрывает лицо."
	icon_state = "shemagh"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/venetian_mask
	name = "Venetian mask"
	desc = "В такой можно прийти на настоящий маскарад."
	icon_state = "venetian_mask"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/vampire/venetian_mask/fancy
	name = "fancy Venetian mask"
	desc = "Чудаковатые богачи наверняка носят что-то в этом роде."
	icon_state = "venetian_mask_fancy"

/obj/item/clothing/mask/vampire/venetian_mask/jester
	name = "jester mask"
	desc = "Весело будет всем. Всем до единого."
	icon_state = "venetian_mask_jester"

/obj/item/clothing/mask/vampire/venetian_mask/scary
	name = "bloody mask"
	desc = "В такой у вас вид человека, готового кого-нибудь разделать."
	icon_state = "venetian_mask_scary"
	flags_inv = HIDEFACE
	flags_cover = NONE

/obj/item/clothing/mask/vampire/fomori_chaser
	name = "scary mask"
	desc = "Любишь фильмы ужасов?"
	icon_state = "chaser"

//Bandanas use TG sprites except the inventory icon sprite, we use Flav's for that.
/obj/item/clothing/mask/bandana/vampire
	desc = "Бандана: в самый раз, чтобы прикрыть лицо, шею или голову!"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/bandana/onfloor/vampire

/obj/item/clothing/mask/bandana/striped/vampire
	desc = "Полосатая бандана: в самый раз, чтобы прикрыть лицо, шею или голову!"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/bandana/striped/onfloor/vampire

/obj/item/clothing/mask/bandana/skull/vampire
	desc = "Бандана с черепом: в самый раз, чтобы прикрыть лицо, шею или голову!"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/bandana/skull/onfloor/vampire

/obj/item/clothing/mask/facescarf/vampire
	desc = "Плотный шарф на лицо: и шею с лицом согреет, и личность скроет."
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/facescarf/onfloor/vampire
