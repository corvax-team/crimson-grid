// from clanbook tremere revised page 58

/obj/ritual_rune/thaumaturgy/inscription
	name = "inscription"
	ru_name = "Начертание"
	desc = "Создаёт свиток, исписанный витэ. С ним ритуал первого или второго уровня сможет провести и неопытный тауматург, и тот, кто Тауматургией не владеет вовсе."
	icon_state = "rune5"
	word = ""
	level = 2
	sacrifices = list(/obj/item/paper)
	var/obj/ritual_rune/ritual_selected

/obj/ritual_rune/thaumaturgy/inscription/attack_hand(mob/living/user)
	var/datum/action/ritual_drawing/ritual_action = locate() in user.actions
	if(!ritual_action)
		return

	var/list/ritual_selection = ritual_action.get_available_runes()

	for(var/ritual_name in ritual_selection)
		var/list/ritual_data = ritual_selection[ritual_name]
		if(ritual_data["level"] > 2 || ritual_data["path"] == type)
			ritual_selection -= ritual_name

	var/selection = tgui_input_list(user, "Какой ритуал вы хотите начертать на свитке?", "Начертание", ritual_selection)
	if(!selection)
		to_chat(user, span_cult("Вы решаете не наносить ритуал на пергамент."))
		return FALSE

	ritual_selected = ritual_selection[selection]["path"]
	. = ..()

/obj/ritual_rune/thaumaturgy/inscription/complete()
	. = ..()

	if(!ritual_selected)
		to_chat(last_activator, span_cult("Вы не выбрали ритуал для начертания."))
		return

	var/obj/item/thaumaturgy_scroll/ritual_scroll = new(loc)
	var/ritual_title = initial(ritual_selected.ru_name) || initial(ritual_selected.name)
	ritual_scroll.ru_names_rename(ru_names_toml(ritual_scroll.name, suffix = " (\"[ritual_title]\")", override_base = ritual_scroll.name))
	ritual_scroll.name = "thaumaturgy scroll ([initial(ritual_selected.name)])"
	ritual_scroll.desc = "Свиток, исписанный витэ. Его владелец может провести ритуал \"[ritual_title]\", не владея Тауматургией. Описание ритуала: [initial(ritual_selected.desc)]"
	ritual_scroll.ritual = ritual_selected

	to_chat(last_activator, span_cult("Силой Тауматургии вы выводите на бумаге письмена собственной витэ. Теперь начертанный ритуал сможет провести и неопытный тауматург, и тот, кто вовсе не сведущ в Тауматургии."))
	qdel(src)

/obj/item/thaumaturgy_scroll
	name = "thaumaturgy scroll"
	desc = "Свиток, с которым тауматургический ритуал проведёт и тот, кто не владеет Тауматургией."
	icon = 'modular_darkpack/modules/ritual_thaumaturgy/icons/ritual_scroll.dmi'
	icon_state = "scroll"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ritual_thaumaturgy/icons/onfloor.dmi')
	var/obj/ritual_rune/ritual

/obj/item/thaumaturgy_scroll/attack_self(mob/living/user)
	if(!ritual)
		to_chat(user, span_cult("Свиток пуст: проводить нечего."))
		return

	to_chat(user, span_cult("Вы разворачиваете свиток и, следуя указаниям, проводите ритуал \"[initial(ritual.ru_name) || initial(ritual.name)]\"."))

	var/obj/ritual_rune/R = new ritual(user.loc)
	R.required_discipline = null // no discipline required to use the ritual
	R.attack_hand(user)

	qdel(src)
