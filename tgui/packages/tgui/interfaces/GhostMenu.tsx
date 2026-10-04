import {
  Button,
  Dropdown,
  ImageButton,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  can_boo: BooleanLike;
  hud_info: HudInfo[];
  has_fun: BooleanLike;
  lag_switch_on: BooleanLike;
  notification_data: NotificationData[];
  max_extra_view: number;
  current_extra_view: number;
  body_name: string;
  current_darkness: string;
  darkness_levels: string[];
};

type HudInfo = {
  name: string;
  enabled: BooleanLike;
  flag: string;
  tooltip: string;
};

type NotificationData = {
  key: string;
  enabled: BooleanLike;
  desc: string;
};

export const GhostMenu = (props) => {
  const { act, data } = useBackend<Data>();
  const { has_fun, can_boo } = data;
  return (
    <Window
      title="Меню призрака"
      width={500}
      height={630}
      buttons={
        !!has_fun && (
          <>
            <Button
              disabled={!can_boo}
              tooltip="Пугает всё вокруг вас. Есть перезарядка."
              onClick={() => act('boo')}
            >
              Бу!
            </Button>
            <Button
              tooltip="Позволяет вселиться в любое неразумное существо."
              onClick={() => act('possess')}
            >
              Вселиться
            </Button>
          </>
        )
      }
    >
      <Window.Content>
        <Stack fill>
          <Stack.Item width="40%">
            <Section title="Игроки и раунд">
              <RoundSection />
            </Section>
            <Section title="HUD">
              <HudSection />
            </Section>
            <Section title="Настройки призрака">
              <GhostSettingsSection />
            </Section>
          </Stack.Item>
          <Stack.Item width="60%">
            <NotificationPreferences />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const RoundSection = (props) => {
  const { act, data } = useBackend<Data>();
  const { body_name } = data;
  return (
    <>
      {!!body_name && (
        <ImageButton
          fluid
          dmIcon="icons/mob/simple/mob.dmi"
          dmIconState="ghost"
          tooltip="Нажмите, чтобы вернуться в своё тело."
          onClick={() => act('return_to_body')}
          fontSize="11px"
          buttons={
            <Button.Confirm
              icon="ghost"
              tooltip="Отказаться от реанимации и навсегда покинуть своё тело."
              onClick={() => act('DNR')}
            />
          }
        >
          Вернуться в тело: {body_name}
        </ImageButton>
      )}
      <ImageButton
        fluid
        dmIcon="icons/obj/machines/wallmounts.dmi"
        dmIconState="newscaster_off"
        onClick={() => act('crew_manifest')}
        fontSize="11px"
      >
        Список жителей
      </ImageButton>
      <ImageButton
        fluid
        dmIcon="icons/obj/aicards.dmi"
        dmIconState="pai"
        onClick={() => act('signup_pai')}
        fontSize="11px"
      >
        Записаться в пИИ
      </ImageButton>
    </>
  );
};

const HudSection = (props) => {
  const { act, data } = useBackend<Data>();
  const { hud_info, lag_switch_on } = data;
  return (
    <Stack vertical>
      {hud_info.map((individual_hud) => (
        <Stack.Item key={individual_hud.name}>
          <Button
            fluid
            icon={individual_hud.enabled ? 'check' : 'times'}
            color={individual_hud.enabled ? 'good' : 'bad'}
            tooltip={individual_hud.tooltip}
            onClick={() =>
              act('toggle_visibility', { toggling: individual_hud.flag })
            }
          >
            {individual_hud.name}
          </Button>
        </Stack.Item>
      ))}
      {!lag_switch_on && (
        <Button
          tooltip="Просвечивает терагерцовым сканером место, где вы находитесь."
          onClick={() => act('tray_scan')}
        >
          Т-сканирование
        </Button>
      )}
    </Stack>
  );
};

const GhostSettingsSection = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    current_darkness,
    darkness_levels,
    max_extra_view,
    current_extra_view,
    lag_switch_on,
  } = data;
  return (
    <Stack vertical>
      <Stack.Item>
        <Dropdown
          options={darkness_levels}
          selected={current_darkness}
          onSelected={(value) =>
            act('darkness', {
              darkness_level: value,
            })
          }
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          fluid
          tooltip="Возвращает призраку внешность и имя из настроек персонажа."
          onClick={() => act('restore_appearance')}
        >
          Вернуть облик персонажа
        </Button>
      </Stack.Item>
      {!lag_switch_on && (
        <Stack.Item mx={1}>
          Доп. дальность обзора:
          <NumberInput
            width="30px"
            step={1}
            value={current_extra_view}
            minValue={0}
            maxValue={max_extra_view}
            onChange={(new_range) =>
              act('view_range', {
                new_view_range: new_range,
              })
            }
          />
        </Stack.Item>
      )}
    </Stack>
  );
};

const NotificationPreferences = (props) => {
  const { act, data } = useBackend<Data>();
  const { notification_data } = data;
  if (!notification_data) {
    return 'Уведомлений нет!';
  }

  const ignores = notification_data.sort((a, b) => {
    const descA = a.desc.toLowerCase();
    const descB = b.desc.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });

  return (
    <Section
      scrollable
      fill
      title="Уведомления о ролях для призраков"
      buttons={
        <>
          <Button
            icon="check"
            color="good"
            tooltip="Включить все уведомления"
            onClick={() => act('turn_all_on')}
          />
          <Button
            icon="times"
            color="bad"
            tooltip="Выключить все уведомления"
            onClick={() => act('turn_all_off')}
          />
        </>
      }
    >
      {ignores.map((ignore) => (
        <Button
          fluid
          key={ignore.key}
          icon={ignore.enabled ? 'times' : 'check'}
          color={ignore.enabled ? 'bad' : 'good'}
          onClick={() => act('change_notification', { key: ignore.key })}
        >
          {ignore.desc}
        </Button>
      ))}
    </Section>
  );
};
