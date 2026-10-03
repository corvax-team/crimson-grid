import { CheckboxInput, type FeatureToggle } from '../base';

export const status_bar: FeatureToggle = {
  name: 'Строка состояния',
  category: 'Интерфейс',
  description: `
      Если включено, в левом нижнем углу экрана показывается название
      того, на что наведён курсор.
    `,
  component: CheckboxInput,
};
