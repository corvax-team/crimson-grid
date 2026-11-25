/// Posts the feed keeps; the oldest one goes when a new one comes
#define ENDPOST_MAX_POSTS 50
/// Comments a post keeps; the oldest one goes when a new one comes
#define ENDPOST_MAX_COMMENTS 30
/// Longest post or comment, in characters
#define ENDPOST_MAX_LENGTH 140
/// How long changes to the feed gather before it goes out to open phones in one go
#define ENDPOST_PUSH_DELAY (1 SECONDS)
/// How often one person may post, comment and like
#define ENDPOST_POST_COOLDOWN (30 SECONDS)
#define ENDPOST_COMMENT_COOLDOWN (5 SECONDS)
#define ENDPOST_LIKE_COOLDOWN (1 SECONDS)
/// How often one phone hears about replies from one and the same person
#define ENDPOST_REPLY_NOTIFY_COOLDOWN (5 SECONDS)

/obj/item/smartphone
	/// TRUE while the EndPost app is on screen: only then is the feed sent to the window
	var/endpost_open = FALSE

// Globals rather than subsystem vars: when the MC restarts, the darkpack SSphones Recover() carries over only its own lists. A counter starting from 1 again would give new posts the ids of old ones
/// Number the next post or comment gets. Posts are found by it: their place in the feed shifts as old ones go
GLOBAL_VAR_INIT(endpost_next_id, 1)
/// When each person may next do each thing in EndPost, keyed by "ckey:what". Kept by person rather than by phone, so a handful of phones buys nothing
GLOBAL_LIST_EMPTY(endpost_cooldowns)

/**
 * Whether `user` may do `kind` again yet. When they may, the wait for the next time starts.
 */
/proc/endpost_cooldown_ready(mob/user, kind, delay)
	var/key = "[user.ckey || REF(user)]:[kind]"
	if(GLOB.endpost_cooldowns[key] > world.time)
		return FALSE
	GLOB.endpost_cooldowns[key] = world.time + delay
	return TRUE

/**
 * Puts a post into the feed and shows the new feed to every phone that has it open.
 *
 * post is list("body", "date", "time", "author"), with optionally "owner" (a weakref to the phone that may delete it).
 */
/proc/endpost_publish(list/post)
	post["id"] = GLOB.endpost_next_id++
	post["comments"] = list()
	/// Weakrefs to the phones that liked it
	post["likes"] = list()
	SSphones.endpost_posts += list(post)
	if(length(SSphones.endpost_posts) > ENDPOST_MAX_POSTS)
		SSphones.endpost_posts.Cut(1, 2)
	endpost_push_feed()

/// The feed has changed. Changes coming close together go out as one update a moment later, so likes and comments in a row cost one send each, not one apiece
/proc/endpost_push_feed()
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(endpost_send_feed)), ENDPOST_PUSH_DELAY, TIMER_UNIQUE)

/// Sends the feed to every phone with the EndPost app on screen
/proc/endpost_send_feed()
	for(var/obj/item/smartphone/phone as anything in GLOB.phones_list)
		if(phone.endpost_open)
			phone.push_phone_state()

/proc/endpost_find_post(id)
	for(var/list/post as anything in SSphones.endpost_posts)
		if(post["id"] == id)
			return post

/proc/endpost_find_comment(list/post, id)
	for(var/list/comment as anything in post["comments"])
		if(comment["id"] == id)
			return comment

/obj/item/smartphone/ui_static_data(mob/user)
	. = ..()
	if(!endpost_open)
		.["posts"] = list()
		return
	var/list/feed = list()
	for(var/list/post as anything in SSphones.endpost_posts)
		var/list/comments = list()
		for(var/list/comment as anything in post["comments"])
			UNTYPED_LIST_ADD(comments, list(
				"id" = comment["id"],
				"author" = comment["author"],
				"reply_to" = comment["reply_to"],
				"body" = comment["body"],
				"time" = comment["time"],
				"mine" = endpost_owns(comment),
			))
		var/list/likes = post["likes"]
		UNTYPED_LIST_ADD(feed, list(
			"id" = post["id"],
			"author" = post["author"],
			"body" = post["body"],
			"date" = post["date"],
			"time" = post["time"],
			"mine" = endpost_owns(post),
			"likes" = length(likes),
			"liked" = (WEAKREF(src) in likes),
			"comments" = comments,
		))
	.["posts"] = feed

/obj/item/smartphone/ui_close(mob/user)
	. = ..()
	endpost_open = FALSE

/// Sends the phone's static data (the EndPost feed and its settings) to everyone looking at it. Goes around the static data throttle: that one covers the screen with a loading notice
/obj/item/smartphone/proc/push_phone_state()
	for(var/datum/tgui/viewer as anything in open_uis)
		viewer.send_full_update(always_instant = TRUE)

