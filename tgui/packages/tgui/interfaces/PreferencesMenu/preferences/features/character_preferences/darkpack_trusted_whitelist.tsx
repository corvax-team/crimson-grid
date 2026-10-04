import type { ReactNode } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Dropdown, Icon, Stack } from 'tgui-core/components';
import { classes } from 'tgui-core/react';
import { capitalizeFirst } from 'tgui-core/string';
import type { PreferencesMenuData } from '../../../types';
import type { FeatureChoiced, FeatureValueProps } from '../base';

type ClanServerData = {
  choices: string[];
  icons: Record<string, string>;
  display_names?: Record<string, string>;
  name?: string;
};

export const vampire_clan: FeatureChoiced = {
  name: 'Клан',
  component: (props: FeatureValueProps<string, string, ClanServerData>) => {
    const { data } = useBackend<PreferencesMenuData>();
    const { serverData, handleSetValue, value } = props;
    const whitelistSet = new Set(data.player_whitelists || []);
    const isTrusted = whitelistSet.has('trusted');
    const names_to_key = data.clan_names_to_key;

    if (!serverData) {
      return null;
    }

    const { choices, icons, display_names } = serverData;
    const labelFor = (choice: string) =>
      display_names?.[choice] || capitalizeFirst(choice);

    const options = choices.map((choice) => {
      const whitelistId = names_to_key[choice];
      const isLocked =
        !!whitelistId && !isTrusted && !whitelistSet.has(whitelistId);

      let displayText: ReactNode = labelFor(choice);

      if (icons?.[choice]) {
        displayText = (
          <Stack align="center">
            <Stack.Item>
              <Box
                className={classes(['preferences32x32', icons[choice]])}
                style={{ transform: 'scale(0.8)', opacity: isLocked ? 0.4 : 1 }}
              />
            </Stack.Item>
            <Stack.Item grow style={{ opacity: isLocked ? 0.4 : 1 }}>
              {labelFor(choice)}
            </Stack.Item>
            {isLocked && (
              <Stack.Item>
                <Icon name="lock" color="label" />
              </Stack.Item>
            )}
          </Stack>
        );
      } else if (isLocked) {
        displayText = (
          <Stack align="center">
            <Stack.Item grow style={{ opacity: 0.4 }}>
              {labelFor(choice)}
            </Stack.Item>
            <Stack.Item>
              <Icon name="lock" color="label" />
            </Stack.Item>
          </Stack>
        );
      }

      return { displayText, value: choice };
    });

    const selectedWhitelistId = names_to_key[value];
    const selectedIsLocked =
      !!selectedWhitelistId &&
      !isTrusted &&
      !whitelistSet.has(selectedWhitelistId);

    return (
      <Dropdown
        buttons
        displayText={
          selectedIsLocked
            ? `${labelFor(value)} ${<Icon name="lock" color="label" />}`
            : labelFor(value) || ''
        }
        onSelected={handleSetValue}
        options={options}
        selected={value}
        width="100%"
        menuWidth="max-content"
      />
    );
  },
};
