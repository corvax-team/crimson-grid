import {
  Button,
  Input,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';
import { chatRenderer } from 'tgui-panel/chat/renderer';
import {
  wsDisconnect,
  wsReconnect,
  wsUpdate,
} from 'tgui-panel/websocket/helpers';
import { useSettings } from './use-settings';

export function SettingsWebsocket(props) {
  const { settings, updateSettings } = useSettings();
  const { statLinked, statFontSize, statTabsStyle } = settings;

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="Вебсокет-клиент">
              <Button.Checkbox
                checked={settings.websocketEnabled}
                color="transparent"
                onClick={() => {
                  const websocketEnabled = !settings.websocketEnabled;
                  updateSettings({ websocketEnabled });
                  wsUpdate(websocketEnabled);
                }}
              >
                Включён
              </Button.Checkbox>
              <Button
                icon={'question'}
                onClick={() => {
                  chatRenderer.processBatch([
                    {
                      html:
                        '<div class="boxed_message"><b>О вебсокете</b><br><span class="notice">' +
                        'Коротко: клиент подключается к указанному вебсокет-серверу и ' +
                        'пересылает ему все данные, которые приходят от игрового сервера. Так ' +
                        'игровые события можно отражать в других сервисах или в реальном ' +
                        'мире (реактивная RGB-подсветка, тактильная отдача, эффекты и анимации ' +
                        'в программах для витуберов и т. п.). Подробнее - ' +
                        '<a href="https://github.com/tgstation/tgstation/pull/96241">в пулл-реквесте.</a></span></div>',
                    },
                  ]);
                }}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Вебсокет-сервер">
              <Stack.Item>
                <Stack>
                  <Input
                    width={'100%'}
                    value={settings.websocketServer}
                    placeholder="localhost:4242"
                    onChange={(value) =>
                      updateSettings({
                        websocketServer: value,
                      })
                    }
                  />
                </Stack>
              </Stack.Item>
            </LabeledList.Item>
            <LabeledList.Item label="Управление">
              <Button
                ml={0.5}
                icon={'globe'}
                color={'good'}
                onClick={wsReconnect}
              >
                Переподключить
              </Button>
              <Button
                ml={0.5}
                icon={'globe'}
                color={'bad'}
                onClick={wsDisconnect}
              >
                Отключить
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
