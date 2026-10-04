/obj/structure/food_cart
	name = "food cart"
	desc = "Динь-дилинь, динь-дон! Подходите за своей порцией холестерина!"
	icon = 'modular_darkpack/modules/food/icons/food_cart.dmi'
	icon_state = "vat1"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/food_cart/Initialize(mapload)
	. = ..()
	icon_state = "vat[rand(1, 3)]"

/obj/machinery/reagentgrinder/kitchen
	name = "kitchen mixer"
	//beaker_type = /obj/item/reagent_containers/glass/mixing_bowl
