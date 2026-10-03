// VTM pg. 481
/datum/quirk/darkpack/short
	name = "Short"
	ru_name = "Коротышка"
	desc = "Ваш рост намного ниже среднего. Вам трудно дотягиваться до предметов, рассчитанных на обычного взрослого, и пользоваться ими, а бегаете вы вдвое медленнее обычного человека."
	icon = FA_ICON_ARROW_DOWN
	value = -4 // Higher than in the ttrpg because it's a round-lasting debuff that'll be painful.
	mob_trait = TRAIT_DWARF // Grants passtable too, but it seems like the simplest way to lock them into being short?
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	gain_text = span_notice("Вы чувствуете себя ниже остальных.")
	lose_text = span_notice("Вы больше не кажетесь себе коротышкой.")
	failure_message = span_notice("Вы больше не кажетесь себе коротышкой.")

/*You are well below average height — four and a half feet (1.5 meters) tall or less.
You have difficulty reaching or manipulating objects designed for normal adult size,
and your running speed is one-half that of an average human.*/

/datum/movespeed_modifier/quirk_short
	multiplicative_slowdown = 2 // Play with this number?

/datum/quirk/darkpack/short/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.add_movespeed_modifier(/datum/movespeed_modifier/quirk_short)

/datum/quirk/darkpack/short/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.remove_movespeed_modifier(/datum/movespeed_modifier/quirk_short)
