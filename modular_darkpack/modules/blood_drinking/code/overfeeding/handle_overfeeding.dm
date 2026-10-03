/mob/living/carbon/human/proc/handle_overfeeding(mob/living/carbon/human/human_mob)
	human_mob.blood_volume = 0
	if(human_mob.stat != DEAD)
		if(isnpc(human_mob))
			var/mob/living/carbon/human/npc/Npc = human_mob
			Npc.last_attacker = null
			killed_count = killed_count+1
			if(killed_count >= 5)
				SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/humanity_loss.ogg', volume = 75))
				to_chat(src, span_userdanger("<b>ПОЛИЦИЯ ИДЁТ НА ШТУРМ</b>"))
		SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/feed_failed.ogg', volume = 75))
		to_chat(src, span_warning("Эта жалкая жертва, принесённая ради собственного удовольствия, что-то надламывает в глубине вашей души."))
		SEND_SIGNAL(src, COMSIG_PATH_HIT, -1, 0, FALSE)
		human_mob.death()
