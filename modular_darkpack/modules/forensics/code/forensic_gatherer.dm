// Microstamping category
/datum/detective_scan_category/microstamp
	id = DETSCAN_CATEGORY_MICROSTAMP
	name = "Микроштамп"
	display_order = 10
	ui_icon = "ss-casing"
	ui_icon_color = "yellow"

// Bullet shrapnel category
/datum/detective_scan_category/bullet
	id = DETSCAN_CATEGORY_BULLET
	name = "Фрагменты пули"
	display_order = 11
	ui_icon = "flask"
	ui_icon_color = "red"

// Unique subtype of the base TG Station scanner; this one lets for unique bullet scanning and has skill-checks on it.
/obj/item/detective_scanner/darkpack
	name = "forensics kit"
	desc = "Набор для поиска и сбора улик: биоматериала для анализа ДНК, отпечатков пальцев, а ещё для изучения стреляных гильз. Умеет печатать отчёт о находках."
	icon = 'modular_darkpack/modules/forensics/icons/forensics_kit.dmi'
	icon_state = "magnifier"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/forensics/icons/onfloor.dmi')
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	range = 1	//Stops across the room gathering.
	custom_price = 10 // DARKPACK EDIT ADD - Police Store

/obj/item/detective_scanner/darkpack/scan(mob/user, atom/scanned_atom)
	if(loc != user)
		return TRUE
	// Can scan items we hold and store
	if(!(scanned_atom in user.get_all_contents()))
		// Can remotely scan objects and mobs.
		if((get_dist(scanned_atom, user) > range) || (!(scanned_atom in view(range, user)) && view_check))
			return TRUE
	playsound(src, SFX_INDUSTRIAL_SCAN, 20, TRUE, -2, TRUE, FALSE)
	scanner_busy = TRUE


	user.visible_message(
		span_notice("[capitalize(user.declent_ru(NOMINATIVE))] наводит [declent_ru(ACCUSATIVE)] на [scanned_atom.declent_ru(ACCUSATIVE)] и проводит криминалистическое сканирование."),
		ignored_mobs = user
	)
	to_chat(user, span_notice("Вы сканируете [scanned_atom.declent_ru(ACCUSATIVE)]. Сканер обрабатывает результаты..."))


	// GATHER INFORMATION

	var/datum/detective_scanner_log/log_entry = new

	// Start gathering

	log_entry.scan_target = scanned_atom.name
	log_entry.scan_time = server_timestamp(ic_time = TRUE)

	var/list/atom_fibers = GET_ATOM_FIBRES(scanned_atom)
	if(length(atom_fibers))
		log_entry.add_data_entry(DETSCAN_CATEGORY_FIBER, atom_fibers.Copy())

	var/list/blood = GET_ATOM_BLOOD_DNA(scanned_atom)
	if(length(blood))
		log_entry.add_data_entry(DETSCAN_CATEGORY_BLOOD, blood.Copy())

	// Skill-check for scans
	var/mob/living/carbon/human/H = user
	var/datum/storyteller_roll/investigation/investigate_roll = new()

	//Minium skill requirement to even use the thing
	if(H.st_get_stat(STAT_INVESTIGATION) <= 0)
		to_chat(user, span_warning("Вам не хватает умения что-либо найти: вы только портите улики!"))
		return FALSE

	if(ishuman(scanned_atom))
		var/mob/living/carbon/human/scanned_human = scanned_atom
		investigate_roll.difficulty = 3
		var/investigation_roll = investigate_roll.st_roll(user, scanned_human)
		if(investigation_roll != ROLL_SUCCESS)
			log_entry.add_data_entry(DETSCAN_CATEGORY_FINGERS, list("Отпечатки сняты неудачно, попробуйте ещё раз."))
		else
			if(!scanned_human.gloves)
				log_entry.add_data_entry(
					DETSCAN_CATEGORY_FINGERS,
					rustg_hash_string(RUSTG_HASH_MD5, scanned_human.dna?.unique_identity)
				)

	else if(!ismob(scanned_atom))
		var/list/atom_fingerprints = GET_ATOM_FINGERPRINTS(scanned_atom)
		investigate_roll.difficulty = 5
		var/investigation_roll = investigate_roll.st_roll(user, scanned_atom)
		if(investigation_roll != ROLL_SUCCESS)
			log_entry.add_data_entry(DETSCAN_CATEGORY_FINGERS, list("Образцы собраны неудачно, попробуйте ещё раз."))
		else
			if(length(atom_fingerprints))
				log_entry.add_data_entry(DETSCAN_CATEGORY_FINGERS, atom_fingerprints.Copy())

			// Only get reagents from non-mobs.
			for(var/datum/reagent/present_reagent as anything in scanned_atom.reagents?.reagent_list)
				log_entry.add_data_entry(DETSCAN_CATEGORY_REAGENTS, list(present_reagent.name = present_reagent.volume))

				// Get blood data from the blood reagent.
				if(!istype(present_reagent, /datum/reagent/blood))
					continue

				var/blood_DNA = present_reagent.data["blood_DNA"]
				var/blood_type = present_reagent.data["blood_type"]
				if(!blood_DNA || !blood_type)
					continue

				log_entry.add_data_entry(DETSCAN_CATEGORY_BLOOD, list(blood_DNA = blood_type))

	if(istype(scanned_atom, /obj/item/ammo_casing))
		investigate_roll.difficulty = 7
		var/investigation_roll = investigate_roll.st_roll(user, scanned_atom)
		var/obj/item/ammo_casing/casing = scanned_atom
		if(investigation_roll != ROLL_SUCCESS)
			log_entry.add_data_entry(DETSCAN_CATEGORY_MICROSTAMP, list("[capitalize(casing.declent_ru(NOMINATIVE))]: микроштамп неполный, разобрать его не удаётся."))
		else
			if(casing.serial_type_index)
				log_entry.add_data_entry(DETSCAN_CATEGORY_MICROSTAMP, list("[capitalize(casing.declent_ru(NOMINATIVE))]: серийный номер [casing.serial_type_index]"))
			else
				log_entry.add_data_entry(DETSCAN_CATEGORY_MICROSTAMP, list("[capitalize(casing.declent_ru(NOMINATIVE))]: микроштамп неполный, разобрать его не удаётся."))

	if(istype(scanned_atom, /obj/item/card/id))
		var/obj/item/card/id/user_id = scanned_atom
		investigate_roll.difficulty = 3
		var/investigation_roll = investigate_roll.st_roll(user, scanned_atom)
		if(investigation_roll != ROLL_SUCCESS)
			log_entry.add_data_entry(DETSCAN_CATEGORY_ACCESS, list("Образцы собраны неудачно, попробуйте ещё раз."))
		else
			for(var/region in DETSCAN_ACCESS_ORDER())
				var/access_in_region = SSid_access.accesses_by_region[region] & user_id.GetAccess()
				if(!length(access_in_region))
					continue
				var/list/access_names = list()
				for(var/access_num in access_in_region)
					access_names += SSid_access.get_access_desc(access_num)

				log_entry.add_data_entry(DETSCAN_CATEGORY_ACCESS, list("[region]" = english_list(access_names)))

	// sends it off to be modified by the items
	SEND_SIGNAL(scanned_atom, COMSIG_DETECTIVE_SCANNED, user, log_entry)

	// Perform sorting now, because probably this will be never modified
	log_entry.sort_data_entries()

	stoplag(3 SECONDS)
	log_data += log_entry
	return TRUE
