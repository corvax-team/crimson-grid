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

/// Russian picker labels mapped back to the keys of GLOB.aura_list
/proc/aura_emotion_labels()
	var/static/list/labels
	if(!labels)
		labels = list()
		for(var/emotion in GLOB.emotion_to_quality)
			labels[capitalize(GLOB.emotion_to_quality[emotion])] = emotion
		labels = sort_list(labels)
	return labels
