/obj/item/camera/spooky
	name = "camera obscura"
	desc = "Фотоаппарат моментальной печати. Поговаривают, он видит призраков!"
	see_ghosts = CAMERA_SEE_GHOSTS_BASIC

/obj/item/camera/spooky/steal_souls(list/victims)
	for(var/mob/living/target in victims)
		if(!(target.mob_biotypes & MOB_SPIRIT))
			continue

		// time to steal your soul
		if(istype(target, /mob/living/basic/revenant))
			var/mob/living/basic/revenant/peek_a_boo = target
			peek_a_boo.apply_status_effect(/datum/status_effect/revenant/revealed, 2 SECONDS) // no hiding
			peek_a_boo.apply_status_effect(/datum/status_effect/incapacitating/paralyzed/revenant, 2 SECONDS)

		target.visible_message(
			span_warning("[capitalize(target.declent_ru(NOMINATIVE))] резко дёргается!"),
			span_revendanger("Вспышка фотоаппарата вытягивает из вас саму сущность!"),
		)
		target.apply_damage(rand(10, 15))

/obj/item/camera/spooky/badmin
	desc = "Фотоаппарат моментальной печати. Поговаривают, он видит призраков! На объектив надета дополнительная линза."
	see_ghosts = CAMERA_SEE_GHOSTS_ORBIT

/obj/item/camera/detective
	name = "detective's camera"
	desc = "Бесшумный фотоаппарат моментальной печати с увеличенным запасом плёнки. Для работы на месте преступления."
	print_monochrome = TRUE
	flash_enabled = FALSE
	silent = TRUE
	pictures_max = 30
	pictures_left = 30
