import { CheckboxInput, type Feature, type FeatureToggle, FeatureSliderInput } from '../base';

export const darkened_flash: FeatureToggle = {
  name: 'Включить затемненные вспышки',
  category: 'Доступность',
  description: `
    Если включено, яркие вспышки теперь будут затемнять
    ваш экран.
  `,
  component: CheckboxInput,
};

export const screen_shake_darken: FeatureToggle = {
  name: 'Замена дрожи экрана затемнением',
  category: 'Доступность',
  description: `
      Если включено, дрожь экрана будет заменена затемнением экрана.
    `,
  component: CheckboxInput,
};

export const remove_double_click: FeatureToggle = {
  name: 'Убрать двойной клик',
  category: 'Доступность',
  description: `
      Если включено, действия, требующие двойного клика, будут предлагать
      альтернативные варианты, что очень удобно, если у вас не очень функциональная мышь.
    `,
  component: CheckboxInput,
};

export const min_recoil_multiplier: Feature<number> = {
  name: 'Сила косметической отдачи',
  category: 'Доступность',
  description: `
      Меняет силу, с которой косметическая отдача трясёт камеру.
      0 полностью отключает косметическую отдачу, на механическую отдачу это не влияет.
    `,
  component: FeatureSliderInput,
};

export const stair_indicator: FeatureToggle = {
  name: 'Включить индикатор лестниц',
  category: 'Доступность',
  description: `
      Если включено, на лестницах появится индикатор, показывающий,
      в какую сторону идти, чтобы перейти на другой этаж.
    `,
  component: CheckboxInput,
};

export const twelve_hour: FeatureToggle = {
  name: '12-часовой формат времени',
  category: 'Доступность',
  description: `
      Если включено, реальное время во многих местах будет показано в формате AM/PM.
    `,
  component: CheckboxInput,
};

