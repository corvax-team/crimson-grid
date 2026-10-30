/// Inits GLOB.glyph_list
/proc/init_glyphs()
	var/glyph_list = list()
	for(var/path in valid_subtypesof(/obj/effect/decal/garou_glyph))
		var/obj/effect/decal/garou_glyph/S = path
		glyph_list[S.garou_name] = S
	sort_list(glyph_list, GLOBAL_PROC_REF(cmp_typepaths_asc))
	return glyph_list

/obj/item/pen/charcoal/interact_with_atom(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isopenturf(target) || isgroundlessturf(target))
		return NONE

	if(!user.has_language(/datum/language/garou_tongue, UNDERSTOOD_LANGUAGE))
		return NONE

	if(!GLOB.glyph_list.len)
		to_chat(user, span_notice("Доступных глифов нет."))
		return NONE

	var/list/glyph_names = list()

	for(var/glyph in GLOB.glyph_list)
		glyph_names += glyph

	var/choice = tgui_input_list(user, "Какой глиф начертить?", "Выбор глифа", glyph_names)
	if(!choice)
		return ITEM_INTERACT_BLOCKING

	var/obj/effect/decal/garou_glyph/drawn_glyph = GLOB.glyph_list[choice]
	if(drawn_glyph)
		user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] начинает выцарапывать на земле глиф..."), \
		span_notice("Вы начинаете выводить завитки и линии выбранного глифа..."))

		if(do_after(user, 5 SECONDS, target))
			new drawn_glyph.type(target)
			user.visible_message(span_notice("[capitalize(user.declent_ru(NOMINATIVE))] заканчивает свой знак."), \
			span_notice("Вы наносите последние штрихи, и знак остаётся на земле перед вами."))
			return ITEM_INTERACT_SUCCESS
		else
			user.visible_message(span_notice("Рука [user.declent_ru(GENITIVE)] срывается, и глиф безнадёжно смазан."), \
			span_notice("Вы ошибаетесь, и от глифа остаётся лишь грязный мазок на земле."))
			return ITEM_INTERACT_FAILURE

/obj/effect/decal/garou_glyph
	abstract_type = /obj/effect/decal/garou_glyph
	name = "odd glyph"
	desc = "Странный набор символов, начерченных, похоже, углём."
	anchored = TRUE
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/glyphs.dmi'
	icon_state = "garou"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	// Very likely not needed
	// layer = SIGIL_LAYER
	var/garou_name = "простой глиф"
	var/garou_desc = "простой глиф, лишённый смысла." // This is shown to werewolves who examine the glyph in order to determine its true meaning.

/obj/effect/decal/garou_glyph/examine(mob/user)
	. = ..()
	if(user.has_language(/datum/language/garou_tongue, UNDERSTOOD_LANGUAGE))
		. += "<b>Название:</b> [garou_name]\n"
		. += "<b>Значение:</b> [garou_desc]\n"

/obj/effect/decal/garou_glyph/wyrm
	name = "creepy glyph"
	garou_name = "глиф Вирма"
	garou_desc = "Глиф, означающий Вирма, силу порчи и разрушения."
	icon_state = "wyrm"

/obj/effect/decal/garou_glyph/vampire
	name = "weird glyph"
	garou_name = "глиф вампиров"
	garou_desc = "Глиф, означающий Сородичей, пиявок Ткачихи и Вирма."
	icon_state = "vampire"

/obj/effect/decal/garou_glyph/kinfolk
	name = "uncanny glyph"
	garou_name = "глиф Родни"
	garou_desc = "Глиф, означающий Родню, человеческих родичей гару."
	icon_state = "kinfolk"

/obj/effect/decal/garou_glyph/dance
	name = "funky glyph"
	garou_name = "глиф танца"
	garou_desc = "Глиф, означающий священные пляски гару."
	icon_state = "dance"

/obj/effect/decal/garou_glyph/caern
	name = "eerie glyph"
	garou_name = "глиф каэрна"
	garou_desc = "Глиф, означающий каэрн, священное место, где сама собой течёт духовная сила."
	icon_state = "caern"

/obj/effect/decal/garou_glyph/danger
	name = "peculiar glyph"
	garou_name = "глиф опасности"
	garou_desc = "Глиф, означающий опасность! Дальше иди с оглядкой."
	icon_state = "danger"

/obj/effect/decal/garou_glyph/garou
	name = "freakish glyph"
	garou_name = "глиф гару"
	garou_desc = "Глиф, означающий гару, воинов Геи."
	icon_state = "garou"

/obj/effect/decal/garou_glyph/conceal
	name = "mysterious glyph"
	garou_name = "глиф сокрытия"
	garou_desc = "Глиф, означающий, что здесь что-то скрыто. Что могли от тебя утаить?"
	icon_state = "conceal"

/obj/effect/decal/garou_glyph/hive
	name = "outlandish glyph"
	garou_name = "глиф Улья"
	garou_desc = "Глиф, означающий Улей, поганое логово стаи Танцоров Чёрной Спирали."
	icon_state = "hive"

/obj/effect/decal/garou_glyph/howl
	name = "unusual glyph"
	garou_name = "глиф воя"
	garou_desc = "Глиф, означающий вой, природную песнь гару."
	icon_state = "howl"

/obj/effect/decal/garou_glyph/remembrance
	name = "morose glyph"
	garou_name = "глиф памяти"
	garou_desc = "Глиф, означающий скорбь и память о павших."
	icon_state = "remembrance"

/obj/effect/decal/garou_glyph/watch
	name = "odd glyph"
	garou_name = "глиф надзора"
	garou_desc = "Глиф, которым помечают то, за чем нужно присматривать"
	icon_state = "watch"

/obj/effect/decal/garou_glyph/toxic
	name = "foul glyph"
	garou_name = "глиф отравы"
	garou_desc = "Глиф, означающий отраву, вещественную порчу Вирма на Земле."
	icon_state = "toxic"

/obj/effect/decal/garou_glyph/dancers
	name = "alien glyph"
	garou_name = "глиф Танцоров Чёрной Спирали"
	garou_desc = "Глиф, означающий племя Танцоров Чёрной Спирали."
	icon_state = "black_spiral_dancers"

/obj/effect/decal/garou_glyph/glasswalkers
	name = "quirky glyph"
	garou_name = "глиф Ходящих по Стеклу"
	garou_desc = "Глиф, означающий племя Ходящих по Стеклу."
	icon_state = "glasswalkers"

/obj/effect/decal/garou_glyph/galestalkers
	name = "abnormal glyph"
	garou_name = "глиф Младшего Брата"
	garou_desc = "Глиф, означающий племя Охотников Бури."
	icon_state = "younger_brother"

/obj/effect/decal/garou_glyph/war_against_wyrm
	name = "terrifying glyph"
	garou_name = "глиф войны с Вирмом"
	garou_desc = "Глиф, означающий апокалиптическую войну гару против Вирма."
	icon_state = "war_against_wyrm"

/obj/effect/decal/garou_glyph/black_furies
	name = "rooted glyph"
	garou_name = "глиф Чёрных Фурий"
	garou_desc = "Глиф, означающий Чёрных Фурий, одно из племён гару."
	icon_state = "black_furies"

/obj/effect/decal/garou_glyph/bonegnawers
	name = "smudged glyph"
	garou_name = "глиф Грызущих Кости"
	garou_desc = "Глиф, означающий Грызущих Кости, одно из племён гару."
	icon_state = "bonegnawers"

/obj/effect/decal/garou_glyph/children_of_gaia
	name = "relaxing glyph"
	garou_name = "глиф Детей Геи"
	garou_desc = "Глиф, означающий Детей Геи, одно из племён гару."
	icon_state = "children_of_gaia"

/obj/effect/decal/garou_glyph/fianna
	name = "musical glyph"
	garou_name = "глиф Фианна"
	garou_desc = "Глиф, означающий Фианна, одно из племён гару."
	icon_state = "fianna"

/obj/effect/decal/garou_glyph/get_of_fenris
	name = "jagged glyph"
	garou_name = "глиф Потомства Фенрира"
	garou_desc = "Глиф, означающий Потомство Фенрира, одно из племён гару."
	icon_state = "get_of_fenris"

/obj/effect/decal/garou_glyph/red_talons
	name = "clawed glyph"
	garou_name = "глиф Красных Когтей"
	garou_desc = "Глиф, означающий Красных Когтей, одно из племён гару."
	icon_state = "red_talons"

/obj/effect/decal/garou_glyph/shadow_lords
	name = "veiled glyph"
	garou_name = "глиф Теневых Владык"
	garou_desc = "Глиф, означающий Теневых Владык, одно из племён гару."
	icon_state = "shadow_lords"

/obj/effect/decal/garou_glyph/silent_striders
	name = "wavy glyph"
	garou_name = "глиф Безмолвных Странников"
	garou_desc = "Глиф, означающий Безмолвных Странников, одно из племён гару."
	icon_state = "silent_striders"

