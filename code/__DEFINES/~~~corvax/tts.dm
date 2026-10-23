#define VV_HK_SELECT_TTS_VOICE "select_tts_voice"

#define TTS_TRAIT_PITCH_WHISPER (1<<1)
#define TTS_TRAIT_RATE_FASTER (1<<2)
#define TTS_TRAIT_RATE_MEDIUM (1<<3)

#define TTS_OVERRIDE_GENDER (1<<0)

#define TTS_CATEGORY_OTHER "Другое"
#define TTS_CATEGORY_WARCRAFT3 "WarCraft 3"
#define TTS_CATEGORY_HALFLIFE2 "Half-Life 2"
#define TTS_CATEGORY_HALFLIFE_ALYX "Half-Life Alyx"
#define TTS_CATEGORY_STARCRAFT "StarCraft"
#define TTS_CATEGORY_PORTAL2 "Portal 2"
#define TTS_CATEGORY_STALKER "STALKER"
#define TTS_CATEGORY_DOTA2 "Dota 2"
#define TTS_CATEGORY_LOL "League of Legends"
#define TTS_CATEGORY_FALLOUT "Fallout"
#define TTS_CATEGORY_FALLOUT2 "Fallout 2"
#define TTS_CATEGORY_POSTAL2 "Postal 2"
#define TTS_CATEGORY_TEAMFORTRESS2 "Team Fortress 2"
#define TTS_CATEGORY_ATOMIC_HEART "Atomic Heart"
#define TTS_CATEGORY_OVERWATCH "Overwatch"
#define TTS_CATEGORY_SKYRIM "Skyrim"
#define TTS_CATEGORY_RITA "Rita"
#define TTS_CATEGORY_METRO "Metro"
#define TTS_CATEGORY_HEROESOFTHESTORM "Heroes of the Storm"
#define TTS_CATEGORY_HEARTHSTONE "Hearthstone"
#define TTS_CATEGORY_VALORANT "Valorant"
#define TTS_CATEGORY_EVILISLANDS "Evil Islands"
#define TTS_CATEGORY_WITCHER "Witcher"
#define TTS_CATEGORY_LEFT4DEAD "Left 4 Dead"
#define TTS_CATEGORY_SPONGEBOB "SpongeBob"
#define TTS_CATEGORY_TINYBUNNY "Tiny Bunny"
#define TTS_CATEGORY_BALDURS_GATE_3 "Baldur's gate 3"
#define TTS_CATEGORY_PORTAL "Portal"
#define TTS_CATEGORY_TMNT "Teenage mutant ninja turtle"
#define TTS_CATEGORY_STAR_WARS "Star Wars"
#define TTS_CATEGORY_TRANSFORMERS "Transformers"
#define TTS_CATEGORY_LOTR "The Lord of the rings"
#define TTS_CATEGORY_SHREK "Shrek"
#define TTS_CATEGORY_POTC "Pirates of the Caribbean"
#define TTS_CATEGORY_HARRY_POTTER "Harry Potter"
#define TTS_CATEGORY_HOGWARTS "Hogwarts legacy"
#define TTS_CATEGORY_X3 "X3"
#define TTS_CATEGORY_OVERLORD2 "The Overlord 2"
#define TTS_CATEGORY_MARVEL "Marvel"
#define TTS_CATEGORY_WOW "World of Warcraft"
#define TTS_CATEGORY_TREASURE_ISLAND "Treasure Island"
#define TTS_CATEGORY_BOYS_WORD "Слово пацана"
#define TTS_CATEGORY_STRONGHOLD "Stronghold Crusade"
#define TTS_CATEGORY_CYBERPUNK "Киберпанк 2077"
#define TTS_CATEGORY_TLOU "The Last of Us"
#define TTS_CATEGORY_DEEP_ROCK_GALACTIC "Deep Rock Galactic"
#define TTS_CATEGORY_SUNBOY "Пророк Санбой"
#define TTS_CATEGORY_WH40k "Warhammer 40k"
#define TTS_CATEGORY_UNKNOWN "Загадка Силеро"

#define TTS_GENDER_ANY "Любой"
#define TTS_GENDER_MALE "Мужской"
#define TTS_GENDER_FEMALE "Женский"

#define TTS_PHRASES list(\
		"Так звучит мой голос.",\
		"Так я звучу.",\
		"Я.",\
		"Поставьте свою подпись.",\
		"Дело сделано.",\
		"Ночь только начинается.",\
		"Князь ждёт вас в Элизиуме.",\
		"Съешь же ещё этих мягких французских булок, да выпей чаю.",\
	)

///from base of atom/change_tts_seed(): (mob/chooser, overrides, list/new_sound_effects)
#define COMSIG_ATOM_TTS_SEED_CHANGE "atom_tts_seed_change"
///from base of atom/cast_tts(): (listener, message, atom/location, is_local, is_radio, list/effects, traits, preSFX, postSFX, tts_seed_override, channel_override, check_deafness, radio_freq)
#define COMSIG_ATOM_TTS_CAST "atom_tts_cast"
///from base of atom/tts_effects_add(): (list/effects)
#define COMSIG_ATOM_TTS_EFFECTS_ADD "atom_tts_effects_add"
///from base of atom/tts_effects_remove(): (list/effects)
#define COMSIG_ATOM_TTS_EFFECTS_REMOVE "atom_tts_effects_remove"
///from base of datum/component/tts_component/finalize_tts(): (list/tts_args)
#define COMSIG_TTS_COMPONENT_PRE_CAST_TTS "tts_component_pre_cast_tts"
	#define TTS_CAST_SPEAKER "tts_speaker"
	#define TTS_CAST_LISTENER "tts_listener"
	#define TTS_CAST_MESSAGE "tts_message"
	#define TTS_CAST_LOCATION "tts_location"
	#define TTS_CAST_LOCAL "tts_local"
	#define TTS_CAST_EFFECTS "tts_effect"
	#define TTS_CAST_TRAITS "tts_traits"
	#define TTS_CAST_PRE_SFX "tts_preSFX"
	#define TTS_CAST_POST_SFX "tts_postSFX"
	#define TTS_CAST_SEED "tts_seed"
	#define TTS_CHANNEL_OVERRIDE "tts_channel_override"

/// Message mod: list of /datum/tts_sound_effect types applied to the spoken line
#define MODE_TTS_FILTERS "tts_filters"
/// Message mod: /datum/tts_seed used instead of the speaker's own
#define MODE_TTS_SEED_OVERRIDE "tts_seed_override"
/// Message mod: text that is voiced instead of the raw message
#define MODE_TTS_MESSAGE_OVERRIDE "tts_message_override"
