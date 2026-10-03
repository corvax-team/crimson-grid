/obj/ritual_rune/necromancy/fireprotection
	name = "chill of oblivion"
	ru_name = "Холод забвения"
	desc = "Впустите в душу холод Земель Теней, и тело перестанет бояться огня. Это нечестивое благословение <b>оскверняет ауру</b> того, кто его принял."
	icon_state = "rune1"
	word = "DHAI'AD BHA'II DAWH'N"
	level = 4

/obj/ritual_rune/necromancy/fireprotection/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody.stat == DEAD)
			to_chat(usr, span_warning("Цель мертва: холод давно поселился в ней."))
			return

		else valid_bodies += targetbody

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("Цель ритуала должна оставаться на руне."))
		return

	var/mob/living/carbon/victim = pick(valid_bodies)

	if(victim.fakediablerist)
		to_chat(usr, span_warning("Холод уже завладел целью ритуала."))
		return

	playsound(loc, 'sound/effects/ghost.ogg', 50, FALSE)
	victim.emote("shiver")
	victim.Immobilize(4 SECONDS)

	to_chat(victim, span_revendanger("Обжигающий лёд сочится из вашей души и растекается по всему вокруг. Вы не можете пошевелиться и стоите в этом холоде, а смерть не спешит уходить."))
	victim.fakediablerist = TRUE
	//removing iscathayan from line 38 -- DAKPACK TODO -- readd KJs (iscathayan(victim))
	if(get_kindred_splat(victim) || victim.has_status_effect(/datum/status_effect/zombie)) //made this a deduction rather than a flat set because of an artifact that independently changes damage mods
		// Im not even certin this does anything for kindred waying heatmod only affects the breath you take and kindred shouldnt be breathing really.
		victim.dna.species.heatmod = max(0.5, victim.dna.species.heatmod-1) // This sucks why are we touching species for this.
	else
		victim.dna.species.heatmod = max(0.5, victim.dna.species.heatmod-0.5)
	qdel(src)
