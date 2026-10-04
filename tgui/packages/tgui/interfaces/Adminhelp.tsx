import { useState } from 'react';
import {
  Box,
  Button,
  Input,
  NoticeBox,
  Stack,
  TextArea,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type AdminhelpData = {
  adminCount: number;
  urgentAhelpEnabled: BooleanLike;
  bannedFromUrgentAhelp: BooleanLike;
  urgentAhelpPromptMessage: string;
};

export const Adminhelp = (props) => {
  const { act, data } = useBackend<AdminhelpData>();
  const {
    adminCount,
    urgentAhelpEnabled,
    bannedFromUrgentAhelp,
    urgentAhelpPromptMessage,
  } = data;
  const [requestForAdmin, setRequestForAdmin] = useState(false);
  const [currentlyInputting, setCurrentlyInputting] = useState(false);
  const [ahelpMessage, setAhelpMessage] = useState('');

  const confirmationText = 'alert admins';
  return (
    <Window
      title="Обращение к администрации"
      theme="admin"
      height={300}
      width={500}
    >
      <Window.Content
        style={{
          backgroundImage: 'none',
        }}
      >
        <Stack vertical fill>
          <Stack.Item grow>
            <TextArea
              autoFocus
              height="100%"
              fluid
              placeholder="Опишите проблему"
              onChange={setAhelpMessage}
            />
          </Stack.Item>
          {urgentAhelpEnabled && adminCount <= 0 && (
            <Stack.Item>
              <NoticeBox info>
                {urgentAhelpPromptMessage}
                {currentlyInputting ? (
                  <Box
                    mt={1}
                    width="100%"
                    fontFamily="arial"
                    backgroundColor="grey"
                    style={{
                      fontStyle: 'normal',
                    }}
                  >
                    Введите &apos;{confirmationText}&apos;, чтобы продолжить.
                    <Input
                      placeholder="Подтверждение"
                      autoFocus
                      fluid
                      onChange={(value) => {
                        if (value === confirmationText) {
                          setRequestForAdmin(true);
                          setCurrentlyInputting(false);
                        }
                      }}
                    />
                  </Box>
                ) : (
                  <Button
                    mt={1}
                    onClick={() => {
                      if (requestForAdmin) {
                        setRequestForAdmin(false);
                      } else {
                        setCurrentlyInputting(true);
                      }
                    }}
                    color={requestForAdmin ? 'orange' : 'blue'}
                    icon={requestForAdmin ? 'check-square-o' : 'square-o'}
                    disabled={bannedFromUrgentAhelp}
                    tooltip={
                      bannedFromUrgentAhelp
                        ? 'Вам запрещено отправлять срочные обращения.'
                        : undefined
                    }
                    fluid
                    textAlign="center"
                  >
                    Вызвать админов?
                  </Button>
                )}
              </NoticeBox>
            </Stack.Item>
          )}
          <Stack.Item>
            <Button
              color="good"
              fluid
              textAlign="center"
              onClick={() =>
                act('ahelp', {
                  urgent: requestForAdmin,
                  message: ahelpMessage,
                })
              }
            >
              Отправить
            </Button>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
