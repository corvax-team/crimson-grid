/obj/ritual_rune/necromancy/locate
	name = "minestra di morte"
	ru_name = "Minestra di Morte"
	desc = "Позволяет узнать, что сталось с душой, и попытаться выяснить, где она находится."
	icon_state = "rune5"
	word = "UAH'V OUH'RAN"
	level = 3
	sacrifices = list(/obj/item/shard)

/obj/ritual_rune/necromancy/locate/complete()

	var/chosen_name = tgui_input_text(usr, "Назовите истинное имя души, которую ищете:", "Minestra di Morte")
	var/target = find_target(chosen_name)

	if(!target)
		to_chat(usr, span_warning("Такой души нет ни за Завесой, ни здесь, в Землях Плоти!"))
		return

	var/area/targetarea = get_area(target)

	if(isavatar(target))
		to_chat(usr, span_ghostalert("Эта душа перекинула мост между двумя мирами. Её астральная проекция блуждает здесь: [targetarea.declent_ru(NOMINATIVE)]."))
		playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)
		qdel(src)
		return

	if(isobserver(target))
		to_chat(usr, span_ghostalert("Эта душа покинула мир живых. Она блуждает здесь: [targetarea.declent_ru(NOMINATIVE)]."))
		playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1off.ogg', 50, FALSE)
		qdel(src)
		return

	if(isliving(target))
		var/mob/living/livetarget = target
		if(livetarget.stat != DEAD)
			to_chat(usr, span_ghostalert("Эта душа всё ещё пребывает в Землях Плоти. Место: [targetarea.declent_ru(NOMINATIVE)]."))
			playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)

			if(IS_UNCONSCIOUS(livetarget))
				to_chat(usr, span_ghostalert("Её связь с этим миром слаба и продолжает слабеть. Смерть уже ждёт."))
			if(livetarget.get_discipline(/datum/discipline/necromancy)) //other necromancers catch onto it if targeted
				var/area/userarea = get_area(usr)
				to_chat(livetarget, span_notice("Холодок и шёпот. Вашу душу разыскал другой некромант. Его собственная душа отзывается отсюда: <b>[userarea.declent_ru(NOMINATIVE)]</b>."))
			qdel(src)
			return

		if (livetarget.stat == DEAD) //for when they haven't ghosted yet
			to_chat(usr, span_ghostalert("Эта душа по-прежнему заперта в своей погибшей оболочке. Место: [targetarea.declent_ru(NOMINATIVE)]."))
			qdel(src)
			return

/obj/ritual_rune/necromancy/locate/proc/find_target(chosen_name)
	var/mob/target_found
	for(var/mob/target in GLOB.player_list)
		if(target.real_name == chosen_name)
			target_found = target
			break
	return target_found
