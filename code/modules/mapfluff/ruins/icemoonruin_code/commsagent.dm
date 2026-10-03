/obj/item/tape/frozen
	name = "frozen tape"
	desc = "A frozen old tape. The cold has somewhat preserved the recording inside."
	icon_state = "tape_white"
	used_capacity = 10 MINUTES
	storedinfo = list(
		"\[00:04\]Три.",
		"\[00:05\]Года.",
		"\[00:07\]Три ЧЕРТОВЫХ года в этом морозильнике",
		"\[00:11\]Моя миссия должна быть закончена уже!",
		"\[00:15\]Nanotrasen оставил свое место сгнить на как,",
		"\[00:20\]8, 9, 10 месяцев? Я потерял счет",
		"\[00:25\]Это была миссия для ДВУХ человек,",
		"\[00:29\]Но другой агент даже не дает никаких признаков пробуждения...",
		//long silence
		"\[02:00\]Я не могу этого больше, чел.",
		"\[02:03\]Мне нужно уйти,",
		"\[02:06\]Может быть, с перчатками гориллы, я могу...",
		"\[02:11\]Хм.",
		//shorter silence
		"\[02:34\]Я решил рискнуть.",
		"\[02:37\]Если кто-то найдет эту ленту,",
		"\[02:40\]независимо от исхода,",
		"\[02:43\]просто знай, что я не пожалел об этом."
	)
	timestamp = list (
		4 SECONDS,
		5 SECONDS,
		7 SECONDS,
		11 SECONDS,
		15 SECONDS,
		20 SECONDS,
		25 SECONDS,
		29 SECONDS,
		2 MINUTES,
		2 MINUTES + 3 SECONDS,
		2 MINUTES + 6 SECONDS,
		2 MINUTES + 11 SECONDS,
		2 MINUTES + 34 SECONDS,
		2 MINUTES + 37 SECONDS,
		2 MINUTES + 40 SECONDS,
		2 MINUTES + 43 SECONDS
	)

/obj/item/tape/frozen/Initialize(mapload)
	. = ..()
	unspool() // the tape spawns damaged

/obj/item/tape/comms_wall
	icon_state = "tape_red"
	used_capacity = 10 MINUTES
	storedinfo = list(
		"\[00:01\]"
	)
