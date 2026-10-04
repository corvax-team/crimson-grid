/obj/ritual_rune/thaumaturgy/bloodwalk
	name = "blood walk"
	ru_name = "Хождение по крови"
	desc = "Прослеживает родословную того, чья кровь набрана в шприц."
	icon_state = "rune7"
	word = "Яви моим очам свой род."
	level = 2

/obj/ritual_rune/thaumaturgy/bloodwalk/complete()
	. = ..()
	for(var/obj/item/reagent_containers/syringe/S in loc)
		for(var/datum/reagent/blood/B in S.reagents.reagent_list)
			var/blood_data = B.data
			if(blood_data)
				var/generation = blood_data["generation"]
				var/clan = LOWER_TEXT(blood_data["clan"])
				var/real_name = blood_data["real_name"]
				var/message = generate_message(generation, clan, real_name)
				to_chat(last_activator, "[message]")
				// Process blood collection for research points
				if(ishuman(last_activator))
					SSoccult_research.process_blood_collection(last_activator, B)
			else
				to_chat(last_activator, "Кровь молчит: в ней нет силы!")
		color = rgb(255,0,0)
		activated = TRUE
		qdel(src)

/obj/ritual_rune/thaumaturgy/bloodwalk/proc/generate_message(generation, clan, real_name)
	var/message = ""
	message += "Истинное имя того, кому принадлежит кровь: [real_name].\n"
	switch(generation)
		if(4)
			message += "Кровь невероятно древняя и могучая! Не иначе как от древнейшего из мафусаилов!\n"
		if(5)
			message += "Кровь невероятно древняя и могучая! Не иначе как от мафусаила!\n"
		if(6)
			message += "Кровь невероятно древняя и могучая! Не иначе как от старейшины!\n"
		if(7, 8, 9)
			message += "Кровь сильна. Она принадлежит анцилле или старейшине!\n"
		if(10, 11)
			message += "Кровь средней силы. Её владелец, должно быть, молод.\n"
		if(12, 13)
			message += "Сила этой крови угасает. Она принадлежит неонату.\n"
		else
			if(generation >= 14)
				message += "Это витэ слабокровного!\n"
	switch(clan)
		if(VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY)
			message += "Кровь сладка и густа. Её владелец наверняка и сам прекрасен.\n"
		if(VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_VENTRUE_ANTITRIBU)
			message += "В этой крови королевская власть, идущая от Митры или Хардештадта.\n"
		if(VAMPIRE_CLAN_LASOMBRA)
			message += "Холодная и тёмная, эта кровь мистически связана с Бездной.\n"
		if(VAMPIRE_CLAN_TZIMISCE)
			message += "Витэ изменчива и искажена. Какие могут быть сомнения в том, чья это проклятая линия?\n"
		if(VAMPIRE_CLAN_OLD_CLAN_TZIMISCE)
			message += "Эта витэ стара, очень стара. Она напоминает вам другую кровь, куда более искажённую и проклятую...\n"
		if(VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL)
			message += "От крови веет чем-то первобытным и диким. Таков, вероятно, и её владелец.\n"
		if(VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_DOMINATE_MALKAVIAN)
			message += "В этой крови вы чуете хаос и безумие. Безумен, должно быть, и её владелец.\n"
		if(VAMPIRE_CLAN_BRUJAH)
			message += "Кровь полна страсти и гнева. Таков, должно быть, и её владелец.\n"
		if(VAMPIRE_CLAN_NOSFERATU)
			message += "Кровь мерзка и отвратительна. То же, вероятно, можно сказать и о её владельце.\n"
		if(VAMPIRE_CLAN_TREMERE)
			message += "Кровь полна магической силы. Её владелец, должно быть, тауматург.\n"
		if(VAMPIRE_CLAN_BAALI)
			message += "Осквернённая и порочная. Гнусная и нечистая. Вы видите в крови своё отражение, но оттуда на вас смотрит что-то иное.\n"
		if(VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_BANU_HAQIM_VIZIER)
			message += "Сильная... смертоносная... и проклятая. Вам хорошо известно проклятие, которое Тремер наложили на ассасинов.\n"
		if(VAMPIRE_CLAN_TRUE_BRUJAH)
			message += "Кровь холодна и неподвижна... В ней почти не ощутить чувств.\n"
		if(VAMPIRE_CLAN_HEALER_SALUBRI)
			message += "Проклятая кровь Салюбри! Её владельца надлежит уничтожить.\n"
		if(VAMPIRE_CLAN_WARRIOR_SALUBRI)
			message += "Перед вами воплощённая месть Самиэля. Осмелитесь ли вы ответить на эту горькую ненависть?\n"
		if(VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_HARBINGER)
			message += "Кровь очень холодна и полна смерти. Её владелец, должно быть, некромант.\n"
		if(VAMPIRE_CLAN_KIASYD)
			message += "В крови различимы следы магии фей.\n"
		if(VAMPIRE_CLAN_GARGOYLE)
			message += "Кровь наших каменных слуг.\n"
		if(VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_WARRIOR_SETITE)
			message += "В этой крови соблазн и искушение. А, один из змей.\n"
		if(VAMPIRE_CLAN_NAGARAJA)
			message += "В этой крови тревожный голод, она холодна и запятнана смертью.\n"
		else
			message += "Происхождение этой крови проследить трудно. Быть может, она принадлежит кому-то из бесклановых?\n"

	return message
