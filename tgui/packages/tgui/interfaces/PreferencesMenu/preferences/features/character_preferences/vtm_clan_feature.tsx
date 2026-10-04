import {
  CheckboxInput,
  type FeatureChoiced,
  FeatureExternalInput,
  type FeatureToggle,
} from '../base';

export const clan_mark: FeatureChoiced = {
  name: 'Метки',
  component: FeatureExternalInput,
};

export const gargoyle_legs_and_tail: FeatureToggle = {
  name: 'Ноги и хвост горгульи',
  component: CheckboxInput,
};
