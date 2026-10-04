/datum/quirk/darkpack/huge_size
	name = "Huge size"
	ru_name = "Гигант"
	desc = "Вы необычайно велики: рост не меньше 208 см, вес от 136 кг. Вас трудно не заметить на людях, зато лишняя масса даёт вам 20 дополнительных единиц здоровья. Персонажам с этим достоинством также проще выбивать двери."
/* Characters with this Merit may
also gain bonuses to push objects, open barred doors,
avoid being knocked down, etc*/
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	mob_trait = TRAIT_HUGE_SIZE
	icon = FA_ICON_ARROW_UP
	value = 4
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	gain_text = span_notice("Вы чувствуете себя крупнее остальных.")
	lose_text = span_notice("Вы больше не кажетесь себе великаном.")
	failure_message = span_notice("Вы больше не кажетесь себе великаном.")


/datum/quirk/darkpack/huge_size/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.maxHealth += 20
	human_holder.health += 20
	human_holder.update_transform(1.25) //Same as TRAIT_GIANT. Maybe a bit excessive.

/datum/quirk/darkpack/huge_size/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.maxHealth -= 20
	human_holder.health -= 20
	human_holder.update_transform(1)
