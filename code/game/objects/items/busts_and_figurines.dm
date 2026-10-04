/obj/item/statuebust
	name = "bust"
	desc = "Бесценный античный мраморный бюст. Таким место в музее." //or you can hit people with it
	icon = 'icons/obj/art/statue.dmi'
	icon_state = "bust"
	force = 15
	throwforce = 10
	throw_speed = 5
	throw_range = 2
	attack_verb_continuous = list("busts")
	attack_verb_simple = list("bust")
	var/impressiveness = 45

/obj/item/statuebust/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/art, impressiveness)
	AddElement(/datum/element/beauty, 1000)

/obj/item/statuebust/hippocratic
	name = "hippocrates bust"
	desc = "Бюст знаменитого греческого врача Гиппократа Косского, которого часто называют отцом западной медицины."
	icon_state = "hippocratic"
	impressiveness = 50
	// If it hits the prob(reference_chance) chance, this is set to TRUE. Adds medical HUD when wielded, but has a 10% slower attack speed and is too bloody to make an oath with.
	var/reference = FALSE
	// Chance for above.
	var/reference_chance = 1
	// Minimum time inbetween oaths.
	COOLDOWN_DECLARE(oath_cd)

/obj/item/statuebust/hippocratic/evil
	reference_chance = 100

/obj/item/statuebust/hippocratic/Initialize(mapload)
	. = ..()
	if(prob(reference_chance))
		name = "Solemn Vow"
		desc = "Art lovers will cherish the bust of Hippocrates, commemorating a time when medics still thought doing no harm was a good idea."
		attack_speed = CLICK_CD_SLOW
		reference = TRUE

/obj/item/statuebust/hippocratic/examine(mob/user)
	. = ..()
	if(reference)
		. += span_notice("You could activate the bust in-hand to swear or forswear a Hippocratic Oath... but it seems like somebody decided it was more of a Hippocratic Suggestion. This thing is caked with bits of blood and gore.")
		return
	. += span_notice("Возьмите бюст в руку и используйте, чтобы принести клятву Гиппократа или отречься от неё! Это даст только пацифизм и повод похвастаться. Пацифизм из других источников не снимает. Не есть.")

/obj/item/statuebust/hippocratic/equipped(mob/living/carbon/human/user, slot)
	..()
	if(!(slot & ITEM_SLOT_HANDS))
		return
	ADD_TRAIT(user, TRAIT_MEDICAL_HUD, type)

/obj/item/statuebust/hippocratic/dropped(mob/living/carbon/human/user)
	..()
	if(HAS_TRAIT_NOT_FROM(user, TRAIT_MEDICAL_HUD, type))
		return
	REMOVE_TRAIT(user, TRAIT_MEDICAL_HUD, type)

/obj/item/statuebust/hippocratic/attack_self(mob/user)
	if(!iscarbon(user))
		to_chat(user, span_warning("You remember how the Hippocratic Oath specifies 'my fellow human beings' and realize that it's completely meaningless to you."))
		return

	if(reference)
		to_chat(user, span_warning("As you prepare yourself to swear the Oath, you realize that doing so on a blood-caked bust is probably not a good idea."))
		return

	if(!COOLDOWN_FINISHED(src, oath_cd))
		to_chat(user, span_warning("Вы совсем недавно клялись или отрекались, передумывать рано. Бюст смотрит на вас с отвращением."))
		return

	COOLDOWN_START(src, oath_cd, 5 MINUTES)

	if(HAS_TRAIT_FROM(user, TRAIT_PACIFISM, type))
		to_chat(user, span_warning("Клятву вы уже дали. Вы готовитесь от неё отречься..."))
		if(do_after(user, 5 SECONDS, target = user))
			user.say("Да уж, с этим 'Гиппопотамом' ничего не вышло. Я ухожу!", forced = "hippocratic hippocrisy")
			REMOVE_TRAIT(user, TRAIT_PACIFISM, type)

	// they can still do it for rp purposes
	if(HAS_TRAIT_NOT_FROM(user, TRAIT_PACIFISM, type))
		to_chat(user, span_warning("Вы и так никому не желаете зла, клятва ничего не изменит!"))


	to_chat(user, span_notice("Вы вспоминаете слова клятвы Гиппократа и готовитесь их произнести..."))
	if(do_after(user, 4 SECONDS, target = user))
		user.say("Я клянусь выполнять, наилучшим образом, в соответствии с моими способностями и суждением, этот завет:", forced = "hippocratic oath")
	else
		return fuck_it_up(user)
	if(do_after(user, 2 SECONDS, target = user))
		user.say("Я буду применять все необходимые меры на благо больных, избегая двух крайностей: чрезмерного ухода и терапевтического нигилизма.", forced = "hippocratic oath")
	else
		return fuck_it_up(user)
	if(do_after(user, 3 SECONDS, target = user))
		user.say("Я буду помнить, что остаюсь членом общества, у которого есть особые обязательства по отношению ко всем моим собратьям - как к здоровым душой и телом, так и к немощным.", forced = "hippocratic oath")
	else

		return fuck_it_up(user)
	if(do_after(user, 3 SECONDS, target = user))
		user.say("Если я не нарушу эту клятву, пусть я буду наслаждаться жизнью и искусством, меня будут уважать, пока я жив, и вспоминать с любовью после этого. Пусть мои действия всегда будут направлены на сохранение лучших традиций моего призвания, и пусть я долго буду испытывать радость от исцеления тех, кто обращается ко мне за помощью.", forced = "hippocratic oath")
	else
		return fuck_it_up(user)

	to_chat(user, span_notice("С последними словами клятвы на вас нисходят покой, ясность и смысл. На миг вы задумываетесь о том, каково это, причинять вред, и вас передёргивает."))
	ADD_TRAIT(user, TRAIT_PACIFISM, type)

// Bully the guy for fucking up.
/obj/item/statuebust/hippocratic/proc/fuck_it_up(mob/living/carbon/user)
	to_chat(user, span_warning("Вы, как последний болван, забыли, что там дальше. Бюст Гиппократа смотрит на вас с разочарованием."))
	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2)
	COOLDOWN_RESET(src, oath_cd)

/obj/item/maneki_neko
	name = "Maneki-Neko"
	desc = "A figurine of a cat holding a coin, said to bring fortune and wealth, and perpetually moving its paw in a beckoning gesture."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "maneki-neko"
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb_continuous = list("bashes", "beckons", "hit")
	attack_verb_simple = list("bash", "beckon", "hit")

/obj/item/maneki_neko/Initialize(mapload)
	. = ..()
	//Not compatible with greyscale configs because it's animated.
	add_atom_colour(pick_weight(list(COLOR_WHITE = 3, COLOR_GOLD = 2, COLOR_DARK = 1)), FIXED_COLOUR_PRIORITY)
	var/mutable_appearance/neko_overlay = mutable_appearance(icon, "maneki-neko-overlay", appearance_flags = RESET_COLOR|KEEP_APART)
	add_overlay(neko_overlay)
	AddElement(/datum/element/art, GOOD_ART)
	AddElement(/datum/element/beauty, 800)
