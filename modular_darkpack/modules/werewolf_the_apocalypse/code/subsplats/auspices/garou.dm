/datum/subsplat/werewolf/auspice/garou
	abstract_type = /datum/subsplat/werewolf/auspice/garou
	fera_restriction = SPLAT_GAROU


/datum/subsplat/werewolf/auspice/garou/ahroun
	name = AUSPICE_AHROUN
	ru_name = "Арун"
	desc = "Арун - это оборотень как он есть, зверь-убийца. Среди них встречаются и отпетые берсерки, и закалённые ветераны, что держат свою Ярость в узде дисциплины. Ярость в них велика, и потому Аруны всегда на взводе: благословение Полной Луны, помимо прочего, делает их вспыльчивыми как порох. Рождённые ближе к растущей луне упиваются славой войны, рождённые ближе к убывающей - безжалостные прагматики, холодные в своей кровожадности. Рядом с любым Аруном опасно, но когда нападают силы Вирма, стая рада, что во главе атаки идёт воин Полнолуния."
	start_rage = 5
	gifts_provided= list(
		/datum/action/cooldown/power/gift/falling_touch,
		/datum/action/cooldown/power/gift/inspiration,
		/datum/action/cooldown/power/gift/razor_claws,
	)
	moons_born_under = list(MOON_FULL)

/datum/subsplat/werewolf/auspice/garou/ahroun/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 10 && honor >= 9 && wisdom >= 4)
		return RANK_ELDER
	if(glory >= 9 && honor >= 4 && wisdom >= 2)
		return RANK_ATHRO
	if(glory >= 6 && honor >= 3 && wisdom >= 1)
		return RANK_ADREN
	if(glory >= 4 && honor >= 1 && wisdom >= 1)
		return RANK_FOSTERN
	if(glory >= 2 && honor >= 1)
		return RANK_CLIATH
	return RANK_CUB

/datum/subsplat/werewolf/auspice/garou/galliard
	name = AUSPICE_GALLIARD
	ru_name = "Галлиард"
	desc = "Там, где Филодокс бесстрастен, Галлиард весь во власти чувств. Горбатая Луна - пламенная муза: она возносит своих детей к вершинам чувства и бросает в его бездны. Все Галлиарды знают и безудержное веселье, и безмерную тоску, но рождённые под убывающей луной легче поддаются тёмным, всепоглощающим страстям. Они трагики гару, сказители гибели и краха, жертвы и утраты. Их собратья, рождённые под растущей луной, поют о триумфе и завоеваниях, о бьющемся сердце и любви к жизни. На Галлиарде обычно держится боевой дух стаи: пока он готов идти дальше, готовы и остальные."
	start_rage = 4
	gifts_provided = list(
		/datum/action/cooldown/power/gift/beast_speech,
		/datum/action/cooldown/power/gift/call_of_the_wyld,
		/datum/action/cooldown/power/gift/mindspeak
	)
	moons_born_under = list(MOON_WAXING_GIBBOUS, MOON_WANING_GIBBOUS)

/datum/subsplat/werewolf/auspice/garou/galliard/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 9 && honor >= 5 && wisdom >= 9)
		return RANK_ELDER
	if(glory >= 7 && honor >= 2 && wisdom >= 6)
		return RANK_ATHRO
	if(glory >= 4 && honor >= 2 && wisdom >= 4)
		return RANK_ADREN
	if(glory >= 4 && wisdom >= 2)
		return RANK_FOSTERN
	if(glory >= 2 && wisdom >= 1)
		return RANK_CLIATH
	return RANK_CUB

/datum/subsplat/werewolf/auspice/garou/philodox
	name = AUSPICE_PHILODOX
	ru_name = "Филодокс"
	desc = "Филодокс так сжился с ролью беспристрастного судьи, что кажется отстранённым, а для оборотня даже на удивление хладнокровным. Рождённые под растущим Полулунием бывают необычайно безмятежны и невозмутимы, и чувства их прорываются наружу, лишь когда закипает Ярость. Филодокс убывающей луны резче и строже в суждениях: его всевидящее око неотступно следит, не отступил ли кто из стаи и собратьев от должного. Суда Полулуний побаиваются, но чтят его высоко: похвала или осуждение многого стоят в устах того, кто рождён видеть обе стороны любой распри."
	start_rage = 3
	gifts_provided= list(
		/datum/action/cooldown/power/gift/resist_pain,
		/datum/action/cooldown/power/gift/scent_of_the_true_form,
		/datum/action/cooldown/power/gift/truth_of_gaia,
	)
	moons_born_under = list(MOON_FIRST_QUARTER, MOON_LAST_QUARTER)

