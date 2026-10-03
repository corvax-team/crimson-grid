/obj/structure/sign/eyechart
	icon_state = "eyechart"
	name = "eye chart"
	desc = "A poster with a series of colored bars and letters of different sizes, \
		used to test color vision and blindness - I mean, visual acuity."
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/eyechart, 32)

/obj/structure/sign/eyechart/examine(mob/user)
	. = ..()
	if(isobserver(user))
		return

	if(!user.can_read(src, READING_CHECK_LITERACY, silent = TRUE) || !user.has_language(/datum/language/common, UNDERSTOOD_LANGUAGE))
		if(!user.is_blind())
			. += "<hr>Вы вглядываетесь в ряды значков, пытаясь понять, что они значат..."
			. += span_warning("...Но ни один из них вам ни о чём не говорит.")
		return

	if(user.is_blind())
		. += "<hr>Вы ощупываете таблицу."
		. += span_notice("Так, на ощупь это... \"Ш, Б, М...\" Хорошо, что таблица продублирована шрифтом Брайля!")
		return

	if(!user.can_read(src, READING_CHECK_LIGHT, silent = TRUE))
		. += "<hr>Вы щуритесь, глядя на таблицу."
		. += span_warning("...Но в такой темноте ничего не разобрать.")
		return

	var/colorblind = HAS_TRAIT(user, TRAIT_COLORBLIND)
	var/obj/item/organ/eyes/eye = user.get_organ_slot(ORGAN_SLOT_EYES)
	// eye null checks here are for mobs without eyes.
	// humans missing eyes will be caught by the is_blind check above.
	var/eye_goodness = isnull(eye) ? 0 : eye.damage
	var/little_bad = isnull(eye) ? 20 : eye.low_threshold
	var/very_bad = isnull(eye) ? 30 : eye.high_threshold

	if(user.has_status_effect(/datum/status_effect/eye_blur))
		eye_goodness = max(eye_goodness, very_bad + 1)
	if(user.is_nearsighted_currently())
		eye_goodness = max(eye_goodness, little_bad + 1)
	eye_goodness += ((get_dist(user, src) - 2) * 5) // add a modifier based on distance, so closer = "better", further = "worse"

	. += "<hr>Вы читаете таблицу, как когда-то у окулиста."
	if(eye_goodness <= 0)
		. += span_notice("\"Ш, Б, М...\" Да, вы читаете всё вплоть до [colorblind ? "коричневой (погодите, она разве не красная?)" : "красной"] черты.")
	else if(eye_goodness < little_bad)
		. += span_notice("\"Ш, Б, М...\" Большую часть букв вы разбираете, но ниже [colorblind ? "серой (погодите, она разве не зелёная?)" : "зелёной"] черты становится трудновато.")
	else if(eye_goodness < very_bad)
		. += span_warning("\"Ш, Б, М..?\" Крупные буквы вы разбираете, а мелкие расплываются.")
	else
		. += span_warning("\"Ш, Б, Н..?\" Вы и крупные-то буквы едва разбираете, не говоря уже о мелких.")
