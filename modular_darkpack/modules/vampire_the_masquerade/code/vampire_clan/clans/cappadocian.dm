/datum/subsplat/vampire_clan/cappadocian
	name = "Cappadocian"
	ru_name = "Каппадокийцы"
	id = VAMPIRE_CLAN_CAPPADOCIAN
	desc = "Клан некромантов, который считается вымершим. Каппадокийцы изучали смерть, какой она предстаёт в физическом мире, а Джованни получили от них Становление, чтобы помочь в изучении загробного. В награду Каппадокийцам достались диаблери и гибель клана вместе с основателем."
	icon = "cappadocian"
	curse = "Бледный, измождённый облик, которому даже трата крови не способна придать человеческий вид."
	sense_the_sin_text = "никогда не избавится от облика гниющего трупа."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/fortitude,
		/datum/discipline/necromancy
	)
	alt_sprite = "rotten1"
	alt_sprite_greyscale = TRUE

	whitelisted = TRUE

/datum/subsplat/vampire_clan/cappadocian/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()

	apply_rot_curse(gaining_mob, gaining_mob.chronological_age)

/datum/subsplat/vampire_clan/cappadocian/proc/apply_rot_curse(mob/living/carbon/human/H, chronological_age)
	switch(chronological_age)
		if (-INFINITY to 500)
			H.rot_body(1)
		if (500 to INFINITY)
			H.rot_body(2)

/datum/subsplat/vampire_clan/cappadocian/harbinger
	name = "Harbinger of Skulls"
	ru_name = "Предвестники Черепов"
	id = VAMPIRE_CLAN_HARBINGER
	desc = "Линия крови клана Каппадокийцев, состоящая главным образом из жертв Пира Глупцов и чистки, которую устроили клану Джованни. Эти Каппадокийцы Шабаша, мастера Некромантии, унесли власть над мёртвыми с собой в загробный мир, где стали могущественными призраками и ждали случая пересечь Завесу, чтобы отомстить за свой клан."
	curse = "Облик мертвеца, который с годами становится только хуже: старейшие из них - ходячие скелеты или призрачные фигуры, напоминающие о времени, проведённом за Завесой."
	icon = "harbinger_of_skulls"

/datum/subsplat/vampire_clan/cappadocian/harbinger/apply_rot_curse(mob/living/carbon/human/H, chronological_age)
	switch(chronological_age)
		if (-INFINITY to 100)
			H.rot_body(1)
		if (100 to 300)
			H.rot_body(2)
		if (300 to 500)
			H.rot_body(3)
		if (500 to INFINITY)
			H.rot_body(4)

/datum/subsplat/vampire_clan/cappadocian/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("В вашу тлеющую плоть вползает новое отчаяние: рядом кто-то есть, и от него веет жуткой пустотой."))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
	new /obj/effect/client_image_holder/baali_demon/spectre(get_turf(target), list(target))
