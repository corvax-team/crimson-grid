/datum/preference/choiced/fera_feature
	abstract_type = /datum/preference/choiced/fera_feature
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	// must_have_relevant_trait = TRUE
	must_be_accessible = TRUE
	var/feature_key
	var/splat_id

/datum/preference/choiced/fera_feature/init_possible_values()
	return assoc_to_keys_features(SSaccessories.feature_list[feature_key])


/datum/preference/choiced/fera_feature/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features[feature_key] = value

/datum/preference/choiced/fera_feature/is_accessible(datum/preferences/preferences)
	. = ..()
	var/datum/splat/splat_path = preferences.read_preference(/datum/preference/choiced/splats)
	if(!ispath(splat_path) || splat_path::id != splat_id)
		return FALSE

/datum/preference/choiced/fera_feature/compile_constant_data()
	var/list/data = ..()
	var/alist/accessories = SSaccessories.feature_list[feature_key]
	var/list/display_names = list()
	for(var/choice in data["choices"])
		var/datum/sprite_accessory/fera_feature/accessory = accessories?[choice]
		display_names[choice] = (istype(accessory) && accessory.ru_name) || choice
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = display_names
	return data


/datum/sprite_accessory/fera_feature
	abstract_type = /datum/sprite_accessory/fera_feature
	/// Russian name shown to players, name stays the saved key
	var/ru_name
