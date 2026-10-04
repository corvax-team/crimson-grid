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

/obj/effect/decal/garou_glyph/rite
	name = "subtle glyph"
	garou_name = "глиф обряда"
	garou_desc = "Глиф, означающий обряд, священный ритуал Фера."
	icon_state = "rite"

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