/obj/effect/decal/garou_glyph/silver_fangs
	name = "illustrious glyph"
	garou_name = "глиф Серебряных Клыков"
	garou_desc = "Глиф, означающий Серебряных Клыков, одно из племён гару."
	icon_state = "silver_fangs"

/obj/effect/decal/garou_glyph/stargazers
	name = "auspicious glyph"
	garou_name = "глиф Звездочётов"
	garou_desc = "Глиф, означающий Звездочётов, племя гару, которое покинуло Нацию."
	icon_state = "stargazers"

/obj/effect/decal/garou_glyph/ghost_council
	name = "watchful glyph"
	garou_name = "глиф Совета Призраков"
	garou_desc = "Глиф, означающий Совет Призраков, одно из племён гару."
	icon_state = "ghost_council"

/obj/effect/decal/garou_glyph/ronin
	name = "messy glyph"
	garou_name = "глиф ронинов"
	garou_desc = "Глиф, означающий ронинов, одиночек без племени, которым редко можно доверять."
	icon_state = "ronin"

/obj/effect/decal/garou_glyph/ratkin
	name = "ominous glyph"
	garou_name = "глиф Раткин"
	garou_desc = "Глиф, означающий Раткин, Фера, что меняют облик человека на крысиный."
	icon_state = "ratkin"

/obj/effect/decal/garou_glyph/corax
	name = "flashy glyph"
	garou_name = "глиф кораксов"
	garou_desc = "Глиф, означающий кораксов, Фера, что меняют облик человека на вороний."
	icon_state = "corax"

/obj/effect/decal/garou_glyph/sept_of_western_eye
	name = "elaborate glyph"
	garou_name = "глиф септа Западного Ока"
	garou_desc = "Глиф, означающий септ Западного Ока, который хранит священные места Геи, скрытые в Сан-Франциско и его окрестностях."
	icon_state = "sept_of_western_eye"

/obj/effect/decal/garou_glyph/bastet
	name = "fanged glyph"
	garou_name = "глиф Бастет"
	garou_desc = "Глиф, означающий Бастет, Фера, что меняют облик человека на кошачий."
	icon_state = "bastet"

/obj/effect/decal/garou_glyph/gurahl
	name = "large glyph"
	garou_name = "глиф Гурал"
	garou_desc = "Глиф, означающий Гурал, Фера, что меняют облик человека на медвежий."
	icon_state = "gurahl"

/obj/effect/decal/garou_glyph/rokea
	name = "watery glyph"
	garou_name = "глиф Рокеа"
	garou_desc = "Глиф, означающий Рокеа, Фера, что меняют облик человека на акулий."
	icon_state = "rokea"

/obj/effect/decal/garou_glyph/corax_safe
	name = "crude marking"
	garou_name = "глиф кораксов: безопасно"
	garou_desc = "Глиф кораксов: это место безопасно."
	icon_state = "corax_safe"

/obj/effect/decal/garou_glyph/corax_danger
	name = "strange lines"
	garou_name = "глиф кораксов: опасность"
	garou_desc = "Глиф кораксов: это место опасно."
	icon_state = "corax_danger"

/obj/effect/decal/garou_glyph/corax_wyrm_spirits
	name = "crude symbols"
	garou_name = "глиф кораксов: духи Вирма"
	garou_desc = "Глиф кораксов: здесь водятся духи Вирма."
	icon_state = "corax_wyrm_spirits"

/obj/effect/decal/garou_glyph/corax_weaver_spirits
	name = "scratch marks"
	garou_name = "глиф кораксов: духи Ткачихи"
	garou_desc = "Глиф кораксов: здесь водятся духи Ткачихи."
	icon_state = "corax_weaver_spirits"

/obj/effect/decal/garou_glyph/corax_food
	name = "oddly arranged dots"
	garou_name = "глиф кораксов: еда"
	garou_desc = "Глиф кораксов: здесь есть еда или случилась бойня."
	icon_state = "corax_food"

/obj/effect/decal/garou_glyph/corax_party
	name = "crude etching"
	garou_name = "глиф кораксов: праздник"
	garou_desc = "Глиф кораксов: здесь идёт гулянка или какое-то празднество."
	icon_state = "corax_party"

/obj/effect/decal/garou_glyph/lodge_of_the_moon
	name = "roof glyph"
	garou_name = "глиф Ложи Луны"
	garou_desc = "Глиф, означающий Ложу Луны, одну из двух лож Серебряных Клыков, что ведает делами духа."
	icon_state = "lodge_of_the_moon"

/obj/effect/decal/garou_glyph/lodge_of_the_sun
	name = "shiny glyph"
	garou_name = "глиф Ложи Солнца"
	garou_desc = "Глиф, означающий Ложу Солнца, одну из двух лож Серебряных Клыков, что ведает делами мирскими."
	icon_state = "lodge_of_the_sun"

/obj/effect/decal/garou_glyph/house_austere_howl
	name = "smoke glyph"
	garou_name = "глиф Дома Сурового Воя"
	garou_desc = "Глиф, означающий Дом Сурового Воя, один из семи домов племени Серебряных Клыков."
	icon_state = "house_austere_howl"

/obj/effect/decal/garou_glyph/house_blood_red_crest
	name = "crying glyph"
	garou_name = "глиф Дома Кроваво-Красного Гребня"
	garou_desc = "Глиф, означающий Дом Кроваво-Красного Гребня, один из семи домов племени Серебряных Клыков."
	icon_state = "house_blood_red_crest"

/obj/effect/decal/garou_glyph/house_crescent_moon
	name = "curved glyph"
	garou_name = "глиф Дома Полумесяца"
	garou_desc = "Глиф, означающий Дом Полумесяца, один из семи домов племени Серебряных Клыков."
	icon_state = "house_crescent_moon"

/obj/effect/decal/garou_glyph/house_gleaming_eye
	name = "gazing glyph"
	garou_name = "глиф Дома Сияющего Ока"
	garou_desc = "Глиф, означающий Дом Сияющего Ока, один из семи домов племени Серебряных Клыков."
	icon_state = "house_gleaming_eye"

/obj/effect/decal/garou_glyph/house_unbreakable_hearth
	name = "sturdy glyph"
	garou_name = "глиф Дома Несокрушимого Очага"
	garou_desc = "Глиф, означающий Дом Несокрушимого Очага, один из семи домов племени Серебряных Клыков."
	icon_state = "house_unbreakable_hearth"

/obj/effect/decal/garou_glyph/house_wise_heart
	name = "knowing glyph"
	garou_name = "глиф Дома Мудрого Сердца"
	garou_desc = "Глиф, означающий Дом Мудрого Сердца, один из семи домов племени Серебряных Клыков."
	icon_state = "house_wise_heart"

/obj/effect/decal/garou_glyph/house_wyrmfoe
	name = "shredded glyph"
	garou_name = "глиф Дома Врага Вирма"
	garou_desc = "Глиф, означающий Дом Врага Вирма, один из семи домов племени Серебряных Клыков."
	icon_state = "house_wyrmfoe"

/obj/effect/decal/garou_glyph/siberakh
	name = "unusual glyph"
	garou_name = "глиф Сиберах"
	garou_desc = "Глиф, означающий Сиберах, скрытное племя, о котором знают лишь Серебряные Клыки и Охотники Бури."
	icon_state = "siberakh"

/obj/effect/decal/garou_glyph/impergium
	name = "fear-inducing glyph"
	garou_name = "глиф Импергиума"
	garou_desc = "Глиф, означающий Импергиум, время, когда гару охотились на людей; его зовут также Первой Войной."
	icon_state = "impergium"

/obj/effect/decal/garou_glyph/litany
	name = "pointed glyph"
	garou_name = "глиф Литании"
	garou_desc = "Глиф, означающий Литанию, священный закон, которому обязана следовать вся Нация Гару."
	icon_state = "litany"

/obj/effect/decal/garou_glyph/pack
	name = "square glyph"
	garou_name = "глиф стаи"
	garou_desc = "Глиф, означающий стаю, самый тесный союз гару."
	icon_state = "pack"

/obj/effect/decal/garou_glyph/moot
	name = "bowl glyph"
	garou_name = "глиф веча"
	garou_desc = "Глиф, означающий вече, большой сход гару."
	icon_state = "moot"

/obj/effect/decal/garou_glyph/weaver
	name = "grid glyph"
	garou_name = "глиф Ткачихи"
	garou_desc = "Глиф, означающий Ткачиху, изначального духа неподвижности и неизменности."
	icon_state = "weaver"

/obj/effect/decal/garou_glyph/defiler_wyrm
	name = "tempting glyph"
	garou_name = "глиф Вирма-Осквернителя"
	garou_desc = "Глиф, означающий Вирма-Осквернителя, растлевающий лик Триединого Вирма."
	icon_state = "defiler_wyrm"

/obj/effect/decal/garou_glyph/beast_of_war
	name = "dangerous glyph"
	garou_name = "глиф Зверя Войны"
	garou_desc = "Глиф, означающий Зверя Войны, яростный лик Триединого Вирма."
	icon_state = "beast_of_war"

