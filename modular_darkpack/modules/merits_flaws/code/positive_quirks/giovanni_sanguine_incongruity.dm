/datum/quirk/darkpack/giovanni_sanguine_incongruity
	name = "Sanguine Incongruity"
	ru_name = "Кровное несоответствие"
	desc = "Вы несёте проклятие мертвенной бледности и трупного облика, унаследованное от крови Каппадокийцев, которой клан был до узурпации. В клане к такому джованни относятся снисходительнее: он либо старейшина, получивший Становление ещё до диаблери, либо ближе к Смерти, чем прочие, а это по клановому поверью сулит большую силу в Некромантии. Кроме того, на вас не действует Проклятие Ламии - сверхъестественно болезненный укус, который так мешает Джованни кормиться. Это достоинство доступно только Джованни."
	ttrpg_sources = list(/datum/source_book/vtm20/lotc = 106)
	value = 5
	mob_trait = TRAIT_SANGUINE_INCONGRUITY
	gain_text = span_notice("Проклятие Ламии покидает ваше тело, и вы можете кормиться как обычно, но кожа бледнеет и становится похожа на кожу трупа.")
	lose_text = span_notice("Проклятие Ламии почему-то возвращается, и ваш укус становится куда болезненнее. Зато кожа снова выглядит живой.")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_GIOVANNI)
	icon = FA_ICON_SKULL_CROSSBONES
	failure_message = "Проклятие Ламии почему-то возвращается, и ваш укус становится куда болезненнее. Зато кожа снова выглядит живой."


/datum/quirk/darkpack/giovanni_sanguine_incongruity/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return

	var/datum/splat/vampire/kindred/kindred = get_kindred_splat(human_holder)
	if(kindred)
		if(istype(kindred.clan, /datum/subsplat/vampire_clan/giovanni))
			REMOVE_TRAIT(human_holder, TRAIT_PAINFUL_VAMPIRE_KISS, SUBSPLAT_TRAIT)

			if(human_holder.chronological_age >= 300)
				human_holder.rot_body(2)
			else
				human_holder.rot_body(1)

