// THIS IS A DARKPACK UI FILE
import { CheckboxInput, type FeatureToggle, FeatureSliderInput, type FeatureNumeric } from '../base';

export const blooper_hear: FeatureToggle = {
  name: 'Слышать голоса персонажей',
  category: 'Звук',
  description: 'Если включено, вы слышите звуки речи других персонажей.',
  component: CheckboxInput,
};

export const sound_blooper_volume: FeatureNumeric = {
  name: 'Громкость голосов персонажей',
  category: 'Звук',
  description: 'С какой громкостью проигрываются звуки речи персонажей.',
  component: FeatureSliderInput,
};
