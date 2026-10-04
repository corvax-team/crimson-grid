/obj/ritual_rune/necromancy/truth
	name = "call upon the shadow's grace"
	ru_name = "Воззвание к милости Тени"
	desc = "Пробуждает тени в разуме жертвы и вырывает у неё самые тёмные тайны."
	icon_state = "rune8"
	word = "MIKHH' AHPP"
	level = 3

/obj/ritual_rune/necromancy/truth/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("Этот ритуал нельзя провести над самим собой."))
			return
		if(targetbody.stat == DEAD)
			to_chat(usr, span_warning("Цель мертва и унесла свои тайны в могилу!"))
			return
		else
			valid_bodies += targetbody

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("Жертва ритуала должна оставаться на руне."))
		return

	var/mob/living/carbon/victim = pick(valid_bodies)
	playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)

	to_chat(usr, span_ghostalert("Вы натравливаете на [victim.declent_ru(ACCUSATIVE)] [victim.ru_p_them()] собственную тень. Солгать вам теперь не выйдет."))

	playsound(victim,'sound/effects/hallucinations/veryfar_noise.ogg',50,TRUE)
	playsound(victim,'sound/music/antag/bloodcult/ghost_whisper.ogg',50,TRUE)

	victim.emote("scream")
	victim.AdjustKnockdown(2 SECONDS)
	victim.do_jitter_animation(3 SECONDS)

	to_chat(victim, span_revenboldnotice("Ваш рот распахивается сам собой, и воздух, сколько его ни вдыхай, не держится в груди."))
	to_chat(victim, span_revenboldnotice("Все тёмные тайны, что вы храните, рвутся наружу раньше, чем вы успеваете их вспомнить."))
	to_chat(victim, span_hypnophrase("ВЫ НЕ МОЖЕТЕ ЛГАТЬ."))

	visible_message(span_danger("Тень [victim.declent_ru(GENITIVE)] бьётся под ногами, словно отдельное существо!"))
	addtimer(CALLBACK(victim, TYPE_PROC_REF(/datum/necrorune/truth, wearoff), victim), 2 MINUTES)
	qdel(src)

/datum/necrorune/truth/proc/wearoff(mob/living/carbon/victim)
	if(!victim)
		return
	to_chat(victim, span_notice("Хватка на вашей душе слабеет. Ваши тайны снова принадлежат только вам."))
