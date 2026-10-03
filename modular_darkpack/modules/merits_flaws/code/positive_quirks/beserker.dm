/datum/quirk/darkpack/beserker
	name = "Berserker"
	ru_name = "Берсерк"
	desc = "Вы на редкость хорошо владеете своим гневом и можете использовать Ярость так, как большинству гару не дано. Вы способны по своей воле впасть в бешенство берсерка и не замечать штрафов от ран. За всё, что вы натворите в бешенстве, отвечать придётся вам. Если обстоятельства могут вызвать бешенство, вы проходите обычную проверку."
	ttrpg_sources = list(/datum/source_book/wta20 = 476)
	value = 2
	icon = FA_ICON_ANGRY
	allowed_splats = SPLAT_SHIFTERS

/datum/quirk/darkpack/beserker/add(client/client_source)
	. = ..()
	add_verb(quirk_holder, /mob/living/carbon/human/proc/manual_frenzy)

/datum/quirk/darkpack/beserker/remove()
	. = ..()
	remove_verb(quirk_holder, /mob/living/carbon/human/proc/manual_frenzy)
