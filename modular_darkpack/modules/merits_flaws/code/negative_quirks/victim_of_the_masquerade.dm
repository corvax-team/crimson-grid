/datum/quirk/darkpack/victim_of_the_masquerade
	name = "Victim of the Masquerade"
	ru_name = "Жертва Маскарада"
	desc = "Пропаганда Камарильи потрудилась над вами на славу. Даже после Становления ваш персонаж отказывается верить, что стал вампиром. Он убеждён, что его состоянию есть логичное объяснение, и тратит уйму времени на поиски оправданий. Каждый раз, когда вы кормитесь, и с каждым пунктом крови, выпитым у жертвы, вы проходите проверку Воли. При неудаче персонаж на пять секунд теряет сознание и лишается пункта Человечности. От вас ждут отыгрыша этого недостатка: например, персонаж упорно ест обычную еду и отказывается пить кровь."
	ttrpg_sources = list(/datum/source_book/vtm20 = 486)
	value = -2
	mob_trait = TRAIT_VICTIM_OF_THE_MASQUERADE
	gain_text = span_notice("Пф, я не вампир. Их не существует.")
	lose_text = span_notice("Возможно, я всё-таки вампир.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_DIZZY
	failure_message = "Возможно, я всё-таки вампир."
	var/datum/storyteller_roll/victim_of_the_masquerade/victim_of_the_masquerade_roll
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/storyteller_roll/victim_of_the_masquerade
	bumper_text = "жертва Маскарада"
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	difficulty = 6
	roll_output_type = ROLL_PRIVATE
