/**
 * Players can revive simplemobs with this.
 * In-game item that can be used to revive a simplemob once. Does not make mobs friendly.
 */
/obj/item/lazarus_injector/lazadon
	name = "lazadon injector"
	desc = "Инъектор с коктейлем препаратов, способным вытащить питомца с того света."
	icon = 'modular_darkpack/modules/medical/icons/lazadon_injector.dmi'
	lefthand_file = 'modular_darkpack/modules/medical/icons/lazadon_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/medical/icons/lazadon_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/medical/icons/lazadon_onfloor.dmi')

	brand = "magadon"
	should_tame = FALSE
