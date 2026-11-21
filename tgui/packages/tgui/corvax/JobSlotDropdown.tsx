// Ported from BandaStation (tgui/interfaces/PreferencesMenu/CharacterPreferences/JobSlotDropdown.tsx).
// Picks which saved character plays a job; the backend is upstream's set_job_to_profile.
// Characters who cannot take the job are greyed out and cannot be picked; the server refuses them too.
import { useBackend } from 'tgui/backend';
import { Box, Dropdown, Tooltip } from 'tgui-core/components';

import type { PreferencesMenuData } from '../interfaces/PreferencesMenu/types';

/** Font Awesome has digit icons only for 1-9; larger slots fall back to a generic icon. */
function slotIcon(slot: number): string {
  if (slot === 0) {
    return 'user';
  }
  return slot <= 9 ? `fa-${slot}` : 'hashtag';
}

type JobSlotDropdownProps = {
  name: string;
};

export function JobSlotDropdown(props: JobSlotDropdownProps) {
  const { data, act } = useBackend<PreferencesMenuData>();
  const { name } = props;
  const { character_profiles, active_slot, job_preferences } = data;
  const unavailableSlots = data.job_unavailable_slots?.[name] ?? [];

  const activeProfileName = character_profiles[active_slot - 1];
  // 0 means no slot is assigned and the active character joins.
  const assignedSlot =
    job_preferences.find((pref) => pref.job === name)?.assigned_profile_slot ??
    0;
  const joiningSlot = assignedSlot > 0 ? assignedSlot : active_slot;
  const joiningName = character_profiles[joiningSlot - 1];
  const joiningUnfit = unavailableSlots.includes(joiningSlot);

  const option = (value: number, text: string, unfit: boolean) => ({
    value,
    displayText: unfit ? <Box color="label">{text} - не подходит</Box> : text,
  });

  const options = [
    option(
      0,
      activeProfileName
        ? `Активный персонаж (${activeProfileName})`
        : 'Активный персонаж',
      unavailableSlots.includes(active_slot),
    ),
    ...character_profiles.flatMap((profile, index) =>
      profile
        ? [
            option(
              index + 1,
              `${index + 1}. ${profile}`,
              unavailableSlots.includes(index + 1),
            ),
          ]
        : [],
    ),
  ];

  return (
    <Tooltip
      content={
        joiningUnfit
          ? `${joiningName} не подходит для этой должности`
          : (joiningName ?? 'Активный персонаж')
      }
      position="top-end"
    >
      <div>
        <Dropdown
          noChevron
          iconOnly
          icon={slotIcon(assignedSlot)}
          color={joiningUnfit ? 'bad' : undefined}
          width="auto"
          menuWidth="auto"
          selected={options.find((entry) => entry.value === assignedSlot)}
          options={options}
          onSelected={(value: number | string) => {
            const slot = Number(value);
            // Clearing the assignment is always allowed; picking an unfit character is not.
            if (slot > 0 && unavailableSlots.includes(slot)) {
              return;
            }
            act('set_job_to_profile', {
              job: name,
              profile: slot > 0 ? slot : -1,
            });
          }}
        />
      </div>
    </Tooltip>
  );
}
