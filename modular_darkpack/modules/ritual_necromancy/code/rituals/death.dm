/obj/ritual_rune/necromancy/death
	name = "death"
	ru_name = "Смерть"
	desc = "Мгновенно переносит вас в Земли Теней."
	icon_state = "rune2"
	word = "Y'HO 'LLOH"

/obj/ritual_rune/necromancy/death/complete()
	last_activator.death()
	qdel(src)
