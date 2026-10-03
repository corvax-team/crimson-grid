// THIS IS A DARKPACK UI FILE
import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureNumeric,
  FeatureSliderInput,
  type FeatureValueProps,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act, data } = useBackend();

  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const blooper_choice: FeatureChoiced = {
  name: 'Голос персонажа',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speed: FeatureNumeric = {
  name: 'Скорость голоса, %',
  description: 'Чем меньше значение, тем медленнее голос, чем больше, тем быстрее.',
  component: FeatureSliderInput,
};

export const blooper_pitch: FeatureNumeric = {
  name: 'Высота голоса, %',
  description: 'Чем меньше значение, тем ниже голос, чем больше, тем выше.',
  component: FeatureSliderInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: 'Диапазон голоса, %',
  description:
    'Чем меньше значение, тем уже диапазон высоты голоса, чем больше, тем шире.',
  component: FeatureSliderInput,
};
