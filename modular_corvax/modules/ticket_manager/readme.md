https://github.com/ss220club/BandaStation/pull/1622
https://github.com/ss220club/BandaStation/pull/1964

## Ticket Manager

Module ID: TICKET_MANAGER

### Description:

Unified Russian admin and mentor ticket creation and chat, including typing indicators, emoji, staff attachments, assignment, conversion, and automatic closure. F1 opens the current ticket or the creation window. Darkpack mentor entry points use the same manager.

Unlike BandaStation, mentor access uses `client.is_mentor()` and the union of admin and mentor clients rather than `R_MENTOR`. Player message markup is escaped; attachment controls are staff-only. UI actions check ticket access before handling replies or typing, and admin tools require `R_ADMIN`. Banda Discord urgency/keyword integration is not included. Plexora handles admin tickets, external replies (two player replies without an assigned in-game staff member), state changes, connections, and conversion. Mentor tickets are not relayed. The UI uses the existing admin theme and does not persist the selected tab.

The message renderer preserves escaped player markup as React text instead of parsing it a second time as HTML. `TicketMessage.test.tsx` covers escaped image/bold tags and retained staff attachments.

The old ticket datums and interfaces remain for upstream merge compatibility. Legacy TGS commands are not migrated.

Darkpack never removed a logged out client from `GLOB.mentors`, leaving null entries that crashed `/datum/escape_menu/proc/build_mentor_list`. The client is now removed on `Destroy`.

Additions for this build, shown to `R_ADMIN` only: a line under the ticket title with the initiator's splat, clan, generation and active Masquerade breaches (`/datum/help_ticket/proc/get_character_summary`), and a button that opens darkpack's Discipline/Preference Editor on the ticket's player.

### TG Proc/File Changes:

- `code/modules/admin/verbs/adminhelp.dm`: `adminhelp`, `view_latest_ticket`; original `admin_ticket_log` disabled in favor of the module implementation.
- `code/modules/client/client_procs.dm`: client login/logout notifications before detaching the persistent client.
- `code/controllers/subsystem/statpanel.dm`: `set_tickets_tab`.
- `code/datums/components/admin_popup.dm`: ticket type, `Initialize`, and `give_admin_popup`.
- `code/modules/escape_menu/escape_menu.dm`: ticket notification data.
- `modular_darkpack/modules/mentor/code/mentorhelp.dm`: `mentorhelp`.
- `modular_darkpack/modules/mentor/code/mentor_manager.dm`: `mentor_requests`.
- `modular_darkpack/modules/mentor/code/mentorpm.dm`: `cmd_mentor_pm`.
- `modular_vcg/modules/plexora/code/topics.dm`: `plx_ticketaction/Run` and `plx_sendaticketpm/Run`.
- `tgstation.dme`: definitions and module includes.

### Modular Overrides:

- `/client/cmd_admin_pm`: ticket-based private messages.
- `/datum/persistent_client/set_client`: preserve player key and ckey offline.
- `/proc/admin_ticket_log`: ticket manager logging.

### Defines:

`code/__DEFINES/~~~corvax/ticket_manager.dm` defines ticket states, types, user roles, logging actions/senders, chat links, stat-panel length, reply cooldown, autoclose timeout, `TICKET_TIMESTAMP`, and `TICKET_EXTERNAL_REPLIES`.

### Included files that are not contained in this module:

- `tgui/packages/tgui/interfaces/TicketCreation.tsx`
- `tgui/packages/tgui/interfaces/TicketManager/`
- `tgui/packages/tgui/interfaces/common/ChatInput.tsx`
- `tgui/packages/tgui/styles/interfaces/ChatInput.scss`
- `tgui/packages/tgui/styles/interfaces/TicketManager.scss`
- `modular_darkpack/master_files/sounds/adminhelp.ogg` (existing shared sound)

### Credits:

Ported from [ss220club/BandaStation](https://github.com/ss220club/BandaStation), commit `a46edb08426f32707bb29b346d99b1a14252a0d7`, PRs #1622 and #1964. Original authors: Aylong and gaxeer. Original source license: AGPL-3.0.
