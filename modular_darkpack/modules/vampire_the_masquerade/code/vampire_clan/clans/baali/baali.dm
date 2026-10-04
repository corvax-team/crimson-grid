/datum/subsplat/vampire_clan/baali
	name = "Baali"
	ru_name = "Баали"
	id = VAMPIRE_CLAN_BAALI
	desc = "Баали - линия крови, связанная с поклонением демонам. Из-за близости к нечестивому они особенно уязвимы перед святыми образами, освящённой землёй и святой водой, а перед истинной верой почти беззащитны."
	icon = "baali"
	curse = "Страх перед святынями."
	sense_the_sin_text = "страшится присутствия Господа."
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/daimonion
	)

	subsplat_traits = list(
		TRAIT_REPELLED_BY_HOLINESS
	)
	male_clothes = /obj/item/clothing/under/vampire/baali
	female_clothes = /obj/item/clothing/under/vampire/baali/female
	enlightenment = TRUE
	whitelisted = TRUE
	subsplat_keys = /obj/item/vamp/keys/baali

/datum/subsplat/vampire_clan/baali/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* to_chat(target, span_notice("The sacred icons appearing before you lack the true substance of faith"))
	new /datum/hallucination/delusion(target, TRUE, "repent", 200, 0)
	to_chat(owner, span_notice("Your illusions are easily dispelled by [target]")) */
	to_chat(target, span_cult("ЗВЕРЬ ВОПИТ В МОЕЙ ГОЛОВЕ: БЕГИ"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
