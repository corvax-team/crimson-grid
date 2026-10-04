
/obj/structure/table/modern
	name = "modern table"
	desc = "Вызывающе модный стол из стеклопластика."
	icon = 'icons/obj/smooth_structures/alien_table.dmi'
	icon_state = "alien_table-0"
	base_icon_state = "alien_table"
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/sheet/iron
	buildstack = /obj/item/stack/sheet/plastic
	framestackamount = 1
	buildstackamount = 1
	smoothing_groups = SMOOTH_GROUP_ABDUCTOR_TABLES
	canSmoothWith = SMOOTH_GROUP_ABDUCTOR_TABLES

/obj/structure/table/countertop
	name = "countertop"
	desc = "Стойка на прочном основании."
	icon = 'icons/obj/smooth_structures/darkpack/bubway_table.dmi'
	icon_state = "bubway_table-0"
	base_icon_state = "bubway_table"
	abstract_type = /obj/structure/table/countertop
	max_integrity = 200
	can_flip = FALSE

/obj/structure/table/countertop/bubway
	desc = "Фирменная стойка, с которой отпускают еду."
	icon = 'icons/obj/smooth_structures/darkpack/bubway_table.dmi'
	icon_state = "bubway_table-0"
	base_icon_state = "bubway_table"
	smoothing_groups = SMOOTH_GROUP_BUB_TABLES
	canSmoothWith = SMOOTH_GROUP_BUB_TABLES


/obj/structure/table/countertop/bacotell
	desc = "Фирменная стойка, с которой отпускают еду."
	icon = 'icons/obj/smooth_structures/darkpack/bacotell_table.dmi'
	icon_state = "bacotell_table-0"
	base_icon_state = "bacotell_table"
	smoothing_groups = SMOOTH_GROUP_BACO_TABLES
	canSmoothWith = SMOOTH_GROUP_BACO_TABLES

/obj/structure/table/countertop/beige
	icon = 'icons/obj/smooth_structures/beigetop_table.dmi'
	icon_state = "beigetop_table-0"
	base_icon_state = "beigetop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/black
	icon = 'icons/obj/smooth_structures/blacktop_table.dmi'
	icon_state = "blacktop_table-0"
	base_icon_state = "blacktop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/green
	icon = 'icons/obj/smooth_structures/greentop_table.dmi'
	icon_state = "greentop_table-0"
	base_icon_state = "greentop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/purple
	icon = 'icons/obj/smooth_structures/purpletop_table.dmi'
	icon_state = "purpletop_table-0"
	base_icon_state = "purpletop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/red
	icon = 'icons/obj/smooth_structures/redtop_table.dmi'
	icon_state = "redtop_table-0"
	base_icon_state = "redtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/teal
	icon = 'icons/obj/smooth_structures/tealtop_table.dmi'
	icon_state = "tealtop_table-0"
	base_icon_state = "tealtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/yellow
	icon = 'icons/obj/smooth_structures/yellowtop_table.dmi'
	icon_state = "yellowtop_table-0"
	base_icon_state = "yellowtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/fastfood
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table.dmi'
	icon_state = "fastfood_table-0"
	base_icon_state = "fastfood_table"
	smoothing_groups = SMOOTH_GROUP_FF_TABLES
	canSmoothWith = SMOOTH_GROUP_FF_TABLES

/obj/structure/table/countertop/fastfood/addon1
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon1.dmi'
	icon_state = "fastfood_table_addon1-0"
	base_icon_state = "fastfood_table_addon1"

/obj/structure/table/countertop/fastfood/addon2
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon2.dmi'
	icon_state = "fastfood_table_addon2-0"
	base_icon_state = "fastfood_table_addon2"

/obj/structure/table/countertop/fastfood/addon3
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon3.dmi'
	icon_state = "fastfood_table_addon3-0"
	base_icon_state = "fastfood_table_addon3"

/obj/structure/table/countertop/fastfood/rand // Should probably use sparingly...
	var/list/possible_icons = list('icons/obj/smooth_structures/darkpack/fastfood_table.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon1.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon2.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon3.dmi')
	var/list/possible_icon_states = list("fastfood_table-0", "fastfood_table_addon1-0",
		"fastfood_table_addon2-0", "fastfood_table_addon3-0")
	var/list/possible_base_icon_states = list("fastfood_table", "fastfood_table_addon1",
		"fastfood_table_addon2", "fastfood_table_addon3")

/obj/structure/table/countertop/fastfood/rand/Initialize(mapload)
	. = ..()
	icon = pick(possible_icons)
	icon_state = possible_icon_states[possible_icons.Find(icon)]
	base_icon_state = possible_base_icon_states[possible_icons.Find(icon)]

/obj/structure/table/wood/bar
	desc = "Довольно изящный ресторанный столик. Одна ножка, прикрученная к полу, - вот это дизайн!"
	icon_state = "table-0"
	base_icon_state = "table"
	icon = 'modular_darkpack/modules/decor/icons/table_wood_bar.dmi'
	can_flip = FALSE

/obj/structure/table/no_smooth
	abstract_type = /obj/structure/table/no_smooth
	icon = 'modular_darkpack/modules/decor/icons/standalone_tables.dmi'
	base_icon_state = "table_wood_stand"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	can_flip = FALSE

/obj/structure/table/no_smooth/modular_desk
	name = "wood desk"
	desc = "Компактный деревянный письменный стол. За такими сидят самые разные деловые люди."
	icon = 'modular_darkpack/modules/decor/icons/modular_tables.dmi'
	icon_state = "desk_wood_mid"
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/table/no_smooth/modular_desk/left
	icon_state = "desk_wood_left"

