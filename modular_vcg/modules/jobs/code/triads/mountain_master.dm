/datum/job/vampire/mountain_master
	title = JOB_MOUNTAIN_MASTER
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "собой и больше ни перед кем"
	config_tag = "MOUNTAIN_MASTER"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/mountain_master

	display_order = JOB_DISPLAY_ORDER_MOUNTAIN_MASTER
	exp_required_type_department = EXP_TYPE_TRIAD
	departments_list = list(
		/datum/job_department/triad,
	)

	known_contacts = list(
		JOB_DEPUTY_MOUNTAIN_MASTER,
		JOB_TRIAD_RED_POLE,
		JOB_TRIAD_BLUE_LANTERNS,
		JOB_DEALER
	)
	allowed_splats = list(SPLAT_NONE)
	description = "Вы глава Триады, тайной преступной организации. На вас все её дела и верность подчинённых."
	minimum_masquerade = 3

/datum/outfit/job/vampire/mountain_master
	name = JOB_MOUNTAIN_MASTER
	jobtype = /datum/job/vampire/mountain_master
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/smartphone/mountain_master
	r_pocket = /obj/item/vamp/keys/triads
	backpack_contents = list(/obj/item/card/credit/rich=1, /obj/item/knife/vamp)
