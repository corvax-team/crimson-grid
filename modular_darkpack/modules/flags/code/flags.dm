/obj/structure/sign/flag
	name = "blank flag"
	desc = "Флаг ничего. На нём ничего нет. Великолепно."
	custom_materials = null
	buildable_sign = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/flag/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/sign/flag/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		if(!item_flag || src.obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
			return
		if(!user.can_perform_action(src, NEED_DEXTERITY))
			return
		user.visible_message(span_notice("[user] снимает и складывает [declent_ru(ACCUSATIVE)]."), span_notice("Вы снимаете и складываете [declent_ru(ACCUSATIVE)]."))
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		user.put_in_hands(flag_item)
		qdel(src)


/obj/item/sign/flag
	name = "folded blank flag"
	desc = "Сложенный флаг ничего. На нём ничего нет. Красота."
	icon_state = "folded_coder"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'
	custom_materials = null
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE

///Since all of the signs rotate themselves on initialisation, this made folded flags look ugly (and more importantly rotated).
///And thus, it gets removed to make them aesthetically pleasing once again.
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/item/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

// Subtypes

/obj/structure/sign/flag/usa
	name = "flag of the United States"
	desc = "Флаг Соединённых Штатов Америки. На Бога уповаем!"
	icon_state = "flag_usa"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/usa, 32)

/obj/structure/sign/flag/california
	name = "flag of California"
	desc = "Флаг великого штата Калифорния. Эврика!"
	icon_state = "flag_california"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/california, 32)

/obj/structure/sign/flag/california/rare
	var/always = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/califorina/rare, 32)

/obj/structure/sign/flag/california/rare/Initialize(mapload)
	. = ..()
	if(prob(1) || always)
		ru_names_rename(ru_names_toml("flag of New California", override_base = initial(name)))
		name = "flag of New California"
		desc = "Флаг великого штата... он что, всегда так выглядел?"
		icon_state = "flag_california_rare"

/obj/structure/sign/flag/britain
	name = "flag of Great Britain"
	desc = "Флаг Соединённого Королевства Великобритании и Северной Ирландии. Dieu et mon droit!"
	icon_state = "flag_britain"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/britain, 32)

/obj/structure/sign/flag/france
	name = "flag of France"
	desc = "Флаг Французской Республики. Liberte, egalite, fraternite!"
	icon_state = "flag_france"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/france, 32)

/obj/structure/sign/flag/germany
	name = "flag of Germany"
	desc = "Флаг Федеративной Республики Германия."
	icon_state = "flag_germany"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/germany, 32)

/obj/structure/sign/flag/spain
	name = "flag of Spain"
	desc = "Флаг Королевства Испания. Plus ultra!"
	icon_state = "flag_spain"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/spain, 32)

/obj/structure/sign/flag/italy
	name = "flag of Italy"
	desc = "Флаг Итальянской Республики."
	icon_state = "flag_italy"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/italy, 32)

/obj/structure/sign/flag/vatican
	name = "flag of the Vatican"
	desc = "Флаг Ватикана."
	icon_state = "flag_vatican"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/vatican, 32)

/obj/structure/sign/flag/russia
	name = "flag of Russia"
	desc = "Флаг Российской Федерации."
	icon_state = "flag_russia"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/russia, 32)

/obj/structure/sign/flag/soviet
	name = "flag of the Soviet Union"
	desc = "Флаг Союза Советских Социалистических Республик. Пролетарии всех стран, соединяйтесь!"
	icon_state = "flag_soviet"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/soviet, 32)

/obj/structure/sign/flag/china
	name = "flag of China"
	desc = "Флаг Китайской Народной Республики."
	icon_state = "flag_china"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/china, 32)

/obj/structure/sign/flag/taiwan
	name = "flag of Taiwan"
	desc = "Флаг Китайской Республики."
	icon_state = "flag_taiwan"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/taiwan, 32)

/obj/structure/sign/flag/japan
	name = "flag of Japan"
	desc = "Флаг Японии."
	icon_state = "flag_japan"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/japan, 32)

/obj/structure/sign/flag/anarchy
	name = "anarchist flag"
	desc = "Флаг анархистского движения."
	icon_state = "flag_anarchy"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/anarchy, 32)
