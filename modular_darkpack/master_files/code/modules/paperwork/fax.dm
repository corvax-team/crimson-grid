/obj/machinery/fax
	special_networks = list(
		nanotrasen = list(fax_name = "Отдел кадров NT", fax_id = "central_command", color = "teal", emag_needed = TRUE),
		syndicate = list(fax_name = "Отдел саботажа", fax_id = "syndicate", color = "red", emag_needed = TRUE),
		camarillaadmin = list(fax_name = "Высший совет", fax_id = "camarillaadmin", color = "teal", emag_needed = TRUE),
		anarchsadmin = list(fax_name = "Движение Свободного государства", fax_id = "anarchsadmin", color = "red", emag_needed = TRUE),
		policeadmin = list(fax_name = "Федеральное правительство", fax_id = "policeadmin", color = "blue", emag_needed = TRUE),
		fbiadmin = list(fax_name = "Штаб-квартира ФБР", fax_id = "fbiadmin", color = "blue", emag_needed = TRUE),
		endronadmin = list(fax_name = "Корпоративное управление " + EVIL_COMPANY, fax_id = "endronadmin", color = "green", emag_needed = TRUE),
		aasimitesadmin = list(fax_name = "Ретранслятор \"Элемент\"", fax_id = "aasimitesadmin", color = "purple", emag_needed = TRUE),
		glasswalkeradmin = list(fax_name = "Корпоративное управление Nightwolf", fax_id = "glasswalkeradmin", color = "grey", emag_needed = TRUE),
	)

/obj/machinery/fax/admin/camarilla
	fax_name = "Высший совет"
	fax_id = "camarillaadmin"

/obj/machinery/fax/admin/anarch
	fax_name = "Движение Свободного государства"
	fax_id = "anarchsadmin"

/obj/machinery/fax/admin/police
	fax_name = "Федеральное правительство"
	fax_id = "policeadmin"

/obj/machinery/fax/admin/fbi
	fax_name = "Штаб-квартира ФБР"
	fax_id = "fbi"

/obj/machinery/fax/admin/endron
	fax_name = "Корпоративное управление " + EVIL_COMPANY
	fax_id = "endronadmin"

/obj/machinery/fax/admin/aasimites
	fax_name = "Ретранслятор \"Элемент\""
	fax_id = "aasimitesadmin"

//The tremere dont get a fax machine because of what happened in Vienna

/obj/machinery/fax/admin/glasswalker
	fax_name = "Корпоративное управление Nightwolf"
	fax_id = "glasswalkeradmin"

/////////////////////////////////////////////

/obj/machinery/fax/camarilla
	fax_name = "Башня Миллениум"
	fax_id = "camarilla"
	special_networks = list(camarillaadmin = list(fax_name = "Высший совет", fax_id = "camarillaadmin", color = "teal", emag_needed = FALSE))


// CRIMSON EDIT ADD - #206
/obj/machinery/fax/clinic
	fax_name = "Клиника Святого Иоанна"
	fax_id = "clinic"
	special_networks = list(clinicadmin = list(fax_name = "Больница Святого Иоанна", fax_id = "clinicadmin", color = "blue", emag_needed = FALSE))
// CRIMSON EDIT ADD END - #206

/obj/machinery/fax/anarch
	fax_name = "Бар \"Anarchy Rose\""
	fax_id = "anarchs"
	special_networks = list(anarchsadmin = list(fax_name = "Движение Свободного государства", fax_id = "anarchsadmin", color = "red", emag_needed = FALSE))

/obj/machinery/fax/police
	fax_name = CITY_POLICE_DEPARTMENT_RU
	fax_id = "police"
	special_networks = list(policeadmin = list(fax_name = "Федеральное правительство", fax_id = "policeadmin", color = "blue", emag_needed = FALSE))

/obj/machinery/fax/fbi
	fax_name = "ФБР"
	fax_id = "fbi"
	special_networks = list(fbiadmin = list(fax_name = "Штаб-квартира ФБР", fax_id = "fbiadmin", color = "blue", emag_needed = TRUE))
	visible_to_network = FALSE

/obj/machinery/fax/endron
	fax_name = "Штаб-квартира " + MAIN_EVIL_COMPANY
	fax_id = "endron"
	special_networks = list(endronadmim = list(fax_name = "Корпоративное управление " + EVIL_COMPANY, fax_id = "endronadmin", color = "green", emag_needed = FALSE))

/obj/machinery/fax/aasimites
	fax_name = "Кофейня \"Chubby Lion\""
	fax_id = "aasimites"
	special_networks = list(aasimitesadmin = list(fax_name = "Ретранслятор \"Элемент\"", fax_id = "aasimitesadmin", color = "purple", emag_needed = FALSE))

/obj/machinery/fax/tremere
	fax_name = "Библиотека"
	fax_id = "library"
	special_networks = list()

/obj/machinery/fax/glasswalker
	fax_name = "Магазин электроники \"Nightwolf\""
	fax_id = "glasswalkers"
	special_networks = list(glasswalkeradmin = list(fax_name = "Корпоративное управление Nightwolf", fax_id = "glasswalkeradmin", color = "grey", emag_needed = FALSE))
