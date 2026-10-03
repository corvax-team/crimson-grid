/datum/skill/gaming
	name = "Видеоигры"
	title = "Геймер"
	desc = "Мой геймерский уровень. Помогает выносить боссов, выжимать максимум из игровых автоматов и вызывает желание закинуться энергетиком."
	modifiers = list(SKILL_PROBS_MODIFIER = list(0, 5, 10, 15, 15, 20, 25),
				SKILL_RANDS_MODIFIER = list(0, 1, 2, 3, 4, 5, 7))
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/gaming

/datum/skill/gaming/New()
	. = ..()
	levelUpMessages[1] = span_nicegreen("Кажется, я начинаю привыкать к управлению в этих играх...")
	levelUpMessages[4] = span_nicegreen("Я начинаю улавливать мету этих автоматов. Если отточить оптимальную стратегию и выстроить весь стиль игры вокруг проверенных приёмов...")
	levelUpMessages[6] = span_nicegreen("Упорство и труд довели меня до вершины геймерского мастерства. Куда расти дальше?.. Может, энергетик и правда помогает играть лучше?..")
