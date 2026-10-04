import { CheckboxInput, type FeatureToggle } from '../base';

export const show_flavor_text_when_masked: FeatureToggle = {
  name: 'Не скрывать личность под маской',
  description:
    'Если включено, то даже когда вы в маске, все видят описание вашего персонажа, а знакомые ещё и имя.',
  component: CheckboxInput,
};
