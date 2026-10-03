
//------------Mask------------
/obj/item/clothing/mask/gas/darkpack/military
	name = "\improper Military Gas Mask"
	desc = "Плотно прилегающий тактический противогаз. Защищает от биологических угроз и от ответственности перед обществом."
	icon_state = "gasmask_NG"
	icon = 'modular_darkpack/modules/ert/icons/clothing.dmi'
	inhand_icon_state = null
	worn_icon = 'modular_darkpack/modules/ert/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/onfloor.dmi')
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDEEYES | HIDEEARS | HIDEHAIR | HIDESNOUT
	visor_flags_inv = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	fishing_modifier = 2
	pepper_tint = FALSE
	brand = "herculean"


/obj/item/clothing/mask/gas/darkpack/military/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('modular_darkpack/modules/ert/icons/worn.dmi', "gasmask_emissive", src, alpha = src.alpha)

/obj/item/clothing/mask/gas/darkpack/military/pentex
	name = "\improper Corporate Gas Mask"
	desc = "Защищает от дыма, смога и любого биологического кошмара, который сейчас бушует в вашей тайной лаборатории."
	icon_state = "gasmask_pentex"
	brand = "endron"

//TODO: Finish CBRN Detachment + Equipment, masks are added seperately for atomization purposes
