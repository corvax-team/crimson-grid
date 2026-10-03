/obj/item/smartphone/prince
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "Генеральный директор", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Генеральный директор \"Трансамерика\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/seneschal
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "Операционный директор", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Операционный директор \"Трансамерика\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sheriff
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "Начальник службы безопасности", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Начальник службы безопасности \"Миллениум Групп\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/harpy
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "Связи с общественностью", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Связи с общественностью \"Миллениум Групп\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/hound
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "Охрана Башни", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/tower_employee
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "Сотрудник Башни", USE_JOB_TITLE = TRUE)
		)

// VENTRUE

/obj/item/smartphone/ventrue_primo
	important_contact_of = VAMPIRE_CLAN_VENTRUE
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Владелец джаз-клуба \"Crown Blue\"", USE_JOB_TITLE = FALSE)
		)

// TOREADOR

/obj/item/smartphone/toreador_primo
	important_contact_of = VAMPIRE_CLAN_TOREADOR
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = ("Владелец ночного клуба \"" + PRIMARY_NIGHTCLUB_COMPANY + "\""), USE_JOB_TITLE = FALSE)
		)

// NOSFERATU

/obj/item/smartphone/nosferatu_primo
	important_contact_of = VAMPIRE_CLAN_NOSFERATU
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Управляющий коммунальными службами", USE_JOB_TITLE = FALSE)
		)

// MALKAVIAN

/obj/item/smartphone/malkavian_primo
	important_contact_of = VAMPIRE_CLAN_MALKAVIAN
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Управляющий лечебницей", USE_JOB_TITLE = FALSE)		// CRIMSON EDIT - Original: OUR_ROLE = "Hospital Administrator"
		)

// LASOMBRA

/obj/item/smartphone/lasombra_primo
	important_contact_of = VAMPIRE_CLAN_LASOMBRA
	contact_networks_pre_init = list(
		alist(NETWORK_ID = LASOMBRA_NETWORK, OUR_ROLE = "Управляющий церковью", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Управляющий церковью", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/lasombra_caretaker
	contact_networks_pre_init = list(
		alist(NETWORK_ID = LASOMBRA_NETWORK, OUR_ROLE = "Смотритель церкви", USE_JOB_TITLE = FALSE)
		)

// BANU HAQIM

/obj/item/smartphone/banu_primo
	important_contact_of = VAMPIRE_CLAN_BANU_HAQIM
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Гражданский консультант SFPD", USE_JOB_TITLE = FALSE)
		)

// TREMERE

/obj/item/smartphone/tremere_regent
	important_contact_of = VAMPIRE_CLAN_TREMERE
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TREMERE_NETWORK, OUR_ROLE = "Заведующий библиотекой", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Заведующий библиотекой", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/archivist
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TREMERE_NETWORK, OUR_ROLE = "Архивариус библиотеки", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/gargoyle
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TREMERE_NETWORK, OUR_ROLE = "Техперсонал библиотеки", USE_JOB_TITLE = FALSE)
		)

// GIOVANNI

/obj/item/smartphone/giovanni_capo
	important_contact_of = VAMPIRE_CLAN_GIOVANNI
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "Управляющий банком", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Управляющий банком", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/giovanni_nonni
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "Акционер банка", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/giovanni_squadra
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "Охрана банка", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/giovanni_famiglia
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "Сотрудник банка", USE_JOB_TITLE = FALSE)
		)

// TZMISCE

/obj/item/smartphone/voivode
	important_contact_of = VAMPIRE_CLAN_TZIMISCE
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TZMISCE_NETWORK, OUR_ROLE = "Хозяин поместья", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Хозяин поместья", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/bogatyr
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TZMISCE_NETWORK, OUR_ROLE = "Житель поместья", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/zadruga
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TZMISCE_NETWORK, OUR_ROLE = "Слуга поместья", USE_JOB_TITLE = FALSE)
		)

// ANARCHS

/obj/item/smartphone/baron
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "Управляющий клубом", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Управляющий клубом \"Anarchy Rose\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/emissary
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "Представитель клуба", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Представитель клуба \"Anarchy Rose\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/bruiser
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "Вышибала клуба", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sweeper
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "Бармен клуба", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/liaison
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "Промоутер клуба", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/tapster
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "Бармен клуба", USE_JOB_TITLE = FALSE)
		)

// SUPPLY

/obj/item/smartphone/supply_tech
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "Техник снабжения", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/dealer
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "Менеджер по снабжению", USE_JOB_TITLE = FALSE),
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Управляющий складом", USE_JOB_TITLE = FALSE)
	)

// ENDRON

/obj/item/smartphone/endron_lead
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "Глава филиала \"Эндрон\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_exec
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "Руководитель \"Эндрон\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_affairs
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "Агент внутренних расследований \"Эндрон\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_sec_chief
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "Начальник охраны \"Эндрон\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_security
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "Агент охраны \"Эндрон\"", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_employee
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "Сотрудник \"Эндрон\"", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/novice
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "Послушник", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/condottieri
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "Кондотьер", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/inquisitor
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "Инквизитор", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/abbe
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "Аббат", USE_JOB_TITLE = TRUE)
		)

// CIVILIAN

/obj/item/smartphone/janitor
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "Уборщик", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/taxi
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "Таксист", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/club_worker
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "Работник клуба", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/priest
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "Священник", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/clinic_director
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "Директор клиники", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/red_news
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "Репортёр RED News", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/doctor
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "Персонал клиники", USE_JOB_TITLE = FALSE)
		)

// SEPT

/obj/item/smartphone/garou_council
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "Наблюдательный комитет NPS", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_guardian
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "Рейнджер парка", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_truthcatcher
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "Гид парка", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_warder
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "Старший рейнджер парка", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_wyrmfoe
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "Биолог NPS", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_keeper
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "Персонал парка", USE_JOB_TITLE = FALSE)
		)

// POLICE

/obj/item/smartphone/police_captain
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "Капитан SFPD", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/dispatch
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "Диспетчер экстренных служб", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/federal_investigator
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "Федеральный следователь", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/police_officer
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "Офицер SFPD", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/police_sergeant
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "Сержант SFPD", USE_JOB_TITLE = FALSE)
		)

// SABBAT

/obj/item/smartphone/sabbat_ductus
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "Начальник смены", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sabbat_pack
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "Придурок-коллега", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sabbat_priest
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "Помощник управляющего", USE_JOB_TITLE = FALSE)
		)

// CRIMSON EDIT ADD - Triads and Rolelocks

/obj/item/smartphone/brujah_primo
	important_contact_of = VAMPIRE_CLAN_BRUJAH
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "Владелец спортзала", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_keeper
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "Персонал парка", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/mountain_master
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "Большой босс", USE_JOB_TITLE = FALSE),
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "Риелтор Чайнатауна", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/deputy_mountain_master
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "Заместитель большого босса", USE_JOB_TITLE = FALSE),
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "Брокер Чайнатауна", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/red_pole
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "Охрана Чайнатауна", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/blue_lantern
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "Лавочник Чайнатауна", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/clinic_officer
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "Санитар клиники", USE_JOB_TITLE = FALSE)
		)
// CRIMSON EDIT ADD END - Triads and Rolelocks


#undef NETWORK_ID
#undef OUR_ROLE
#undef USE_JOB_TITLE
