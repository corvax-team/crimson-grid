// Ported from BandaStation (tgui/interfaces/PreferencesMenu/CharacterPreferences/JobSlotDropdown.tsx).
// Picks which saved character plays a job; the backend is upstream's set_job_to_profile.
import { useBackend } from 'tgui/backend';
import { Dropdown, Tooltip } from 'tgui-core/components';

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

  const activeProfileName = character_profiles[active_slot - 1];
  // 0 means no slot is assigned and the active character joins.
  const assignedSlot =
    job_preferences.find((pref) => pref.job === name)?.assigned_profile_slot ??
    0;
  const assignedName =
    assignedSlot > 0 ? character_profiles[assignedSlot - 1] : activeProfileName;

  const options = [
    {
      value: 0,
      displayText: activeProfileName
        ? `Активный персонаж (${activeProfileName})`
        : 'Активный персонаж',
    },
    ...character_profiles.flatMap((profile, index) =>
      profile
        ? [{ value: index + 1, displayText: `${index + 1}. ${profile}` }]
        : [],
    ),
  ];

  return (
    <Tooltip content={assignedName ?? 'Активный персонаж'} position="top-end">
      <div>
        <Dropdown
          noChevron
          iconOnly
          icon={slotIcon(assignedSlot)}
          width="auto"
          menuWidth="auto"
          selected={options.find((option) => option.value === assignedSlot)}
          options={options}
          onSelected={(value: number | string) => {
            const slot = Number(value);
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
