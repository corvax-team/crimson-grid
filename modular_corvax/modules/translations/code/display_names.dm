/datum/subsplat
	/// Russian name shown to players, name stays the internal key
	var/ru_name

/datum/subsplat/proc/get_display_name()
	return ru_name || name

/datum/morality
	/// Russian name shown to players, name stays the internal key
	var/ru_name

/datum/morality/proc/get_display_name()
	return ru_name || name

/datum/splat
	/// Russian name shown to players, name stays the internal key
	var/ru_name

/datum/splat/proc/get_display_name()
	return ru_name || name

/datum/bodypart_overlay/simple/clan_mark
	/// Russian name shown to players, the stored value is built from the typepath
	var/ru_name

/datum/preference/external_choiced/compile_constant_data()
	var/list/display_names = get_display_names()
	if(!length(display_names))
		return null
	return list(CHOICED_PREFERENCE_DISPLAY_NAMES = display_names)

/// Picker labels mapped back to the stored values
/datum/preference/external_choiced/proc/get_choice_labels(datum/preferences/preferences)
	var/list/labels = list()
	for(var/choice in get_choices(preferences))
		labels[get_choice_label(choice)] = choice
	return labels

/datum/preference/external_choiced/proc/get_choice_label(value)
	return get_display_names()?[value] || value

/// Stored value -> label shown to the player, null to show the stored values as is
/datum/preference/external_choiced/proc/get_display_names()
	return null

/// Russian picker labels mapped back to the keys of GLOB.aura_list
/proc/aura_emotion_labels()
	var/static/list/labels
	if(!labels)
		labels = list()
		for(var/emotion in GLOB.emotion_to_quality)
			labels[capitalize(GLOB.emotion_to_quality[emotion])] = emotion
		labels = sort_list(labels)
	return labels
