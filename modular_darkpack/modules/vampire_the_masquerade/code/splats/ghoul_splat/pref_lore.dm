/datum/splat/vampire/ghoul/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#ac151d", update = FALSE)
	human.set_hairstyle("Long Fringe", update = TRUE)
	human.set_eye_color("#2D4118")
	human.undershirt = "Tank Top (Fire)"
	human.update_body()

/datum/splat/vampire/ghoul/get_splat_description()
	return "Смертные, которых поддерживает и связывает вампирская витэ: она дарит им неестественную живучесть, вечную молодость и душевную зависимость от домитора. Одни служат по своей воле, из внушённой витэ любви, преданности или честолюбия, другие же просто не могут вырваться из уз крови и собственной тяги.\n\nПо всему миру гули служат Сородичам любой секты и фракции телохранителями, слугами, агентами и посредниками. Они сильнее обычных людей и могут действовать днём, но остаются беззащитны перед прихотями и интригами общества Сородичей и собственных хозяев."

// Pulled straight from the wiki https://whitewolf.fandom.com/wiki/Ghoul_(VTM)
/datum/splat/vampire/ghoul/get_splat_lore()
	return list(
		"Напоите почти любое живое существо вампирской кровью, и оно станет гулем, по крайней мере на время. В мире Маскарада гули - вездесущие слуги, которых легко создать и с которыми обращаются хуже некуда, хотя существуют и тайные сети, помогающие им бежать от хозяев. Пьянящий наркотик витэ в жилах, не говоря уже об узах крови, доводит чувства гуля до крайностей: такое существо нередко становится жертвой приступов гнева и пугающих влечений. Гулей прозвали гулями не случайно."
	)

/datum/splat/vampire/ghoul/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_DROPLET,
			SPECIES_PERK_NAME = "Узы",
			SPECIES_PERK_DESC = "Гули, как правило, связаны узами крови и исполняют волю хозяина.",
		),
	)

	return to_add
