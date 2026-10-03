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

/datum/quirk
	/// Russian name shown to players, name stays the key saved in preferences
	var/ru_name

/datum/quirk/proc/get_display_name()
	return ru_name || name

/datum/quirk/bilingual
	ru_name = "Дополнительный язык"

/datum/quirk/item_quirk/signer
	ru_name = "Язык жестов"

/datum/quirk/poor_aim
	ru_name = "Меткость штурмовика"

/datum/quirk/item_quirk/scarred_eye
	ru_name = "Одноглазость"

/datum/bodypart_overlay/simple/clan_mark
	/// Russian name shown to players, the stored value is built from the typepath
	var/ru_name

/obj/ritual_rune
	/// Russian ritual name shown in tomes and pickers, name stays English
	var/ru_name

/obj/ritual_rune/Initialize(mapload)
	. = ..()
	if(!ru_name)
		return
	ritual_name = ru_name
	ru_names_rename(ru_names_list(initial(name), "руна \"[ru_name]\"", "руны \"[ru_name]\"", "руне \"[ru_name]\"", "руну \"[ru_name]\"", "руной \"[ru_name]\"", "руне \"[ru_name]\"", FEMALE))

// the base type appends " rune" to name, so the lookup by name in /atom/New would wipe the declensions
/obj/ritual_rune/ru_names_rename(list/new_list)
	if(ru_name && new_list?["base"] != initial(name))
		return
	return ..()

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