/obj/structure/table/no_smooth/modular_desk/right
	icon_state = "desk_wood_right"

/obj/structure/table/no_smooth/modular_desk/corner
	icon_state = "desk_wood_corner"

// Metal Non-Smoothing tables //

/obj/structure/table/no_smooth/metal
	name = "metal table"
	desc = "Стол, который по последнему слову техники сделали... круглым."
	icon_state = "table_metal_round"
	base_icon_state = "table_metal_round"
	max_integrity = 225
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/rods
	buildstack = /obj/item/stack/sheet/iron

/obj/structure/table/no_smooth/metal/Initialize(mapload)
	. = ..()
	if(prob(35))
		icon_state = "[base_icon_state]-[rand(1,2)]"

// Rolling table

/obj/structure/table/rolling/darkpack
	desc = "Столик на колёсах \"Rolly poly\" от " + BRAND_DEPARTMENT_STORE_COMPANY_2 + ". Он может укатиться - и укатится."
	icon = 'modular_darkpack/modules/decor/icons/standalone_tables.dmi'
	icon_state = "table_rolling"

// Large tables //

/obj/structure/table/no_smooth/large
	name = "base class large ms13 table"
	desc = "CALL A CODER, CALL A CODER. For ME!"
	icon = 'modular_darkpack/modules/decor/icons/64x64_large_tables.dmi'
	icon_state = "table_wood_wide_square"

/obj/structure/table/no_smooth/large/Initialize(mapload)
	. = ..()
	if(dir == NORTH)
		bound_width = 64

	if(dir == EAST)
		bound_height = 64

	if(dir == SOUTH)
		bound_width = 64

	if(dir == WEST)
		bound_height = 64

// Metal Large tables /

/obj/structure/table/no_smooth/large/metal
	name = "metal table"
	desc = "Прочный широкий металлический стол. Ничего примечательного."
	icon_state = "table_metal_wide"
	max_integrity = 300
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/rods
	buildstack = /obj/item/stack/sheet/iron

/obj/structure/table/no_smooth/large/metal/desk
	name = "metal desk"
	desc = "Прочный широкий металлический стол. Ничего примечательного."
	icon_state = "desk_metal"

/obj/structure/table/no_smooth/large/metal/desk/alt
	name = "metal desk"
	desc = "Компактный металлический стол. За такими сидят люди, которым без вас работалось бы куда легче."
	icon_state = "desk_metal_small"

// Wood Non-Smoothing tables //

/obj/structure/table/no_smooth/wood
	name = "wood table"
	desc = "Простой круглый деревянный стол. Вам бы так уметь."
	icon_state = "table_wood_round"
	max_integrity = 150
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/table/no_smooth/wood/square
	name = "wood table"
	desc = "Простой квадратный деревянный стол. Вам бы так уметь."
	icon_state = "table_wood_square"

/obj/structure/table/no_smooth/wood/low
	name = "coffee table"
	desc = "Низкий столик, на который складывают всё подряд, не вставая с дивана."
	icon_state = "table_wood_low"

/obj/structure/table/no_smooth/wood/stand
	name = "bed stand"
	desc = "Высокая тумбочка. Встречается у кроватей и на свалках."
	icon_state = "table_wood_stand"

/obj/structure/table/no_smooth/wood/end
	name = "console end"
	desc = "Приставная секция к консоли, продаётся отдельно. Ещё больше места для книг, которые вы так и не прочтёте!"
	icon_state = "table_wood_end"

/obj/structure/table/no_smooth/wood/cablereel
	name = "cable reel"
	desc = "Когда-то на ней был медный кабель, теперь - что придётся."
	icon_state = "cable_reel"

// Wood Large tables //

/obj/structure/table/no_smooth/large/wood
	name = "wood table"
	desc = "Большой овальный деревянный стол. Идеален для семейных фотографий, которых у вас нет."
	icon_state = "table_wood_wide_oval"
	max_integrity = 200
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/table/no_smooth/large/wood/square
	desc = "Большой прямоугольный деревянный стол. Очень крепкий."
	icon_state = "table_wood_wide_square"

/obj/structure/table/no_smooth/large/wood/desk
	name = "wood desk"
	desc = "Полноразмерный деревянный письменный стол. За такими сидят люди, которым без вас работалось бы куда легче."
	icon_state = "desk_wood"

/obj/structure/table/no_smooth/large/wood/desk/alt
	name = "wood desk"
	desc = "Компактный деревянный письменный стол. За такими сидят самые разные деловые люди."
	icon_state = "desk_wood_small"

/obj/structure/table/no_smooth/large/wood/stand
	name = "wood console"
	desc = "Гладкая консоль от IDEA. В основном просто украшает комнату."
	icon_state = "stand_wood"

/obj/structure/table/no_smooth/large/wood/stand/alt
	icon_state = "stand_wood_small"

//Misc tables //

/obj/structure/table/no_smooth/dice
	name = "dice table"
	desc = "Сыграйте с друзьями в кости. Желательно в игральные."
	icon_state = "dice_dirty"
	max_integrity = 150
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/tile/carpet/red

/obj/structure/table/no_smooth/dice/pristine
	icon_state = "dice_clean"
	max_integrity = 200


// Misc Large tables //

/obj/structure/table/no_smooth/large/cards
	name = "cards table"
	desc = "Выглядит шикарно. Сразу вспоминается тот случай в Лас-Вегасе..."
	icon_state = "table_cards"
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/tile/carpet/purple