/obj/effect/decal/garou_glyph/eater_of_souls
	name = "empty glyph"
	garou_name = "глиф Пожирателя Душ"
	garou_desc = "Глиф, означающий Пожирателя Душ, лик Триединого Вирма, алчущий всего сотворённого."
	icon_state = "eater_of_souls"

/obj/effect/decal/garou_glyph/wyld
	name = "chaotic glyph"
	garou_name = "глиф Вильда"
	garou_desc = "Глиф, означающий Вильд, изначального духа жизни и творения."
	icon_state = "wyld"

/obj/effect/decal/garou_glyph/umbra
	name = "inconspicuous glyph"
	garou_name = "глиф Умбры"
	garou_desc = "Глиф, означающий Умбру, мир духов, что лежит в шаге в сторону от мира вещей."
	icon_state = "umbra"

/obj/effect/decal/garou_glyph/luna
	name = "circle glyph"
	garou_name = "глиф Луны"
	garou_desc = "Глиф, означающий Луну, духа ночного светила, даровавшего гару их Ярость."
	icon_state = "luna"

/obj/effect/decal/garou_glyph/helios
	name = "compass glyph"
	garou_name = "глиф Гелиоса"
	garou_desc = "Глиф, означающий Гелиоса, духа солнца, даровавшего кораксам их свет."
	icon_state = "helios"

/obj/effect/decal/garou_glyph/fish
	name = "fishy glyph"
	garou_name = "глиф рыбы"
	garou_desc = "Глиф, означающий рыбу."
	icon_state = "fish"

/obj/effect/decal/garou_glyph/forest
	name = "small glyph"
	garou_name = "глиф леса"
	garou_desc = "Глиф, означающий лес."
	icon_state = "forest"

/obj/effect/decal/garou_glyph/ally
	name = "reassuring glyph"
	garou_name = "глиф союза"
	garou_desc = "Глиф, означающий союз."
	icon_state = "ally"

/obj/effect/decal/garou_glyph/moon_bridge
	name = "crossed glyph"
	garou_name = "глиф лунного моста"
	garou_desc = "Глиф, означающий лунный мост, по которому переходят из мира вещей в Умбру и обратно."
	icon_state = "moon_bridge"

/obj/effect/decal/garou_glyph/chimera
	name = "imposing glyph"
	garou_name = "глиф Химеры"
	garou_desc = "Глиф, означающий Химеру, тотемного духа Звездочётов."
	icon_state = "chimera"

/obj/effect/decal/garou_glyph/cockroach
	name = "gross glyph"
	garou_name = "глиф Таракана"
	garou_desc = "Глиф, означающий Таракана, тотемного духа Ходящих по Стеклу."
	icon_state = "cockroach"

/obj/effect/decal/garou_glyph/falcon
	name = "gazing glyph"
	garou_name = "глиф Сокола"
	garou_desc = "Глиф, означающий Сокола, тотемного духа Серебряных Клыков."
	icon_state = "falcon"

/obj/effect/decal/garou_glyph/fenris
	name = "carved glyph"
	garou_name = "глиф Фенрира"
	garou_desc = "Глиф, означающий Фенрира, тотемного духа Потомства Фенрира."
	icon_state = "fenris"

/obj/effect/decal/garou_glyph/griffin
	name = "unsettling glyph"
	garou_name = "глиф Грифона"
	garou_desc = "Глиф, означающий Грифона, тотемного духа Красных Когтей."
	icon_state = "griffin"

/obj/effect/decal/garou_glyph/owl
	name = "perched glyph"
	garou_name = "глиф Совы"
	garou_desc = "Глиф, означающий Сову, тотемного духа Безмолвных Странников."
	icon_state = "owl"

/obj/effect/decal/garou_glyph/grandfather_thunder
	name = "weathered glyph"
	garou_name = "глиф Деда Грома"
	garou_desc = "Глиф, означающий Деда Грома, тотемного духа Теневых Владык."
	icon_state = "grandfather_thunder"

/obj/effect/decal/garou_glyph/pegasus
	name = "swift glyph"
	garou_name = "глиф Пегаса"
	garou_desc = "Глиф, означающий Пегаса, тотемного духа Чёрных Фурий."
	icon_state = "pegasus"

/obj/effect/decal/garou_glyph/rat
	name = "nasty glyph"
	garou_name = "глиф Крысы"
	garou_desc = "Глиф, означающий Крысу, тотемного духа Грызущих Кости."
	icon_state = "rat"

/obj/effect/decal/garou_glyph/stag
	name = "horned glyph"
	garou_name = "глиф Оленя"
	garou_desc = "Глиф, означающий Оленя, тотемного духа Фианна."
	icon_state = "stag"

/obj/effect/decal/garou_glyph/horned_serpent
	name = "slithery glyph"
	garou_name = "глиф Рогатого Змея"
	garou_desc = "Глиф, означающий Рогатого Змея, тотемного духа Охотников Бури."
	icon_state = "horned_serpent"

/obj/effect/decal/garou_glyph/unicorn
	name = "noble glyph"
	garou_name = "глиф Единорога"
	garou_desc = "Глиф, означающий Единорога, тотемного духа Детей Геи."
	icon_state = "unicorn"

/obj/effect/decal/garou_glyph/north_wind
	name = "simple glyph"
	garou_name = "глиф Северного Ветра"
	garou_desc = "Глиф, означающий Северный Ветер, тотемного духа Совета Призраков."
	icon_state = "north_wind"

/obj/effect/decal/garou_glyph/gun
	name = "smoking glyph"
	garou_name = "глиф оружия"
	garou_desc = "Глиф, означающий огнестрельное оружие."
	icon_state = "gun"

/obj/effect/decal/garou_glyph/path
	name = "meandering glyph"
	garou_name = "глиф тропы"
	garou_desc = "Глиф, означающий тропу."
	icon_state = "path"

/obj/effect/decal/garou_glyph/urge_wyrm
	name = "alluring glyph"
	garou_name = "глиф Вирма Побуждений"
	garou_desc = "Глиф, означающий Вирмов Побуждений, духовных сущностей, способных растлить разум."
	icon_state = "urge_wyrm"

/obj/effect/decal/garou_glyph/radiation
	name = "glowing glyph"
	garou_name = "глиф радиации"
	garou_desc = "Глиф, означающий радиацию, которая оскверняет жизнь как мало что другое."
	icon_state = "radiation"

/obj/effect/decal/garou_glyph/spirit
	name = "abstract glyph"
	garou_name = "глиф духа"
	garou_desc = "Глиф, означающий присутствие духа."
	icon_state = "spirit"

/obj/effect/decal/garou_glyph/mend
	name = "cross glyph"
	garou_name = "глиф починки"
	garou_desc = "Глиф, призывающий починить или исцелить место, вещь или живое существо."
	icon_state = "mend"

/obj/effect/decal/garou_glyph/safety
	name = "reassuring glyph"
	garou_name = "глиф безопасности"
	garou_desc = "Глиф, означающий безопасное место."
	icon_state = "safety"

/obj/effect/decal/garou_glyph/suffering
	name = "upsetting glyph"
	garou_name = "глиф страдания"
	garou_desc = "Глиф, означающий страдание или место страданий."
	icon_state = "suffering"

/obj/effect/decal/garou_glyph/regeneration
	name = "calming glyph"
	garou_name = "глиф исцеления"
	garou_desc = "Глиф, означающий исцеление и восстановление или место, где они возможны."
	icon_state = "regeneration"

/obj/effect/decal/garou_glyph/storm
	name = "lightning glyph"
	garou_name = "глиф бури"
	garou_desc = "Глиф, означающий бурю во всей её мощи."
	icon_state = "storm"

/obj/effect/decal/garou_glyph/story
	name = "weird glyph"
	garou_name = "глиф сказания"
	garou_desc = "Глиф, которым отмечают место, где рассказывают истории, или сам рассказ, записанный глифами."
	icon_state = "story"

/obj/effect/decal/garou_glyph/totem
	name = "involved glyph"
	garou_name = "глиф тотема"
	garou_desc = "Глиф, означающий тотем, духа-покровителя племени гару."
	icon_state = "totem"

/obj/effect/decal/garou_glyph/cyberrealm
	name = "messy glyph"
	garou_name = "глиф Киберцарства"
	garou_desc = "Глиф, означающий Киберцарство, духовный мир интернета."
	icon_state = "cyberspace"

/obj/effect/decal/garou_glyph/wolfhome
	name = "feral glyph"
	garou_name = "глиф Волчьего Дома"
	garou_desc = "Глиф, означающий Волчий Дом, первозданное царство духов, бескрайний лес, где обитают духи волчьих стай и их добычи."
	icon_state = "wolfhome"

/obj/effect/decal/garou_glyph/malfeas
	name = "bone-chilling glyph"
	garou_name = "глиф Малфеаса"
	garou_desc = "Глиф, означающий Малфеас, тёмное царство Умбры, что лежит в Пасти Вирма."
	icon_state = "malfeas"

