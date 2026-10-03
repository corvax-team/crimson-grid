/datum/job/vampire/guardian
	title = JOB_GAROU_GUARDIAN
	description = "В иерархии септа вы на нижней ступени, зато именно вы первыми идёте в бой и первыми встречаете удар. Вы служите под началом Стража и Врага Вирма и бережёте каэрн."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_GAIA
	total_positions = 3
	spawn_positions = 3
	supervisors = "Стражем"
	req_admin_notify = 1
	minimal_player_age = 25
	exp_required_type_department = EXP_TYPE_GAIA
	config_tag = "GUARDIAN"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/guardian

	allowed_splats = list(SPLAT_GAROU)
	allowed_tribes = TRIBE_LIST_GAIA

	display_order = JOB_DISPLAY_ORDER_GUARDIAN
	departments_list = list(
		/datum/job_department/gaia,
	)

	known_contacts = list(
		JOB_GAROU_COUNCIL,
		JOB_GAROU_TRUTHCATCHER,
		JOB_GAROU_WARDER,
		JOB_GAROU_WYRMFOE,
		JOB_GAROU_GUARDIAN
	)

/datum/outfit/job/vampire/guardian
	name = JOB_GAROU_GUARDIAN
	jobtype = /datum/job/vampire/guardian

	id = /obj/item/card/park_ranger
	uniform =  /obj/item/clothing/under/vampire/biker
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/baseballcap
	belt = /obj/item/melee/baton/vamp
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/jacket
	l_pocket = /obj/item/smartphone/garou_guardian
	backpack_contents = list(/obj/item/card/credit=1)
