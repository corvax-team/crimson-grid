// I know, you were expecting more, right?
// Nah just kidding, search "can see you!" in code/modules/mob/living/carbon/examine.dm

// Okay, you came back thinking there was more, right? no thats it.

/mob/dead/observer/get_status_tab_items()
	. = ..()
	if(!GLOB.observer_default_invisibility)
		. += "Живые видят призраков!"
	else if (!invisibility)
		. += "Живые вас видят!"
	else if (invisibility <= SEE_INVISIBLE_LIVING)
		. += "Вас видит большинство живых существ!"
