/datum/quirk/darkpack/metamorph
	name = "Metamorph"
	ru_name = "Метаморф"
	desc = "Менять форму для вас так же естественно, как дышать. Вам не нужно проходить проверку, чтобы сменить форму, и не нужно тратить пункт Ярости на мгновенное превращение. Считается, что при смене формы вы получили пять успехов. Если вы теряете сознание от ран или по другой причине, то не возвращаетесь в родную форму, а можете пройти проверку Смекалки + Первобытного инстинкта (сложность 8) и выбрать форму сами."
	ttrpg_sources = list(/datum/source_book/wta20 = 473)
	value = 7
	mob_trait = TRAIT_METAMORPH
	// I love the greg sam. sa
	icon = FA_ICON_BUG
	allowed_splats = SPLAT_SHIFTERS

/datum/storyteller_roll/metamorph
	bumper_text = "метаморф"
	applicable_stats = list(STAT_WITS) // + PRIMAL_URGE
	difficulty = 8
	roll_output_type = ROLL_PRIVATE
