/datum/quirk/darkpack/eat_food
	name = "Eat Food"
	ru_name = "Железное нутро"
	desc = "В отличие от большинства немёртвых, вы сохранили способность нормально есть и переваривать пищу, словно отголосок смертной жизни. Еда вас не насыщает, но вы можете есть без отвращения, обычного для Сородичей. Но учтите: всё съеденное рано или поздно выйдет обратно."
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 1
	mob_trait = TRAIT_EAT_FOOD
	gain_text = span_notice("В животе что-то шевелится: желудок оживает. Теперь вы можете есть обычную пищу.")
	lose_text = span_notice("Вы теряете способность есть обычную пищу.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_UTENSILS

/datum/quirk/darkpack/eat_food/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	var/obj/item/organ/tongue/tongue = human_holder.get_organ_by_type(/obj/item/organ/tongue)
	tongue?.liked_foodtypes = initial(tongue.liked_foodtypes)
	tongue?.disliked_foodtypes = initial(tongue.disliked_foodtypes)
	tongue?.toxic_foodtypes = initial(tongue.toxic_foodtypes)
