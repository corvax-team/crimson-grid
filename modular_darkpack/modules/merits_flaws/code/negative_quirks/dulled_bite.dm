/datum/quirk/darkpack/dulled_bite
	name = "Dulled Bite"
	ru_name = "Тупые клыки"
	desc = "Ваши клыки почему-то не выросли до конца или не появились вовсе. Чтобы покормиться, вам придётся пускать кровь как-то иначе. Этот недостаток часто встречается у каитифов и вампиров высоких поколений."
	ttrpg_sources = list(/datum/source_book/vtm20 = 481)
	value = -2
	mob_trait = TRAIT_DULLFANGS
	gain_text = span_notice("Ваши клыки затупились.")
	lose_text = span_notice("Ваши клыки снова остры.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_TEETH
	failure_message = "Ваши клыки снова остры."
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/status_effect/dull_fangs // Applied when pliers are used on vampires without the dulled bite quirk.
	id = "dulled_fangs"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 SCENES // Around 30 minutes
	remove_on_fullheal = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/dull_fangs

/atom/movable/screen/alert/status_effect/dull_fangs
	name = "Вырванные клыки"
	desc = "Вам выдрали клыки!"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "default"

/datum/status_effect/dull_fangs/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_DULLFANGS, TRAIT_GENERIC)

/datum/status_effect/dull_fangs/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_DULLFANGS, TRAIT_GENERIC)

/datum/status_effect/dull_fangs/permanent // Applied when pliers are used on vampires without the dulled bite quirk.
	id = "dulled_fangs_permanent"
	status_type = STATUS_EFFECT_UNIQUE
	duration = -1 // Lasts all round.
	remove_on_fullheal = FALSE // Doesn't remove on fullheal.
	alert_type = /atom/movable/screen/alert/status_effect/dull_fangs
