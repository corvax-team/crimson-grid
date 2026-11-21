/turf/open/umbra/zPassIn(direction)
	if(direction == DOWN)
		return TRUE
	return FALSE

/turf/open/umbra/zPassOut(direction)
	if(direction == DOWN)
		return TRUE
	return FALSE

/turf/open/umbra/Enter(atom/movable/movable, atom/oldloc)
	. = ..()
	if(.)
		movable.set_currently_z_moving(CURRENTLY_Z_FALLING_FROM_MOVE)

/turf/open/umbra/Entered(atom/movable/movable)
	. = ..()
	if(movable.set_currently_z_moving(CURRENTLY_Z_FALLING))
		zFall(movable, falling_from_move = TRUE)

/turf/open/umbra/initialize_occupant(atom/movable/occupant)
	. = ..()
	zfall_if_on_turf(occupant)

/turf/open/umbra/proc/zfall_if_on_turf(atom/movable/movable)
	if(QDELETED(movable) || movable.loc != src)
		return
	zFall(movable)

/turf/open/umbra/zFall(atom/movable/falling, levels = 1, force = FALSE, falling_from_move = FALSE)
	if(falling.has_gravity() <= NEGATIVE_GRAVITY)
		return FALSE
	return ..(falling, levels * 100, force, falling_from_move)
