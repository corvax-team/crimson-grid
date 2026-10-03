import { CheckboxInput, type FeatureToggle } from '../base';

export const particle_weather: FeatureToggle = {
  name: 'Красивая погода на частицах (несовместимо с видеокартами AMD)',
  category: 'Геймплей',
  description:
    'Включает красивую погоду на частицах. Несовместимо с видеокартами AMD: из-за бага BYOND на них начинаются сильные лаги.',
  component: CheckboxInput,
};
