import { CheckboxInput, type FeatureToggle } from '../base';

export const nsfw_content_pref: FeatureToggle = {
  name: 'Показывать NSFW-контент',
  category: 'Геймплей',
  description: 'Позволяет видеть NSFW-описания персонажей.',
  component: CheckboxInput,
};
