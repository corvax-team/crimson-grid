// THIS IS A DARKPACK UI FILE
import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const country_of_origin: FeatureChoiced = {
    name: 'Страна происхождения',
    component: FeatureDropdownInput,
};

export const state_of_origin: FeatureChoiced = {
    name: 'Штат происхождения',
    component: FeatureDropdownInput,
};
