/obj/ritual_rune/thaumaturgy/selfgib
	name = "self destruction"
	ru_name = "Самоуничтожение"
	desc = "Примите Окончательную смерть."
	icon_state = "rune2"
	word = "CHNGE DA'WORD, GDBE"

/obj/ritual_rune/thaumaturgy/selfgib/complete()
	. = ..()
	last_activator.death()

