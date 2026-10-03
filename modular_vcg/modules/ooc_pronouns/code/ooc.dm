#define MAX_PRONOUNS 5
// This list is non-exhaustive
GLOBAL_LIST_INIT(pronouns_valid, list(
	"he", "him", "his",
	"she","her","hers",
	"hyr", "hyrs",
	"they", "them", "their","theirs",
	"it", "its",
	"any", "all",
	"xey", "xe", "xem", "xyr", "xyrs",
	"ze", "zir", "zirs",
	"ey", "em", "eir", "eirs",
	"fae", "faer", "faers",
	"ve", "ver", "vis", "vers",
	"ne", "nem", "nir", "nirs",
	"он", "его", "ему",
	"она", "её", "ее", "ей",
	"оно",
	"они", "их", "им",
	"любые", "все",
))

// examples:
// "she/fae"
// "she/fae - small comment"
// "she/her/they - sysadmin"
// "they/ve - sysadmin"

// at least ONE is required
GLOBAL_LIST_INIT(pronouns_required, list(
	"he", "her", "she", "they", "them", "fae", "faer", "it", "its", "any", "all",
	"он", "его", "она", "её", "ее", "оно", "они", "их", "любые", "все",
))

/datum/preference/text/ooc_pronouns
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "oocpronouns"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/text/ooc_pronouns/create_default_value()
	return ""

/datum/preference/text/ooc_pronouns/is_valid(value)
	value = LOWER_TEXT(value)

	if (!value || trim(value) == "")
		return TRUE

	var/regex/reg = regex(@"^[a-zа-яА-ЯёЁ/]+", "i")
	reg.Find(value)
	if (!length(reg.match))
		to_chat(usr, span_warning("Местоимения не найдены. Проверьте, что они разделены косой чертой (/) и состоят только из русских или английских букв."))
		return FALSE
	var/pronouns = splittext(reg.match, "/")
	if (length(pronouns) > MAX_PRONOUNS)
		to_chat(usr, span_warning("Можно указать не больше [MAX_PRONOUNS] разных местоимений."))
		return FALSE


	for (var/pronoun in pronouns)
		// while parsing, remove common suffixes

		if (endswith(pronoun, "s"))
			pronoun = copytext(pronoun, 1, length(pronoun) - 1)
		if (endswith(pronoun, "self"))
			pronoun = copytext(pronoun, 1, length(pronoun) - 4)
		pronoun = trim(pronoun)

		if (!(pronoun in GLOB.pronouns_valid))
			to_chat(usr, span_warning("Недопустимое местоимение: [pronoun]. Допустимые местоимения: [GLOB.pronouns_valid.Join(", ")]"))
			return FALSE

	if (length(pronouns) != length(unique_list(pronouns)))
		to_chat(usr, span_warning("Одно и то же местоимение нельзя указывать дважды."))
		return FALSE

	for (var/pronoun in GLOB.pronouns_required)
		if (pronoun in pronouns)
			return TRUE

	to_chat(usr, span_warning("Укажите хотя бы одно из этих местоимений: [GLOB.pronouns_required.Join(", ")]"))
	// Someone may yell at me i dont know
	return FALSE

#undef MAX_PRONOUNS
