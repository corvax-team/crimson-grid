/mob/living/carbon/human/proc/check_can_drink_dry(mob/living/drunk_from_mob)
	if(!get_kindred_splat(drunk_from_mob) || !get_kindred_splat(src))
		return TRUE

	if(!drunk_from_mob.client)
		to_chat(src, span_warning("Сначала нужно завладеть вниманием [drunk_from_mob.declent_ru(GENITIVE)]..."))
		return FALSE

	message_admins("[ADMIN_LOOKUPFLW(src)] is attempting to Diablerize [ADMIN_LOOKUPFLW(drunk_from_mob)]")
	log_attack("[key_name(src)] is attempting to Diablerize [key_name(drunk_from_mob)].")

	to_chat(src, span_userdanger(span_bold("ВЫ ПЫТАЕТЕСЬ СОВЕРШИТЬ ДИАБЛЕРИ. ЖЕРТВА: [drunk_from_mob.declent_ru(NOMINATIVE)].")))
	return TRUE
