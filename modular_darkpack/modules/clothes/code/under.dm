/obj/item/clothing/under/vampire
	abstract_type = /obj/item/clothing/under/vampire
	desc = "Какая-то одежда."
	name = "clothes"
	has_sensor = NO_SENSORS
	random_sensor = FALSE
	can_adjust = FALSE
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "undersuit", FALSE)

/obj/item/clothing/under/vampire/brujah
	name = "punk attire"
	desc = "Грубая рубашка с коротким рукавом и засаленные штаны."
	icon_state = "brujah_m"

/obj/item/clothing/under/vampire/brujah/female
	desc = "Спортивный топ и чёрные треники. Шикарно."
	icon_state = "brujah_f"

/obj/item/clothing/under/vampire/gangrel
	name = "Rugged attire"
	desc = "Одёжка бродяги."
	icon_state = "gangrel_m"

/obj/item/clothing/under/vampire/gangrel/female
	icon_state = "gangrel_f"

/obj/item/clothing/under/vampire/malkavian
	name = "Grimey pants"
	desc = "Штаны настоящего мачо."
	icon_state = "malkavian_m"

/obj/item/clothing/under/vampire/malkavian/female
	name = "schoolgirl attire"
	icon_state = "malkavian_f"

/obj/item/clothing/under/vampire/nosferatu
	name = "gimp outfit"
	desc = "Приведи Гимпа."
	icon_state = "nosferatu_m"

/obj/item/clothing/under/vampire/nosferatu/female
	name = "feminine gimp outfit"
	icon_state = "nosferatu_f"

/obj/item/clothing/under/vampire/toreador
	name = "flamboyant outfit"
	desc = "Весьма соблазнительная одежда."
	icon_state = "toreador_m"

/obj/item/clothing/under/vampire/toreador/female
	name = "dancer's offwear"
	desc = "Я что, похожа на твою девушку?"
	icon_state = "toreador_f"

/obj/item/clothing/under/vampire/tremere
	name = "burgundy suit"
	desc = "На удивление опрятная одежда."
	icon_state = "tremere_m"

/obj/item/clothing/under/vampire/tremere/female
	name = "burgundy suit skirt"
	icon_state = "tremere_f"

/obj/item/clothing/under/vampire/ventrue
	name = "brown luxury shirt"
	desc = "Одежда для богатых."
	icon_state = "ventrue_m"

/obj/item/clothing/under/vampire/ventrue/female
	name = "brown luxury suit skirt"
	icon_state = "ventrue_f"

/obj/item/clothing/under/vampire/baali
	name = "edgy outfit"
	desc = "Красная пентаграмма на чёрной футболке. Если уж это не убережёт вашу девственность, то ничто не убережёт."
	icon_state = "baali_m"

/obj/item/clothing/under/vampire/baali/female
	icon_state = "baali_f"

/obj/item/clothing/under/vampire/salubri
	name = "grey attire"
	desc = "Очень нейтральная одежда без ярких цветов."
	icon_state = "salubri_m"

/obj/item/clothing/under/vampire/salubri/female
	icon_state = "salubri_f"

/obj/item/clothing/under/vampire/punk
	name = "punk rocker outfit"
	desc = "Белая, пропитанная потом футболка с огромным чёрным черепом на груди. Это заявление. Возможно, \"я не пользуюсь дезодорантом\", но всё же заявление."
	icon_state = "dirty"

/obj/item/clothing/under/vampire/sceneleopard
	name = "revealing outfit"
	desc = "Вы и не думали, что вам так нужны тонкие бретельки."
	icon_state = "scenetop_leopard"

/obj/item/clothing/under/vampire/scenemoody
	name = "moody attire"
	desc = "Классический топ с My Chemistry Romance."
	icon_state = "scenetop_moody"

/obj/item/clothing/under/vampire/scenezim
	name = "intruder zim attire"
	desc = "Топ по вашему любимому мультсериалу \"Вторженец Зим\""
	icon_state = "scenetop_zim"

/obj/item/clothing/under/vampire/scenepink
	name = "popular Outfit"
	desc = "В таком почти чувствуешь себя дрянной девчонкой"
	icon_state = "scenetop_pink"

/obj/item/clothing/under/vampire/turtleneck_white
	name = "white turtleneck"
	desc = "У меня всегда так."
	icon_state = "turtleneck_white"

/obj/item/clothing/under/vampire/turtleneck_black
	name = "black turtleneck"
	desc = "Знающие люди зовут её \"тактолазкой\": первейшая одежда секретного агента."
	icon_state = "turtleneck_black"

/obj/item/clothing/under/vampire/turtleneck_red
	name = "red turtleneck"
	desc = "Красная водолазка"
	icon_state = "turtleneck_red"

