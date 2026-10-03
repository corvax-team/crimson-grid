// VTM pg. 482-483
/datum/quirk/darkpack/permanent_wound
	name = "Permanent Wound"
	ru_name = "Незаживающая рана"
	desc = "Во время Становления вы получили рану, которую преображение почему-то не исцелило. Каждую ночь вы просыпаетесь с тяжёлыми ранами."
	value = -3
	gain_text = span_notice("Незажившая рана ноет.")
	lose_text = span_notice("Вы больше не чувствуете боли от раны.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_USER_INJURED
	failure_message = span_notice("Вы больше не чувствуете боли от раны.")
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/*You suffered injuries during your Embrace which your transformation somehow failed to repair.
At the beginning of each night,
you rise from sleep at the Wounded health level, though this may be healed by spending blood points.*/

/datum/quirk/darkpack/permanent_wound/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.adjust_agg_loss(90, TRUE)
