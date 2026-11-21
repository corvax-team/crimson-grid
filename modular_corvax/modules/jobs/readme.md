## Jobs

Module ID: JOB_SLOTS (job character slots); `job_restrictions.dm` predates this readme and carries no marker.

### Description:

- `job_restrictions.dm` builds the restriction lines shown in the job tooltip of the character menu.
- `job_character_slots.dm` makes job restrictions follow the character that actually joins.

Upstream (tgstation) lets a player assign a saved character slot to a job: at roundstart that character is loaded instead of the active one. Upstream ran every job check against the active character and then spawned the assigned one unchecked, so an assigned character could take a job its clan, generation, age or splat forbids.

Now:

- `/datum/preferences/proc/get_job_character_slot(job_title)` picks the character that joins as a job: the assigned slot at roundstart (if it holds a character), the active slot once the round is running. Latejoin keeps using the active character, as upstream does.
- `/datum/preferences/proc/get_roundstart_job_character_slot(job_title)` is the roundstart half of that rule. The jobs page always uses it, so the page does not change when the round starts: it configures the next roundstart, not latejoin.
- `/datum/preferences/proc/get_character_job_unavailability(job, slot)` runs the character-level checks (character age, splat, splat slots, Kindred immortal age / generation / clan, Garou auspice / tribe) against any saved slot, read straight from the savefile without loading it. It writes no logs, so the character menu can call it for every job and slot.
- `SSjob.check_job_eligibility` (through `check_job_eligibility_darkpack`) runs those checks against `get_job_character_slot`, so distribution and dynamic candidacy see the same character that `create_character` spawns. There is no fallback to another character: if the character set for a job does not fit, the job is not given.
- Assigning a character that does not fit a job is refused by the server (`set_job_to_profile` override).
- The jobs page greys out jobs the joining character cannot take, shows «Недоступно» with the reason in a tooltip instead of the priority buttons, and greys out unfit characters in the per-job slot dropdown. If an assigned character stops fitting later (the player changed it), the assignment stays, the job turns grey and the dropdown button turns red until the player reassigns it.

On a merge conflict in `_job_assignment.dm`: upstream changes to the removed `check_kindred_prefs()` / `check_garou_prefs()` must be ported into `get_kindred_job_unavailability()` / `get_garou_job_unavailability()`, and new character checks added to `get_character_job_unavailability()`.

### TG Proc/File Changes:

- `code/controllers/subsystem/job.dm`: `check_job_eligibility()` - the character age check removed (moved to `get_character_job_unavailability()`).
- `code/modules/mob/dead/new_player/new_player.dm`: `create_character()` - the roundstart slot comes from `get_job_character_slot()`.
- `modular_darkpack/modules/jobs/code/_job_assignment.dm`: `check_job_eligibility_darkpack()` delegates to `get_character_job_unavailability()`; `check_kindred_prefs()` and `check_garou_prefs()` removed.
- `tgui/packages/tgui/interfaces/PreferencesMenu/CharacterPreferences/JobsPage.tsx`: slot dropdown next to the priorities, unavailable job state.
- `tgui/packages/tgui/interfaces/PreferencesMenu/types.ts`: `job_unavailable`, `job_unavailable_slots`.

### Modular Overrides:

- `modular_corvax/modules/jobs/code/job_character_slots.dm`: `/datum/preference_middleware/jobs/set_job_to_profile()`, `/datum/preference_middleware/jobs/get_ui_data()`.

### Defines:

- N/A

### Included files that are not contained in this module:

- `tgui/packages/tgui/corvax/JobSlotDropdown.tsx` - the per-job slot dropdown.

### Credits:

- Slot dropdown ported from BandaStation (`JobSlotDropdown.tsx`, ss220club/BandaStation).
