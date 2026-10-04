/datum/disease/flu
	name = "Грипп"
	max_stages = 3
	spread_text = "Воздушно-капельный путь"
	cure_text = /datum/reagent/medicine/spaceacillin::name + ", отдых облегчает течение"
	cures = list(/datum/reagent/medicine/spaceacillin)
	cure_chance = 5
	agent = "H13N1 Flu Virion"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 0.75
	desc = "Обычная и слегка досадная зараза. Если не лечить, больному станет совсем нехорошо."
	severity = DISEASE_SEVERITY_MINOR
	required_organ = ORGAN_SLOT_LUNGS

/datum/disease/flu/cure(add_resistance)
	// buy one, get one free
	if(add_resistance && affected_mob)
		LAZYOR(affected_mob.disease_resistances, "[/datum/disease/fluspanish]")
	return ..()

/datum/disease/flu/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("У вас ломит мышцы."))
				if(prob(20))
					affected_mob.take_bodypart_damage(1, updating_health = FALSE)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("У вас болит живот."))
				if(prob(20))
					affected_mob.adjust_tox_loss(1, FALSE)
			if(affected_mob.body_position == LYING_DOWN && SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_notice("Вам становится лучше."))
				stage--
				return

		if(3)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("У вас ломит мышцы."))
				if(prob(20))
					affected_mob.take_bodypart_damage(1, updating_health = FALSE)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("У вас болит живот."))
				if(prob(20))
					affected_mob.adjust_tox_loss(1, FALSE)
			if(affected_mob.body_position == LYING_DOWN && SPT_PROB(7.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("Вам становится лучше."))
				stage--
				return