/obj/effect/decal/garou_glyph/aetherial
	name = "dazzling glyph"
	garou_name = "глиф Эфирного Царства"
	garou_desc = "Глиф, означающий Эфирное Царство, область Умбры, где лежат Дикие земли духов."
	icon_state = "aetherial"

/obj/effect/decal/garou_glyph/arcadia_gateway
	name = "loopy glyph"
	garou_name = "глиф Врат Аркадии"
	garou_desc = "Глиф, означающий Врата Аркадии, край в глубине Средней Умбры, похожий на легендарную родину фей."
	icon_state = "arcadia_gateway"

/obj/effect/decal/garou_glyph/atrocity_realm
	name = "fetid glyph"
	garou_name = "глиф Царства Зверств"
	garou_desc = "Глиф, означающий Царство Зверств, место, где плодятся Бейны."
	icon_state = "atrocity_realm"

/obj/effect/decal/garou_glyph/battleground
	name = "tattered glyph"
	garou_name = "глиф Поля Битвы"
	garou_desc = "Глиф, означающий Поле Битвы, Ближнее Царство, вместившее все битвы и распри, что когда-либо случались."
	icon_state = "battleground"

/obj/effect/decal/garou_glyph/erebus
	name = "pointed glyph"
	garou_name = "глиф Эреба"
	garou_desc = "Глиф, означающий Эреб, царство духовного очищения, которое часто сравнивают с адом."
	icon_state = "erebus"

/obj/effect/decal/garou_glyph/flux
	name = "wild glyph"
	garou_name = "глиф Потока"
	garou_desc = "Глиф, означающий Поток, Ближнее Царство чистой силы Вильда, не тронутой Ткачихой."
	icon_state = "flux"

/obj/effect/decal/garou_glyph/legendary_realm
	name = "powerful glyph"
	garou_name = "глиф Царства Легенд"
	garou_desc = "Глиф, означающий Царство Легенд, куда гару приходят прожить жизни своих предков."
	icon_state = "legendary_realm"

/obj/effect/decal/garou_glyph/pangaea
	name = "primal glyph"
	garou_name = "глиф Пангеи"
	garou_desc = "Глиф, означающий Пангею, царство, где Земля осталась такой, какой была до цивилизации, истории и конца Импергиума."
	icon_state = "pangaea"

/obj/effect/decal/garou_glyph/the_scar
	name = "ugly glyph"
	garou_name = "глиф Шрама"
	garou_desc = "Глиф, означающий Шрам, Ближнее Царство, отражение промышленной революции с её гнётом и отравой."
	icon_state = "the_scar"

/obj/effect/decal/garou_glyph/summer_country
	name = "impressive glyph"
	garou_name = "глиф Летней Страны"
	garou_desc = "Глиф, означающий Летнюю Страну, угасающее царство, в котором, как говорят, воплотилась чистая любовь Геи к её детям."
	icon_state = "summer_country"

/obj/effect/decal/garou_glyph/pollution
	name = "arched glyph"
	garou_name = "глиф загрязнения"
	garou_desc = "Глиф, означающий загрязнение, порчу Вирма, которую разносит промышленность."
	icon_state = "pollution"

/obj/effect/decal/garou_glyph/ananasi
	name = "spindly glyph"
	garou_name = "глиф Ананаси"
	garou_desc = "Глиф, означающий Ананаси, Фера, наделённых даром менять облик человека на паучий."
	icon_state = "ananasi"

/obj/effect/decal/garou_glyph/nagah
	name = "fanged glyph"
	garou_name = "глиф Нага"
	garou_desc = "Глиф, означающий Нага, Фера, наделённых даром менять облик человека на змеиный."
	icon_state = "nagah"

/obj/effect/decal/garou_glyph/fire
	name = "smokey glyph"
	garou_name = "глиф огня"
	garou_desc = "Глиф, означающий огонь, первозданную силу разрушения."
	icon_state = "fire"

/obj/effect/decal/garou_glyph/bane
	name = "concerning glyph"
	garou_name = "глиф Бейнов"
	garou_desc = "Глиф, означающий присутствие Бейнов, духов, искажённых Вирмом."
	icon_state = "bane"

/obj/effect/decal/garou_glyph/fomori
	name = "boxed glyph"
	garou_name = "глиф фомори"
	garou_desc = "Глиф, означающий фомори, пёстрое племя одержимых Бейнами смертных, которых изуродовали слуги Вирма."
	icon_state = "fomori"

/obj/effect/decal/garou_glyph/therapy
	name = "relaxing glyph"
	garou_name = "глиф лечения"
	garou_desc = "Глиф, означающий лечение или место, где лечат."
	icon_state = "therapy"

/obj/effect/decal/garou_glyph/ragabash
	name = "oval glyph"
	garou_name = "глиф Рагабаша"
	garou_desc = "Глиф, означающий Рагабаша, покровительство плута и смутьяна."
	icon_state = "ragabash"

/obj/effect/decal/garou_glyph/theurge
	name = "crested glyph"
	garou_name = "глиф Теурга"
	garou_desc = "Глиф, означающий Теурга, покровительство духов и исцеления."
	icon_state = "theurge"

/obj/effect/decal/garou_glyph/philodox
	name = "crescent glyph"
	garou_name = "глиф Филодокса"
	garou_desc = "Глиф, означающий Филодокса, покровительство суда и истины."
	icon_state = "philodox"

/obj/effect/decal/garou_glyph/galliard
	name = "gashed glyph"
	garou_name = "глиф Галлиарда"
	garou_desc = "Глиф, означающий Галлиарда, покровительство сказаний, вдохновения и наставничества."
	icon_state = "galliard"

/obj/effect/decal/garou_glyph/ahroun
	name = "circular glyph"
	garou_name = "глиф Аруна"
	garou_desc = "Глиф, означающий Аруна, покровительство ярости и силы."
	icon_state = "ahroun"

/obj/effect/decal/garou_glyph/homid
	name = "rigid glyph"
	garou_name = "глиф хомида"
	garou_desc = "Глиф, означающий людей и хомидов, гару, рождённых людьми."
	icon_state = "homid"

/obj/effect/decal/garou_glyph/crinos
	name = "unsavory glyph"
	garou_name = "глиф Кринос"
	garou_desc = "Глиф, означающий Кринос, детей войны, рождённых от запретной пары гару."
	icon_state = "crinos"

/obj/effect/decal/garou_glyph/lupus
	name = "sharp glyph"
	garou_name = "глиф люпуса"
	garou_desc = "Глиф, означающий волков и люпусов, гару, рождённых волками."
	icon_state = "lupus"

/obj/effect/decal/garou_glyph/bunyip
	name = "sorrowful glyph"
	garou_name = "глиф Бунипа"
	garou_desc = "Глиф, означающий Бунипа, утраченное племя гару из сумчатых тилацинов."
	icon_state = "bunyip"

/obj/effect/decal/garou_glyph/croatan
	name = "lost glyph"
	garou_name = "глиф Кроатана"
	garou_desc = "Глиф, означающий Кроатана, Среднего Брата Чистых племён, что принёс себя в жертву, чтобы сдержать Вирма-Осквернителя."
	icon_state = "croatan"

/obj/effect/decal/garou_glyph/gnosis
	name = "energized glyph"
	garou_name = "глиф Гнозиса"
	garou_desc = "Глиф, означающий Гнозис, прилив хаотических энергий Вильда в самом себе."
	icon_state = "gnosis"

/obj/effect/decal/garou_glyph/glory
	name = "proud glyph"
	garou_name = "глиф Славы"
	garou_desc = "Глиф, означающий Славу, одну из форм известности гару, что чтит доблесть."
	icon_state = "glory"

/obj/effect/decal/garou_glyph/honor
	name = "noble glyph"
	garou_name = "глиф Чести"
	garou_desc = "Глиф, означающий Честь, одну из форм известности гару, что чтит уважение."
	icon_state = "honor"

/obj/effect/decal/garou_glyph/wisdom
	name = "telling glyph"
	garou_name = "глиф Мудрости"
	garou_desc = "Глиф, означающий Мудрость, одну из форм известности гару, что чтит знание."
	icon_state = "wisdom"

/obj/effect/decal/garou_glyph/lost_cub
	name = "wandering glyph"
	garou_name = "глиф потерянного щенка"
	garou_desc = "Глиф, означающий потерянного щенка, юного гару, что ещё не нашёл свой путь."
	icon_state = "lost_cub"

/obj/effect/decal/garou_glyph/silver_pack
	name = "venerable glyph"
	garou_name = "глиф Серебряной Стаи"
	garou_desc = "Глиф, означающий Серебряную Стаю, легендарную первую стаю в истории гару."
	icon_state = "silver_pack"

/obj/effect/decal/garou_glyph/silver_record
	name = "storied glyph"
	garou_name = "глиф Серебряной Летописи"
	garou_desc = "Глиф, означающий Серебряную Летопись, писаные сказания нации гару."
	icon_state = "silver_record"

/obj/effect/decal/garou_glyph/klaive
	name = "dagger glyph"
	garou_name = "глиф клайва"
	garou_desc = "Глиф, означающий клайв, духовно мощный клинок, почти всегда из серебра."
	icon_state = "klaive"

