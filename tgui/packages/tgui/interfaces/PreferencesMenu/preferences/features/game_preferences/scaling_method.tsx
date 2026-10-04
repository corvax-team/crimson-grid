import { createDropdownInput, type Feature } from '../base';

export const scaling_method: Feature<string> = {
  name: 'Метод масштабирования',
  category: 'Интерфейс',
  component: createDropdownInput({
    blur: 'Билинейный',
    distort: 'Ближайший сосед',
    normal: 'Точечная выборка',
  }),
};
