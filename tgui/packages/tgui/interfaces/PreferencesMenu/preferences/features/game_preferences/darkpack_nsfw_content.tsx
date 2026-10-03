import { CheckboxInput, type FeatureToggle } from '../base';

export const nsfw_content_pref: FeatureToggle = {
  name: 'Enable NSFW Content',
  category: 'Геймплей',
  description: 'The ability to see NSFW flavor texts.',
  component: CheckboxInput,
};
