/datum/job/vampire/capo
	title = JOB_CAPO
	faction = FACTION_GIOVANNI
	total_positions = 1
	spawn_positions = 1
	supervisors = "Семьёй и Традициями"
	config_tag = "CAPO"
	outfit = /datum/outfit/job/vampire/capo
	job_flags = CITY_JOB_FLAGS
	display_order = 1
	departments_list = list(
		/datum/job_department/giovanni,
	)

	exp_required_type_department = EXP_TYPE_GIOVANNI
	exp_requirements = EXP_REQ_HEAD

	known_contacts = list(
		JOB_LA_FAMIGLIA,
		JOB_LA_SQUADRA,
		JOB_PRINCE,
		JOB_SENESCHAL,
		JOB_SHERIFF,
		JOB_BARON,
		JOB_EMISSARY
	)

	description = "В ваших жилах течёт чистая кровь, а с ней и древняя сила. За долгую жизнь вы научились держаться за две вещи и никогда их не отпускать: за деньги и за семью."
	minimum_masquerade = 0
	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_GIOVANNI)

/datum/outfit/job/vampire/capo
	name = JOB_CAPO
	jobtype = /datum/job/vampire/capo

	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/smartphone/giovanni_capo
	r_pocket = /obj/item/vamp/keys/capo
	backpack_contents = list(/obj/item/card/credit/giovanniboss=1, /obj/item/ritual_tome/necromancy=1, /obj/item/vamp/keys/graveyard = 1)

/datum/memory/key/bank_vault_code
	var/remembered_code

/datum/memory/key/bank_vault_code/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	remembered_code,
)
	src.remembered_code = remembered_code
	return ..()

/datum/memory/key/bank_vault_code/get_names()
	return list("Код от банковского хранилища - [remembered_code].")

/datum/memory/key/bank_vault_code/get_starts()
	return list(
		"[protagonist_name] выпаливает [remembered_code] и тут же нервно озирается. А можно ли было это говорить?.."
	)

/datum/job/vampire/capo/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/obj/structure/vaultdoor/pincode/bank/door = locate() in GLOB.vault_doors
	if(door)
		spawned.mind.add_memory(/datum/memory/key/bank_vault_code, remembered_code = door.pincode)
