/datum/reagent
	/// What a doctor calls this substance without knowing its exact name; null hides it from examinations
	var/medical_kind = "неизвестное вещество"

/datum/reagent/medicine
	medical_kind = "лекарство"

/datum/reagent/toxin
	medical_kind = "яд"

/datum/reagent/drug
	medical_kind = "наркотик"

/datum/reagent/consumable
	medical_kind = null

/datum/reagent/consumable/ethanol
	medical_kind = "алкоголь"

/datum/reagent/blood
	medical_kind = null

/// What a doctor recognises this substance as by its effect on the body
/datum/reagent/proc/get_medical_kind()
	if(TRAIT_ANALGESIA in metabolized_traits)
		return "обезболивающее"
	if(LAZYACCESS(addiction_types, /datum/addiction/opioids))
		return "опиат"
	if(LAZYACCESS(addiction_types, /datum/addiction/stimulants))
		return "стимулятор"
	if(LAZYACCESS(addiction_types, /datum/addiction/hallucinogens))
		return "галлюциноген"
	return medical_kind
