// THIS IS A DARKPACK UI FILE
import { Icon, Stack } from 'tgui-core/components';
import { NavigableApps } from '.';

// fake phone info generated when the phone is spawned. random for now, maybe implemented later. maybe never.
const totalStorage = 128;
const storageUsed = Math.min(
  Math.floor(Math.random() * (totalStorage - 10)),
  totalStorage - 40,
); //im bad at math
const storageFree = totalStorage - storageUsed;

const batteryPercentage = Math.min(Math.floor(Math.random() * 100), 100);
const batteryDays = Math.floor(Math.random() * 3) + 1;
const batteryHours = Math.floor(Math.random() * 5) + 1;

type SettingsChoice = {
  name: string;
  description?: string;
  icon: string;
  functional: boolean;
  action: () => void;
};

export const ScreenSettings = (props: {
  setApp: React.Dispatch<React.SetStateAction<NavigableApps | null>>;
}) => {
  const { setApp } = props;

  // most of these are fake... for now
  const choices: SettingsChoice[] = [
    {
      name: 'Сеть и интернет',
      description: 'Мобильная сеть, Wi-Fi, точка доступа',
      icon: 'wifi',
      functional: false,
      action: () => null,
    },
    {
      name: 'Подключённые устройства',
      description: 'Bluetooth, сопряжение',
      icon: 'computer',
      functional: false,
      action: () => null,
    },
    {
      name: 'Персонализация',
      description: 'Сменить обои телефона',
      icon: 'image',
      functional: true,
      action: () => setApp(NavigableApps.Backgrounds),
    },
    {
      name: 'Экран',
      description: 'Тёмная тема, размер шрифта, яркость',
      icon: 'sun',
      functional: false,
      action: () => null,
    },
    {
      name: 'Главный экран и блокировка',
      description: 'Что показывать на главном экране и экране блокировки',
      icon: 'phone',
      functional: false,
      action: () => null,
    },
    {
      name: 'Звук и вибрация',
      description: 'Громкость, вибрация, режим "Не беспокоить", мелодии', //CRIMSON GRID EDIT - ORIGINAL: description: 'Volume, vibration, Do Not Disturb',
      icon: 'volume-up',
      functional: true,
      action: () => setApp(NavigableApps.SoundSettings),
    },
    {
      name: 'Уведомления',
      description: 'История уведомлений, переписки',
      icon: 'bell',
      functional: false,
      action: () => null,
    },
    {
      name: 'Жесты',
      description: 'Быстрый доступ к частым функциям жестами и кнопками',
      icon: 'hand-pointer',
      functional: false,
      action: () => null,
    },
    {
      name: 'Батарея',
      description: `${batteryPercentage}% - ${batteryDays} дн. ${batteryHours} ч`,
      icon: 'battery-full',
      functional: false,
      action: () => null,
    },
    {
      name: 'Хранилище',
      description: `Занято ${storageUsed}% - свободно ${storageFree} ГБ`,
      icon: 'hdd',
      functional: false,
      action: () => null,
    },
    {
      name: 'Местоположение',
      description: 'Вкл. - доступ есть у 3 приложений',
      icon: 'map-marker-alt',
      functional: false,
      action: () => null,
    },
    {
      name: 'Специальные возможности',
      description: 'Экран, управление, звук',
      icon: 'person',
      functional: false,
      action: () => null,
    },
  ];
  return (
    <Stack vertical fill backgroundColor="#ffffff" textColor="#000">
      <Stack.Item backgroundColor="#5f5f5f" textColor="#fff" p={1}>
        <Stack align="center">
          <Icon
            name="arrow-left"
            onClick={() => setApp(null)}
            style={{ cursor: 'pointer' }}
          />
          <Stack.Item grow ml={1}>
            Настройки
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item
        grow
        overflowY="auto"
        style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
      >
        <Stack vertical mb={5}>
          {choices.map((choice, index) => (
            <Stack.Item
              key={index}
              p={1}
              onClick={choice.action}
              className={
                choice.functional ? 'Telephone__ContactsElement' : null
              } // only working apps are clickable
            >
              <Stack align="center" mb={1}>
                <Stack.Item ml={2} mr={2} width={2}>
                  <Icon name={choice.icon} size={1.5} />
                </Stack.Item>
                <Stack.Item grow ml={1.2} mr={2}>
                  <Stack vertical>
                    <Stack.Item fontSize={1.3}>{choice.name}</Stack.Item>
                    {choice.description ? (
                      <Stack.Item fontSize={1} mt={-1} opacity={0.7}>
                        {choice.description}
                      </Stack.Item>
                    ) : null}
                  </Stack>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          ))}
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