/datum/subsplat/werewolf/auspice/garou/philodox/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 4 && honor >= 10 && wisdom >= 9)
		return RANK_ELDER
	if(glory >= 3 && honor >= 8 && wisdom >= 4)
		return RANK_ATHRO
	if(glory >= 2 && honor >= 6 && wisdom >= 2)
		return RANK_ADREN
	if(glory >= 1 && honor >= 4 && wisdom >= 1)
		return RANK_FOSTERN
	if(honor >= 3)
		return RANK_CLIATH
	return RANK_CUB


/datum/subsplat/werewolf/auspice/garou/theurge
	name = AUSPICE_THEURGE
	ru_name = "Теург"
	desc = "Лунные Серпы бывают странны и загадочны: человеческой логике они нередко предпочитают запутанную, полную символов логику духов, с которыми водятся. У Теургов, рождённых под убывающей луной, отношения с миром духов чаще суровые и враждебные: они мастера сковывать духов и подчинять их своей воле, а в бою с ними особенно свирепы. Теурги растущей луны щедрее и открытее с духами: они не запугивают и не грозят, а очаровывают и уговаривают."
	subsplat_traits = list(TRAIT_OPENS_MOONGATES)
	start_rage = 2
	gifts_provided = list(
		/datum/action/cooldown/power/gift/mothers_touch,
		/datum/action/cooldown/power/gift/sense_wyrm,
		/datum/action/cooldown/power/gift/spirit_speech
	)
	moons_born_under = list(MOON_WANING_CRESCENT, MOON_WAXING_CRESENT)

/datum/subsplat/werewolf/auspice/garou/theurge/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 4 && honor >= 9 && wisdom >= 10)
		return RANK_ELDER
	if(glory >= 4 && honor >= 2 && wisdom >= 9)
		return RANK_ATHRO
	if(glory >= 2 && honor >= 1 && wisdom >= 7)
		return RANK_ADREN
	if(glory >= 1 && wisdom >= 5)
		return RANK_FOSTERN
	if(wisdom >= 3)
		return RANK_CLIATH
	return RANK_CUB


/datum/subsplat/werewolf/auspice/garou/ragabash
	name = AUSPICE_RAGABASH
	ru_name = "Рагабаш"
	desc = "Рагабаш, рождённый под растущим новолунием, обычно беспечен и переменчив, а рождённый под убывающим чуть злее и безжалостнее. Редкий Рагабаш лишён острого ума и не сумеет найти смешное в любом, даже самом мрачном, положении. Многие оборотни не спешат принимать Рагабашей всерьёз: поди разбери, когда Новолуние насмешкой указывает на роковой изъян плана, а когда просто потешается. Иной раз Рагабаш говорит, что король-то голый, а иной раз первым кричит \"Волки!\", если можно так выразиться."
	start_rage = 1
	gifts_provided= list(
		/datum/action/cooldown/power/gift/blur_of_the_milky_eye,
		/datum/action/cooldown/power/gift/infectious_laughter,
		/datum/action/cooldown/power/gift/open_seal,
	)
	moons_born_under = list(MOON_NEW)

/datum/subsplat/werewolf/auspice/garou/ragabash/rank_requirments(list/renown)
	var/total_score = renown[RENOWN_GLORY] + renown[RENOWN_HONOR] + renown[RENOWN_WISDOM]

	if(total_score >= 25)
		return RANK_ELDER
	if(total_score >= 19)
		return RANK_ATHRO
	if(total_score >= 13)
		return RANK_ADREN
	if(total_score >= 7)
		return RANK_FOSTERN
	if(total_score >= 3)
		return RANK_CLIATH
	return RANK_CUB

/datum/subsplat/werewolf/auspice/garou/stolen_moon
	name = AUSPICE_NONE
	ru_name = "Украденная Луна"
	// DARKPACK TODO - WEREWOLF - (len lore)
	desc = "Ты ведь не пёс, верно."
	// Stolen moon get no gifts
