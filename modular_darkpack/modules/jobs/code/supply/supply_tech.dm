/datum/job/vampire/supply
	title = "Supply Technician"
	faction = FACTION_CITY
	total_positions = 8
	spawn_positions = 8
	supervisors = "Дельцом"
	config_tag = "SUPPLY"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/supply_tech


	display_order = JOB_DISPLAY_ORDER_SUPPLY
	departments_list = list(
		/datum/job_department/supply,
	)


	description = "Вы работаете на складе: таскаете ящики и продаёте не вполне законный товар любому, у кого есть деньги."
	maximal_generation = 9
	maximum_immortal_age = 200
	minimum_masquerade = 0

	known_contacts = list(
		JOB_DEALER
	)

/datum/outfit/job/vampire/supply_tech
	name = JOB_SUPPLY_TECH
	jobtype = /datum/job/vampire/supply
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/supplytech
	l_pocket = /obj/item/smartphone/supply_tech
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/card/credit=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/knife/vamp)