/obj/effect/decal/garou_glyph/war_of_rage
	name = "devastating glyph"
	garou_name = "глиф Войны Ярости"
	garou_desc = "Глиф, означающий Войну Ярости, когда гару истребили почти все прочие народы Фера."
	icon_state = "war_of_rage"

/obj/effect/decal/garou_glyph/gaia
	name = "worldly glyph"
	garou_name = "глиф Геи"
	garou_desc = "Глиф, означающий Гею, живой дух земли или само бытие."
	icon_state = "gaia"

/obj/effect/decal/garou_glyph/star
	name = "pointy glyph"
	garou_name = "глиф звезды"
	garou_desc = "Глиф, означающий звезду, сияющий дух в Умбре."
	icon_state = "star"

/obj/effect/decal/garou_glyph/animal
	name = "feral glyph"
	garou_name = "глиф зверей"
	garou_desc = "Глиф, означающий зверей и животных."
	icon_state = "animal"

/obj/effect/decal/garou_glyph/horse
	name = "tasty glyph"
	garou_name = "глиф лошади"
	garou_desc = "Глиф, означающий лошадей и, в широком смысле, прочих зверей-добычу."
	icon_state = "horse"

/obj/effect/decal/garou_glyph/claw
	name = "line glyph"
	garou_name = "глиф когтя"
	garou_desc = "Глиф, означающий одиночный коготь."
	icon_state = "claw"

/obj/effect/decal/garou_glyph/tooth
	name = "curved glyph"
	garou_name = "глиф клыка"
	garou_desc = "Глиф, означающий зуб и клык."
	icon_state = "tooth"

/obj/effect/decal/garou_glyph/bone
	name = "teardrop glyph"
	garou_name = "глиф кости"
	garou_desc = "Глиф, означающий кость."
	icon_state = "bone"

/obj/effect/decal/garou_glyph/wilderness
	name = "creeping glyph"
	garou_name = "глиф глуши"
	garou_desc = "Глиф, означающий дикие места, просторы Вильда, где Ткачиха и Вирм всего слабее."
	icon_state = "wilderness"

/obj/effect/decal/garou_glyph/mountain
	name = "imposing glyph"
	garou_name = "глиф гор"
	garou_desc = "Глиф, означающий горы."
	icon_state = "mountain"

/obj/effect/decal/garou_glyph/desert
	name = "arid glyph"
	garou_name = "глиф пустыни"
	garou_desc = "Глиф, означающий пустыни и пустоши — природные и неестественные места Вирма."
	icon_state = "desert"

/obj/effect/decal/garou_glyph/air
	name = "curved glyph"
	garou_name = "глиф воздуха"
	garou_desc = "Глиф, означающий воздух."
	icon_state = "air"

/obj/effect/decal/garou_glyph/water
	name = "wavy glyph"
	garou_name = "глиф воды"
	garou_desc = "Глиф, означающий воду."
	icon_state = "water"

/obj/effect/decal/garou_glyph/metal
	name = "gash glyph"
	garou_name = "глиф металла"
	garou_desc = "Глиф, означающий металл, чаще серебро, но в мирном смысле."
	icon_state = "metal"

/obj/effect/decal/garou_glyph/dark
	name = "shadowy glyph"
	garou_name = "глиф тьмы"
	garou_desc = "Глиф, означающий тьму."
	icon_state = "dark"

/obj/effect/decal/garou_glyph/stone
	name = "rigid glyph"
	garou_name = "глиф камня"
	garou_desc = "Глиф, означающий камни, исконное владение Ткачихи."
	icon_state = "stone"

/obj/effect/decal/garou_glyph/snow
	name = "cold glyph"
	garou_name = "глиф снега"
	garou_desc = "Глиф, означающий снег."
	icon_state = "snow"

/obj/effect/decal/garou_glyph/rain
	name = "wet glyph"
	garou_name = "глиф дождя"
	garou_desc = "Глиф, означающий дождь."
	icon_state = "rain"

/obj/effect/decal/garou_glyph/lightning
	name = "electric glyph"
	garou_name = "глиф молнии"
	garou_desc = "Глиф, означающий молнию."
	icon_state = "lightning"

/obj/effect/decal/garou_glyph/flood
	name = "rushing glyph"
	garou_name = "глиф наводнения"
	garou_desc = "Глиф, означающий наводнение."
	icon_state = "flood"

/obj/effect/decal/garou_glyph/winter
	name = "freezing glyph"
	garou_name = "глиф зимы"
	garou_desc = "Глиф, означающий зиму, пору голых ветвей."
	icon_state = "winter"

/obj/effect/decal/garou_glyph/spring
	name = "blossoming glyph"
	garou_name = "глиф весны"
	garou_desc = "Глиф, означающий весну, пору новой листвы."
	icon_state = "spring"

/obj/effect/decal/garou_glyph/summer
	name = "warming glyph"
	garou_name = "глиф лета"
	garou_desc = "Глиф, означающий лето, пору зелёной листвы."
	icon_state = "summer"

/obj/effect/decal/garou_glyph/autumn
	name = "chilling glyph"
	garou_name = "глиф осени"
	garou_desc = "Глиф, означающий осень, пору листопада."
	icon_state = "autumn"

/obj/effect/decal/garou_glyph/north
	name = "notched glyph"
	garou_name = "глиф севера"
	garou_desc = "Глиф, означающий Яркую Звезду, что ведёт странников на север."
	icon_state = "north"

/obj/effect/decal/garou_glyph/south
	name = "notched glyph"
	garou_name = "глиф юга"
	garou_desc = "Глиф, означающий Звезду Ухода, что ведёт странников на юг."
	icon_state = "south"

/obj/effect/decal/garou_glyph/east
	name = "notched glyph"
	garou_name = "глиф востока"
	garou_desc = "Глиф, означающий Путь Восхода, восточную дорогу, откуда встаёт солнце."
	icon_state = "east"

/obj/effect/decal/garou_glyph/west
	name = "notched glyph"
	garou_name = "глиф запада"
	garou_desc = "Глиф, означающий Путь Заката, западную дорогу, куда солнце уходит."
	icon_state = "west"

/obj/effect/decal/garou_glyph/life
	name = "breathing glyph"
	garou_name = "глиф жизни"
	garou_desc = "Глиф, означающий саму природу жизни."
	icon_state = "life"

/obj/effect/decal/garou_glyph/death
	name = "still glyph"
	garou_name = "глиф смерти"
	garou_desc = "Глиф, означающий саму природу смерти."
	icon_state = "death"

/obj/effect/decal/garou_glyph/peace
	name = "soothing glyph"
	garou_name = "глиф мира"
	garou_desc = "Глиф, означающий мир. Возможно ли такое вообще?"
	icon_state = "peace"

/obj/effect/decal/garou_glyph/sacrifice
	name = "giving glyph"
	garou_name = "глиф жертвы"
	garou_desc = "Глиф, означающий жертвоприношение."
	icon_state = "sacrifice"

/obj/effect/decal/garou_glyph/garou_nation
	name = "united glyph"
	garou_name = "глиф Нации Гару"
	garou_desc = "Глиф, означающий Нацию Гару, крупнейшую организацию гару по всему миру."
	icon_state = "garou_nation"

/obj/effect/decal/garou_glyph/rage
	name = "angry glyph"
	garou_name = "глиф ярости"
	garou_desc = "Глиф, означающий ярость и бешенство, когда дары Луны одолевают гару."
	icon_state = "rage"

/obj/effect/decal/garou_glyph/birth
	name = "new glyph"
	garou_name = "глиф рождения"
	garou_desc = "Глиф, означающий рождение или начало чего-то нового."
	icon_state = "birth"

/obj/effect/decal/garou_glyph/love
	name = "warm glyph"
	garou_name = "глиф любви"
	garou_desc = "Глиф, означающий любовь и привязанность."
	icon_state = "love"

/obj/effect/decal/garou_glyph/quest
	name = "galvanizing glyph"
	garou_name = "глиф искания"
	garou_desc = "Глиф, означающий поиск, нередко айслинг для духа."
	icon_state = "quest"

/obj/effect/decal/garou_glyph/create
	name = "signed glyph"
	garou_name = "глиф созидания"
	garou_desc = "Глиф, означающий созидание, а также автора, художника или творца."
	icon_state = "create"

/obj/effect/decal/garou_glyph/build
	name = "constructive glyph"
	garou_name = "глиф строительства"
	garou_desc = "Глиф, означающий строительство, соединение или сборку из частей."
	icon_state = "build"

/obj/effect/decal/garou_glyph/defiance
	name = "prideful glyph"
	garou_name = "глиф неповиновения"
	garou_desc = "Глиф, означающий акт неповиновения."
	icon_state = "defiance"

/obj/effect/decal/garou_glyph/time
	name = "long glyph"
	garou_name = "глиф времени"
	garou_desc = "Глиф, означающий время или, буквальнее, сплетение прошлого, настоящего и будущего."
	icon_state = "time"

