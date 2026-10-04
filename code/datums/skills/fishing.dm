/**
 * skill associated with the fishing feature. It modifies the fishing minigame difficulty
 * and is gained each time one is completed.
 */
/datum/skill/fishing
	name = "Рыбалка"
	title = "Рыболов"
	desc = "Как же пусто и одиноко на этой бесплодной земле."
	modifiers = list(SKILL_VALUE_MODIFIER = list(1, 0, -1, -3, -5, -7, -10))
	skill_item_path = /obj/item/clothing/head/soft/fishing_hat

/datum/skill/fishing/New()
	. = ..()
	levelUpMessages[SKILL_LEVEL_NOVICE] = span_nicegreen("Кажется, я начинаю понимать, что такое рыбалка! Размер и вес рыбы теперь прикидываю на глаз.")
	levelUpMessages[SKILL_LEVEL_APPRENTICE] = span_nicegreen("Рыбалка даётся уже чуть лучше! Теперь я вижу, голодна рыба, умирает или с ней всё в порядке.")
	levelUpMessages[SKILL_LEVEL_JOURNEYMAN] = span_nicegreen("Похоже, в рыбалке я уже кое-что смыслю! В любом месте могу сказать, какая рыба тут водится.")
	levelUpMessages[SKILL_LEVEL_MASTER] = span_nicegreen("Мне открылась неожиданная глубина рыбалки. Теперь я мастер и заранее чувствую, что клюнет!")

/datum/skill/fishing/level_gained(datum/mind/mind, new_level, old_level, silent)
	. = ..()
	if(new_level >= SKILL_LEVEL_NOVICE && old_level < SKILL_LEVEL_NOVICE)
		ADD_TRAIT(mind, TRAIT_EXAMINE_FISH, SKILL_TRAIT)
	if(new_level >= SKILL_LEVEL_APPRENTICE && old_level < SKILL_LEVEL_APPRENTICE)
		ADD_TRAIT(mind, TRAIT_EXAMINE_DEEPER_FISH, SKILL_TRAIT)
	if(new_level >= SKILL_LEVEL_JOURNEYMAN && old_level < SKILL_LEVEL_JOURNEYMAN)
		ADD_TRAIT(mind, TRAIT_EXAMINE_FISHING_SPOT, SKILL_TRAIT)
	if(new_level >= SKILL_LEVEL_MASTER && old_level < SKILL_LEVEL_MASTER)
		ADD_TRAIT(mind, TRAIT_REVEAL_FISH, SKILL_TRAIT)

/datum/skill/fishing/level_lost(datum/mind/mind, new_level, old_level, silent)
	. = ..()
	if(old_level >= SKILL_LEVEL_MASTER && new_level < SKILL_LEVEL_MASTER)
		REMOVE_TRAIT(mind, TRAIT_REVEAL_FISH, SKILL_TRAIT)
	if(old_level >= SKILL_LEVEL_JOURNEYMAN && new_level < SKILL_LEVEL_JOURNEYMAN)
		REMOVE_TRAIT(mind, TRAIT_EXAMINE_FISHING_SPOT, SKILL_TRAIT)
	if(old_level >= SKILL_LEVEL_APPRENTICE && new_level < SKILL_LEVEL_APPRENTICE)
		REMOVE_TRAIT(mind, TRAIT_EXAMINE_DEEPER_FISH, SKILL_TRAIT)
	if(old_level >= SKILL_LEVEL_NOVICE && new_level < SKILL_LEVEL_NOVICE)
		REMOVE_TRAIT(mind, TRAIT_EXAMINE_FISH, SKILL_TRAIT)
