import { CheckboxInput, type FeatureToggle } from '../../base';

export const use_tgui_player_panel: FeatureToggle = {
  name: 'Новая панель игрока',
  category: 'Админ',
  description: 'Использовать новую панель игрока на TGUI вместо старой на HTML.',
  component: CheckboxInput,
};

export const auto_browser_inspect: FeatureToggle = {
  name: 'Автоматический инспектор браузера',
  category: 'Админ',
  description:
    'Сразу даёт возможность исследовать элементы в окнах, без включения отдельной командой.',
  component: CheckboxInput,
};
