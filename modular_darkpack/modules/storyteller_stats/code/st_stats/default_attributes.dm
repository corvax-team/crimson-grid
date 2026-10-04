/datum/st_stat/attribute/strength
	name = "Сила"
	description = "Влияет на множитель повреждений от ударов без оружия. Повышает шанс сбить противника с ног в рукопашной."
	subcategory = "Физические"


/datum/st_stat/attribute/dexterity
	name = "Ловкость"
	description = "Влияет на скорость и точность ударов оружием ближнего боя. Помогает устоять на ногах в рукопашной. Ускоряет некоторые действия."
	subcategory = "Физические"

/datum/st_stat/attribute/dexterity/update_mob(mob/living/our_mob, initial)
	our_mob.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/dexterity, multiplicative_slowdown = -(get_score() / 20))


/datum/st_stat/attribute/stamina
	name = "Выносливость"
	description = "Влияет на максимальный запас здоровья. Используется в Упокоении."
	subcategory = "Физические"

/datum/st_stat/attribute/stamina/update_mob(mob/living/our_mob, initial)
	our_mob.recalculate_max_health(initial)


/datum/st_stat/attribute/charisma
	name = "Обаяние"
	description = "Умение увлекать людей и нравиться им за счёт личного обаяния. Используется в Помешательстве, Доминировании и Величии."
	subcategory = "Социальные"

/datum/st_stat/attribute/manipulation
	name = "Манипуляция"
	description = "Умение выражать свои мысли так, чтобы другие приняли вашу точку зрения или выполнили ваши прихоти. Используется в социальных и ментальных Дисциплинах."
	subcategory = "Социальные"

/datum/st_stat/attribute/appearance
	name = "Привлекательность"
	description = "Показывает, какое первое впечатление производит персонаж. Используется в социальных Дисциплинах и делает персонажа привлекательнее."
	subcategory = "Социальные"

/* For the bimbo in the audience
/datum/st_stat/attribute/appearance/update_mob(mob/living/our_mob, initial)
	update_bloodquality_from_appearance()
*/


/datum/st_stat/attribute/perception
	name = "Восприятие"
	description = "Умение замечать происходящее вокруг. Ускоряет осмотр. Используется в Ясновидении."
	subcategory = "Ментальные"

/datum/st_stat/attribute/intelligence
	name = "Интеллект"
	description = "Владение фактами и знаниями. Также определяет способность рассуждать, решать задачи и оценивать ситуацию. Используется в магических Дисциплинах и ритуалах."
	subcategory = "Ментальные"

/datum/st_stat/attribute/wits
	name = "Смекалка"
	description = "Умение быстро соображать и мгновенно реагировать на происходящее. Также отражает общую находчивость персонажа. Используется в Некромантии."
	subcategory = "Ментальные"
