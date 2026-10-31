// Default vampire base type.
/datum/job
	/// The list of alternative job titles people can pick from, null by default.
	var/list/alt_titles = null // ALTERNATIVE_JOB_TITLES

	///List of splats that are allowed to do this job.
	var/list/allowed_splats
	///List of species that are limited to a certain amount of that species doing this job. e.g: list(SPLAT_NONE = -1, SPLAT_GHOUL = -1, SPLAT_KINDRED = -1)
	var/list/splat_slots

	// VTM
	///Minimum vampire Generation necessary to do this job.
	var/minimal_generation = HIGHEST_GENERATION_LIMIT
	//Maximum vampire generation to play the job.
	var/maximal_generation = LOWEST_GENERATION_LIMIT
	///Minimum Masquerade level necessary to do this job.
	var/minimum_masquerade = 0
	/// Character must be at least this age (in years) since embrace (chronological_age - age) to join as role.
	var/minimum_immortal_age = 0
	/// Character must not be over this age (in years) since embrace (chronological_age - age) to join as role. (Defaults null, set to desired age.)
	var/maximum_immortal_age = null
	///List of Clans that are allowed to do this job.
	var/list/allowed_clans
	///List of Clans that are disallowed to do this job.
	var/list/disallowed_clans

	// WTA
	///Minimum Renown Rank necessary to do this job.
	var/minimal_renown_rank
	///List of Tribes that are allowed to do this job.
	var/list/allowed_tribes
	var/list/disallowed_tribes
	///List of Auspices that are allowed to do this job.
	var/list/allowed_auspice
	var/list/disallowed_auspice


	///If this job requires whitelisting before it can be selected for characters.
	var/whitelisted = FALSE
	/// Only for display in memories — AND now used to populate guestbook entries on spawn. // CORVAX EDIT CHANGE - ORIGINAL: /// Only for display in memories
	var/list/known_contacts = null

	///Guestbook flags, to establish who knowns who etc
	var/guestbook_flags = NONE

// Default vampire job outfits.
/datum/outfit/job/vampire
	uniform = /obj/item/clothing/under/vampire/sport
	id = null
	ears = null
	belt = null
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/vampire
	box = null
	pda_slot = null
	var/uses_default_clan_clothes = FALSE

/datum/outfit/job/vampire/pre_equip(mob/living/carbon/human/H, visuals_only)
	. = ..()
	if(uses_default_clan_clothes == TRUE && uniform == initial(uniform))
		var/datum/splat/vampire/kindred/kindred = get_kindred_splat(H)
		if(kindred)
			if(H.jumpsuit_style == PREF_SUIT)
				if(!shoes)
					shoes = /obj/item/clothing/shoes/vampire
				if(kindred.clan.male_clothes && !uniform)
					uniform = kindred.clan.male_clothes
			else
				if(!shoes)
					shoes = /obj/item/clothing/shoes/vampire/heels
				if(kindred.clan.female_clothes && !uniform)
					uniform = kindred.clan.female_clothes
		else
			if(H.jumpsuit_style == PREF_SKIRT)
				if(!shoes)
					shoes = /obj/item/clothing/shoes/vampire
				if(!uniform)
					uniform = /obj/item/clothing/under/vampire/red
			else
				if(!shoes)
					shoes = /obj/item/clothing/shoes/vampire/heels
				if(!uniform)
					uniform = /obj/item/clothing/under/vampire/sport

