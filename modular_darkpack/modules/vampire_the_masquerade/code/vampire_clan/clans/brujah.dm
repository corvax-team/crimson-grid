/datum/subsplat/vampire_clan/brujah
	name = "Brujah"
	ru_name = "Бруха"
	id = VAMPIRE_CLAN_BRUJAH
	desc = "Бруха - клан радикалов и смутьянов, который даёт Становление тем, кто не побоится поставить зарвавшегося на место. Большинство из них видит себя воинами за идею: этими Бунтарями движут страсть, сила и преданность идеалам, какими бы те ни были. Бруха - бунтари, философы и революционеры, которые в последнее время толпами уходят к анархам, оставляя Камарилью. Многие, особенно старейшины, всё ещё сочувствуют Камарилье, да и формально клан числится в ней, так что городские Бруха нередко балансируют между инакомыслием и долгом. Они печально известны своим нравом: из-за кланового изъяна сопротивляться Безумию им куда труднее, чем большинству Сородичей."
	icon = "brujah"
	curse = "Безумие приходит чаще и длится дольше."
	roleplay_level = "Для новичков"
	sense_the_sin_text = "расплачивается вечным гневом за позор Карфагена."
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/potence,
		/datum/discipline/presence
	)
	subsplat_traits = list(
		TRAIT_DIFFICULT_FRENZY
	)
	male_clothes = /obj/item/clothing/under/vampire/brujah
	female_clothes = /obj/item/clothing/under/vampire/brujah/female
	subsplat_keys = /obj/item/vamp/keys/brujah


/datum/subsplat/vampire_clan/brujah/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* to_chat(target, span_warning("You see visions of an underground stone monument weeping blood."))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
	to_chat(target, span_cult("THE BEAST RAGES AGAINST THIS VISION!!")) */
	to_chat(target, span_cult("ЗВЕРЬ ВОПИТ В МОЕЙ ГОЛОВЕ: БЕГИ"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
