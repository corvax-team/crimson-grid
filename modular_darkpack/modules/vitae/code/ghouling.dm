/mob/living/carbon/human/proc/prompt_permanent_ghouling()
	var/response = tgui_alert(src, "Оставить персонажа гулем в этом слоте сохранения? Это навсегда, отменить выбор будет нельзя!", "Превращение в гуля", list("Да", "Нет"))
	if(response == "Да")
		write_preference_midround(/datum/preference/choiced/splats, SPLAT_GHOUL)
		to_chat(src, span_danger("Вы решили остаться гулем навсегда!"))


/mob/living/carbon/human/proc/ghoulificate(mob/living/carbon/human/owner)
	make_ghoul(owner)
	if(!mind)
		return
	send_ghoul_vitae_consumption_message(owner)

/mob/living/carbon/human/proc/send_ghoul_vitae_consumption_message(mob/living/carbon/human/owner)
	if(HAS_TRAIT(src, TRAIT_UNBONDABLE) || !owner)
		to_chat(src, span_warning("Драгоценная витэ касается языка - наркотик, от которого не отвыкнуть. Но преданности тому, кто её дал, вы не чувствуете: вам нужна только она сама."))
		return TRUE
	var/mob/living/master = mind.enslaved_to?.resolve()
	if(master != owner)
		mind.enslave_mind_to_creator(owner)
		apply_status_effect(/datum/status_effect/blood_bond, owner)
		to_chat(src, span_userdanger("С первым глотком в первую ночь вы станете боготворить или ненавидеть того, чьей крови испили. Со вторым глотком во вторую ночь начнёте ловить каждое его слово и искать его расположения. На третью ночь, с третьим глотком, вы принадлежите ему без остатка. Воспротивиться ещё можно, но такие порывы мимолётны."))
		return TRUE


