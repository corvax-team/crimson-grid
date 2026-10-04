/obj/item/sabbat_war_party
	name = "Sabbat War Party Totem"
	desc = "Тотем из вампирского черепа. Созывает все стаи Шабаша в логово Дуктуса."
	icon = 'modular_darkpack/modules/sabbat/icons/sabbat_war_party.dmi'
	icon_state = "sabbat_warparty"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL

/obj/item/sabbat_war_party/attack_self(mob/user)
	. = ..()

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	if(!is_sabbat_ductus(H.mind.assigned_role) && !is_sabbat_priest(H.mind.assigned_role))
		to_chat(H, span_cult("Созвать Боевой поход через тотем может только Дуктус или духовник!"))
		return

	var/choice = tgui_alert(H, "Разослать всему Шабашу в городе приказ вернуться в логово?", "Сбор стаи", list("Да", "Нет"), 10 SECONDS)
	if(choice == "Да")

		// Inform the user about the current status of the totem
		to_chat(H, span_notice("Вы взываете к силе черепа, и его глазницы вспыхивают багровым светом."))
		for(var/mob/living/carbon/human/sabbat_member in GLOB.player_list)
			if(sabbat_member.mind && is_sabbatist(sabbat_member.mind.assigned_role))
				to_chat(sabbat_member, span_cult("Дуктус созывает всю стаю в логово. Возвращайтесь немедленно!"))
				SEND_SOUND(sabbat_member, sound('modular_darkpack/master_files/sounds/announce.ogg'))
				sabbat_member.emote("twitch")
	else
		to_chat(user, span_warning("Вы решаете не созывать боевой поход."))
