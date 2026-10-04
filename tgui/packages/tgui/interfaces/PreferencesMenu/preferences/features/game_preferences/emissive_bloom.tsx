import { type Feature, FeatureSliderInput } from '../base';

export const emissive_bloom: Feature<number> = {
  name: 'Сила свечения',
  category: 'Геймплей',
  description: `Насколько сильно светятся излучающие свет объекты, например экраны компьютеров. На производительность почти не влияет.`,
  component: FeatureSliderInput,
};
