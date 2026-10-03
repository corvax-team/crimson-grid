/obj/ritual_rune/thaumaturgy/identification
	name = "occult artifact identification"
	ru_name = "Опознание оккультного артефакта"
	desc = "Раскрывает природу одного оккультного предмета."
	icon_state = "rune4"
	word = "IN'DAR"

/obj/ritual_rune/thaumaturgy/identification/complete()
	. = ..()
	for(var/obj/item/occult_artifact/VA in loc)
		var/mob/living/carbon/human/identifier = usr
		if(VA.identified)
			to_chat(identifier, span_warning("Этот артефакт уже опознан."))
			return
		VA.identify()
		identifier.research_points += VA.research_value
		qdel(src)
		return

