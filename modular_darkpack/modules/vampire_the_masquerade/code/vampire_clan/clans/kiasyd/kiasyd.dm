/datum/subsplat/vampire_clan/kiasyd
	name = "Kiasyd"
	ru_name = "Киасиды"
	id = VAMPIRE_CLAN_KIASYD
	desc = "Киасиды - линия крови Ласомбра, возникшая после загадочного \"несчастного случая\" с ласомбра Марконием Страсбургским. В этом \"случае\" были замешаны феи и кровь \"Зеернебуха, бога Подземного мира\"; в итоге Марконий вырос на несколько футов, стал белым как мел и обзавёлся огромными вытянутыми чёрными глазами."
	icon = "kiasyd"
	curse = "С первого взгляда они вызывают у большинства тревогу и оторопь: обликом киасиды очень похожи на фей из старинных преданий. Кроме того, они как-то связаны с подменышами и уязвимы для холодного железа."
	sense_the_sin_text = "боится холодного железа."
	clan_disciplines = list(
		/datum/discipline/dominate,
		/datum/discipline/obtenebration,
		/datum/discipline/mytherceria
	)
	subsplat_traits = list(
		TRAIT_MASQUERADE_VIOLATING_EYES
	)
	alt_sprite = "kiasyd"
	no_facial = TRUE
	male_clothes = /obj/item/clothing/under/vampire/archivist
	female_clothes = /obj/item/clothing/under/vampire/archivist
	whitelisted = TRUE
	clan_marks = list(/datum/bodypart_overlay/simple/clan_mark/fae_ears)

/datum/subsplat/vampire_clan/kiasyd/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	/*
	// Kiasyd are made taller and thinner
	if (gaining_mob.has_quirk(/datum/quirk/dwarf))
		gaining_mob.remove_quirk(/datum/quirk/dwarf)
	else if (!gaining_mob.has_quirk(/datum/quirk/tower))
		gaining_mob.add_quirk(/datum/quirk/tower)
	*/

	var/obj/item/organ/eyes/kiasyd/weird_eyes = new()
	weird_eyes.Insert(gaining_mob, TRUE, DELETE_IF_REPLACED)

/datum/subsplat/vampire_clan/kiasyd/on_lose(mob/living/carbon/human/losing_mob)
	. = ..()

	/*
	if (losing_mob.has_quirk(/datum/quirk/tower))
		losing_mob.remove_quirk(/datum/quirk/tower)
	else
		losing_mob.add_quirk(/datum/quirk/dwarf)
	*/

	// replace eyes
	var/eye_type = /obj/item/organ/eyes
	if(losing_mob.dna.species && losing_mob.dna.species.mutanteyes)
		eye_type = losing_mob.dna.species.mutanteyes
	var/obj/item/organ/eyes/new_eyes = new eye_type()
	new_eyes.Insert(losing_mob, TRUE, DELETE_IF_REPLACED)

	losing_mob.update_body()

/datum/subsplat/vampire_clan/kiasyd/on_join_round(mob/living/carbon/human/joining)
	. = ..()

	//give them sunglasses to hide their freakish eyes
	var/obj/item/clothing/glasses/vampire/sun/new_glasses = new(joining.loc)
	joining.equip_to_appropriate_slot(new_glasses, TRUE)


/obj/item/organ/eyes/kiasyd
	eye_icon = 'modular_darkpack/modules/vampire_the_masquerade/icons/human_eyes.dmi'
	eye_icon_state = "kiasyd"
	eye_color_left = "#FFFFFF"
	eye_color_right = "#FFFFFF"

	iris_overlay = null
	blink_animation = FALSE
