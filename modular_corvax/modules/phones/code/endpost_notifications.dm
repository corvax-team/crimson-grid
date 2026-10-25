/obj/item/smartphone
	var/endpost_notifications = TRUE

/obj/item/smartphone/ui_data(mob/user)
	. = ..()
	.["endpost_notifications"] = endpost_notifications

/obj/item/smartphone/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	if(action != "toggle_endpost_notifications")
		return
	endpost_notifications = !endpost_notifications
	balloon_alert(ui.user, "уведомления EndPost [endpost_notifications ? "включены" : "выключены"]")
	return TRUE

/proc/endpost_notify_phones(author, body, obj/item/smartphone/author_phone)
	for(var/obj/item/smartphone/listening_phone as anything in GLOB.phones_list)
		if(listening_phone == author_phone || !listening_phone.endpost_notifications || !listening_phone.sim_card)
			continue
		listening_phone.receive_notification("EndPost", author, body)

/// Only the one carrying the phone in hands or a pocket reads it, a phone in a bag goes unnoticed
/obj/item/smartphone/proc/show_notification_in_chat(app, title, body)
	var/mob/living/holder = loc
	if(!istype(holder))
		return
	to_chat(holder, span_notice("[icon2html(src, holder)] <b>[html_encode(app)]</b> - [html_encode(title)]: [html_encode(body)]"))
