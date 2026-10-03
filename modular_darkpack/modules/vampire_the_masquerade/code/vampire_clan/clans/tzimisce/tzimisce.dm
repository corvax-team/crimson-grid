/datum/subsplat/vampire_clan/tzimisce
	name = "Tzimisce"
	ru_name = "Цимисхи"
	id = VAMPIRE_CLAN_TZIMISCE
	desc = "Назовите цимисха бесчеловечным садистом - он, пожалуй, похвалит вас за проницательность, а потом покажет, насколько смехотворно убого смертное представление о садизме. Цимисхи с радостью оставили человеческую природу позади и теперь стремятся превзойти пределы уже вампирского состояния. При беглом взгляде или в короткой беседе цимисх кажется одним из самых приятных вампиров: вежливый, умный, любознательный, он разительно отличается от воющих толп Шабаша и даже от вроде бы более человечных бруха или носферату. Но стоит присмотреться, и становится ясно: это лишь маска, за которой скрывается нечто чуждое и чудовищное."
	curse = "Привязаны к родной земле."
	icon = "tzimisce"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/animalism,
		/datum/discipline/vicissitude

	)
	male_clothes = /obj/item/clothing/under/vampire/sport
	female_clothes = /obj/item/clothing/under/vampire/red
	enlightenment = TRUE
	clan_marks = list(
		/datum/bodypart_overlay/simple/clan_mark/spines,
		/datum/bodypart_overlay/simple/clan_mark/spines_slim,
		/datum/bodypart_overlay/simple/clan_mark/animal_skull,
	)

/datum/subsplat/vampire_clan/tzimisce/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
	to_chat(target, span_cult("I SEE VISIONS OF FLAME ENGULFING MY DOMAIN"))
	new /datum/hallucination/fire(target, TRUE)
	target.Paralyze(6 SECONDS) */
	to_chat(target, span_cult("ЗВЕРЬ ВОПИТ В МОЕЙ ГОЛОВЕ: БЕГИ"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY

/datum/subsplat/vampire_clan/tzimisce/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	sense_the_sin_text = "[joining.name] живёт одним-единственным желанием."
	var/obj/item/ground_heir/heirloom = new(get_turf(joining))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	joining.equip_in_one_of_slots(heirloom, slots, FALSE)
	joining.AddComponent(/datum/component/needs_home_soil, heirloom)

/datum/movespeed_modifier/centipede
	multiplicative_slowdown = -0.6
