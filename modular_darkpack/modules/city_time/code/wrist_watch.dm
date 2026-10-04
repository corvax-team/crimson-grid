/obj/item/watch
	name = "wrist watch"
	desc = "Наручные часы: время всегда под рукой."
	icon = 'modular_darkpack/modules/city_time/icons/clock.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon_state = "watch"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/card_id
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slot_flags = ITEM_SLOT_GLOVES
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	custom_price = 20 // ECONOMY

/obj/item/watch/examine(mob/user)
	. = ..()
	. += "[capitalize(declent_ru(NOMINATIVE))]: <b>[server_timestamp("hh:mm:ss", ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))], [text2num(server_timestamp("DD", ic_time = TRUE))] [ru_month_name(text2num(server_timestamp("MM", ic_time = TRUE)), GENITIVE)]</b>"
	. += "Значит, сегодня <b>[ru_weekday_name(server_timestamp("DDD", ic_time = TRUE))]</b>."

// CRIMSON EDIT ADD START - Sell Valuables
/obj/item/watch/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 20, "watch", FALSE)
// CRIMSON EDIT ADD END - Sell Valuables
