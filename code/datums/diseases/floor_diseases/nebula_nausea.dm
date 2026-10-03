/// Caused by dirty food. Makes you vomit stars.
/datum/disease/nebula_nausea
	name = "Звёздная тошнота"
	desc = "Удержать в себе всю красочную прелесть космоса вам не под силу."
	form = "Состояние"
	agent = "Звёзды"
	cure_text = /datum/reagent/space_cleaner::name
	spread_text = "Не передаётся"
	cures = list(/datum/reagent/space_cleaner)
	viable_mobtypes = list(/mob/living/carbon/human)
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	severity = DISEASE_SEVERITY_MEDIUM
	required_organ = ORGAN_SLOT_STOMACH
	max_stages = 5

/datum/disease/advance/nebula_nausea/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("Красочная прелесть космоса, похоже, плохо сказалась на вашем равновесии."))
		if(3)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("В животе у вас кружатся цвета, которых не видел человеческий глаз."))
		if(4)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("Вас будто несёт сквозь водоворот небесных красок."))
		if(5)
			if(SPT_PROB(1, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(affected_mob))
				to_chat(affected_mob, span_warning("Ваш желудок превратился в бурлящую туманность с калейдоскопом узоров."))
			else
				affected_mob.vomit(vomit_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM), vomit_type = /obj/effect/decal/cleanable/vomit/nebula, lost_nutrition = 10, distance = 2)
