/obj/ritual_rune/thaumaturgy/blood_to_water
	name = "blood to water"
	ru_name = "Кровь в воду"
	desc = "Обращает в воду всю кровь поблизости, не оставляя следов."
	icon_state = "rune8"
	word = "CL-ENE"

/obj/ritual_rune/thaumaturgy/blood_to_water/complete()
	. = ..()
	for(var/atom/A in range(7, src))
		A.wash(CLEAN_WASH)
	qdel(src)
