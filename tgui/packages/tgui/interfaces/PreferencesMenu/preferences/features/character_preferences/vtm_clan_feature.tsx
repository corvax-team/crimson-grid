import {
  CheckboxInput,
  type FeatureChoiced,
  FeatureExternalInput,
  type FeatureToggle,
  type FeatureValueProps,
} from '../base';

export const clan_mark: FeatureChoiced = {
  name: 'Метки',
  component: (props: FeatureValueProps<string, string>) => {
    return <FeatureExternalInput {...props} />;
  },
};

export const gargoyle_legs_and_tail: FeatureToggle = {
  name: 'Ноги и хвост горгульи',
  component: CheckboxInput,
};
