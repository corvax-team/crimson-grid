/datum/quirk/darkpack/forked_tongue
	name = "Forked Tongue"
	ru_name = "Раздвоенный язык"
	desc = "У вас раздвоенный язык, поэтому звук \"с\" вы произносите с шипением."
	icon = FA_ICON_S
	value = -1
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_WARRIOR_SETITE, VAMPIRE_CLAN_TLACIQUE)
	/// The original tongue from before the forked one was applied
	var/obj/item/organ/old_organ

/datum/quirk/darkpack/forked_tongue/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	old_organ = human_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	var/obj/item/organ/tongue/lizard/forked = new
	forked.Insert(human_holder, special = TRUE)
	if(old_organ)
		old_organ.moveToNullspace()
		STOP_PROCESSING(SSobj, old_organ)

/datum/quirk/darkpack/forked_tongue/remove()
	if(old_organ)
		old_organ.Insert(quirk_holder, special = TRUE)
	old_organ = null

/datum/quirk/darkpack/permafangs/fake
	name = "Cosmetic Fangs"
	ru_name = "Бутафорские клыки"
	desc = "Вы подпилили зубы или носите накладки, и теперь кажется, что у вас во рту клыки. Многие сочтут это экзотикой или причудой, но кое-кто из суеверных увидит в них нечто большее..."
	value = -1
	gain_text = span_notice("Вы чувствуете, как ваши зубы заостряются")
	lose_text = span_notice("Вы чувствуете, как зубы снова становятся обычными.")
	allowed_splats = list(SPLAT_NONE, SPLAT_GHOUL)
	failure_message = "Вы чувствуете, как зубы снова становятся обычными."

/datum/quirk/darkpack/homestuck
	name = "Home Stuck"
	ru_name = "Хоумстак"
	desc = "Окружающим трудно разобрать вашу речь."
	value = 0
	icon = FA_ICON_HOUSE_USER
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL)
	included_clans = list(VAMPIRE_CLAN_MALKAVIAN)

/datum/quirk/darkpack/homestuck/add(client/client_source)
	quirk_holder.AddComponent(/datum/component/speechmod, replacements = list("a"="4", "A"="4", "i"="1", "I"="1", "e"="3", "E"="3", "а"="4", "А"="4", "и"="1", "И"="1", "е"="3", "Е"="3"), uppercase = TRUE)

/datum/quirk/darkpack/ghoul_armblade
	name = "Armblade"
	ru_name = "Костяной клинок"
	desc = "С помощью Преображения в одной из ваших рук спрятан ужасающе острый костяной клинок."
	value = 5
	icon = FA_ICON_PERSON_RIFLE
	allowed_splats = list(SPLAT_GHOUL)
	included_clans = list(VAMPIRE_CLAN_TZIMISCE)

/datum/quirk/darkpack/ghoul_armblade/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/cyberimp/arm/toolkit/tzimisce/arm_blade = new()
	arm_blade.Insert(human_holder)
