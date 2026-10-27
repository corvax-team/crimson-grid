/atom/movable/screen/zone_hud/Click(location, control, params)
	var/area/vtm/current_area = get_area(usr)
	if(!istype(current_area))
		return
	to_chat(usr, boxed_message(zone_info(current_area.zone_type)))

/atom/movable/screen/zone_hud/proc/zone_info(zone_type)
	switch(zone_type)
		if(ZONE_MASQUERADE)
			return "[span_boldnotice("Маскарад")]<br>\
				[span_notice("Здесь действует Маскарад. Если смертные увидят, как вы применяете сверхъестественные силы, это будет нарушением Маскарада. Свидетели сообщат о стрельбе, убийствах и кражах в полицию. Ведите себя как обычный человек")]"
		if(ZONE_ELYSIUM)
			return "[span_boldnotice("Безопасная зона")]<br>\
				[span_notice("Убежища, клубы и места встреч. Нарушения Маскарада здесь не засчитываются, можно не скрывать свою природу. Драться здесь не принято: за нападение спросят хозяева места")]"
		if(ZONE_NO_MASQUERADE)
			return "[span_boldnotice("Вне Маскарада")]<br>\
				[span_notice("Посторонних глаз здесь нет: нарушения Маскарада не засчитываются, полицию никто не вызовет. Но и защиты никакой: здесь может случиться что угодно, будьте осторожны")]"
