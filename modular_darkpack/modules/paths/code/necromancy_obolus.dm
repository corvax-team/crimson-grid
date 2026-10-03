/obj/item/coin/iron/obolus
	name = "obolus"
	desc = "Серовато-голубая монета, от которой исходит мягкий сумеречный свет. Стоит к ней прикоснуться, и она будто начинает тихо стонать и скорбно причитать..."
	pickup_sound = 'modular_darkpack/modules/toys/sounds/femurbreaker.ogg'

/obj/item/coin/iron/obolus/Initialize(mapload)
	. = ..()
	pickup_sound = pick(list('modular_darkpack/modules/toys/sounds/femurbreaker.ogg', 'sound/effects/curse/curse1.ogg', 'sound/effects/curse/curse4.ogg', 'sound/effects/curse/curse5.ogg', 'sound/effects/curse/curse6.ogg', 'sound/effects/hallucinations/behind_you1.ogg', 'sound/effects/ghost.ogg'))
	AddComponent(/datum/component/selling, 700, "artifact", FALSE, 0, 10, TRUE)
