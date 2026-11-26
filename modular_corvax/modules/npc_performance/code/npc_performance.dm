/mob/living/carbon/human/npc/proc/npc_walk_to(atom/target)
	var/datum/move_loop/has_target/dist_bound/move_to/npc/current_loop = GLOB.move_manager.processing_on(src, SSmovement)
	if(istype(current_loop) && current_loop.target == target && current_loop.delay == max(cached_multiplicative_slowdown, world.tick_lag))
		return
	GLOB.move_manager.add_to_loop(src, SSmovement, /datum/move_loop/has_target/dist_bound/move_to/npc, MOVEMENT_DEFAULT_PRIORITY, NONE, null, cached_multiplicative_slowdown, INFINITY, target, 0)

/// The full path search runs only when a straight step is blocked, it costs far more than the step itself
/datum/move_loop/has_target/dist_bound/move_to/npc

/datum/move_loop/has_target/dist_bound/move_to/npc/move()
	if(!check_dist())
		return MOVELOOP_FAILURE
	var/atom/old_loc = moving.loc
	var/update_dir = !(flags & MOVEMENT_LOOP_NO_DIR_UPDATE)
	var/turf/next = get_step_towards(moving, target)
	if(next && !next.is_blocked_turf(exclude_mobs = TRUE, source_atom = moving))
		moving.Move(next, get_dir(moving, next), FALSE, update_dir)
	if(QDELETED(moving))
		return MOVELOOP_FAILURE
	if(moving.loc == old_loc)
		next = get_step_to(moving, target)
		moving.Move(next, get_dir(moving, next), FALSE, update_dir)
	return old_loc != moving?.loc ? MOVELOOP_SUCCESS : MOVELOOP_FAILURE

#define NPC_WAKE_RANGE 12
#define NPC_WAKE_LEVELS_ABOVE 2
#define DORMANT_NPC_LIFE_STRIDE 5

/mob/living/carbon/human/npc
	var/dormant = FALSE
	var/skipped_life_ticks = 0
	COOLDOWN_DECLARE(dormancy_check_cooldown)

/// Organs, blood, breathing and temperature are most of an NPC's cost, away from players they run in rarer steps that cover the skipped time
/mob/living/carbon/human/npc/Life(seconds_per_tick = SSMOBS_DT)
	if(skipped_life_ticks < DORMANT_NPC_LIFE_STRIDE - 1 && life_can_wait())
		skipped_life_ticks++
		return
	// the stuck counter that teleports dormant NPCs counts Life calls, so the skipped ones still count
	if(loc == tupik_loc)
		tupik_steps += skipped_life_ticks
	var/elapsed = seconds_per_tick * (skipped_life_ticks + 1)
	skipped_life_ticks = 0
	return ..(elapsed)

/// Temperature math breaks on steps longer than one tick, which dormant NPCs pass into Life
/datum/species/handle_body_temperature(mob/living/carbon/human/humi, seconds_per_tick)
	return ..(humi, min(seconds_per_tick, SSMOBS_DT))

/mob/living/carbon/human/npc/proc/life_can_wait()
	return !client && !danger_source && !on_fire && npc_is_dormant()

/// Nobody can see a wandering NPC this far from every player, so it skips the steps and lets the stuck teleport carry it instead
/mob/living/carbon/human/npc/proc/npc_is_dormant()
	if(!COOLDOWN_FINISHED(src, dormancy_check_cooldown))
		return dormant
	COOLDOWN_START(src, dormancy_check_cooldown, 2 SECONDS)
	var/now_dormant = !player_nearby()
	if(now_dormant && !dormant)
		GLOB.move_manager.stop_looping(src)
	dormant = now_dormant
	return dormant

/mob/living/carbon/human/npc/proc/player_nearby()
	var/turf/level = get_turf(src)
	for(var/i in 0 to NPC_WAKE_LEVELS_ABOVE)
		if(!level)
			return FALSE
		if(length(SSspatial_grid.orthogonal_range_search(level, SPATIAL_GRID_CONTENTS_TYPE_CLIENTS, NPC_WAKE_RANGE)))
			return TRUE
		level = GET_TURF_ABOVE(level)
	return FALSE

#undef NPC_WAKE_RANGE
#undef NPC_WAKE_LEVELS_ABOVE
#undef DORMANT_NPC_LIFE_STRIDE
