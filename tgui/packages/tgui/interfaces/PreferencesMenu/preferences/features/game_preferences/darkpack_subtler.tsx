// THIS IS A DARKPACK UI FILE
import { CheckboxInput } from '../base'
import type { FeatureToggle } from '../base';

export const subtler_sound: FeatureToggle = {
  name: 'Toggle Subtler Sound',
  category: 'Звук',
  description: 'Toggles whether you hear subtler emote sound effects',
  component: CheckboxInput,
};