/obj/item/clothing/under/vampire/turtleneck_navy
	name = "navy turtleneck"
	desc = "Тёмно-синяя водолазка"
	icon_state = "turtleneck_navy"

/obj/item/clothing/under/vampire/napoleon
	name = "french emperor suit"
	desc = "Подозрительно историческая одежда."
	icon_state = "napoleon"

/obj/item/clothing/under/vampire/military_fatigues
	name = "military fatigues"
	desc = "Военная форма."
	icon_state = "milfatigues"

//FOR NPC

//GANGSTERS AND BANDITS

/obj/item/clothing/under/vampire/larry
	name = "yellow tanktop"
	desc = "Знаю, у меня проблемы с весом, и мне на это насрать!"
	icon_state = "larry"

/obj/item/clothing/under/vampire/bandit
	name = "white tanktop"
	desc = "Подозрительно заношенная майка."
	icon_state = "bandit"

/obj/item/clothing/under/vampire/biker
	name = "biker attire"
	desc = "Грязная одежда."
	icon_state = "biker"

//USUAL

/obj/item/clothing/under/vampire/mechanic
	name = "blue overalls"
	desc = "Синий рабочий комбинезон. Так и просит маску капитана Кирка."
	icon_state = "mechanic"

/obj/item/clothing/under/vampire/sport
	name = "red tracksuit"
	desc = "Чики-брики!"
	icon_state = "sport"

/obj/item/clothing/under/vampire/office
	name = "white shirt"
	desc = "Охренеть какая чистая рубашка."
	icon_state = "office"

/obj/item/clothing/under/vampire/sexy
	name = "purple outfit"
	desc = "Самая обычная одежда."
	icon_state = "sexy"

/obj/item/clothing/under/vampire/slickback
	name = "slick suit"
	desc = "Одежда с лоском."
	icon_state = "slickback"

/obj/item/clothing/under/vampire/burlesque
	name = "burlesque outfit"
	desc = "Одежда для бурлеска."
	icon_state = "burlesque"

/obj/item/clothing/under/vampire/burlesque/daisyd
	name = "daisy dukes"
	desc = "Очень короткие шорты."
	icon_state = "daisyd"

/obj/item/clothing/under/vampire/emo
	name = "uncolorful attire"
	desc = "Самая обычная одежда."
	icon_state = "emo"

//WOMEN

/obj/item/clothing/under/vampire/black
	name = "black croptop"
	desc = "Самая обычная одежда."
	icon_state = "black"

/obj/item/clothing/under/vampire/red
	name = "red croptop"
	desc = "Самая обычная одежда."
	icon_state = "red"

/obj/item/clothing/under/vampire/gothic
	name = "gothic getup"
	desc = "Рваные джинсы и чёрный свитшот. Готика. Вроде бы."
	icon_state = "gothic"

//PATRICK BATEMAN (High Society)

/obj/item/clothing/under/vampire/rich
	desc = "Одежда для богатых."
	name = "rich suit"
	icon_state = "rich"

/obj/item/clothing/under/vampire/business
	name = "black dress"
	desc = "Урок первый: как пишется слово \"бизнес\"."
	icon_state = "business"

//Homeless

/obj/item/clothing/under/vampire/homeless
	name = "dirty attire"
	desc = "Одёжка бродяги."
	icon_state = "homeless_m"

/obj/item/clothing/under/vampire/homeless/female
	icon_state = "homeless_f"

//Police and Guards

/obj/item/clothing/under/vampire/police
	name = "police uniform"
	/*
	 * I did like a fair bit of research tracking down the statistic, 44% was the original value here but I cant find anything supporting that,
	 * The commonly thrown around number of 40% is from
	 * Johnson, L.B. (1991). On the front lines: Police stress and family well-being. Hearing before the Select Committee on Children, Youth, and Families House of Representatives: 102 Congress First Session May 20 (p. 32-48). Washington DC: US Government Printing Office.
	 * Most other stuides get lower numbers e.g
	 * Neidig, P.H., Russell, H.E. & Seng, A.F. (1992). Interspousal aggression in law enforcement families: A preliminary investigation. Police Studies, Vol. 15 (1), p. 30-38.
	 * Anyway im done doing research for this joke. - Fallcon
	 */
	desc = "Форма парней в синем. А вы знали, что 40% копов слышали про \"Пентекс\"? Загуглите \"40% копов\", чтобы узнать больше."
	icon_state = "police"
	custom_price = 20

/obj/item/clothing/under/vampire/police/long
	name = "police uniform"
	icon_state = "policelong"

/obj/item/clothing/under/vampire/police/turtleneck
	name = "police turtleneck"
	icon_state = "policeturtleneck"

/obj/item/clothing/under/vampire/police/pants
	name = "police fatigue pants"
	icon_state = "policepants"

