/datum/persistent_client
	/// Patreon data for this player.
	var/datum/patreon_data/patreon
	/// Twitch subscription data for this player.
	var/datum/twitch_data/twitch

/client/proc/is_donator()
	if(persistent_client?.patreon?.has_access(ACCESS_ASSISTANT_RANK))
		return TRUE
	if(persistent_client?.twitch?.has_access(ACCESS_TWITCH_SUB_TIER_1))
		return TRUE
	return FALSE

/datum/persistent_client/proc/is_donator()
	if(patreon?.has_access(ACCESS_ASSISTANT_RANK))
		return TRUE
	if(twitch?.has_access(ACCESS_TWITCH_SUB_TIER_1))
		return TRUE
	return FALSE

/datum/persistent_client/New(ckey, client)
	. = ..()
	patreon = new(ckey, src)
	twitch = new(ckey, src)

/datum/preferences
	/// If our owner is patreon or twitch sub
	var/donator = FALSE

/datum/preferences/refresh_membership()
	. = ..()
	donator = parent?.persistent_client?.is_donator()

	if(donator)
		max_save_slots += CONFIG_GET(number/extra_save_slots_donator)

/datum/preference/text/headshot/is_valid(value)
	var/patreon_link = CONFIG_GET(string/patreon_link)
	var/twitch_link = CONFIG_GET(string/twitch_link)
	if(!usr?.client?.is_donator())
		// split into multiple lines for easier reading
		var/notice = "Портрет доступен только донатерам. Ссылка сохранится, но другие игроки увидят портрет, только если вы " + \
			"[patreon_link ? "<a href='[patreon_link]'>": ""]поддерживаете нас на Patreon[patreon_link ? "</a>": ""] или " + \
			"[twitch_link ? "<a href='[twitch_link]'>": ""]подписаны на Twitch[twitch_link ? "</a>": ""]."
		to_chat(usr, span_boldnotice(notice))
	. = ..()

/datum/examine_panel/ui_data(mob/user)
	. = ..()
	if(.["headshot"] && !(holder?.client?.is_donator()))
		.["headshot"] = null

/datum/preference/toggle/twitch_public
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "twitch_public"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/twitch_public/is_accessible(datum/preferences/preferences)
	if(preferences.parent?.persistent_client?.twitch?.access_rank < 1)
		return FALSE
	return ..()

/datum/preference/toggle/patreon_public
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "patreon_public"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/patreon_public/is_accessible(datum/preferences/preferences)
	if(preferences.parent?.persistent_client?.patreon?.access_rank < 1)
		return FALSE
	return ..()
