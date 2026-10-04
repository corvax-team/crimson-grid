/obj/effect/vip_barrier/stripclub
	name = "VIP Area"
	desc = "Отсюда начинается нейтральная территория города для тех, кто не человек. За этой чертой настоящие ночные твари могут собираться, ничего не опасаясь."
	protected_zone_id = "elysium_strip"
	social_roll_difficulty = 9


/obj/effect/vip_barrier/stripclub/check_entry_permission_custom(mob/living/carbon/human/entering_mob)
	if(issupernatural(entering_mob) || istype(entering_mob.mind?.assigned_role, /datum/outfit/job/vampire/club_worker))
		return TRUE
	return FALSE
