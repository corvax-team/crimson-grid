/area
	/// Tracking powers and papers (Blood Hunt, Camarilla and Inquisition papers, Garou pocketwatch) can't tell anyone is here.
	var/hidden_from_tracking = FALSE

/area/vtm/interior/police/fed
	hidden_from_tracking = TRUE

/area/vtm/interior/sabbat_lair
	hidden_from_tracking = TRUE

// The first floor is the basement; the second is the public lobby; the third and up are staff only.
/area/vtm/interior/millennium_tower
	hidden_from_tracking = TRUE

/area/vtm/interior/millennium_tower/f2
	hidden_from_tracking = FALSE

/area/vtm/interior/giovanni/basement
	hidden_from_tracking = TRUE

/area/vtm/interior/anarch/basement
	hidden_from_tracking = TRUE

/area/vtm/interior/sewer
	hidden_from_tracking = TRUE

/// The Triad basement under the laundromat. Painted onto the map in place of plain interior.
/area/vtm/interior/laundromat/basement
	name = "Laundromat - Basement"
	hidden_from_tracking = TRUE

/// Returns TRUE if tracking can't tell where `target` is.
/proc/is_hidden_from_tracking(atom/target)
	var/area/target_area = get_area(target)
	return isnull(target_area) || target_area.hidden_from_tracking

/// Where `target` is, as tracking powers and papers report it. Hidden places read as unknown, coordinates included.
/proc/get_tracked_location(atom/target, show_coordinates = FALSE)
	if(is_hidden_from_tracking(target))
		return "Неизвестное расположение"
	if(!show_coordinates)
		return get_area_name(target)
	var/turf/target_turf = get_turf(target)
	return "[get_area_name(target)], X:[target_turf.x] Y:[target_turf.y] Z:[target_turf.z]"
