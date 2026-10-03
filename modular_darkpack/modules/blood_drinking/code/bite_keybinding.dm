/datum/keybinding/human/bite
	hotkey_keys = list("V")
	name = "bite"
	full_name = "Укусить"
	description = "Укусить того, кого вы держите агрессивным захватом, и по возможности испить его крови."
	keybind_signal = COMSIG_KB_HUMAN_BITE_DOWN

/datum/keybinding/human/bite/down(client/user)
	. = ..()
	if(.)
		return

	if(ishuman(user.mob))
		var/mob/living/carbon/human/human_user = user.mob
		human_user.vamp_bite()

	return TRUE
