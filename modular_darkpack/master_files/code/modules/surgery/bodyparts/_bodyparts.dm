/obj/item/bodypart
	///The current amount of aggravated damage the limb has
	var/aggravated_dam = 0
	/// Aggravated damage gets multiplied by this on receive_damage()
	var/aggravated_modifier = 1

	var/light_aggravated_msg = "покрытой кровоподтёками и онемевшей"
	var/medium_aggravated_msg = "разорванной"
	var/heavy_aggravated_msg = "разваливающейся на куски"
