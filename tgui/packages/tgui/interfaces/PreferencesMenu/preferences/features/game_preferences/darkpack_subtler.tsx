// THIS IS A DARKPACK UI FILE
import { CheckboxInput } from '../base'
import type { FeatureToggle } from '../base';

export const subtler_sound: FeatureToggle = {
  name: 'Звук скрытых эмоций',
  category: 'Звук',
  description: 'Слышать ли звуковой эффект скрытых эмоций (subtler)',
  component: CheckboxInput,
};
