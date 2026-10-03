import { type Feature, FeatureShortTextInput } from '../../base';

export const oocpronouns: Feature<string> = {
  name: 'Местоимения в OOC',
  category: 'Чат',
  description:
    'Местоимения, которые видны в OOC при наведении курсора на ваш ник. Перечисляются через косую черту, распознаются самые распространённые английские местоимения и неоместоимения. После них можно дописать свой текст. Пример: "she/it/fae - моя заметка!"',
  component: FeatureShortTextInput,
};
