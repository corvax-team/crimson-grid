import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const garou_fur_color: FeatureChoiced = {
  name: 'Цвет шерсти гару',
  component: FeatureDropdownInput,
};

export const corax_fur_color: FeatureChoiced = {
  name: 'Цвет перьев коракса',
  component: FeatureDropdownInput,
};


export const garou_hair: FeatureChoiced = {
  name: 'Грива гару',
  component: FeatureDropdownInput,
};

export const garou_body: FeatureChoiced = {
  name: 'Телосложение гару',
  component: FeatureDropdownInput,
};

export const garou_clothes: FeatureChoiced = {
  name: 'Одежда гару',
  component: FeatureDropdownInput,
};
