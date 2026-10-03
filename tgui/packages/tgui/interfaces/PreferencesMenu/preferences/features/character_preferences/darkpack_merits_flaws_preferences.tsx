// THIS IS A DARKPACK UI FILE
import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const territorial: FeatureChoiced = {
  name: 'Территория',
  description: 'Охотничья территория персонажа.',
  component: FeatureDropdownInput,
};

export const prey_exclusion: FeatureChoiced = {
  name: 'Запретная добыча',
  description: 'Добыча, на которую персонаж не охотится.',
  component: FeatureDropdownInput,
};

export const missing_arm: FeatureChoiced = {
  name: 'Отсутствующая рука',
  component: FeatureDropdownInput,
};

export const lame_leg: FeatureChoiced = {
  name: 'Хромая нога',
  component: FeatureDropdownInput,
};

export const acute_sense: FeatureChoiced = {
  name: 'Обострённое чувство',
  component: FeatureDropdownInput,
};

export const fetish_merit: FeatureChoiced = {
  name: 'Фетиш',
  description: 'Какой фетиш получит персонаж.',
  component: FeatureDropdownInput,
};
