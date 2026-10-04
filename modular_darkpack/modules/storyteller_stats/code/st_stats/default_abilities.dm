// Talents
/datum/st_stat/ability/alertness
	subcategory = "Таланты"
	name = "Бдительность"
	description = "Влияет на интуицию персонажа."

/datum/st_stat/ability/athletics
	subcategory = "Таланты"
	name = "Атлетика"
	description = "Влияет на физическую форму и выносливость персонажа, а также на умение лазать по стенам и прыгать."

/datum/st_stat/ability/awareness
	subcategory = "Таланты"
	name = "Шестое чувство"
	description = "Влияет на то, насколько хорошо персонаж подмечает мельчайшие детали. Используется в Ясновидении."

/datum/st_stat/ability/brawl
	subcategory = "Таланты"
	name = "Драка"
	description = "Влияет на умение драться без оружия и на минимальные повреждения в рукопашной."

/datum/st_stat/ability/empathy
	subcategory = "Таланты"
	name = "Эмпатия"
	description = "Влияет на способность понимать чужие чувства и душевное состояние."

/datum/st_stat/ability/expression
	subcategory = "Таланты"
	name = "Красноречие"
	description = "Влияет на способность персонажа выражать свои мысли и чувства."

/datum/st_stat/ability/intimidation
	subcategory = "Таланты"
	name = "Запугивание"
	description = "Влияет на умение убеждать угрозами и силой. Используется в Доминировании, Величии и других ментальных и социальных Дисциплинах."

/datum/st_stat/ability/leadership
	subcategory = "Таланты"
	name = "Лидерство"
	description = "Влияет на природную склонность вести за собой, руководить, брать на себя ответственность и планировать. Увеличивает максимальное число последователей и прислужников."

/datum/st_stat/ability/streetwise
	subcategory = "Таланты"
	name = "Уличное чутьё"
	description = "Влияет на знание преступного мира и связи в бедных кварталах."

/datum/st_stat/ability/subterfuge
	subcategory = "Таланты"
	name = "Хитрость"
	description = "Влияет на умение вредить исподтишка, действовать скрытно и обманывать. Используется в Доминировании, Величии и Сокрытии."

// Skills
/datum/st_stat/ability/animal_ken
	subcategory = "Навыки"
	name = "Обращение с животными"
	description = "Влияет на умение ладить с животными и прочими тварями."

/datum/st_stat/ability/crafts
	subcategory = "Навыки"
	name = "Ремесло"
	description = "Влияет на возможность изготавливать некоторые предметы."

/datum/st_stat/ability/drive
	subcategory = "Навыки"
	name = "Вождение"
	description = "Определяет, насколько хорошо персонаж водит. С нулём точек вы вообще не сможете сесть за руль."

/datum/st_stat/ability/etiquette
	subcategory = "Навыки"
	name = "Этикет"
	description = "Влияет на умение производить впечатление приятного в общении человека."

/datum/st_stat/ability/firearms
	subcategory = "Навыки"
	name = "Стрельба"
	description = "Влияет на владение огнестрельным оружием. Снижает отдачу некоторых видов оружия. Каждая точка даёт 10% шанса на то, что пуля нанесёт на 40% больше повреждений (максимум 50%)."

/datum/st_stat/ability/larceny
	subcategory = "Навыки"
	name = "Воровство"
	description = "Влияет на умение красть и вскрывать замки. С нулём точек вы вообще не сможете пользоваться отмычками."

/datum/st_stat/ability/melee
	subcategory = "Навыки"
	name = "Фехтование"
	description = "Влияет на повреждения от любого оружия ближнего боя."

/datum/st_stat/ability/performance
	subcategory = "Навыки"
	name = "Исполнение"
	description = "Влияет на актёрский талант персонажа. Используется в Величии и Сокрытии."

/datum/st_stat/ability/stealth
	subcategory = "Навыки"
	name = "Скрытность"
	description = "Влияет на умение красться и оставаться незамеченным. Используется в Сокрытии."

/datum/st_stat/ability/survival
	subcategory = "Навыки"
	name = "Выживание"
	description = "Влияет на способность выживать в одиночку - в дикой природе или на холодных, безжалостных улицах города."

// Knowledges
/datum/st_stat/ability/academics
	subcategory = "Знания"
	name = "Гуманитарные науки"
	description = "Влияет на познания в гуманитарных науках и литературе, а также на число языков, которыми владеет персонаж. С нулём точек он знает только один язык."

/datum/st_stat/ability/computer
	subcategory = "Знания"
	name = "Информатика"
	/* V20 p. 108
	This Knowledge represents the ability to operate and program computers, including mobile devices.
	Most Computer use also imparts a degree of Internet awareness (if not savvy).
	*/
	description = "Влияет на умение пользоваться компьютерной техникой."

// This kinda sucks dick to do for every stat.
/datum/st_stat/ability/computer/New()
	. = ..()
	if(CONFIG_GET(flag/punishing_zero_dots))
		description += " С нулём точек вы не сможете пользоваться компьютером."

/datum/st_stat/ability/finance
	subcategory = "Знания"
	name = "Финансы"
	description = "Влияет на достаток и деловую хватку персонажа. От этой способности зависит стартовая сумма на банковском счёте и выручка от продажи предметов."

/datum/st_stat/ability/investigation
	subcategory = "Знания"
	name = "Расследование"
	description = "Влияет на умение складывать наблюдения в общую картину и делать выводы."

/datum/st_stat/ability/law
	subcategory = "Знания"
	name = "Юриспруденция"
	description = "Влияет на знание законов и правил и умение применять их к месту."

/datum/st_stat/ability/medicine
	subcategory = "Знания"
	name = "Медицина"
	description = "Влияет на знание анатомии, лекарств и первой помощи. Используется в Преображении."

/datum/st_stat/ability/medicine/link_mob(mob/living/our_mob)
	RegisterSignal(our_mob, COMSIG_LIVING_OPERATING_ON, PROC_REF(check_medicine_wound_tending))

/datum/st_stat/ability/medicine/unlink_mob(mob/living/our_mob)
	UnregisterSignal(our_mob, COMSIG_LIVING_OPERATING_ON)

/datum/st_stat/ability/occult
	subcategory = "Знания"
	name = "Оккультизм"
	description = "Влияет на познания в эзотерике и оккультизме. Используется в магических Дисциплинах и влияет на ваши ритуалы. С Оккультизмом 3 и выше вы можете опознавать магические артефакты."

/datum/st_stat/ability/politics
	subcategory = "Знания"
	name = "Политика"
	description = "Влияет на умение вести политические игры."

/datum/st_stat/ability/science
	subcategory = "Знания"
	name = "Естественные науки"
	description = "Влияет на познания в естественных науках и на умение синтезировать химические вещества."

/datum/st_stat/ability/technology
	subcategory = "Знания"
	name = "Электроника"
	/* V20 p. 110
	The Technology Knowledge represents a broad acumen with electronics, computer hardware, and devices more elaborate than “machines,” which fall under the Crafts Skill.
	If it has a processor, a transistor, or an integrated circuit — if it’s electronic rather than electrical manipulating it uses the Technology Knowledge.
	This is the wide-ranging Ability used to build one’s own computer, install (or subvert) a security system, repair a mobile phone, or kitbash a shortwave radio.
	You must always choose a specialization in Technology, even though you possess some skill in multiple fields.
	*/
	description = "Влияет на знание техники, устройств и электрических систем."
