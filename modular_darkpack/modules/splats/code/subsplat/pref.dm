/datum/preference/choiced/subsplat
	abstract_type = /datum/preference/choiced/subsplat
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/subsplat/compile_constant_data()
	var/list/data = ..()
	var/list/display_names = list()
	for(var/datum/subsplat/subsplat as anything in valid_subtypesof(/datum/subsplat))
		if(subsplat::name in data["choices"])
			display_names[subsplat::name] = subsplat::ru_name || subsplat::name
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = display_names
	return data
