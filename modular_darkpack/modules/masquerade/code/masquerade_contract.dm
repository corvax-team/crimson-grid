/obj/item/masquerade_contract
	name = "\improper elegant scroll"
	desc = "Изящный на вид свиток."
	icon = 'modular_darkpack/modules/masquerade/icons/masquerade_contract.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/masquerade/icons/onfloor.dmi')
	icon_state = "masquerade"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/masquerade_contract
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/masquerade_contract
	fire = 100
	acid = 100

/obj/item/masquerade_contract/attack_self(mob/user, modifiers)
	. = ..()
	if(!get_vampire_splat(user))
		return
	var/turf/current_location = get_turf(user)
	to_chat(user, "[span_bold("ВЫ")], [get_area_name(user)] X:[current_location.x] Y:[current_location.y] Z:[current_location.z]")
	for(var/mob/living/carbon/breacher in GLOB.masquerade_breakers_list)
		var/location_info
		var/turf/turf = get_turf(breacher)
		if(breacher.masquerade_score <= 2)
			location_info = "[get_area_name(turf)], X:[turf.x] Y:[turf.y] Z:[turf.z]"
		else
			location_info = "[get_area_name(turf)]"
		to_chat(user, span_info("[breacher.real_name], нарушений Маскарада: [5 - breacher.masquerade_score], диаблерист: [(HAS_TRAIT(breacher, TRAIT_DIABLERIE) && !HAS_TRAIT(breacher, TRAIT_HIDDEN_DIABLERIE)) ? "<b>ДА</b>" : "НЕТ"], [location_info]")) // CRIMSON EDIT CHANGE - Original: to_chat(user, span_info("[breacher.real_name], Masquerade: [breacher.masquerade_score], Diablerist: [(HAS_TRAIT(breacher, TRAIT_DIABLERIE) && !HAS_TRAIT(breacher, TRAIT_HIDDEN_DIABLERIE)) ? "<b>YES</b>" : "NO"], [location_info]"))

	if(!GLOB.masquerade_breakers_list)
		to_chat(user, span_info("В городе нет известных нарушителей Маскарада..."))

/obj/item/veil_contract
	name = "\improper brass pocketwatch"
	desc = "Шикарные на вид карманные часы."
	icon = 'modular_darkpack/modules/masquerade/icons/masquerade_contract.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/masquerade/icons/onfloor.dmi')
	icon_state = "pocketwatch"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/masquerade_contract
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/veil_contract/attack_self(mob/user, modifiers)
	. = ..()
	if(!get_werewolf_splat(user))
		return
	var/turf/current_location = get_turf(user)
	to_chat(user, "[span_bold("ВЫ")], [get_area_name(user)] X:[current_location.x] Y:[current_location.y] Z:[current_location.z]")
	for(var/mob/living/breacher in GLOB.veil_breakers_list)
		var/location_info
		var/turf/turf = get_turf(breacher)
		if(breacher.masquerade_score <= 2)
			location_info = "[get_area_name(turf)], X:[turf.x] Y:[turf.y] Z:[turf.z]"
		else
			location_info = "[get_area_name(turf)]"
		to_chat(user, span_info("[breacher.real_name], Вуаль: [breacher.masquerade_score], [location_info]"))

	if(!GLOB.veil_breakers_list)
		to_chat(user, span_info("В городе нет известных нарушителей Вуали..."))

/obj/item/intel_report
	name = "intelligence report"
	desc = "Папка со сведениями о местных операциях и списком лиц, представляющих интерес."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "docs_part"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/masquerade_contract
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/intel_report/attack_self(mob/user, modifiers)
	. = ..()
	var/turf/current_location = get_turf(user)
	to_chat(user, span_info("[span_bold("ВЫ")], [get_area_name(user)] X:[current_location.x] Y:[current_location.y] Z:[current_location.z]"))
	for(var/mob/living/breacher in GLOB.supernatural_breakers_list)
		var/location_info
		var/turf/turf = get_turf(breacher)
		if(breacher.masquerade_score <= 2)
			location_info = "[get_area_name(turf)], X:[turf.x] Y:[turf.y] Z:[turf.z]"
		else
			location_info = "[get_area_name(turf)]"
		to_chat(user, span_info("[breacher.real_name], Вуаль: [breacher.masquerade_score], [location_info]"))

	if(!GLOB.supernatural_breakers_list)
		to_chat(user, span_info("В городе нет известных нелюдей..."))

// CRIMSON EDIT ADD START - Sell Valuables
/obj/item/veil_contract/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "watch", FALSE)
// CRIMSON EDIT ADD END - Sell Valuables
