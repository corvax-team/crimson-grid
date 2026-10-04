import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const adjective_preference: FeatureChoiced = {
  name: 'Прилагательное',
  description: 'Как одним словом описать внешность вашего персонажа?',
  component: FeatureDropdownInput,
};
