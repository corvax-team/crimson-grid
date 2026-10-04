import { CheckboxInput, type FeatureToggle } from '../base';

export const playtime_reward_cloak: FeatureToggle = {
  name: 'Надевать плащ ветерана',
  description:
    'Награда за 5000+ часов игры: роскошный плащ, который могут носить только такие же заслуженные ветераны.',
  component: CheckboxInput,
};
