/// The BYOND hub shows non-ASCII text as question marks
/proc/hub_safe_text(text, fallback)
	if(length(text) == length_char(text))
		return text
	return fallback
