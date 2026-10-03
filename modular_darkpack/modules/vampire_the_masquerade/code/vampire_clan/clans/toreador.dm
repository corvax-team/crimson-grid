/datum/subsplat/vampire_clan/toreador
	name = "Toreador"
	ru_name = "Тореадор"
	id = VAMPIRE_CLAN_TOREADOR
	desc = "Тореадоры известны умением обольщать, пленительными манерами и изяществом, доходящим до одержимости. Они дают Становление художникам и влюблённым, вечно пытаясь расшевелить собственные омертвевшие сердца. Сверхъестественно грациозные и обаятельные, Дивы всегда ищут новых острых ощущений, оставляя за собой шлейф брошенных любовников и жертв. Тореадоры - ценители красоты и всего, что связано с искусством, и завсегдатаи высшего общества Сородичей. Прочно связанные с Камарильей, они заняты культурой и влиянием: одни покровительствуют искусствам, другие одержимы модными веяниями и мимолётными сенсациями. Искусством может стать что угодно, если тореадор сочтёт это искусством. Клановый изъян заставляет их впадать в опасное оцепенение перед красотой и сильным чувством."
	icon = "toreador"
	curse = "Человечность меняется вдвое сильнее."
	roleplay_level = "Для новичков"
	sense_the_sin_text = "доходит в своих увлечениях до одержимости."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/celerity,
		/datum/discipline/presence
	)
	subsplat_traits = list(
		TRAIT_SENSITIVE_HUMANITY
	)
	male_clothes = /obj/item/clothing/under/vampire/toreador
	female_clothes = /obj/item/clothing/under/vampire/toreador/female
	subsplat_keys = /obj/item/vamp/keys/toreador

/datum/subsplat/vampire_clan/toreador/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh2.ogg", 50, FALSE)
	new /datum/hallucination/fire(target, TRUE)
	to_chat(target, span_cult("FLAMES ENGULF MY BEAUTY"))
	target.Paralyze(5 SECONDS) */
	to_chat(target, span_cult("ЗВЕРЬ ВОПИТ В МОЕЙ ГОЛОВЕ: БЕГИ"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
