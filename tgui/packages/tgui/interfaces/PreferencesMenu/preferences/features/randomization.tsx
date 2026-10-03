import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';

import { RandomizationButton } from '../../components/RandomizationButton';
import { type PreferencesMenuData, RandomSetting } from '../../types';
import { useRandomToggleState } from '../../useRandomToggleState';
import { CheckboxInput, type Feature, type FeatureToggle } from './base';

export const random_body: Feature<RandomSetting> = {
  name: 'Случайное тело',
  component: (props) => {
    const [randomToggle, setRandomToggle] = useRandomToggleState();
    const { act } = useBackend();

    return (
      <Stack>
        <Stack.Item>
          <RandomizationButton
            setValue={(newValue) => props.handleSetValue(newValue)}
            value={props.value}
          />
        </Stack.Item>

        {randomToggle ? (
          <>
            <Stack.Item>
              <Button
                color="green"
                onClick={() => {
                  act('randomize_character');
                  setRandomToggle(false);
                }}
              >
                Рандомизировать
              </Button>
            </Stack.Item>

            <Stack.Item>
              <Button color="red" onClick={() => setRandomToggle(false)}>
                Отмена
              </Button>
            </Stack.Item>
          </>
        ) : (
          <Stack.Item>
            <Button onClick={() => setRandomToggle(true)}>
              Рандомизировать
            </Button>
          </Stack.Item>
        )}
      </Stack>
    );
  },
};

export const random_hardcore: FeatureToggle = {
  name: 'Тотальный рандом',
  component: CheckboxInput,
};

export const random_name: Feature<RandomSetting> = {
  name: 'Случайное имя',
  component: (props) => {
    return (
      <RandomizationButton
        setValue={(value) => props.handleSetValue(value)}
        value={props.value}
      />
    );
  },
};

export const random_splats: Feature<RandomSetting> = { // DARKPACK EDIT CHANGE - SPLATS
  name: 'Случайный сплат', // DARKPACK EDIT CHANGE - SPLATS
  component: (props) => {
    const { act, data } = useBackend<PreferencesMenuData>();

    const splats = data.character_preferences.randomization.splats; // DARKPACK EDIT CHANGE - SPLATS

    return (
      <RandomizationButton
        setValue={(newValue) =>
          act('set_random_preference', {
            preference: 'splats', // DARKPACK EDIT CHANGE - SPLATS
            value: newValue,
          })
        }
        value={splats || RandomSetting.Disabled} // DARKPACK EDIT CHANGE - SPLATS
      />
    );
  },
};
