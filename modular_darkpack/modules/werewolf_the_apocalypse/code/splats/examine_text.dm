/datum/splat/werewolf/proc/examine_other_human(mob/living/carbon/examined)
	var/datum/splat/werewolf/wolp_splat = get_werewolf_splat(examined)
	if(wolp_splat)
		var/list/honor_flavor = list("порядочности", "чести", "благородстве")
		var/list/wisdom_flavor = list("проницательности", "мудрости", "прозорливости")
		var/list/glory_flavor = list("храбрости", "доблести", "славе")

		var/same_tribe = FALSE
		var/is_known = FALSE

		if(!tribe)
			return
		if(!wolp_splat.tribe || !wolp_splat.auspice)
			return
		if(tribe.name == wolp_splat.tribe.name)
			same_tribe = TRUE

		switch(wolp_splat.renown_rank)
			if(RANK_CUB to RANK_FOSTERN)
				if(same_tribe)
					. += "<b>Вам известно, что перед вами [fera_rank_name(wolp_splat.renown_rank, wolp_splat.id)] из племени [wolp_splat.tribe.get_display_name()].</b>"
					is_known = TRUE
			if(RANK_ADREN to RANK_LEGEND)
				. += "<b>Вам известно, что перед вами [fera_rank_name(wolp_splat.renown_rank, wolp_splat.id)], [wolp_splat.auspice.get_display_name()] из племени [wolp_splat.tribe.get_display_name()].</b>"
				is_known = TRUE

		if(is_known)
			switch(wolp_splat.renown[RENOWN_HONOR])
				if(4,5,6)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [honor_flavor[1]].</i>"
				if(7,8,9)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [honor_flavor[2]].</i>"
				if(10)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [honor_flavor[3]].</i>"
			switch(wolp_splat.renown[RENOWN_WISDOM])
				if(4,5,6)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [wisdom_flavor[1]].</i>"
				if(7,8,9)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [wisdom_flavor[2]].</i>"
				if(10)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [wisdom_flavor[3]].</i>"
			switch(wolp_splat.renown[RENOWN_GLORY])
				if(4,5,6)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [glory_flavor[1]].</i>"
				if(7,8,9)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [glory_flavor[2]].</i>"
				if(10)
					. += "<i>Среди местных гару ходит молва о [examined.ru_p_them()] [glory_flavor[3]].</i>"
