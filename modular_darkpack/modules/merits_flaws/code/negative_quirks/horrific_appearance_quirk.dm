/datum/quirk/darkpack/horrific_appearance
	name = "Horrific Appearance"
	ru_name = "Ужасающая внешность"
	desc = "В клане Каппадокийцев всё чаще встречается обострение кланового проклятия. Многие каппадокийцы, и без того похожие на ходячих мертвецов, начинают разлагаться быстрее. Кожа туго обтягивает кости и сходит лоскутами, тело гниёт, пропадают нос и уши. Привлекательность такого каппадокийца всегда равна нулю, а его лицо нарушает Маскарад: внешность приходится скрывать Дисциплинами или масками."
	value = -3
	mob_trait = TRAIT_HORRIFIC_APPEARANCE
	gain_text = span_notice("Ваше мёртвое тело начинает разлагаться быстрее!")
	lose_text = span_notice("Кожа на вашем мёртвом теле приходит в норму.")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_CAPPADOCIAN)
	icon = FA_ICON_SKULL
	failure_message = "Кожа на вашем мёртвом теле приходит в норму."
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/horrific_appearance/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	var/years_undead = human_holder.chronological_age - human_holder.age
	switch(years_undead)
		if (-INFINITY to 500)
			human_holder.rot_body(3)
		if (500 to INFINITY)
			human_holder.rot_body(4)
	human_holder.st_add_stat_clamp(STAT_APPEARANCE, 0, type)

/datum/quirk/darkpack/horrific_appearance/remove()
	. = ..()
	quirk_holder.st_remove_stat_clamp(STAT_APPEARANCE, type)