/obj/effect/decal/garou_glyph/cycle
	name = "circular glyph"
	garou_name = "глиф цикла"
	garou_desc = "Глиф, означающий цикл или повторение."
	icon_state = "cycle"

/obj/effect/decal/garou_glyph/ancient
	name = "archaic glyph"
	garou_name = "глиф древности"
	garou_desc = "Глиф, означающий Первые Времена или просто нечто древнее."
	icon_state = "ancient"

/obj/effect/decal/garou_glyph/branded
	name = "wounding glyph"
	garou_name = "глиф клейма"
	garou_desc = "Глиф, означающий то, что клеймят или уродуют шрамами, либо сам шрам."
	icon_state = "branded"

/obj/effect/decal/garou_glyph/coward
	name = "meek glyph"
	garou_name = "глиф труса"
	garou_desc = "Глиф, означающий труса или слабака."
	icon_state = "coward"

/obj/effect/decal/garou_glyph/rival
	name = "antagonistic glyph"
	garou_name = "глиф соперника"
	garou_desc = "Глиф, означающий соперника или соперничество между двумя вещами либо понятиями."
	icon_state = "rival"

/obj/effect/decal/garou_glyph/destructive
	name = "violent glyph"
	garou_name = "глиф разрушения"
	garou_desc = "Глиф, означающий жестокое разрушение, очищение или серебро в его губительном смысле."
	icon_state = "destructive"

/obj/effect/decal/garou_glyph/minotaur
	name = "demeaning glyph"
	garou_name = "глиф Минотавра"
	garou_desc = "Глиф, означающий Минотавра, духа, с которым часто заключают договоры Украденные Луны."
	icon_state = "minotaur"

/obj/effect/decal/garou_glyph/quick
	name = "rushed glyph"
	garou_name = "глиф скорости"
	garou_desc = "Глиф, означающий скорость и стремительность."
	icon_state = "quick"

/obj/effect/decal/garou_glyph/resilient
	name = "enduring glyph"
	garou_name = "глиф стойкости"
	garou_desc = "Глиф, означающий стойкость, силу держаться наперекор невозможному."
	icon_state = "resilient"

/obj/effect/decal/garou_glyph/hungry
	name = "begging glyph"
	garou_name = "глиф голода"
	garou_desc = "Глиф, означающий голод или состояние голода. Им часто метят источники еды в городах."
	icon_state = "hungry"

/obj/effect/decal/garou_glyph/cold
	name = "chilly glyph"
	garou_name = "глиф холода"
	garou_desc = "Глиф, означающий сам холод."
	icon_state = "cold"

/obj/effect/decal/garou_glyph/wounded
	name = "painful glyph"
	garou_name = "глиф раны"
	garou_desc = "Глиф, означающий ранение или состояние боли."
	icon_state = "wounded"

/obj/effect/decal/garou_glyph/eldered
	name = "elaborate glyph"
	garou_name = "глиф старейшины"
	garou_desc = "Глиф, которым метят тех, кто стал старейшиной, или тех, кого чтут и кто мудр."
	icon_state = "eldered"

/obj/effect/decal/garou_glyph/help
	name = "desperate glyph"
	garou_name = "глиф мольбы о помощи"
	garou_desc = "Глиф, который может означать и крик о помощи, и обещание её."
	icon_state = "help"

/obj/effect/decal/garou_glyph/solar_eclipse
	name = "masked glyph"
	garou_name = "глиф солнечного затмения"
	garou_desc = "Глиф, означающий солнечное затмение, когда свет Гелиоса затмевает ярость Луны."
	icon_state = "solar_eclipse"

/obj/effect/decal/garou_glyph/lunar_eclipse
	name = "casted glyph"
	garou_name = "глиф лунного затмения"
	garou_desc = "Глиф, означающий лунное затмение, когда Луна краснеет от ярости."
	icon_state = "lunar_eclipse"

/obj/effect/decal/garou_glyph/legend
	name = "notable glyph"
	garou_name = "глиф легенды"
	garou_desc = "Глиф, означающий легенду: сказания древности или предков, достигших величия."
	icon_state = "legend"

/obj/effect/decal/garou_glyph/mate
	name = "bound glyph"
	garou_name = "глиф пары"
	garou_desc = "Глиф, означающий пару, спутника, с которым обычно связаны на всю жизнь."
	icon_state = "mate"

/obj/effect/decal/garou_glyph/rite
	name = "spiritual glyph"
	garou_name = "глиф обряда"
	garou_desc = "Глиф, означающий обряд, ритуал гару, служащий самым разным целям."
	icon_state = "rite"

/obj/effect/decal/garou_glyph/realm
	name = "marked glyph"
	garou_name = "глиф владения"
	garou_desc = "Глиф, означающий владение, карман в Умбре, где сосредоточен особый духовный смысл."
	icon_state = "realm"

/obj/effect/decal/garou_glyph/rite_of_passage
	name = "staring glyph"
	garou_name = "глиф Обряда Перехода"
	garou_desc = "Глиф, которым метят Обряд Перехода, испытание, что ведёт молодых щенков к обретению племени, духа и места в нации как клиата."
	icon_state = "rite_of_passage"

/obj/effect/decal/garou_glyph/rite_of_binding
	name = "chained glyph"
	garou_name = "глиф обряда связывания"
	garou_desc = "Глиф, которым метят обряд связывания, обращающий духа в слугу. Обычно это добровольный договор на время или вложение в тален."
	icon_state = "rite_of_binding"

/obj/effect/decal/garou_glyph/rite_of_the_fetish
	name = "convoluted glyph"
	garou_name = "глиф обряда фетиша"
	garou_desc = "Глиф, которым метят обряд фетиша, связывающий духа в предмет. По традиции предмет три ночи подряд очищают в проточной воде, чистой земле, на постоянном ветру или над пламенем, прежде чем уговорить или принудить духа войти. Фианна льстят, Грызущие Кости и Безмолвные Странники подкупают."
	icon_state = "rite_of_the_fetish"

/obj/effect/decal/garou_glyph/fetish
	name = "chaotic glyph"
	garou_name = "глиф фетиша"
	garou_desc = "Глиф, означающий фетиш, предмет с пробуждённым духом внутри."
	icon_state = "fetish"

/obj/effect/decal/garou_glyph/celestine
	name = "divine glyph"
	garou_name = "глиф Селестины"
	garou_desc = "Глиф, означающий одну из Селестин, могучих духов вроде Гелиоса и Луны, что сродни богам."
	icon_state = "celestine"

/obj/effect/decal/garou_glyph/incarna
	name = "angelic glyph"
	garou_name = "глиф Инкарны"
	garou_desc = "Глиф, означающий Инкарну, могучих духов, стоящих ниже Селестин."
	icon_state = "incarna"

/obj/effect/decal/garou_glyph/deep_umbra
	name = "abstract glyph"
	garou_name = "глиф Глубинной Умбры"
	garou_desc = "Глиф, означающий Глубинную Умбру, огромное пространство за пределами владений, где обитают отвлечённые мысли и понятия."
	icon_state = "deep_umbra"

/obj/effect/decal/garou_glyph/dark_umbra
	name = "final glyph"
	garou_name = "глиф Тёмной Умбры"
	garou_desc = "Глиф, означающий Тёмную Умбру, владение памяти и мёртвых."
	icon_state = "dark_umbra"

/obj/effect/decal/garou_glyph/spirit_wilds
	name = "scratchy glyph"
	garou_name = "глиф Духовных Глушей"
	garou_desc = "Глиф, означающий Духовные Глуши, огромное пространство, что отражает дикие места Геи, и уцелевшие, и осквернённые."
	icon_state = "spirit_wilds"

/obj/effect/decal/garou_glyph/city
	name = "arched glyph"
	garou_name = "глиф города"
	garou_desc = "Глиф, означающий город, владение человека и Ткачихи."
	icon_state = "city"

/obj/effect/decal/garou_glyph/building
	name = "structured glyph"
	garou_name = "глиф строения"
	garou_desc = "Глиф, означающий строение: логова из камня, бетона и дерева, во многом подвластные Ткачихе."
	icon_state = "building"

/obj/effect/decal/garou_glyph/gate
	name = "arch glyph"
	garou_name = "глиф ворот"
	garou_desc = "Глиф, означающий ворота, вход в город или проход, созданный Ткачихой."
	icon_state = "gate"

/obj/effect/decal/garou_glyph/park
	name = "contained glyph"
	garou_name = "глиф парка"
	garou_desc = "Глиф, означающий парк, малый защищённый островок Вильда среди людей."
	icon_state = "park"

/obj/effect/decal/garou_glyph/monster
	name = "dangerous glyph"
	garou_name = "глиф чудовища"
	garou_desc = "Глиф, означающий чудовище."
	icon_state = "monster"

/obj/effect/decal/garou_glyph/abomination
	name = "horrifying glyph"
	garou_name = "глиф мерзости"
	garou_desc = "Глиф, означающий мерзость, гару, осквернённого Пожирателем Душ и обращённого в кровососа вопреки власти Луны."
	icon_state = "abomination"

