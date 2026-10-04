/datum/ert/darkpack
	abstract_type = /datum/ert/darkpack

/datum/ert/darkpack/swat
	leader_role = /datum/antagonist/ert/darkpack/swat/leader
	roles = list(/datum/antagonist/ert/darkpack/swat/medic, /datum/antagonist/ert/darkpack/swat/rifleman, /datum/antagonist/ert/darkpack/swat/negotiations)
	rename_team = "Отряд SWAT"
	mission = "Оцените обстановку и окажите содействие полицейскому департаменту. Добейтесь восстановления закона и порядка в городе."
	polldesc = "городской отряд SWAT"

/datum/ert/darkpack/national_guard
	leader_role = /datum/antagonist/ert/darkpack/national_guard/leader
	roles = list(/datum/antagonist/ert/darkpack/national_guard/medic, /datum/antagonist/ert/darkpack/national_guard/rifleman, /datum/antagonist/ert/darkpack/national_guard/explosives)
	rename_team = "Взвод Национальной гвардии"
	mission = "Стабилизируйте обстановку в районе. Введите комендантский час. Разгоните беспорядки. Обеспечьте безопасность и немедленно восстановите порядок - любыми средствами."
	polldesc = "отряд экстренного реагирования Национальной гвардии"

/datum/ert/darkpack/pentex
	leader_role = /datum/antagonist/ert/darkpack/pentex/leader
	roles = list(/datum/antagonist/ert/darkpack/pentex/medic, /datum/antagonist/ert/darkpack/pentex/exterminator, /datum/antagonist/ert/darkpack/pentex/specialist)
	rename_team = "Первая Команда"
	mission = "Ликвидируйте все враждебные аномальные сущности"
	polldesc = "элитную Первую Команду"

/datum/ert/darkpack/pentex/budget
	leader_role = /datum/antagonist/ert/darkpack/pentex/budget_leader
	roles = list(/datum/antagonist/ert/darkpack/pentex/budget_intern, /datum/antagonist/ert/darkpack/pentex/budget_medic)
	rename_team = "Первая Команда" //For when you need a death-squad on a budget
	mission = "Устраните все враждебные аномальные сущности"
	polldesc = "\"элитную\" Первую Команду"

/datum/ert/darkpack/fbi
	leader_role = /datum/antagonist/ert/darkpack/fbi/leader
	roles = list(/datum/antagonist/ert/darkpack/fbi/medic, /datum/antagonist/ert/darkpack/fbi/rifleman, /datum/antagonist/ert/darkpack/fbi/marksman)
	rename_team = "Отряд SWAT ФБР"
	mission = "Оцените обстановку и окажите содействие работающим на месте специальным агентам ФБР."
	polldesc = "отряд SWAT ФБР"
