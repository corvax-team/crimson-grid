/datum/subsplat/vampire_clan/gangrel
	name = "Gangrel"
	ru_name = "Гангрел"
	id = VAMPIRE_CLAN_GANGREL
	desc = "Гангрелы ближе к зверям, чем прочие вампиры, и считают себя высшими хищниками. Эти Дикари рыщут по глухим местам так же уверенно, как по городским джунглям, и ни один клан не сравнится с ними в умении выстоять, выжить и освоиться где угодно. Они ревниво стерегут свою территорию, а их способность менять облик заставляет призадуматься даже немёртвых. Гангрелы - странники и хищники, привыкшие выживать где угодно и тесно связанные со своими инстинктами и со Зверем. Клан официально покинул Камарилью много лет назад, но в ней осталось достаточно старейшин-гангрелов, чтобы сохранять влияние. Жёсткой политики Гангрелы сторонятся: независимость и практическая сила для них важнее статуса. Из-за кланового изъяна после Безумия в их облике проступают звериные черты, и постепенно они всё меньше походят на людей."
	icon = "gangrel"
	curse = "Начинают с пониженной Человечностью."
	roleplay_level = "Для новичков"
	sense_the_sin_text = "не в силах совладать со своими порывами."
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/fortitude,
		/datum/discipline/protean
	)
	male_clothes = /obj/item/clothing/under/vampire/gangrel
	female_clothes = /obj/item/clothing/under/vampire/gangrel/female
	clan_marks = list(
		/datum/bodypart_overlay/simple/clan_mark/beast_legs,
		/datum/bodypart_overlay/simple/clan_mark/beast_tail,
		/datum/bodypart_overlay/simple/clan_mark/beast_tail_and_legs,
	)

/datum/subsplat/vampire_clan/gangrel/city
	name = "City Gangrel"
	ru_name = "Городские Гангрелы"
	desc = "Городские Гангрелы - линия крови Шабаша, отколовшаяся от исконных Гангрелов. Они обжили города и с помощью своих особых Дисциплин - Стремительности (скорость) и Сокрытия (сверхъестественная способность прятаться) - выслеживают очередную жертву в переулках, на крышах и в канализации бок о бок с собратьями по стае."
	id = VAMPIRE_CLAN_CITY_GANGREL
	icon = "city_gangrel"
	roleplay_level = "Для новичков"
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/obfuscate,
		/datum/discipline/protean
	)