/obj/item/clothing/under/vampire/police/utility
	name = "police fatigues"
	icon_state = "policeutil"

/obj/item/clothing/under/vampire/police/fbi
	name = "\improper FBI turtleneck"
	desc = "Форма лучших людей Бюро. В комплекте прочные тянущиеся брюки, чтобы вышибать двери ногой."
	icon_state = "fbiturtleneck"

/obj/item/clothing/under/vampire/police/fbi/utility
	name = "\improper FBI fatigues"
	icon_state = "fbiutil"

/obj/item/clothing/under/vampire/police/fbi/pants
	name = "\improper FBI fatigue pants"
	icon_state = "fbipants"

/obj/item/clothing/under/vampire/guard
	name = "security guard uniform"
	desc = "Не позволяйте чёрствому, рыхлому бисквиту жизни помешать вам добраться до вкусной кремовой начинки успеха."
	icon_state = "guard"

//JOBS

/obj/item/clothing/under/vampire/janitor
	name = "janitorial uniform"
	desc = "Ваша работа? Толчки да котлы, котлы да толчки, ну и тот самый кипящий толчок."
	icon_state = "janitor"

/obj/item/clothing/under/vampire/nurse
	name = "nurse scrubs"
	desc = "Стерильная одежда."
	icon_state = "nurse"

/obj/item/clothing/under/vampire/nurse/nurseb
	name = "black nurse scrubs"
	desc = "Стерильная одежда."
	icon_state = "nurseb"

/obj/item/clothing/under/vampire/nurse/nurseg
	name = "green nurse scrubs"
	desc = "Стерильная одежда."
	icon_state = "nurseg"

/obj/item/clothing/under/vampire/nurse/nursep
	name = "pink nurse scrubs"
	desc = "Стерильная одежда."
	icon_state = "nursep"

/obj/item/clothing/under/vampire/nurse/nursec
	name = "cyan nurse scrubs"
	desc = "Стерильная одежда."
	icon_state = "nursec"

/obj/item/clothing/under/vampire/graveyard
	desc = "Снимете это - и последствия будут МОГИЛЬНО серьёзными!"
	icon_state = "graveyard"

/obj/item/clothing/under/vampire/suit
	name = "suit"
	desc = "Деловая одежда."
	icon_state = "suit"

/obj/item/clothing/under/vampire/suit/female
	name = "suitskirt"
	icon_state = "suit_f"

/obj/item/clothing/under/vampire/sheriff
	name = "red suit"
	desc = "Деловая одежда."
	icon_state = "sheriff"

/obj/item/clothing/under/vampire/sheriff/female
	name = "red suitskirt"
	icon_state = "sheriff_f"

/obj/item/clothing/under/vampire/clerk
	name = "blue suit"
	desc = "Деловая одежда."
	icon_state = "clerk"

/obj/item/clothing/under/vampire/clerk/female
	name = "blue suitskirt"
	icon_state = "clerk_f"

/obj/item/clothing/under/vampire/prince
	name = "fancy black suit"
	desc = "Мало добиться власти, её ещё нужно удержать."
	icon_state = "prince"

/obj/item/clothing/under/vampire/prince/female
	name = "fancy black suitskirt"
	icon_state = "prince_f"

/obj/item/clothing/under/vampire/hound
	name = "scruffy black suit"
	desc = "Извините, тут внизу никого нет, только самые нежеланные агенты ФБР."
	icon_state = "agent"

/obj/item/clothing/under/vampire/archivist
	name = "brown and red suit"
	desc = "Очень надеюсь, что Пирамида не взлетит на воздух из-за какой-нибудь дурацкой, бездарно написанной череды событий!"
	icon_state = "archivist"

/obj/item/clothing/under/vampire/archivist/female
	name = "brown and red suitskirt"
	icon_state = "archivist_f"

/obj/item/clothing/under/vampire/bar
	name = "red shirt"
	desc = "Одежда прислуги."
	icon_state = "bar"

/obj/item/clothing/under/vampire/bar/female
	name = "red skirt"
	icon_state = "bar_f"

/obj/item/clothing/under/vampire/bouncer
	name = "loose shirt"
	desc = "Что, тяжёлая ночка?"
	icon_state = "bouncer"

/obj/item/clothing/under/vampire/supply
	name = "cargo jumpsuit"
	desc = "Каин жив? Не-не-не. Жива Каргония."
	icon_state = "supply"

//PRIMOGEN

/obj/item/clothing/under/vampire/primogen_malkavian
	name = "stark white pants"
	desc = "Наряд по-настоящему безумных. Кто вообще носит белые штаны? Тем более в этой дыре."
	icon_state = "malkav_pants"

/obj/item/clothing/under/vampire/voivode
	name = "blue windbreaker"
	desc = "Нарядная одежда."
	icon_state = "voivode"

