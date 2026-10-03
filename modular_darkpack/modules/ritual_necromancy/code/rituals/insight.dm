/obj/ritual_rune/necromancy/insight
	name = "insight"
	ru_name = "Прозрение"
	desc = "Позволяет узнать, как умер покойник, расспросив его душу."
	icon_state = "rune6"
	word = "IH'DET ULYSS RES'SAR"
	level = 2

/obj/ritual_rune/necromancy/insight/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("Этот ритуал нельзя провести над самим собой."))
			return
		else if(targetbody.stat == DEAD)
			valid_bodies += targetbody
		else
			to_chat(usr, span_warning("Цель ещё жива! Вот сами и спросите!"))
			return

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("Здесь нет тела, пригодного для этого ритуала."))
		return

	playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)

	var/mob/living/carbon/victim = pick(valid_bodies)

	var/mob/dead/observer/victim_ghost = victim.last_mind

	var/permission = null

	if(isnpc(victim))
		to_chat(last_activator, span_notice("[capitalize(victim.declent_ru(NOMINATIVE))] - лишь угасающий, примитивный Трутень. Никаких особых знаний из него не извлечь."))
		to_chat(last_activator, span_notice("<b>Полученные повреждения:</b><br>Раны: [victim.get_brute_loss()]<br>Удушье: [victim.get_oxy_loss()]<br>Отравление: [victim.get_tox_loss()]<br>Ожоги: [victim.get_fire_loss()]<br>Губительные: [victim.get_agg_loss()]"))
		to_chat(last_activator, span_notice("Последний, кто напал в ближнем бою: [victim.lastattacker]"))
		qdel(src)
		return

	if(victim_ghost)
		permission = tgui_input_list(victim_ghost, "[last_activator.real_name] желает знать, как вы умерли. Вы ответите?", "Выбор", list("Да", "Нет", "Я не помню"), "Нет", 1 MINUTES)

	if(permission == "Да" && victim_ghost)
		to_chat(last_activator, span_ghostalert("Ваш разум наполняет неотвязный шёпот [victim.declent_ru(GENITIVE)]..."))
		var/deathdesc = tgui_input_text(victim_ghost, "", "Как вы умерли?", "", 300, TRUE, TRUE, 5 MINUTES)
		if(deathdesc == "")
			to_chat(last_activator, span_warning("Завеса слишком плотна, а шёпот слишком бессвязен: ничего полезного не разобрать."))
		else
			to_chat(last_activator, span_ghostalert("<i>[deathdesc]</i>"))
			//discount scanner
			to_chat(last_activator, span_notice("<b>Полученные повреждения:</b><br>Раны: [victim.get_brute_loss()]<br>Удушье: [victim.get_oxy_loss()]<br>Отравление: [victim.get_tox_loss()]<br>Ожоги: [victim.get_fire_loss()]<br>Губительные: [victim.get_agg_loss()]"))
			to_chat(last_activator, span_notice("Последний, кто напал в ближнем бою: [victim.lastattacker]")) //guns behave weirdly
			qdel(src)

	else if(permission == "Нет")
		to_chat(last_activator, span_danger("Призрак отворачивается от вас. Своих тайн он не выдаст."))
