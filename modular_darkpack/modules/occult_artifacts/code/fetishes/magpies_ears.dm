// Homebrew I made up for a special little snowflake
/obj/item/occult_artifact/werewolf/magpies_ears
	name = "strange doll"
	desc = "Самодельная кукла с какими-то странными украшениями."
	true_name = "Magpie's Ears"
	true_desc = "Самодельная кукла, которая очень любит слушать."
	icon_state = "argemia"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/toys/icons/toys_onfloor.dmi')
	spirit_type = SPIRIT_ANIMAL
	var/list/heard_messages
	COOLDOWN_DECLARE(yap_cooldown)

/obj/item/occult_artifact/werewolf/magpies_ears/Initialize(mapload)
	. = ..()
	spirit_name = generate_spirit_name(spirit_type)
	add_traits(list(TRAIT_ACUTE_HEARING, TRAIT_XRAY_HEARING, TRAIT_GOOD_HEARING), INNATE_TRAIT)
	become_hearing_sensitive()

/obj/item/occult_artifact/werewolf/magpies_ears/Hear(atom/movable/speaker, message_language, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods, message_range, source)
	. = ..()
	if((speaker == owner) || (speaker == src))
		return .

	var/number_of_excess_strings = LAZYLEN(heard_messages) - 100
	if(number_of_excess_strings > 0) // only remove if we're overfull
		for(var/i in 1 to number_of_excess_strings)
			LAZYREMOVE(heard_messages, pick(heard_messages))

	LAZYADD(heard_messages, html_decode(raw_message))
	Shake(duration = 0.2 SECONDS)

/obj/item/occult_artifact/werewolf/magpies_ears/attack_self(mob/user, modifiers)
	if(!identified)
		return ..()

	if(!COOLDOWN_FINISHED(src, yap_cooldown))
		return

	if(!length(heard_messages))
		say("Боюсь, мне нечего сказать.")

	COOLDOWN_START(src, yap_cooldown, 5 SECONDS)
	var/message = pick(heard_messages)
	say(message)
	LAZYREMOVE(heard_messages, message)
	return TRUE

/obj/item/occult_artifact/werewolf/magpies_ears/identify()
	. = ..()
	say("Я - [spirit_name]... Мои уши и мои секреты к вашим услугам...")
