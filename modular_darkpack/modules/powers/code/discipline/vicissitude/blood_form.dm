#define SPECIES_BLOODFORM "bloodform"

/datum/species/tzimisce_blood_form
	// A living puddle of Vitae, immune to Bashing and Lethal damage.
	name = "\improper Bloodform"
	plural_form = "Bloodforms"
	id = SPECIES_BLOODFORM
	examine_limb_id = SPECIES_BLOODFORM
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_SLIME
	inherent_traits = list(
		TRAIT_MUTE,
		TRAIT_NO_EYE_CONTACT,
		TRAIT_MUTANT_COLORS,
		TRAIT_NEVER_WOUNDED,
		TRAIT_STAKE_IMMUNE,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_PACIFISM,
		TRAIT_PUSHIMMUNE,
		TRAIT_MARTIAL_ARTS_IMMUNE,
		TRAIT_NO_SLIP_ALL,
		TRAIT_PULL_BLOCKED,
		TRAIT_MASQUERADE_VIOLATING_FACE,
		TRAIT_NO_CUFF,
	) //Made of blood and can't be staked or wounded, but also has no actual ability to attack, per-se.
	exotic_bloodtype = /datum/blood_type/kindred
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/blood_form,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/blood_form,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/blood_form,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/blood_form,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/blood_form,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/blood_form,
	)
	mutanteyes = /obj/item/organ/eyes/bloodform
	mutantbrain = /obj/item/organ/brain/bloodform
	mutantears = /obj/item/organ/ears/bloodform
	fixed_mut_color = "#990000a9"
	hair_color_mode = USE_FIXED_MUTANT_COLOR
	hair_alpha = 70
	facial_hair_alpha = 70
	var/datum/action/innate/regenerate_blood_limbs/regenerate_limbs

/datum/species/tzimisce_blood_form/on_species_gain(mob/living/carbon/new_jellyperson, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(ishuman(new_jellyperson))
		regenerate_limbs = new
		regenerate_limbs.Grant(new_jellyperson)
	new_jellyperson.AddElement(/datum/element/soft_landing)
	new_jellyperson.pass_flags = PASSTABLE | PASSMOB | PASSDOORS //A moving pool of blood, it can slip through and around most things.

/datum/species/tzimisce_blood_form/on_species_loss(mob/living/carbon/former_jellyperson, datum/species/new_species, pref_load)
	if(regenerate_limbs)
		regenerate_limbs.Remove(former_jellyperson)
	former_jellyperson.RemoveElement(/datum/element/soft_landing)
	former_jellyperson.pass_flags = NONE //Resets it to default for humans after loss.
	for(var/obj/item/organ/bloodform_organs in former_jellyperson.organs)
		if(istype(bloodform_organs, /obj/item/organ/brain/bloodform) || istype(bloodform_organs, /obj/item/organ/eyes/bloodform) || istype(bloodform_organs, /obj/item/organ/ears/bloodform))
			bloodform_organs.organ_flags &= ~ORGAN_UNREMOVABLE
	return ..()

/datum/action/innate/regenerate_blood_limbs
	name = "Восстановить конечности"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimeheal"
	button_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	var/blood_per_limb = 1

/datum/action/innate/regenerate_blood_limbs/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = owner
	var/list/limbs_to_heal = H.get_missing_limbs()
	if(!length(limbs_to_heal))
		return FALSE
	if(H.bloodpool >= blood_per_limb)
		return TRUE

/datum/action/innate/regenerate_blood_limbs/Activate()
	var/mob/living/carbon/human/H = owner
	var/list/limbs_to_heal = H.get_missing_limbs()
	if(!length(limbs_to_heal))
		to_chat(H, span_notice("Вы и так целы."))
		return
	to_chat(H, span_notice("Вы сосредотачиваетесь на [length(limbs_to_heal) >= 2 ? "утраченных конечностях" : "утраченной конечности"]..."))
	if(H.bloodpool >= blood_per_limb * length(limbs_to_heal))
		H.regenerate_limbs()
		H.adjust_blood_pool(-blood_per_limb * length(limbs_to_heal))
		to_chat(H, span_notice("...и миг спустя тело вновь обретает форму!"))
		return
	else if(H.bloodpool >= blood_per_limb) //We can partially heal some limbs
		while(H.bloodpool >= blood_per_limb)
			var/healed_limb = pick(limbs_to_heal)
			H.regenerate_limb(healed_limb)
			limbs_to_heal -= healed_limb
			H.adjust_blood_pool(-blood_per_limb)
		to_chat(H, span_warning("...но вас самих не хватает, чтобы восстановить всё! Для полного исцеления нужно больше витэ!"))
		return
	to_chat(H, span_warning("...но вас самих на это не хватает! Чтобы исцелиться, нужно больше витэ!"))

/// Bodyparts
/obj/item/bodypart/head/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	teeth_count = 0
	head_flags = HEAD_EYECOLOR | HEAD_EYESPRITES | HEAD_HAIR | HEAD_FACIAL_HAIR
	butcher_replacement = null
	is_dimorphic = FALSE
	brute_modifier = 0 //Immune to non-burning, magical, or blood drinking damage.

/obj/item/bodypart/chest/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = TRUE
	brute_modifier = 0 //Immune to non-burning, magical, or blood drinking damage.

/obj/item/bodypart/chest/blood_form/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_SLIME)

/obj/item/bodypart/arm/left/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE
	brute_modifier = 0 //Immune to non-burning, magical, or blood drinking damage.

/obj/item/bodypart/arm/right/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE
	brute_modifier = 0 //Immune to non-burning, magical, or blood drinking damage.

/obj/item/bodypart/leg/left/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE
	brute_modifier = 0 //Immune to non-burning, magical, or blood drinking damage.

/obj/item/bodypart/leg/right/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE
	brute_modifier = 0 //Immune to non-burning, magical, or blood drinking damage.

/// Organs
/obj/item/organ/eyes/bloodform
	name = "bloody eyes"
	desc = "Это ошибка разработки! Если вы это видите, сообщите на GitHub!"
	zone = BODY_ZONE_CHEST
	iris_overlay = null
	eye_color_left = "#990000a9"
	eye_color_right = "#990000a9"
	organ_flags = ORGAN_HIDDEN | ORGAN_UNREMOVABLE //Shouldn't come up, but just in case someone tries surgery on Bloodform for some reason.
	maxHealth = INFINITY //Pseudo-organs, shouldn't technically be damageable.

/obj/item/organ/ears/bloodform
	name = "bloody ears"
	desc = "Это ошибка разработки! Если вы это видите, сообщите на GitHub!"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_HIDDEN | ORGAN_UNREMOVABLE //Shouldn't come up, but just in case someone tries surgery on Bloodform for some reason.
	maxHealth = INFINITY //Pseudo-organs, shouldn't technically be damageable.

/obj/item/organ/brain/bloodform
	name = "bloody... brain?"
	desc = "Это ошибка разработки! Если вы это видите, сообщите на GitHub!"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_HIDDEN | ORGAN_UNREMOVABLE //Shouldn't come up, but just in case someone tries surgery on Bloodform for some reason.
	maxHealth = INFINITY //Pseudo-organs, shouldn't technically be damageable.

#undef SPECIES_BLOODFORM