/obj/effect/decal/garou_glyph/uktena
	name = "curious glyph"
	garou_name = "глиф Уктены"
	garou_desc = "Глиф, означающий Уктену, одно из племён гару."
	icon_state = "uktena"

/obj/effect/decal/garou_glyph/jump
	name = "airy glyph"
	garou_name = "глиф прыжка"
	garou_desc = "Глиф, означающий прыжок: оттолкнуться от Геи и умчаться вместе с ветром."
	icon_state = "jump"

/obj/effect/decal/garou_glyph/sex
	name = "impassioned glyph"
	garou_name = "глиф соития"
	garou_desc = "Глиф, означающий соитие, выражение любви между парой, обычно ради детей."
	icon_state = "sex"

/obj/effect/decal/garou_glyph/pregnant
	name = "nurturing glyph"
	garou_name = "глиф беременности"
	garou_desc = "Глиф, означающий беременность, священный и необходимый рост новой жизни и потомства."
	icon_state = "pregnant"

/obj/effect/decal/garou_glyph/sun
	name = "bright glyph"
	garou_name = "глиф Катанки-Соннака"
	garou_desc = "Глиф, означающий Катанку-Соннака, Всадника Ветра, Инкарну Солнца и лик Гелиоса."
	icon_state = "sun"

/obj/effect/decal/garou_glyph/mercury
	name = "hot glyph"
	garou_name = "глиф Митану"
	garou_desc = "Глиф, означающий Митану, Инкарну Меркурия. Он трикстер и любитель комедии."
	icon_state = "mercury"

/obj/effect/decal/garou_glyph/vulcan
	name = "unremarkable glyph"
	garou_name = "глиф Хакахе"
	garou_desc = "Глиф, означающий Хакахе, Инкарну Вулкана. Он чтит тайну, тьму и молчание и благоволит Уктене. Современные люди разуверились в нём."
	icon_state = "vulcan"

/obj/effect/decal/garou_glyph/venus
	name = "shrouded glyph"
	garou_name = "глиф Тамбии"
	garou_desc = "Глиф, означающий Тамбию, Сокрытую Матерь и Инкарну Венеры. Она чтит равновесие, мудрость и справедливость, покровительствуя Чёрным Фуриям и всем, кто стремится к её началам."
	icon_state = "venus"

/obj/effect/decal/garou_glyph/earth
	name = "homely glyph"
	garou_name = "глиф Эштарры"
	garou_desc = "Глиф, означающий Эштарру, Песенную Сказительницу и Инкарну Земли. Её почитают ликом самой Великой Матери, с упором на музыку, плодородие и оборонительный бой."
	icon_state = "earth"

/obj/effect/decal/garou_glyph/moon
	name = "dark glyph"
	garou_name = "глиф Сохты"
	garou_desc = "Глиф, означающий Сохту, Сияющую Госпожу и Инкарну Луны. Она лик Луны, Луны Эштарры, что превыше всего ставит покой, созерцание и медитацию."
	icon_state = "moon"

/obj/effect/decal/garou_glyph/mars
	name = "intense glyph"
	garou_name = "глиф Неригала"
	garou_desc = "Глиф, означающий Неригала, Ледяного Воина и Инкарну Марса. Его зовут и Окровавленным; он чтит напор и твёрдую волю."
	icon_state = "mars"

/obj/effect/decal/garou_glyph/asteroid_belt
	name = "foreboding glyph"
	garou_name = "глиф Рорга"
	garou_desc = "Глиф, означающий Рорга, Многокоготного Охотника и Инкарну Турога, погибшей планеты, из обломков которой сложился пояс астероидов. Он воплощает катастрофические перемены и погибель."
	icon_state = "asteroid_belt"

/obj/effect/decal/garou_glyph/jupiter
	name = "regal glyph"
	garou_name = "глиф Зарока"
	garou_desc = "Глиф, означающий Зарока, Инкарну Юпитера. Он воплощает мудрость и власть и особо благоволит Серебряным Клыкам."
	icon_state = "jupiter"

/obj/effect/decal/garou_glyph/saturn
	name = "quaint glyph"
	garou_name = "глиф Лу-Бата"
	garou_desc = "Глиф, означающий Лу-Бата, Мирного Советника и Инкарну Сатурна. Он воплощает мир, приятие и мудрость, благоволя Детям Геи."
	icon_state = "saturn"

/obj/effect/decal/garou_glyph/uranus
	name = "snaking glyph"
	garou_name = "глиф Руатмы"
	garou_desc = "Глиф, означающий Руатму, Окутанного Тенью и Инкарну Урана. Он воплощает дипломатию и поиск скрытого смысла и особо благоволит Теневым Владыкам."
	icon_state = "uranus"

/obj/effect/decal/garou_glyph/neptune
	name = "ravaged glyph"
	garou_name = "глиф Шантара"
	garou_desc = "Глиф, означающий Шантара, Ткача Основы и Инкарну Нептуна. Он воплощает прежде всего изобретательность, но также перемены, и особо благоволит Ходящим по Стеклу."
	icon_state = "neptune"

/obj/effect/decal/garou_glyph/pluto
	name = "waving glyph"
	garou_name = "глиф Мероса"
	garou_desc = "Глиф, означающий Мероса, Инкарну Плутона. Его влечёт неустанный поиск истины, ведущий к неизбежной смерти. Так он воплощает смерть, истину и искание, благоволя Безмолвным Странникам."
	icon_state = "pluto"

/obj/effect/decal/garou_glyph/red_star
	name = "perplexing glyph"
	garou_name = "глиф Красной Звезды"
	garou_desc = "Глиф, означающий Антелиоса, Красную Звезду. Она существует лишь десятилетие... и что это значит?"
	icon_state = "red_star"

/obj/effect/decal/garou_glyph/storm_eater
	name = "imposing glyph"
	garou_name = "глиф Пожирателя Бури"
	garou_desc = "Глиф, означающий Пожирателя Бури, ужасного Бейна, что грозил Чистым Землям во времена после Прихода Вирма."
	icon_state = "storm_eater"

/obj/effect/decal/garou_glyph/ape_warders
	name = "archaic glyph"
	garou_name = "глиф Хранителей Обезьян"
	garou_desc = "Глиф, означающий Хранителей Обезьян, первое имя Ходящих по Стеклу, когда люди ещё жили в простых деревнях."
	icon_state = "ape_warders"

/obj/effect/decal/garou_glyph/man_warders
	name = "ancient glyph"
	garou_name = "глиф Хранителей Людей"
	garou_desc = "Глиф, означающий Хранителей Людей, второе имя Ходящих по Стеклу, что явилось с ростом их деревень."
	icon_state = "man_warders"

/obj/effect/decal/garou_glyph/iron_riders
	name = "industrial glyph"
	garou_name = "глиф Железных Всадников"
	garou_desc = "Глиф, означающий Железных Всадников, третье имя Ходящих по Стеклу, что явилось с расцветом металлургии."
	icon_state = "iron_riders"

/obj/effect/decal/garou_glyph/claws
	name = "sharp glyph"
	garou_name = "глиф когтей"
	garou_desc = "Глиф, означающий множество когтей."
	icon_state = "claws"

/obj/effect/decal/garou_glyph/pelt
	name = "stolen glyph"
	garou_name = "глиф шкуры"
	garou_desc = "Глиф, означающий шкуру: будь то звериная шкура, которую часто отбирают люди, или одежда из шкур."
	icon_state = "pelt"

/obj/effect/decal/garou_glyph/king
	name = "regal glyph"
	garou_name = "глиф короля"
	garou_desc = "Глиф, означающий короля, человеческое слово для патриархального и полновластного правителя, которым часто пользуются Серебряные Клыки."
	icon_state = "king"

/obj/effect/decal/garou_glyph/nameless
	name = "lost glyph"
	garou_name = "глиф без имени"
	garou_desc = "Безымянный глиф, которым часто пользуются сказители или в иных случаях, когда имени нет."
	icon_state = "nameless"

/obj/effect/decal/garou_glyph/appalachia
	name = "homey glyph"
	garou_name = "глиф Аппалачей"
	garou_desc = "Глиф, означающий Аппалачи, название горной гряды в Чистых Землях."
	icon_state = "appalachia"

/obj/effect/decal/garou_glyph/new_york
	name = "caged glyph"
	garou_name = "глиф Нью-Йорка"
	garou_desc = "Глиф, означающий Нью-Йорк, штат в Америке после Прихода Вирма и дом густого человеческого населения."
	icon_state = "new_york"

/obj/effect/decal/garou_glyph/russia
	name = "violent glyph"
	garou_name = "глиф России"
	garou_desc = "Глиф, означающий Россию, человеческое имя огромных земель, важных для Серебряных Клыков и когда-то для Красных Когтей."
	icon_state = "russia"

/obj/effect/decal/garou_glyph/wyld_ways
	name = "elaborate glyph"
	garou_name = "глиф Путей Вильда"
	garou_desc = "Глиф, что буквально означает: Пути Вильда Надежды, Скорби и Гнева передаются из рук в руки. Это часто история, которую рассказывают Чёрные Фурии."
	icon_state = "wyld_ways"