/obj/item/clothing/under/vampire/bogatyr
	name = "blue shirt"
	desc = "Приличная одежда."
	icon_state = "bogatyr"

/obj/item/clothing/under/vampire/bogatyr/female
	name = "blue skirt"
	desc = "Приличная одежда."
	icon_state = "bogatyr"

/obj/item/clothing/under/vampire/primogen_malkavian/female
	name = "catsuit"
	desc = "Весьма отдалённо навеян \"хитом\" 2004 года."
	icon_state = "malkav_suit"

/obj/item/clothing/under/vampire/primogen_toreador
	name = "white suit"
	desc = "Пожелайте спокойной ночи плохому парню!"
	icon_state = "toreador_male"

/obj/item/clothing/under/vampire/primogen_toreador/female
	name = "crimson red dress"
	desc = "Соблазнительный наряд богатой дамы."
	icon_state = "toreador_female"

/obj/item/clothing/under/vampire/fancy_gray
	name = "fancy red suit"
	desc = "Костюм для настоящего дела."
	icon_state = "fancy_gray"

/obj/item/clothing/under/vampire/fancy_red
	name = "Fancy grey suit"
	desc = "Костюм для настоящего дела."
	icon_state = "fancy_red"

/obj/item/clothing/under/vampire/leatherpants
	name = "leather pants"
	desc = "Костюм для ПО-НАСТОЯЩЕМУ настоящего дела."
	icon_state = "leather_pants"


/obj/item/clothing/under/vampire/bacotell
	name = "bacotell uniform"
	desc = "Форменная одежда закусочной \"Baco Tell\"."
	icon_state = "bacotell"

/obj/item/clothing/under/vampire/bubway
	name = "bubway uniform"
	desc = "Форменная одежда закусочной \"Bubway\"."
	icon_state = "bubway"

/obj/item/clothing/under/vampire/gummaguts
	name = "gummaguts uniform"
	desc = "Форменная одежда закусочной \"Gummaguts\"."
	icon_state = "gummaguts"


//PENTEX
/obj/item/clothing/under/vampire/pentex_janitor
	name = "Ardus Enterprises custodian jumpsuit"
	desc = "Форма уборщика \"Ардус Энтерпрайзис\"."
	icon_state = "pentex_janitor"
	brand = "ardus"

/obj/item/clothing/under/vampire/pentex_shortsleeve
	name = "\improper " + MAIN_EVIL_COMPANY + " polo-shirt"
	desc = "Форма сотрудника \"Эндрон Интернейшнл\". Вот эта - симпатичное поло!"
	icon_state = "pentex_shortsleeve"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_longleeve
	name = "\improper " + MAIN_EVIL_COMPANY + " shirt"
	desc = "Форма сотрудника \"Эндрон Интернейшнл\". У этой есть рукава!"
	icon_state = "pentex_longsleeve"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_turtleneck
	name = "\improper " + MAIN_EVIL_COMPANY + " turtleneck"
	desc = "Форма сотрудника \"Эндрон Интернейшнл\". Вот эта - симпатичная водолазка!"
	icon_state = "pentex_turtleneck"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_suit
	name = "\improper " + MAIN_EVIL_COMPANY + " suit"
	desc = "Приличный костюм с зелёной рубашкой. На нём бирка \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_suit"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_suitskirt
	name = "\improper " + MAIN_EVIL_COMPANY + " suitskirt"
	desc = "Приличный костюм с юбкой и зелёной рубашкой. На нём бирка \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_suitskirt"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executive_suit
	name = "\improper " + MAIN_EVIL_COMPANY + " executive suit"
	desc = "Белый дизайнерский костюм с зелёной рубашкой. На нём бирка \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_executivesuit"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executiveskirt
	name = "\improper " + MAIN_EVIL_COMPANY + " executive suitskirt"
	desc = "Белый дизайнерский костюм с юбкой и зелёной рубашкой. На нём бирка \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_executiveskirt"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executive_suit
	name = "Endron executive suit"
	desc = "Белый дизайнерский костюм с зелёной рубашкой. На нём бирка \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_executivesuit"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executiveskirt
	name = "Endron executive suitskirt"
	desc = "Белый дизайнерский костюм с юбкой и зелёной рубашкой. На нём бирка \"Эндрон Интернейшнл\"!"
	icon_state = "pentex_executiveskirt"
	brand = "endron"

/obj/item/clothing/under/vampire/gown_black
	name = "black gown"
	desc = "Дорогое чёрное вечернее платье."
	icon_state = "gown_black"

/obj/item/clothing/under/vampire/gown_white
	name = "white gown"
	desc = "Дорогое белое вечернее платье."
	icon_state = "gown_white"
