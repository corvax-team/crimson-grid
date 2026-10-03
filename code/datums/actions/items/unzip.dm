/datum/action/item_action/zipper
	name = "Расстегнуть сумку"
	desc = "Расстегнуть надетую сумку, чтобы добраться до содержимого."

/datum/action/item_action/zipper/New(Target)
	. = ..()
	RegisterSignal(target, COMSIG_DUFFEL_ZIP_CHANGE, PROC_REF(on_zip_change))
	var/obj/item/storage/backpack/duffelbag/duffle_target = target
	on_zip_change(target, duffle_target.zipped_up)

/datum/action/item_action/zipper/proc/on_zip_change(datum/source, new_zip)
	SIGNAL_HANDLER
	if(new_zip)
		name = "Расстегнуть" 
		desc = "Расстегнуть надетую сумку, чтобы добраться до содержимого."
	else
		name = "Застегнуть"
		desc = "Застегнуть надетую сумку, чтобы она не мешала двигаться."
	build_all_button_icons(UPDATE_BUTTON_NAME)
