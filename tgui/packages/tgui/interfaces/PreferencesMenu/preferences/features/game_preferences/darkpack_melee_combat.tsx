import { CheckboxInput, type FeatureToggle } from '../base';

export const ranged_click_to_melee: FeatureToggle = {
  name: 'Удар по клику вдали',
  category: 'Геймплей',
  description: `
    Клик по клетке, до которой вы не дотягиваетесь, вызывает взмах или удар в её сторону.
  `,
  component: CheckboxInput,
};
