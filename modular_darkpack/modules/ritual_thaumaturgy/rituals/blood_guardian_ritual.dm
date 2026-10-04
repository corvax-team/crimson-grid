/obj/ritual_rune/thaumaturgy/blood_guardian
	name = "blood imp"
	ru_name = "Кровавый бес"
	desc = "Тауматургам порой нужен помощник в лаборатории или страж для капеллы. Этот ритуал оживляет человекоподобное создание, сотворённое из крови самого заклинателя."
	icon_state = "rune1"
	word = "UR'JOLA"
	level = 3
	cost = 5

/obj/ritual_rune/thaumaturgy/blood_guardian/complete()
	. = ..()
	var/mob/living/carbon/human/H = last_activator
	H.add_beastmaster_minion(/mob/living/basic/blood_guard)
	if(length(H.beastmaster_minions) > 3+H.st_get_stat(STAT_LEADERSHIP))
		var/mob/living/basic/blood_guard/B = pick(H.beastmaster_minions)
		B.death()
	qdel(src)

