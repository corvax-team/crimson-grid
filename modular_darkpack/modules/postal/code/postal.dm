/obj/lettermachine
	name = "letter machine"
	desc = "Стань почтальоном! Найди себе работу!"
	icon = 'modular_darkpack/modules/postal/icons/letters.dmi'
	icon_state = "mail"
	density = TRUE
	anchored = TRUE
	plane = GAME_PLANE
	layer = CAR_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/money = 0

/obj/lettermachine/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(money >= 10)
		new /obj/item/letter(loc)
		say("Новое письмо выдано!")
		money = max(0, money-10)
	else
		say("Недостаточно средств на балансе!")

/obj/lettermachine/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(iscash(tool))
		money += tool.get_item_credit_value()
		to_chat(user, span_notice("Вы вносите [tool.get_item_credit_value()] [MONEY_NAME_AUTOPURAL(tool.get_item_credit_value())] в [declent_ru(ACCUSATIVE)]."))
		say("Деньги приняты.")
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/mark))
		new /obj/item/stack/dollar(loc, 30)
		say("Доставка подтверждена!")
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/lettermachine/examine(mob/user)
	. = ..()
	. += span_info("На балансе [money] [MONEY_NAME_AUTOPURAL(money)].")

/obj/item/letter
	name = "letter"
	icon_state = "letter"
	icon = 'modular_darkpack/modules/postal/icons/letters.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	var/datum/weakref/mail_target_weakref

/obj/item/mark
	name = "letter mark"
	icon_state = "mark"
	icon = 'modular_darkpack/modules/postal/icons/letters.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_TINY

/obj/item/letter/Initialize(mapload)
	. = ..()
	var/list/mail_recipients = list()
	for(var/mob/living/carbon/human/alive in GLOB.player_list)
		if(alive.stat != DEAD)
			mail_recipients += alive
	if(length(mail_recipients))
		var/mob/mail_target = pick(mail_recipients)
		ru_names_rename(ru_names_toml("letter", suffix = " ([mail_target.real_name])", override_base = initial(name)))
		name = "letter ([mail_target.real_name])"
		mail_target_weakref = WEAKREF(mail_target)

/obj/item/letter/examine(mob/user)
	. = ..()
	var/mob/mail_target = mail_target_weakref.resolve()
	. += "Письмо адресовано: <b>[mail_target?.real_name]</b>"

/obj/item/letter/attack_self(mob/user)
	. = ..()
	var/mail_target = mail_target_weakref.resolve()
	if(user == mail_target)
		playsound(loc, 'sound/items/poster/poster_ripped.ogg', 50, TRUE)
		var/IT = pick(
			/obj/item/storage/pill_bottle/unknown,
			/obj/item/storage/pill_bottle/ephedrine,
			/obj/item/storage/pill_bottle/potassiodide,
			/obj/item/vampire_stake,
			/obj/item/stack/dollar/rand,
			/obj/item/knife/vamp,
			/obj/item/melee/vamp/tire,
			/obj/item/reagent_containers/blood,
			/obj/item/gun/ballistic/revolver/darkpack/snub,
			/obj/item/vamp/keys/hack,
		)
		new IT(user.loc)
		new /obj/item/mark(user.loc)
		qdel(src)

