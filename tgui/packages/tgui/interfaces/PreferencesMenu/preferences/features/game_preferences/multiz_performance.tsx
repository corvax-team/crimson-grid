import { createDropdownInput, type Feature } from '../base';

export const multiz_performance: Feature<number> = {
  name: 'Мульти-Z - детализация',
  category: 'Геймплей',
  description: 'Уровень детализации мульти-Z. Влияет на производительность.',
  component: createDropdownInput({
    [-1]: 'Без ограничений',
    5: 'Высокая', // DARKPACK EDIT CHANGE
    3: 'Средняя', // DARKPACK EDIT CHANGE
    0: 'Низкая',
  }),
};
