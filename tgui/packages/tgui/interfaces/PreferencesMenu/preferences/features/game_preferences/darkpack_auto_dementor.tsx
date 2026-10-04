// THIS IS A DARKPACK UI FILE
import { CheckboxInput, type FeatureToggle } from '../base';

export const auto_dementor_pref: FeatureToggle = {
  name: 'Автоматически снимать права ментора',
  category: 'Админ',
  description: 'Если включено, права ментора будут сниматься с вас автоматически.',
  component: CheckboxInput,
};
