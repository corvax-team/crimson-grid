GLOBAL_LIST_INIT(skill_types, subtypesof(/datum/skill))

/datum/skill
	var/name = "Skilling"
	var/title = "Skiller"
	var/desc = "искусство делать дела"
	///Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	var/modifiers = list(SKILL_SPEED_MODIFIER = list(1, 1, 1, 1, 1, 1, 1)) //Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	///List Path pointing to the skill item reward that will appear when a user finishes leveling up a skill
	var/skill_item_path
	///List associating different messages that appear on level up with different levels
	var/list/levelUpMessages = list()
	///List associating different messages that appear on level up with different levels
	var/list/levelDownMessages = list()

/datum/skill/proc/get_skill_modifier(modifier, level)
	return modifiers[modifier][level] //Levels range from 1 (None) to 7 (Legendary)
/**
 * new: sets up some lists.
 *
 *Can't happen in the datum's definition because these lists are not constant expressions
 */
/datum/skill/New()
	. = ..()
	levelUpMessages = list(span_nicegreen("Что ещё за навык \"[name]\"? Если видите это сообщение, расскажите администратору."), //This first index shouldn't ever really be used
	span_nicegreen("Навык \"[name]\": кажется, я начинаю понимать, что к чему!"),
	span_nicegreen("Навык \"[name]\": получается уже чуть лучше!"),
	span_nicegreen("Навык \"[name]\": получается заметно лучше!"),
	span_nicegreen("Навык \"[name]\": похоже, я уже неплохо в этом разбираюсь!"),
	span_nicegreen("Навык \"[name]\": после долгой практики мне открылись все тонкости и неожиданная глубина этого дела. Теперь я с полным правом называю себя мастером."),
	span_nicegreen("Навык \"[name]\": упорство и труд довели меня до самой вершины. Теперь обо мне будут ходить легенды!") )
	levelDownMessages = list(span_nicegreen("Навык \"[name]\" каким-то образом полностью выветрился из головы. Если видите это сообщение, расскажите администратору."),
	span_nicegreen("Навык \"[name]\": я уже начинаю забывать, что это вообще такое. Нужно больше практики..."),
	span_nicegreen("Навык \"[name]\": получается немного хуже. Без постоянной практики лучше не станет..."),
	span_nicegreen("Навык \"[name]\": получается немного хуже..."),
	span_nicegreen("Навык \"[name]\": сноровка уходит..."),
	span_nicegreen("Навык \"[name]\": кажется, мастерство уже не то."),
	span_nicegreen("Навык \"[name]\": от былой легендарной формы мало что осталось. Чтобы вернуть её, придётся тренироваться всерьёз.") )

/**
 * level_gained: Gives skill levelup messages to the user
 *
 * Only fires if the xp gain isn't silent, so only really useful for messages.
 * Arguments:
 * * mind - The mind that you'll want to send messages
 * * new_level - The newly gained level. Can check the actual level to give different messages at different levels, see defines in skills.dm
 * * old_level - Similar to the above, but the level you had before levelling up.
 * * silent - Silences the announcement if TRUE
 */
/datum/skill/proc/level_gained(datum/mind/mind, new_level, old_level, silent)
	if(silent)
		return
	to_chat(mind.current, levelUpMessages[new_level]) //new_level will be a value from 1 to 6, so we get appropriate message from the 6-element levelUpMessages list
/**
 * level_lost: See level_gained, same idea but fires on skill level-down
 */
/datum/skill/proc/level_lost(datum/mind/mind, new_level, old_level, silent)
	if(silent)
		return
	to_chat(mind.current, levelDownMessages[old_level]) //old_level will be a value from 1 to 6, so we get appropriate message from the 6-element levelUpMessages list

/**
 * try_skill_reward: Checks to see if a user is eligable for a tangible reward for reaching a certain skill level
 *
 * Currently gives the user a special cloak when they reach a legendary level at any given skill
 * Arguments:
 * * mind - The mind that you'll want to send messages and rewards to
 * * new_level - The current level of the user. Used to check if it meets the requirements for a reward
 */
/datum/skill/proc/try_skill_reward(datum/mind/mind, new_level)
	if (new_level != SKILL_LEVEL_LEGENDARY)
		return
	if (!ispath(skill_item_path))
		to_chat(mind.current, span_nicegreen("Навык \"[name]\" у меня теперь легендарный, вот только у профессиональной ассоциации не нашлось никакого знака отличия, чтобы это отметить. Безобразие, конечно."))
		return
	if (LAZYFIND(mind.skills_rewarded, src.type))
		to_chat(mind.current, span_nicegreen("Похоже, второй знак отличия профессиональная ассоциация мне не пришлёт."))
		return
	podspawn(list(
		"target" = get_turf(mind.current),
		"style" = /datum/pod_style/advanced,
		"spawn" = skill_item_path,
		"delays" = list(POD_TRANSIT = 150, POD_FALLING = 4, POD_OPENING = 30, POD_LEAVING = 30)
	))
	to_chat(mind.current, span_nicegreen("Мой легендарный навык заметили в профессиональной ассоциации. Кажется, мне высылают знак отличия."))
	LAZYADD(mind.skills_rewarded, src.type)
