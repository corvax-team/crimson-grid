/obj/item/storage/pill_bottle/ephedrine
	name = "ephedrine pill bottle"
	desc = "На крышке значок: содержит наркотическое вещество."
	spawn_count = 10
	spawn_type = /obj/item/reagent_containers/applicator/pill/ephedrine
	custom_price = 200

/obj/item/reagent_containers/applicator/pill/ephedrine
	name = "ephedrine pill"
	desc = "Помогает стабилизировать пациента."
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/medicine/ephedrine = 15)
	rename_with_volume = TRUE

//Sugar pills

/datum/reagent/drug/placebatol
	name = "Placebatol"
	description = "Порошок без цвета и запаха, который иногда выписывают врачи. Возможно, он вообще ничего не делает...?"
	//reagent_state = SOLID
	color = "#f5f5f0"
	metabolization_rate = REAGENTS_METABOLISM * 0.25
	taste_description = "сахара" //effectively a sugar pill, but sugar actually has a use

/obj/item/reagent_containers/applicator/pill/placebatol
	name = "prescription pill"
	desc = "Таблетка из спрессованного белого порошка. Принимать по назначению врача."
	icon_state = "pill9"
	list_reagents = list(/datum/reagent/drug/placebatol = 10)

/obj/item/storage/pill_bottle/estrogen
	name = "estrogen pill bottle"
	desc = "На крышке нарисована грудь."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/placebatol

/obj/item/storage/pill_bottle/unknown
	name = "unknown pill bottle"
	desc = "Этикетки нет, и от чего эти таблетки - непонятно."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/placebatol
