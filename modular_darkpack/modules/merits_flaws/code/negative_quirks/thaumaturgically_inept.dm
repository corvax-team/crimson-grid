/datum/quirk/darkpack/thaumaturgically_inept
	name = "Thaumaturgically Inept"
	ru_name = "Неспособность к Тауматургии"
	desc = "Что-то в вас не откликается на Тауматургию. Она вам просто не даётся. Тауматургия будет полностью удалена при входе в игру."
	value = -5
	icon = FA_ICON_BAN
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/thaumaturgically_inept/add(client/client_source)
	var/datum/splat/vampire/kindred/kindred_splat = get_kindred_splat(quirk_holder)
	if(!kindred_splat)
		return
	kindred_splat.remove_power(/datum/discipline/thaumaturgy)
