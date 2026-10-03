/obj/structure/sign/flag/pride
	name = "coder pride flag"
	desc = "Вообще-то вы не должны этого видеть. Пожалуйтесь кодерам."
	icon = 'modular_darkpack/modules/flags/icons/pride_flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride, 32)

/obj/structure/sign/flag/pride/click_alt(mob/user)
	var/init_icon_state = initial(icon_state)
	if(icon_state == init_icon_state)
		icon_state = "[icon_state]_vertical"
	else
		icon_state = init_icon_state
	return CLICK_ACTION_SUCCESS

/obj/structure/sign/flag/pride/gay
	name = "gay pride flag"
	desc = "Флаг ЛГБТ-прайда."
	icon_state = "flag_pride"
	item_flag = /obj/item/sign/flag/pride/gay

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/gay, 32)

/obj/structure/sign/flag/pride/ace
	name = "asexual pride flag"
	desc = "Флаг асексуального прайда."
	icon_state = "flag_ace"
	item_flag = /obj/item/sign/flag/pride/ace

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/ace, 32)

/obj/structure/sign/flag/pride/bi
	name = "bisexual pride flag"
	desc = "Флаг бисексуального прайда."
	icon_state = "flag_bi"
	item_flag = /obj/item/sign/flag/pride/bi

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/bi, 32)

/obj/structure/sign/flag/pride/lesbian
	name = "lesbian pride flag"
	desc = "Флаг лесбийского прайда."
	icon_state = "flag_lesbian"
	item_flag = /obj/item/sign/flag/pride/lesbian

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/lesbian, 32)

/obj/structure/sign/flag/pride/pan
	name = "pansexual pride flag"
	desc = "Флаг пансексуального прайда."
	icon_state = "flag_pan"
	item_flag = /obj/item/sign/flag/pride/pan

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/pan, 32)

/obj/structure/sign/flag/pride/trans
	name = "trans pride flag"
	desc = "Флаг транс-прайда."
	icon_state = "flag_trans"
	item_flag = /obj/item/sign/flag/pride/trans

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/trans, 32)

/obj/structure/sign/flag/pride/mlm
	name = "men-loving-men pride flag"
	desc = "Флаг прайда мужчин, любящих мужчин."
	icon_state = "flag_mlm"
	item_flag = /obj/item/sign/flag/pride/mlm

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/mlm, 32)

/obj/structure/sign/flag/pride/rabies
	name = "rabies pride flag"
	desc = "Флаг прайда бешенства."
	icon_state = "flag_rabies"
	item_flag = /obj/item/sign/flag/pride/rabies

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/rabies, 32)

/obj/structure/sign/flag/pride/enby
	name = "non-binary pride flag"
	desc = "Флаг небинарного прайда."
	icon_state = "flag_enby"
	item_flag = /obj/item/sign/flag/pride/enby

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/enby, 32)

/obj/structure/sign/flag/pride/inter
	name = "intersex pride flag"
	desc = "Флаг интерсекс-прайда."
	icon_state = "flag_inter"
	item_flag = /obj/item/sign/flag/pride/inter

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/inter, 32)

// FOLDED

/obj/item/sign/flag/pride
	name = "folded coder pride flag"
	desc = "Вообще-то вы не должны этого видеть. Пожалуйтесь кодерам."
	icon = 'modular_darkpack/modules/flags/icons/pride_flags.dmi'

/obj/item/sign/flag/pride/choose
	name = "folded unknown pride flag"
	desc = "Возьмите в руку, чтобы выбрать флаг."

/obj/item/sign/flag/pride/choose/attack_hand(mob/user)
	. = ..()
	var/list/flag_options = list()
	for(var/obj/item/sign/flag/pride/flag_type as anything in subtypesof(/obj/item/sign/flag/pride) - /obj/item/sign/flag/pride/choose)
		flag_options[capitalize(declent_ru_initial(initial(flag_type.name), NOMINATIVE, initial(flag_type.name)))] = flag_type
	var/obj/item/chosen_flag = flag_options[tgui_input_list(user, "Какой у вас был флаг?", "Выбор флага", flag_options)]
	if(!ispath(chosen_flag))
		return
	var/obj/item/created_flag = new chosen_flag(loc)
	qdel(src)
	user.put_in_hands(created_flag)

/obj/item/sign/flag/pride/gay
	name = "folded gay pride flag"
	desc = "Сложенный флаг ЛГБТ-прайда."
	icon_state = "folded_pride"
	sign_path = /obj/structure/sign/flag/pride/gay

/obj/item/sign/flag/pride/ace
	name = "folded asexual pride flag"
	desc = "Сложенный флаг асексуального прайда."
	icon_state = "folded_pride_ace"
	sign_path = /obj/structure/sign/flag/pride/ace

/obj/item/sign/flag/pride/bi
	name = "folded bisexual pride flag"
	desc = "Сложенный флаг бисексуального прайда."
	icon_state = "folded_pride_bi"
	sign_path = /obj/structure/sign/flag/pride/bi

/obj/item/sign/flag/pride/lesbian
	name = "folded lesbian pride flag"
	desc = "Сложенный флаг лесбийского прайда."
	icon_state = "folded_pride_lesbian"
	sign_path = /obj/structure/sign/flag/pride/lesbian

/obj/item/sign/flag/pride/pan
	name = "folded pansexual pride flag"
	desc = "Сложенный флаг пансексуального прайда."
	icon_state = "folded_pride_pan"
	sign_path = /obj/structure/sign/flag/pride/pan

/obj/item/sign/flag/pride/trans
	name = "folded trans pride flag"
	desc = "Сложенный флаг транс-прайда."
	icon_state = "folded_pride_trans"
	sign_path = /obj/structure/sign/flag/pride/trans

/obj/item/sign/flag/pride/mlm
	name = "folded men-loving-men pride flag"
	desc = "Сложенный флаг прайда мужчин, любящих мужчин."
	icon_state = "folded_pride_mlm"
	sign_path = /obj/structure/sign/flag/pride/mlm

/obj/item/sign/flag/pride/rabies
	name = "folded rabies pride flag"
	desc = "Сложенный флаг прайда бешенства."
	icon_state = "folded_pride_rabies"
	sign_path = /obj/structure/sign/flag/pride/rabies

/obj/item/sign/flag/pride/enby
	name = "folded non-binary pride flag"
	desc = "Сложенный флаг небинарного прайда."
	icon_state = "folded_pride_enby"
	sign_path = /obj/structure/sign/flag/pride/enby

/obj/item/sign/flag/pride/inter
	name = "folded intersex pride flag"
	desc = "Сложенный флаг интерсекс-прайда."
	icon_state = "folded_pride_inter"
	sign_path = /obj/structure/sign/flag/pride/inter
