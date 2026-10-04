/obj/structure/city_map
	name = "\improper map"
	desc = "Самое время понять, где вы находитесь."
	icon = 'modular_darkpack/modules/decor/icons/city_map.dmi'
	icon_state = "map"
	anchored = TRUE
	density = TRUE
	var/page_link = "Map"

/obj/structure/city_map/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Проложить маршрут", rmb_text = "Открыть карту")

/obj/structure/city_map/attack_hand(mob/user)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"
	if(!isliving(user))
		return TRUE
	var/mob/living/navigator = user
	navigator.navigate()

/obj/structure/city_map/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	var/wiki_url = CONFIG_GET(string/wikiurl)
	if(!wiki_url)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	var/confirmation = (alert(user, "Открыть карту на вики?", "[capitalize(declent_ru(NOMINATIVE))]", "Да", "Нет"))
	if(confirmation == "Да")
		DIRECT_OUTPUT(user, link("[wiki_url]/[page_link]"))
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
