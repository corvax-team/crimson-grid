#define TICKET_OPEN 0
#define TICKET_CLOSED 1
#define TICKET_RESOLVED 2

#define TICKET_TYPE_ADMIN "Admin"
#define TICKET_TYPE_MENTOR "Mentor"
#define TICKET_TYPE_HIDDEN_PM "Private Message"
#define TICKET_TYPE_HIDDEN_TICKET "Ticket"

#define TICKET_MANAGER_USER_TYPE_PLAYER 0
#define TICKET_MANAGER_USER_TYPE_MENTOR 1
#define TICKET_MANAGER_USER_TYPE_ADMIN 2

// "Ticket Opened" as /datum/admin_help wrote it: SS Central reads the ticket table and starts a ticket on this action
#define TICKET_AHELP_ACTION_OPENED "Ticket Opened"
#define TICKET_AHELP_ACTION_REOPENED "Reopened"
#define TICKET_AHELP_ACTION_CLOSED "Closed"
#define TICKET_AHELP_ACTION_RESOLVED "Resolved"
#define TICKET_AHELP_ACTION_RECONNECTED "Reconnected"
#define TICKET_AHELP_ACTION_DISCONNECTED "Disconnected"
#define TICKET_AHELP_ACTION_REPLY "Reply"
#define TICKET_AHELP_ACTION_CONVERT "Convert"
#define TICKET_AHELP_ACTION_UNASSIGNED "Unassigned"
#define TICKET_AHELP_ACTION_ASSIGNED "Assigned"

#define TICKET_LOG_SENDER_ADMIN_TICKET_LOG "ADMIN_TICKET_LOG"
#define TICKET_LOG_SENDER_CLIENT_CONNECTED "CLIENT_CONNECTED"
#define TICKET_LOG_SENDER_CLIENT_DISCONNECTED "CLIENT_DISCONNECTED"

#define TICKET_OPEN_LINK(id, msg) ("<a href='byond://?src=[GLOB.ticket_manager_ref];ticket_id=[id];open_ticket=1'>[msg]</a>")
#define TICKET_REPLY_LINK(id, msg) (span_adminsay("<a href='byond://?src=[GLOB.ticket_manager_ref];ticket_id=[id];reply_ticket=1'>[msg]</a>"))
#define TICKET_RESOLVE_LINK(id) ("<a href='byond://?src=[GLOB.ticket_manager_ref];ticket_id=[id];resolve_ticket=1'>Решить</a>")
#define TICKET_CLOSE_LINK(id) ("<a href='byond://?src=[GLOB.ticket_manager_ref];ticket_id=[id];close_ticket=1'>Закрыть</a>")

#define TICKET_ADMIN(user, id) "[ADMIN_FULLMONTY_NONAME(user)] [TICKET_RESOLVE_LINK(id)] [TICKET_CLOSE_LINK(id)] [TICKET_OPEN_LINK(id, "Открыть чат")]"
#define TICKET_MENTOR(user, id) "(<a href='byond://?_src_=mentor;mentor_follow=[REF(user)];[MentorHrefToken(TRUE)]'>F</a>) [TICKET_RESOLVE_LINK(id)] [TICKET_CLOSE_LINK(id)] [TICKET_OPEN_LINK(id, "Открыть чат")]"

#define TICKET_STAT_PANEL_MESSAGE_MAX_LENGTH 100
#define TICKET_REPLY_COOLDOWN 5 SECONDS
#define TICKET_AUTOCLOSE_TIMER 20 MINUTES
#define TICKET_TIMESTAMP(...) (time2text(world.timeofday, "DDD MMM DD hh:mm:ss YYYY", TIMEZONE_UTC))
#define TICKET_EXTERNAL_REPLIES 2
