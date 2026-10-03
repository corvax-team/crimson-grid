/obj/ritual_rune/abyss/identification
	name = "occult items identification"
	ru_name = "Опознание оккультных предметов"
	desc = "Раскрывает природу одного оккультного предмета."
	icon_state = "rune4"
	word = "WUS'ZAT"
	cost = 1

/obj/ritual_rune/abyss/identification/complete()
	. = ..()
	for(var/obj/item/occult_artifact/VA in loc)
		var/mob/living/carbon/human/identifier = usr
		if(VA.identified)
			to_chat(identifier, span_warning("Этот артефакт уже опознан."))
			return
		VA.identify()
		qdel(src)
		return
