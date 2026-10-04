import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureToggle,
} from '../base';
import {
  FeatureDropdownInput,
  FeatureIconnedDropdownInput,
} from '../dropdowns';

export const language: FeatureChoiced = {
  name: 'Язык',
  component: FeatureIconnedDropdownInput,
};

export const language_speakable: FeatureToggle = {
  name: 'Умение говорить',
  description: `Если снять галочку, вы будете только понимать язык,
    но не сможете на нём говорить.`,
  component: CheckboxInput,
};

export const language_skill: FeatureChoiced = {
  name: 'Владение языком',
  description: 'Какую долю сказанного на этом языке вы понимаете.',
  component: FeatureDropdownInput,
};

export const csl_strength: FeatureChoiced = {
  name: 'Владение языком',
  description: 'Какую долю сказанного на общем языке вы понимаете.',
  component: FeatureDropdownInput,
};
