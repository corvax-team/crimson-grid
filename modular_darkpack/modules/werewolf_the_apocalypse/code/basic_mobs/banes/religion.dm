/mob/living/basic/bane/religion
	desc = "Странно знакомое существо: чем-то оно напоминает вашу тётушку."
	icon_state = "religion_bane"
	maxHealth = 50
	health = 50
	pass_flags = PASSMOB
	mob_size = MOB_SIZE_SMALL

/mob/living/basic/bane/religion/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)
	AddComponent(/datum/component/swarming)
