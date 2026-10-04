/datum/quirk/darkpack/stillness_of_death
	name = "Stillness of Death"
	ru_name = "Мёртвая неподвижность"
	desc = "Некоторые горгульи умеют обращать себе на пользу свой противоестественный облик, не-жизнь, каменный оттенок кожи и родство с камнем и бетоном, которое даёт Висцератика: они прячутся, притворяясь самыми настоящими статуями. Это достоинство позволяет горгулье принять \"форму статуи\" и замереть неподвижно, чтобы не нарушить Маскарад и обмануть случайных свидетелей."
	ttrpg_sources = list(/datum/source_book/vtm20/lotb = 37)
	value = 2
	mob_trait = TRAIT_STILLNESS_OF_DEATH
	gain_text = span_notice("Вам хватает смелости прятаться, притворяясь статуей.")
	lose_text = span_notice("Вам больше не хочется прятаться под видом статуи.")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_GARGOYLE)
	icon = FA_ICON_MOUNTAIN
	failure_message = "Вам больше не хочется прятаться под видом статуи."

/datum/quirk/darkpack/stillness_of_death/add(client/client_source)
	var/datum/action/gargoyle_statue_form/statue_action = new()
	statue_action.Grant(quirk_holder)

/datum/action/gargoyle_statue_form
	name = "Форма статуи"
	desc = "Замрите так неподвижно, что прохожие примут вас, с вашим каменным обликом, за обычную статую."
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "gargoyle"
	var/active = FALSE
	var/original_name

/datum/action/gargoyle_statue_form/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	if(!owner)
		return

	if(active)
		deactivate_statue()
	else
		activate_statue()

/datum/action/gargoyle_statue_form/proc/activate_statue()
	if(!owner || active)
		return
	original_name = owner.name
	active = TRUE
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, "statue_form")
	ADD_TRAIT(owner, TRAIT_MUTE, "statue_form")
	REMOVE_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, SUBSPLAT_TRAIT)
	owner.name = "статуя горгульи"
	var/newcolor = list(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0))
	owner.add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)

	to_chat(owner, span_notice("Вы обращаетесь в каменную статую: теперь вы неподвижны и безмолвны."))

/datum/action/gargoyle_statue_form/proc/deactivate_statue()
	if(!owner || !active)
		return

	active = FALSE

	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, "statue_form")
	REMOVE_TRAIT(owner, TRAIT_MUTE, "statue_form")
	ADD_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, SUBSPLAT_TRAIT)

	owner.remove_atom_colour(FIXED_COLOUR_PRIORITY)
	owner.name = original_name

	to_chat(owner, span_notice("Вы возвращаетесь в обычную форму."))

/datum/action/gargoyle_statue_form/Remove(mob/remove_from)
	if(active)
		deactivate_statue()
	return ..()
