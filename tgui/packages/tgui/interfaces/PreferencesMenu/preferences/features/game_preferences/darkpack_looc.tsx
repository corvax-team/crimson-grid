// THIS IS A DARKPACK UI FILE

import type { FeatureToggle } from '../base';
import { CheckboxInput } from '../base';

export const looc_admin_pref: FeatureToggle = {
  name: 'Видеть LOOC как админ',
  category: 'Админ',
  description:
    'Показывать ли вам как админу сообщения LOOC из любой точки карты.',
  component: CheckboxInput,
};

export const enable_looc_runechat: FeatureToggle = {
  name: 'LOOC в рунчате',
  category: 'Рунчат',
  description:
    'Если включено, сообщения LOOC показываются не только в чате, но и над головой говорящего.',
  component: CheckboxInput,
};
