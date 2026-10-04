/obj/effect/vip_barrier/giovanni
	name = "Giovanni Checkpoint"
	desc = "Тут семейная встреча, capisce?"
	protected_zone_id = "giovanni"
	social_roll_difficulty = 7

/obj/effect/vip_barrier/giovanni/check_entry_permission_custom(mob/living/carbon/human/entering_mob)
	if(entering_mob.mind && entering_mob.mind.assigned_role && (entering_mob.mind.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_GIOVANNI))
		return TRUE
	return FALSE
