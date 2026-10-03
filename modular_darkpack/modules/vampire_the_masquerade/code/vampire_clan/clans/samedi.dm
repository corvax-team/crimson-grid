/datum/subsplat/vampire_clan/samedi
	name = "Samedi"
	ru_name = "Самеди"
	id = VAMPIRE_CLAN_SAMEDI
	desc = "Редкая линия крови Ходячих Мертвецов, которая ведёт начало от загадочного основателя, известного просто как Барон Самеди."
	curse = "Облик насквозь прогнившего трупа. Самый настоящий ходячий зомби."
	icon = "samedi"
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/fortitude,
		/datum/discipline/thanatosis
	)
	alt_sprite = "rotten4"
	subsplat_traits = list(
		TRAIT_MASQUERADE_VIOLATING_FACE
	)
	whitelisted = TRUE

/datum/subsplat/vampire_clan/samedi/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	gaining_mob.rot_body(4)