/// Whether this phone wrote the post or comment, and may delete it
/obj/item/smartphone/proc/endpost_owns(list/entry)
	var/datum/weakref/owner = entry["owner"]
	return owner?.resolve() == src

/obj/item/smartphone/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user
	switch(action)
		if("endpost_open")
			endpost_open = TRUE
			push_phone_state()
			return TRUE

		if("endpost_close")
			endpost_open = FALSE
			return TRUE

		if("submit_post")
			var/body = endpost_clean_text(params["body"])
			if(!body || !endpost_username)
				return TRUE
			if(!endpost_cooldown_ready(user, "post", ENDPOST_POST_COOLDOWN))
				balloon_alert(user, "слишком часто!")
				return TRUE
			endpost_publish(list(
				"body" = body,
				"date" = phone_date_ru(),
				"time" = server_timestamp("hh:mm", ic_time = TRUE),
				"author" = endpost_username,
				"owner" = WEAKREF(src),
			))
			log_phone("[key_name(user)] submitted a new endpost: [body] as [endpost_username]")
			endpost_notify_phones(endpost_username, body, src)
			return TRUE

		if("endpost_like")
			var/list/post = endpost_find_post(params["post"])
			if(!post || !endpost_cooldown_ready(user, "like", ENDPOST_LIKE_COOLDOWN))
				return TRUE
			// A like belongs to the phone, as posts do: one per phone, and a second press takes it back. Nobody is notified of it
			var/list/likes = post["likes"]
			var/datum/weakref/ours = WEAKREF(src)
			if(ours in likes)
				likes -= ours
			else
				likes += ours
			endpost_push_feed()
			return TRUE

		if("endpost_comment")
			var/list/post = endpost_find_post(params["post"])
			var/body = endpost_clean_text(params["body"])
			if(!post || !body || !endpost_username)
				return TRUE
			if(!endpost_cooldown_ready(user, "comment", ENDPOST_COMMENT_COOLDOWN))
				balloon_alert(user, "слишком часто!")
				return TRUE
			// A reply is a comment like any other, with the name of whoever it answers in front
			var/list/answered = endpost_find_comment(post, params["reply_to"])
			var/list/comments = post["comments"]
			comments += list(list(
				"id" = GLOB.endpost_next_id++,
				"body" = body,
				"time" = server_timestamp("hh:mm", ic_time = TRUE),
				"author" = endpost_username,
				"owner" = WEAKREF(src),
				"reply_to" = answered?["author"],
			))
			if(length(comments) > ENDPOST_MAX_COMMENTS)
				comments.Cut(1, 2)
			log_phone("[key_name(user)] commented on the endpost by [post["author"]][answered ? " in reply to [answered["author"]]" : ""]: [body] as [endpost_username]")
			endpost_push_feed()
			// A reply is heard by whoever it answers, a plain comment by the post's author: if they keep EndPost notifications on, and about one person at most once in a while
			var/datum/weakref/heard_ref = answered ? answered["owner"] : post["owner"]
			var/obj/item/smartphone/heard_phone = heard_ref?.resolve()
			if(heard_phone && heard_phone != src && heard_phone.sim_card && heard_phone.endpost_notifications \
				&& endpost_cooldown_ready(user, "reply:[REF(heard_phone)]", ENDPOST_REPLY_NOTIFY_COOLDOWN))
				heard_phone.receive_notification("EndPost", "ответ от [endpost_username]", body)
			return TRUE

		if("endpost_delete")
			var/list/post = endpost_find_post(params["post"])
			if(!post || !(endpost_owns(post) || is_admin(user.client)))
				return TRUE
			SSphones.endpost_posts -= list(post)
			log_phone("[key_name(user)] removed an endpost: [post["body"]] by [post["author"]]", list("author" = post["author"], "body" = post["body"]))
			endpost_push_feed()
			return TRUE

		if("endpost_delete_comment")
			var/list/post = endpost_find_post(params["post"])
			var/list/comment = post && endpost_find_comment(post, params["comment"])
			if(!comment || !(endpost_owns(comment) || is_admin(user.client)))
				return TRUE
			post["comments"] -= list(comment)
			log_phone("[key_name(user)] removed a comment: [comment["body"]] by [comment["author"]]")
			endpost_push_feed()
			return TRUE

/// A post or comment as typed, trimmed to the length the feed allows. Null when nothing is left
/proc/endpost_clean_text(text)
	if(!istext(text))
		return null
	text = trim(copytext_char(text, 1, ENDPOST_MAX_LENGTH + 1))
	return length(text) ? text : null

#undef ENDPOST_MAX_POSTS
#undef ENDPOST_MAX_COMMENTS
#undef ENDPOST_MAX_LENGTH
#undef ENDPOST_PUSH_DELAY
#undef ENDPOST_POST_COOLDOWN
#undef ENDPOST_COMMENT_COOLDOWN
#undef ENDPOST_LIKE_COOLDOWN
#undef ENDPOST_REPLY_NOTIFY_COOLDOWN