/datum/job/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!(guestbook_flags & GUESTBOOK_FORGETMENOT))
		for(var/mob/player_mob as anything in GLOB.player_list)
			if((player_mob == spawned) || !player_mob.mind?.assigned_role)
				continue
			var/datum/job/player_mob_job = player_mob.mind.assigned_role
			var/list/common_departments = player_mob_job.departments_list & departments_list //wonky
			//if we satisfy at least one condition, add us to their guestbook
			if(player_mob_job.guestbook_flags & GUESTBOOK_OMNISCIENT || \
				((player_mob_job.guestbook_flags & GUESTBOOK_JOB) && (player_mob_job.type == src.type)) || \
				((player_mob_job.guestbook_flags & GUESTBOOK_DEPARTMENT) && length(common_departments)))
				player_mob.mind.guestbook.add_guest(player_mob, spawned, spawned.mind.name, spawned.mind.name, silent = TRUE)
			//if we satisfy at least one condition, add them to our guestbook
			if(guestbook_flags & GUESTBOOK_OMNISCIENT || \
				((guestbook_flags & GUESTBOOK_JOB) && (src.type == player_mob_job.type)) || \
				((guestbook_flags & GUESTBOOK_DEPARTMENT) && length(common_departments)))
				spawned.mind.guestbook.add_guest(spawned, player_mob, player_mob.mind.name, player_mob.mind.name, silent = TRUE)

	// CORVAX EDIT ADD START
	// Auto-populate guestbook from known_contacts (round-only, not persisted).
	sync_known_contacts_to_guestbook(spawned)
	// CORVAX EDIT ADD END

	var/obj/item/smartphone/phone = locate() in spawned.contents
	if(phone)
		phone.update_initialized_contacts(spawned, player_client)

// CORVAX EDIT ADD START
/**
 * Adds contacts from this job's known_contacts list to the spawning player's guestbook,
 * and additionally adds the spawning player to the guestbooks of anyone who has this job's
 * title in their own known_contacts.
 *
 * Bidirectional: covers both "I know them because they're my contact" and "they know me
 * because I'm THEIR contact". Entries are temporary — stored in temporary_known_names,
 * which is not persisted to disk, so unrenamed auto-entries vanish at round end.
 *
 * Called from /datum/job/after_spawn. When a contact joins later, their own after_spawn
 * performs the reverse check and adds them to our guestbook for the round.
 */
/datum/job/proc/sync_known_contacts_to_guestbook(mob/living/spawned)
	if(!ishuman(spawned))
		return
	var/mob/living/carbon/human/spawned_human = spawned
	if(!spawned_human.mind?.guestbook)
		return

	var/datum/guestbook/spawned_guestbook = spawned_human.mind.guestbook

	for(var/mob/player_mob as anything in GLOB.player_list)
		if(player_mob == spawned_human || !player_mob.mind?.assigned_role || !player_mob.mind?.guestbook)
			continue
		if(!ishuman(player_mob))
			continue

		var/mob/living/carbon/human/other = player_mob
		var/datum/job/other_job = other.mind.assigned_role

		// 1) spawned knows others whose jobs are listed in spawned's known_contacts.
		if(LAZYLEN(known_contacts) && (other_job.title in known_contacts))
			spawned_guestbook.add_guest(
				spawned_human, other,
				other.real_name, other.real_name,
				silent = TRUE, temporary = TRUE,
			)

		// 2) others know spawned if spawned's job title is listed in their known_contacts.
		if(LAZYLEN(other_job.known_contacts) && (title in other_job.known_contacts))
			other.mind.guestbook.add_guest(
				other, spawned_human,
				spawned_human.real_name, spawned_human.real_name,
				silent = TRUE, temporary = TRUE,
			)
// CORVAX EDIT ADD END

/datum/job/vampire
	abstract_type = /datum/job/vampire
	exp_required_type = EXP_TYPE_PLAYTIME
	exp_granted_type = EXP_TYPE_PLAYTIME
	tgui_icon = FA_ICON_QUESTION

// CORVAX EDIT START
// gen	Fledgling/Neonate 0-100, 	Ancilla 101-200, 	 Elder 201+.
// age			  Neonate 12-14, 	Ancilla 10-11,		 Elder 6-9.
#define V20_JOB_TIER_ELDER "elder"
#define V20_JOB_TIER_ANCILLA "ancilla"
#define V20_JOB_TIER_NEONATE "neonate"