/obj/effect/decal/garou_glyph/down_in_end_times
	name = "finite glyph"
	garou_name = "глиф «На дне в Последние Времена»"
	garou_desc = "Глиф, означающий «На дне в Последние Времена»; так часто называют историю, которую рассказывают Грызущие Кости."
	icon_state = "down_in_end_times"

/obj/effect/decal/garou_glyph/healing_gaia
	name = "healing glyph"
	garou_name = "глиф исцеления мира"
	garou_desc = "Глиф, возвещающий, что он и есть исцеление мира. Часто употребляется риторически Детьми Геи."
	icon_state = "healing_gaia"

/obj/effect/decal/garou_glyph/fiery_head_and_heart
	name = "smokey glyph"
	garou_name = "глиф Огня в Голове и Сердце"
	garou_desc = "Глиф, означающий Огонь в Голове и Сердце. Так часто называется история, которую рассказывают Фианна."
	icon_state = "fiery_head_and_heart"

/obj/effect/decal/garou_glyph/axe_and_claw
	name = "warring glyph"
	garou_name = "глиф топора и когтя"
	garou_desc = "Глиф, означающий топор, людской инструмент, ставший и оружием войны, и коготь, одно из орудий люпусов и гару. Вместе их часто поминают в сказаниях Потомства Фенрира."
	icon_state = "axe_and_claw"

/obj/effect/decal/garou_glyph/wolves_at_gate
	name = "besieged glyph"
	garou_name = "глиф «волков у ворот»"
	garou_desc = "Глиф, означающий «волки у ворот», речение из историй Ходящих по Стеклу, но им же клеймят и ярость племён Вильда против Ткачихи."
	icon_state = "wolves_at_gate"

/obj/effect/decal/garou_glyph/hell_and_high_water
	name = "challenging glyph"
	garou_name = "глиф «сквозь ад и воду»"
	garou_desc = "Глиф, отсылающий к людской поговорке «сквозь ад и воду» о опасном пути. Его часто используют в преданиях родичей."
	icon_state = "hell_and_high_water"

/obj/effect/decal/garou_glyph/croatan_song
	name = "wistful glyph"
	garou_name = "глиф песни Кроатанов"
	garou_desc = "Глиф, говорящий о песни Кроатанов; его часто используют Чистые племена в память о павшем Среднем Брате."
	icon_state = "croatan_song"

/obj/effect/decal/garou_glyph/no_compromise
	name = "dangerous glyph"
	garou_name = "глиф «Никаких уступок»"
	garou_desc = "Глиф, означающий «Никаких уступок»; Красные Когти часто употребляют его, подтверждая свой фанатизм."
	icon_state = "no_compromise"

/obj/effect/decal/garou_glyph/retribution_and_ascendance
	name = "resurgent glyph"
	garou_name = "глиф возмездия и восхождения"
	garou_desc = "Глиф, означающий возмездие и восхождение; у Теневых Владык он нередко служит литературным приёмом."
	icon_state = "retribution_and_ascendance"

/obj/effect/decal/garou_glyph/long_haunted_road
	name = "perilous glyph"
	garou_name = "глиф Долгой Одержимой Дороги"
	garou_desc = "Глиф, соединяющий тропу и духа и говорящий о духовном присутствии вдоль пути. Его часто используют Безмолвные Странники."
	icon_state = "long_haunted_road"

/obj/effect/decal/garou_glyph/shattered_soul
	name = "morose glyph"
	garou_name = "глиф расколотой души"
	garou_desc = "Глиф, говорящий о расколотой душе, людском слове для духа. Им часто называют историю Безмолвных Странников."
	icon_state = "shattered_soul"

/obj/effect/decal/garou_glyph/once_and_future_kings
	name = "aspirational glyph"
	garou_name = "глиф королей былых и грядущих"
	garou_desc = "Глиф, говорящий о наследии Серебряных Клыков, что некогда правили гару как короли и мечтают вернуть это."
	icon_state = "once_and_future_kings"

/obj/effect/decal/garou_glyph/king_of_wolves
	name = "lording glyph"
	garou_name = "глиф короля волков"
	garou_desc = "Глиф, напоминающий о том, как сами Серебряные Клыки зовут себя королями волков."
	icon_state = "king_of_wolves"

/obj/effect/decal/garou_glyph/elemental_mind
	name = "balanced glyph"
	garou_name = "глиф ума стихий"
	garou_desc = "Глиф, говорящий об уме, чутком к стихиям; этому часто учат Звездочёты."
	icon_state = "elemental_mind"

/obj/effect/decal/garou_glyph/binder_of_secrets
	name = "shrouded glyph"
	garou_name = "глиф Связывающего Тайны"
	garou_desc = "Глиф, означающий Связывающего Тайны, сказание, что часто рассказывает Старший Брат."
	icon_state = "binder_of_secrets"

/obj/effect/decal/garou_glyph/vengeance_of_wind
	name = "chilling glyph"
	garou_name = "глиф мести ветра"
	garou_desc = "Глиф, означающий месть ветра, как часто рассказывают в преданиях Младшего Брата."
	icon_state = "vengeance_of_wind"

/obj/effect/decal/garou_glyph/vancouver
	name = "ominous glyph"
	garou_name = "глиф Ванкувера"
	garou_desc = "Глиф, означающий Ванкувер, город в Британской Колумбии."
	icon_state = "vancouver"

/obj/effect/decal/garou_glyph/blood_moon
	name = "fearsome glyph"
	garou_name = "глиф кровавой луны"
	garou_desc = "Глиф, означающий кровавую луну, когда Луна краснеет в ярости."
	icon_state = "blood_moon"

/obj/effect/decal/garou_glyph/bat
	name = "flighty glyph"
	garou_name = "глиф летучей мыши"
	garou_desc = "Глиф, означающий летучую мышь или, возможно, вымерших Камазотцев."
	icon_state = "bat"

/obj/effect/decal/garou_glyph/boar
	name = "sniveling glyph"
	garou_name = "глиф кабана"
	garou_desc = "Глиф, означающий кабанов или их вымерших собратьев Фера, Грондров."
	icon_state = "boar"

/obj/effect/decal/garou_glyph/cow
	name = "bullish glyph"
	garou_name = "глиф коровы"
	garou_desc = "Глиф, означающий коров или их вымерших собратьев Фера, Аписов."
	icon_state = "cow"

/obj/effect/decal/garou_glyph/coyote
	name = "tricky glyph"
	garou_name = "глиф койота"
	garou_desc = "Глиф, означающий койотов или их хитрых собратьев Фера, Нувиша."
	icon_state = "coyote"

/obj/effect/decal/garou_glyph/dragon
	name = "spiny glyph"
	garou_name = "глиф дракона"
	garou_desc = "Глиф, означающий драконов, рептилий и их древних собратьев Фера, Моколе."
	icon_state = "dragon"

/obj/effect/decal/garou_glyph/fox
	name = "flashy glyph"
	garou_name = "глиф лисицы"
	garou_desc = "Глиф, означающий лисиц и их переменчивых собратьев Фера, Кицунэ."
	icon_state = "fox"

/obj/effect/decal/garou_glyph/hyena
	name = "funny glyph"
	garou_name = "глиф гиены"
	garou_desc = "Глиф, означающий гиен, африканских зверей, глубоко важных для людей, что живут рядом с ними."
	icon_state = "hyena"

/obj/effect/decal/garou_glyph/phoenix
	name = "fiery glyph"
	garou_name = "глиф феникса"
	garou_desc = "Глиф, означающий феникса, изначальных огненных птиц."
	icon_state = "phoenix"

/obj/effect/decal/garou_glyph/tick
	name = "itchy glyph"
	garou_name = "глиф Клеща"
	garou_desc = "Глиф, означающий Клеща, тотема Хитрости, разумного паразита и трикстера."
	icon_state = "tick"

/obj/effect/decal/garou_glyph/drone
	name = "rigid glyph"
	garou_name = "глиф дрона"
	garou_desc = "Глиф, означающий дрона, зверя, одержимого духами Ткачихи."
	icon_state = "drone"

/obj/effect/decal/garou_glyph/gorgon
	name = "energetic glyph"
	garou_name = "глиф горгоны"
	garou_desc = "Глиф, означающий горгону, зверя, одержимого духами Вильда."
	icon_state = "gorgon"

/obj/effect/decal/garou_glyph/kami
	name = "impassioned glyph"
	garou_name = "глиф Ками"
	garou_desc = "Глиф, означающий Ками, полудухов Геи, что вселились в зверя. Это же слово по-японски значит «дух», но глиф означает не это."
	icon_state = "kami"

/obj/effect/decal/garou_glyph/sun_storm_shadow
	name = "multifaceted glyph"
	garou_name = "глиф солнца, бури и тени"
	garou_desc = "Глиф, означающий множество видов суровой погоды; им часто пользуются Кораксы, показывая, что ничто не помешает им в их деле, делиться знанием и узнавать новое."
	icon_state = "sun_storm_shadow"
