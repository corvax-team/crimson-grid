
ADMIN_VERB(dsay, R_NONE, "DSay", "Speak to the dead.", ADMIN_CATEGORY_GAME)
	VERB_ARG(message, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)
	if(user.prefs.muted & MUTE_DEADCHAT)
		to_chat(user, span_danger("You cannot send DSAY messages (muted)."), confidential = TRUE)
		return

	if (user.handle_spam_prevention(message,MUTE_DEADCHAT))
		return

	// Callers pass both raw and already encoded text, so decode first to encode exactly once
	message = copytext_char(sanitize(html_decode(message)), 1, MAX_MESSAGE_LEN) // CORVAX EDIT CHANGE - CHAT_XSS. ORIGINAL: message = copytext_char(message, 1, MAX_MESSAGE_LEN)
	user.mob.log_talk(message, LOG_DSAY)

	if (!message)
		return
	var/rank_name = user.holder.rank_names()
	var/admin_name = user.key
	if(user.holder.fakekey)
		rank_name = pick(strings("admin_nicknames.json", "ranks", "config"))
		admin_name = pick(strings("admin_nicknames.json", "names", "config"))
	var/name_and_rank = "[span_tooltip(rank_name, "STAFF")] ([admin_name])"

	deadchat_broadcast("[span_prefix("DEAD:")] [name_and_rank] says, <span class='message'>\"[emoji_parse(message)]\"</span>")

	BLACKBOX_LOG_ADMIN_VERB("Dsay")

/client/proc/get_dead_say()
	var/msg = input(src, null, "dsay \"text\"") as text|null
	if (isnull(msg))
		return
	SSadmin_verbs.dynamic_invoke_verb(src, /datum/admin_verb/dsay, msg)
