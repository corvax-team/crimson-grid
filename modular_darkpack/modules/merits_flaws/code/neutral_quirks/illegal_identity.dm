// Homebrew?
/datum/quirk/darkpack/illegal_identity
	name = "Illegal Identity"
	ru_name = "Без документов"
	desc = "Нелегальный иммигрант? Официально мертвы? Родились волком? Полиция от вас не в восторге."
	ttrpg_sources = list(/datum/source_book/homebrew = WE_MADE_IT_UP)
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	icon = FA_ICON_PERSON_CIRCLE_QUESTION
	mob_trait = TRAIT_ILLEGAL_IDENTITY
	gain_text = span_warning("С документами у вас всё плохо.")
	lose_text = span_notice("С документами у вас полный порядок.")
	medical_record_text = "Пациент поступил без действительного удостоверения личности."
	//excluded_clans = list(VAMPIRE_CLAN_RAVNOS) // They are forced to take this
	failure_message = "О, а вот и мои настоящие документы, просто завалялись не там..."

/datum/quirk/darkpack/illegal_identity/add()
	. = ..()
	var/mob/living/carbon/human/criminal = astype(quirk_holder)
	if(!criminal)
		return

	var/obj/item/passport/passport = locate() in criminal // In pockets
	if(!passport && criminal.back)
		passport = locate() in criminal.back // In backpack
	if(passport && passport.owner == criminal.real_name)
		passport.link_human(criminal)
	//drivers license too
	var/obj/item/card/drivers_license/license = locate() in criminal // In pockets
	if(!license && criminal.back)
		license = locate() in criminal.back // In backpack
	if(license)
		license.link_human(criminal)
