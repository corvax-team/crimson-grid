
/*
 * Pill Bottles
 */
/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "Герметичная баночка для лекарств."
	icon_state = "pill_canister"
	icon = 'icons/obj/medical/chemical.dmi'
	inhand_icon_state = "contsolid"
	worn_icon_state = "nothing"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	pickup_sound = 'sound/items/handling/pill_bottle_pickup.ogg'
	drop_sound = 'sound/items/handling/pill_bottle_place.ogg'
	storage_type = /datum/storage/pillbottle
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)

	///Number of pills to spawn
	VAR_PROTECTED/spawn_count
	///Pill type to spawn
	VAR_PROTECTED/obj/item/reagent_containers/applicator/pill/spawn_type

/obj/item/storage/pill_bottle/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[capitalize(user.declent_ru(NOMINATIVE))] пытается снять крышку с [declent_ru(GENITIVE)]! Кажется, это попытка самоубийства!"))
	return TOXLOSS

/obj/item/storage/pill_bottle/PopulateContents()
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!spawn_count)
		return

	for(var/i in 1 to spawn_count)
		new spawn_type(src)

/obj/item/storage/pill_bottle/multiver
	name = "bottle of multiver pills"
	desc = "Таблетки от отравлений."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/multiver

/obj/item/storage/pill_bottle/multiver/less
	spawn_count = 3

/obj/item/storage/pill_bottle/epinephrine
	name = "bottle of epinephrine pills"
	desc = "Таблетки, которыми стабилизируют пациентов."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/epinephrine

/obj/item/storage/pill_bottle/mutadone
	name = "bottle of mutadone pills"
	desc = "Таблетки для лечения генетических отклонений."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/mutadone

/obj/item/storage/pill_bottle/potassiodide
	name = "bottle of potassium iodide pills"
	desc = "Таблетки, ослабляющие лучевое поражение."
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/potassiodide
	custom_price = 100 // DARKPACK EDIT ADD - ECONOMY

/obj/item/storage/pill_bottle/probital
	name = "bottle of probital pills"
	desc = "Таблетки от ушибов и ран. На этикетке: \"Принимать после еды, может вызывать усталость\"."
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/probital

/obj/item/storage/pill_bottle/iron
	name = "bottle of iron pills"
	desc = "Таблетки, которые постепенно восполняют кровопотерю. На этикетке: \"Не больше одной раз в пять минут\"."
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/iron

/obj/item/storage/pill_bottle/mannitol
	name = "bottle of mannitol pills"
	desc = "Таблетки от повреждений мозга."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/mannitol

//Contains 4 pills instead of 7, and 5u pills instead of 50u (50u pills heal 250 brain damage, 5u pills heal 25)
/obj/item/storage/pill_bottle/mannitol/braintumor
	desc = "Contains diluted pills used to treat brain tumor symptoms. Take one when feeling lightheaded."
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/mannitol/braintumor

/obj/item/storage/pill_bottle/stimulant
	name = "bottle of stimulant pills"
	desc = "Гарантированный заряд бодрости на долгую смену!"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/stimulant

/obj/item/storage/pill_bottle/sansufentanyl
	name = "bottle of experimental medication"
	desc = "A bottle of pills developed by Interdyne Pharmaceuticals. They're used to treat Hereditary Manifold Sickness."
	spawn_count = 6
	spawn_type = /obj/item/reagent_containers/applicator/pill/sansufentanyl

/obj/item/storage/pill_bottle/mining
	name = "bottle of patches"
	desc = "Contains patches used to treat brute and burn damage."
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/patch/libital

/obj/item/storage/pill_bottle/zoom
	name = "suspicious pill bottle"
	desc = "Этикетка старая и почти нечитаемая, но кое-какие химические названия разобрать можно."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/zoom

/obj/item/storage/pill_bottle/happy
	name = "suspicious pill bottle"
	desc = "На крышке нарисован смайлик."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/happy

/obj/item/storage/pill_bottle/lsd
	name = "suspicious pill bottle"
	desc = "На ней корявый рисунок: то ли гриб, то ли кривая луна."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/lsd

/obj/item/storage/pill_bottle/aranesp
	name = "suspicious pill bottle"
	desc = "The label has 'fuck disablers' hastily scrawled in black marker."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/aranesp

/obj/item/storage/pill_bottle/psicodine
	name = "bottle of psicodine pills"
	desc = "Таблетки от душевных расстройств и травм."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/psicodine

/obj/item/storage/pill_bottle/penacid
	name = "bottle of pentetic acid pills"
	desc = "Таблетки, выводящие радиацию и токсины."
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/penacid

/obj/item/storage/pill_bottle/neurine
	name = "bottle of neurine pills"
	desc = "Таблетки для лечения лёгких травм мозга."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/neurine

/obj/item/storage/pill_bottle/maintenance_pill
	name = "bottle of maintenance pills"
	desc = "Старая баночка из-под таблеток. Пахнет затхлостью."
	spawn_type = /obj/item/reagent_containers/applicator/pill/maintenance

/obj/item/storage/pill_bottle/maintenance_pill/Initialize(mapload)
	if(!spawn_count)
		spawn_count = rand(1,7)
	. = ..()
	var/obj/item/reagent_containers/applicator/pill/P = locate() in src
	name = "bottle of [P.name]s"

/obj/item/storage/pill_bottle/maintenance_pill/full
	spawn_count = 7

///////////////////////////////////////// Psychologist inventory pillbottles
/obj/item/storage/pill_bottle/happinesspsych
	name = "happiness pills"
	desc = "Таблетки на самый крайний случай: на время глушат депрессию и тревогу. ВНИМАНИЕ: среди побочных эффектов невнятная речь, слюнотечение и тяжёлая зависимость."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/happinesspsych

/obj/item/storage/pill_bottle/lsdpsych
	name = "mindbreaker toxin pills"
	desc = "!FOR THERAPEUTIC USE ONLY! Contains pills used to alleviate the symptoms of Reality Dissociation Syndrome."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/lsdpsych

/obj/item/storage/pill_bottle/paxpsych
	name = "pax pills"
	desc = "Таблетки, которыми на время успокаивают пациентов, опасных для себя или окружающих."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/paxpsych

/obj/item/storage/pill_bottle/naturalbait
	name = "freshness jar"
	desc = "Full of natural fish bait."
	spawn_count = 7
	spawn_type = /obj/item/food/bait/natural

/obj/item/storage/pill_bottle/ondansetron
	name = "ondansetron patches"
	desc = "A bottle containing patches of ondansetron, a drug used to treat nausea and vomiting. May cause drowsiness."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/patch/ondansetron

/obj/item/storage/pill_bottle/immunodeficiency
	name = "bottle of immune boosters"
	desc = "Contains immune system boosters, used to manage chronic immunodeficiency."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/spaceacillin

/obj/item/storage/pill_bottle/prescription_stimulant
	name = "bottle of prescribed stimulant pills"
	desc = "A bottle of mild and medicinally approved stimulants to help prevent drowsiness. \n\
		The list of substances reads: Contains 3u modafinil, 5u synaptizine and 5u glucose. \n\
		A warning label reads: <b>Take in moderation</b>."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/prescription_stimulant

/obj/item/storage/pill_bottle/sepsisillin
	name = "bottle of sepsisillin pills"
	desc = "Contains immune system suppressants, for assisting virology research. Do not confuse with spaceacillin."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/sepsisillin
