/obj/ritual_rune/abyss/calling_the_hungry_shade
	name = "calling the hungry shade"
	ru_name = "Призыв голодной тени"
	desc = "Вызывает из Бездны голодную и разъярённую тень, которую вы попытаетесь укротить. Берегитесь: в случае неудачи она набросится на вас!"
	icon_state = "rune8"
	word = "Дух Голода."
	level = 3
	cost = 1
	difficulty = 9

/obj/ritual_rune/abyss/calling_the_hungry_shade/complete()
	. = ..()
	if(ishuman(last_activator))
		var/mob/living/carbon/human/human_activator = last_activator
		human_activator.add_beastmaster_minion(/mob/living/basic/shadow_guard/hungry_shade)
		if(length(human_activator.beastmaster_minions) > human_activator.st_get_stat(STAT_OCCULT))
			var/mob/living/beastmaster_minion = pick(human_activator.beastmaster_minions)
			beastmaster_minion.death()
	qdel(src)

/obj/ritual_rune/abyss/calling_the_hungry_shade/ritual_failure()
	. = ..()
	var/mob/living/basic/shadow_guard/hungry_shade/shade = new(get_turf(src))
	shade.ai_controller = new /datum/ai_controller/basic_controller/simple/simple_hostile(shade)
	shade.ai_controller.set_blackboard_key(BB_CURRENT_TARGET, last_activator)
	shade.remove_faction(VAMPIRE_CLAN_LASOMBRA)
	to_chat(last_activator, span_warning("Ритуал ускользает из-под вашей власти, но на зов всё равно что-то откликается!"))
	qdel(src)

/obj/ritual_rune/abyss/calling_the_hungry_shade/ritual_botch()
	. = ..()
	var/mob/living/basic/shadow_guard/hungry_shade/shade = new(get_turf(src))
	shade.ai_controller = new /datum/ai_controller/basic_controller/simple/simple_hostile(shade)
	shade.ai_controller.set_blackboard_key(BB_CURRENT_TARGET, last_activator)
	shade.remove_faction(VAMPIRE_CLAN_LASOMBRA)
	to_chat(last_activator, span_warning("Вы теряете власть над ритуалом!"))
	last_activator.apply_damage(30, AGGRAVATED)
	qdel(src)