/// Authoritative V20 restriction tiers.
GLOBAL_LIST_INIT(v20_job_tiers, list(
	// Camarilla
	/datum/job/vampire/prince = V20_JOB_TIER_ELDER,
	/datum/job/vampire/clerk = V20_JOB_TIER_ELDER,
	/datum/job/vampire/sheriff = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/harpy = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/hound = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/primogen_banu = V20_JOB_TIER_ELDER,
	/datum/job/vampire/primogen_brujah = V20_JOB_TIER_ELDER,
	/datum/job/vampire/primogen_lasombra = V20_JOB_TIER_ELDER,
	/datum/job/vampire/primogen_malkavian = V20_JOB_TIER_ELDER,
	/datum/job/vampire/primogen_nosferatu = V20_JOB_TIER_ELDER,
	/datum/job/vampire/primogen_toreador = V20_JOB_TIER_ELDER,
	/datum/job/vampire/primogen_ventrue = V20_JOB_TIER_ELDER,
	/datum/job/vampire/towerwork = V20_JOB_TIER_NEONATE,
	// Anarchs
	/datum/job/vampire/baron = V20_JOB_TIER_ELDER,
	/datum/job/vampire/emissary = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/bruiser = V20_JOB_TIER_NEONATE,
	/datum/job/vampire/sweeper = V20_JOB_TIER_NEONATE,
	// Tremere
	/datum/job/vampire/regent = V20_JOB_TIER_ELDER,
	/datum/job/vampire/archivist = V20_JOB_TIER_ANCILLA,
	// Giovanni
	/datum/job/vampire/capo = V20_JOB_TIER_ELDER,
	/datum/job/vampire/nonni = V20_JOB_TIER_ELDER,
	/datum/job/vampire/squadra = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/famiglia = V20_JOB_TIER_NEONATE,
	// Sabbat
	/datum/job/vampire/sabbatductus = V20_JOB_TIER_ELDER,
	/datum/job/vampire/sabbatpriest = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/sabbatpack = V20_JOB_TIER_NEONATE,
	// Tzimisce
	/datum/job/vampire/voivode = V20_JOB_TIER_ELDER,
	/datum/job/vampire/bogatyr = V20_JOB_TIER_ANCILLA,
	// City roles open to Kindred
	/datum/job/vampire/clinic_director = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/doctor = V20_JOB_TIER_NEONATE,
	/datum/job/vampire/clinic_guard = V20_JOB_TIER_NEONATE,
	/datum/job/vampire/priest = V20_JOB_TIER_ANCILLA,
	/datum/job/vampire/club_worker = V20_JOB_TIER_NEONATE,
	/datum/job/vampire/citizen = V20_JOB_TIER_NEONATE,
	/datum/job/vampire/janitor = V20_JOB_TIER_NEONATE,
	/datum/job/vampire/supply = V20_JOB_TIER_NEONATE,
	/datum/job/vampire/dealer = V20_JOB_TIER_NEONATE,
))

/datum/job/vampire/New()
	. = ..()
	apply_v20_job_tier()

/datum/job/vampire/proc/apply_v20_job_tier()
	switch(GLOB.v20_job_tiers[type])
		if(V20_JOB_TIER_ELDER)
			minimal_generation = 9
			maximal_generation = 6
			minimum_immortal_age = 201
			maximum_immortal_age = null
		if(V20_JOB_TIER_ANCILLA)
			minimal_generation = 11
			maximal_generation = 10
			minimum_immortal_age = 101
			maximum_immortal_age = 200
		if(V20_JOB_TIER_NEONATE)
			minimal_generation = 14
			maximal_generation = 12
			minimum_immortal_age = 0
			maximum_immortal_age = 100
	if(type == /datum/job/vampire/gargoyle)
		minimal_generation = 10
		maximal_generation = 8
		minimum_immortal_age = 0
		maximum_immortal_age = 842
// CORVAX EDIT END

/**
 * This type is used to indicate a lack of a job.
 * The mind variable assigned_role will point here by default.
 * As any other job datum, this is a singleton.
 **/

/datum/job/vampire/unassigned
	title = JOB_ORDINARY_CITIZEN
	rpg_title = "Peasant"


/// Returns information pertaining to this job's radio.
/datum/job/vampire/get_radio_information()
	return

/datum/job/vampire/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	spawned.add_faction(faction)
