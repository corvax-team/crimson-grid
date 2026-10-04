/obj/machinery/computer/stockexchange
	name = "stock exchange computer"
	desc = "Терминал с выходом на фондовую биржу. Торговля акциями сопряжена с серьёзным риском потерь и подходит далеко не каждому кладовщику."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = MAP_SWITCH("oldcomp", "/obj/machinery/computer/pod/old")
	icon_screen = "stock_computer"
	icon_keyboard = null
	var/logged_in = "Millenium Stock Department"
	var/vmode = 1
	interaction_flags_atom = INTERACT_ATOM_REQUIRES_DEXTERITY | INTERACT_ATOM_UI_INTERACT | INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_REQUIRES_ANCHORED

	light_color = LIGHT_COLOR_GREEN

//i just removed all the stupid flavcode shit that was here. it was not worth looking at.
// DARKPACK TODO - Stock market rework
