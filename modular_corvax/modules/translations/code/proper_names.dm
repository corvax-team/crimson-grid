/mob/living/carbon/human/update_visible_name()
	SIGNAL_HANDLER
	. = ..()
	name = ru_proper_name(name)

/// BYOND puts "the" before names starting with a lowercase letter, like "молодой человек"
/proc/ru_proper_name(name)
	var/first_letter = copytext_char(name, 1, 2)
	if(first_letter == uppertext(first_letter))
		return name
	return "\proper [name]"
