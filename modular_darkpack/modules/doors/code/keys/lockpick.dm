// TODO: Repath these to remove keys. They have no real relation to them.
/obj/item/vamp/keys/hack
	name = "\improper lockpick"
	desc = "Такой можно открыть кое-какие двери. Незаконно...<br>Если осмотреть дверь с отмычкой в руке, можно прикинуть, насколько крепок замок, и заодно присмотреться к самому зданию, если там есть на что смотреть."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "hack"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/keys
	resistance_flags = FIRE_PROOF | ACID_PROOF
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

