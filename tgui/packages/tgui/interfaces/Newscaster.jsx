/**
 * @file
 * @author Original by ArcaneMusic (https://github.com/ArcaneMusic)
 * @author Changes Shadowh4nD/jlsnow301
 * @license MIT
 */

import { useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  Divider,
  Image,
  LabeledList,
  Modal,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend, useSharedState } from '../backend';
import { processedText } from '../process';
import { BountyBoardContent } from './BountyBoard';
import { LoadingScreen } from './common/LoadingScreen';
import { UserDetails } from './Vending';

const CENSOR_MESSAGE =
  'Этот канал признан угрозой общественному \
  порядку и закрыт цензурой.';

export const Newscaster = (props) => {
  const { act, data } = useBackend();
  const NEWSCASTER_SCREEN = 1;
  const BOUNTYBOARD_SCREEN = 2;
  const [screenmode, setScreenmode] = useSharedState(
    'tab_main',
    NEWSCASTER_SCREEN,
  );

  return (
    <>
      <NewscasterChannelCreation />
      <NewscasterCommentCreation />
      <Stack fill vertical>
        <NewscasterWantedScreen />
        <Stack.Item>
          <Tabs fluid textAlign="center">
            <Tabs.Tab
              color="Green"
              selected={screenmode === NEWSCASTER_SCREEN}
              onClick={() => setScreenmode(NEWSCASTER_SCREEN)}
            >
              Новости
            </Tabs.Tab>
            <Tabs.Tab
              Color="Blue"
              selected={screenmode === BOUNTYBOARD_SCREEN}
              onClick={() => setScreenmode(BOUNTYBOARD_SCREEN)}
            >
              Доска заказов
            </Tabs.Tab>
          </Tabs>
        </Stack.Item>
        <Stack.Item grow>
          {screenmode === NEWSCASTER_SCREEN && <NewscasterContent />}
          {screenmode === BOUNTYBOARD_SCREEN && <BountyBoardContent />}
        </Stack.Item>
      </Stack>
    </>
  );
};

/** The modal menu that contains the prompts to making new channels. */
const NewscasterChannelCreation = (props) => {
  const { act, data } = useBackend();
  const [lockedmode, setLockedmode] = useState(true);
  const [cross_sector, setcross_sector] = useState(false);
  const { creating_channel, awaiting_approval, name, desc } = data;

  if (awaiting_approval) {
    return <LoadingScreen label="Ожидается одобрение..." />;
  }

  if (!creating_channel) {
    return null;
  }

  return (
    <Modal textAlign="center" mr={1.5}>
      <Stack vertical>
        <Stack.Item>
          <Box pb={1}>
            Название канала:
            <Button
              color="red"
              icon="times"
              position="relative"
              top="20%"
              left="15%"
              onClick={() => act('cancelCreation')}
            />
          </Box>
          <TextArea
            height="40px"
            width="240px"
            backgroundColor="black"
            textColor="white"
            maxLength={42}
            onBlur={(value) =>
              act('setChannelName', {
                channeltext: value,
              })
            }
          >
            Название канала
          </TextArea>
        </Stack.Item>
        <Stack.Item>
          <Box pb={1}>Описание канала:</Box>
          <TextArea
            height="150px"
            width="240px"
            backgroundColor="black"
            textColor="white"
            maxLength={512}
            onBlur={(value) =>
              act('setChannelDesc', {
                channeldesc: value,
              })
            }
          >
            Описание канала
          </TextArea>
        </Stack.Item>
        <Stack.Item>
          <Section>
            Канал будет публичным или личным
            <Box pt={1}>
              <Button
                selected={!lockedmode}
                disabled={cross_sector}
                onClick={() => setLockedmode(false)}
              >
                Публичный
              </Button>
              <Button
                selected={!!lockedmode}
                disabled={cross_sector}
                onClick={() => setLockedmode(true)}
              >
                Личный
              </Button>
            </Box>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            fluid
            checked={cross_sector}
            onClick={() => {
              setcross_sector(!cross_sector);
              setLockedmode(true);
            }}
            tooltip="Каждую статью межсекторного канала придётся согласовывать. Такие каналы автоматически закрыты для чужих публикаций."
            tooltipPosition="bottom-start"
          >
            Сделать межсекторным?
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Box>
            <Button
              onClick={() =>
                act('createChannel', {
                  cross_sector: cross_sector,
                  lockedmode: lockedmode,
                })
              }
            >
              Создать канал
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Modal>
  );
};

/** The modal menu that contains the prompts to making new comments. */
const NewscasterCommentCreation = (props) => {
  const { act, data } = useBackend();
  const { creating_comment, viewing_message } = data;
  if (!creating_comment) {
    return null;
  }
  return (
    <Modal textAlign="center" mr={1.5}>
      <Stack vertical>
        <Stack.Item>
          <Box pb={1}>
            Комментарий:
            <Button
              color="red"
              position="relative"
              icon="times"
              top="20%"
              left="25%"
              onClick={() => act('cancelCreation')}
            />
          </Box>
          <TextArea
            height="120px"
            width="240px"
            backgroundColor="black"
            textColor="white"
            maxLength={512}
            onBlur={(value) =>
              act('setCommentBody', {
                commenttext: value,
              })
            }
          >
            Название канала
          </TextArea>
        </Stack.Item>
        <Stack.Item>
          <Box>
            <Button
              onClick={() =>
                act('createComment', {
                  messageID: viewing_message,
                })
              }
            >
              Отправить комментарий
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Modal>
  );
};

const NewscasterWantedScreen = (props) => {
  const { act, data } = useBackend();
  const {
    viewing_wanted,
    photo_data,
    security_mode,
    wanted = [],
    criminal_name,
    crime_description,
  } = data;
  if (!viewing_wanted) {
    return null;
  }
  return (
    <Modal textAlign="center" mr={1} width={25}>
      {wanted.map((activeWanted) => (
        <>
          <Stack vertical>
            <Stack.Item>
              <Box bold color="red">
                {activeWanted.active ? 'Активный розыск:' : 'Розыск прекращён:'}
                <Button
                  color="red"
                  position="relative"
                  icon="times"
                  top="20%"
                  left="15%"
                  onClick={() => act('cancelCreation')}
                />
              </Box>
              {!!activeWanted.criminal && (
                <>
                  <Section>
                    <Box bold>{activeWanted.criminal}</Box>
                    <Box italic>{activeWanted.crime}</Box>
                  </Section>
                  <Image src={activeWanted.image ? activeWanted.image : null} />
                  <Box italic>
                    Опубликовал:{' '}
                    {activeWanted.author ? activeWanted.author : 'Н/Д'}
                  </Box>
                </>
              )}
            </Stack.Item>
          </Stack>
          <Divider />
        </>
      ))}
      {security_mode ? (
        <>
          <LabeledList>
            <LabeledList.Item label="Имя преступника">
              <Button
                disabled={!security_mode}
                icon="pen"
                onClick={() => act('setCriminalName')}
              >
                {criminal_name ? criminal_name : ' N/A'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Преступление">
              <Button
                nowrap={false}
                disabled={!security_mode}
                icon="pen"
                onClick={() => act('setCrimeData')}
              >
                {crime_description ? crime_description : ' N/A'}
              </Button>
            </LabeledList.Item>
          </LabeledList>
          <Section>
            <Button
              icon="camera"
              selected={photo_data}
              disabled={!security_mode}
              onClick={() => act('togglePhoto')}
            >
              {photo_data ? 'Убрать фото' : 'Прикрепить фото'}
            </Button>
            <Button
              disabled={!security_mode}
              icon="volume-up"
              onClick={() => act('submitWantedIssue')}
            >
              Объявить розыск
            </Button>
            <Button
              disabled={!security_mode}
              icon="times"
              color="red"
              onClick={() => act('clearWantedIssue')}
            >
              Снять розыск
            </Button>
          </Section>
        </>
      ) : (
        <Box>
          {wanted.map((activeWanted) =>
            activeWanted.active
              ? 'Если увидите этого человека, сообщите в полицию.'
              : 'Сейчас никто не разыскивается. Спокойного дня.',
          )}
        </Box>
      )}
    </Modal>
  );
};

const NewscasterContent = (props) => {
  const { act, data } = useBackend();
  const { current_channel = {} } = data;
  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item grow>
            <NewscasterChannelSelector />
          </Stack.Item>
          <Stack.Item grow={2}>
            <Stack fill vertical>
              <Stack.Item>
                <UserDetails />
              </Stack.Item>
              <Stack.Item grow>
                <NewscasterChannelBox
                  channelName={current_channel.name}
                  channelOwner={current_channel.owner}
                  channelDesc={current_channel.desc}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <NewscasterChannelMessages />
      </Stack.Item>
    </Stack>
  );
};

/** The Channel Box is the basic channel information where buttons live.*/
const NewscasterChannelBox = (props) => {
  const { act, data } = useBackend();
  const {
    channelName,
    channelDesc,
    channelLocked,
    channelAuthor,
    channelCensored,
    receivingCrossSector,
    viewing_channel,
    admin_mode,
    photo_data,
    paper,
    user,
  } = data;
  return (
    <Section fill title={channelName}>
      <Stack fill vertical>
        <Stack.Item grow>
          {channelCensored ? (
            <Section>
              <BlockQuote color="red">
                <b>ВНИМАНИЕ:</b> {CENSOR_MESSAGE}
              </BlockQuote>
            </Section>
          ) : (
            <Section fill scrollable>
              <BlockQuote italic fontSize={1.2} wrap>
                {decodeHtmlEntities(channelDesc)}
              </BlockQuote>
            </Section>
          )}
        </Stack.Item>
        <Stack.Item>
          <Box>
            <Button
              icon="print"
              disabled={
                (channelLocked && channelAuthor !== user.name) ||
                channelCensored ||
                receivingCrossSector
              }
              onClick={() => act('createStory', { current: viewing_channel })}
              mt={1}
            >
              Опубликовать статью
            </Button>
            <Button
              icon="camera"
              selected={photo_data}
              disabled={
                (channelLocked && channelAuthor !== user.name) ||
                channelCensored ||
                receivingCrossSector
              }
              onClick={() => act('togglePhoto')}
            >
              Выбрать фото
            </Button>
            {!!admin_mode && (
              <Button
                icon="ban"
                tooltip="Закрыть цензурой весь канал и его содержимое."
                disabled={!admin_mode || !viewing_channel}
                onClick={() =>
                  act('channelDNotice', {
                    secure: admin_mode,
                    channel: viewing_channel,
                  })
                }
              >
                D-Notice
              </Button>
            )}
          </Box>
          <Box>
            <Button
              icon="newspaper"
              tooltip={paper <= 0 ? 'Сначала вставьте бумагу!' : ''}
              disabled={paper <= 0}
              onClick={() => act('printNewspaper')}
            >
              Напечатать газету
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

/** Channel select is the left-hand menu where all the channels are listed. */
const NewscasterChannelSelector = (props) => {
  const { act, data } = useBackend();
  const { channels = [], viewing_channel, wanted = [] } = data;
  return (
    <Section minHeight="100%" width={`${window.innerWidth - 410}px`}>
      <Tabs vertical>
        {wanted.map((activeWanted) => (
          <Tabs.Tab
            pt={0.75}
            pb={0.75}
            mr={1}
            key={activeWanted.index}
            icon={activeWanted.active ? 'skull-crossbones' : null}
            textColor={activeWanted.active ? 'red' : 'grey'}
            onClick={() => act('toggleWanted')}
          >
            Розыск
          </Tabs.Tab>
        ))}
        {channels.map((channel) => (
          <Tabs.Tab
            key={channel.index}
            pt={0.75}
            pb={0.75}
            mr={1}
            selected={viewing_channel === channel.ID}
            icon={channel.censored ? 'ban' : null}
            textColor={channel.censored ? 'red' : 'white'}
            onClick={() =>
              act('setChannel', {
                channel: channel.ID,
              })
            }
          >
            {channel.name}
          </Tabs.Tab>
        ))}
        <Tabs.Tab
          pt={0.75}
          pb={0.75}
          mr={1}
          textColor="white"
          color="Green"
          onClick={() => act('startCreateChannel')}
        >
          Создать канал [+]
        </Tabs.Tab>
      </Tabs>
    </Section>
  );
};

/** This is where the channels comments get spangled out (tm) */
const NewscasterChannelMessages = (props) => {
  const { act, data } = useBackend();
  const {
    messages = [],
    viewing_channel,
    admin_mode,
    channelCensored,
    receivingCrossSector,
    channelLocked,
    channelAuthor,
    user,
  } = data;
  if (channelCensored) {
    return (
      <Section color="red">
        <b>ВНИМАНИЕ:</b> Комментарии сейчас недоступны.
        <br />
        Спасибо за понимание и спокойного дня.
      </Section>
    );
  }
  const visibleMessages = messages.filter(
    (message) => message.ID !== viewing_channel,
  );
  return (
    <Section>
      {visibleMessages.map((message) => {
        return (
          <Section
            key={message.index}
            textColor="white"
            title={
              <i>
                {message.censored_author ? (
                  <Box textColor="red">
                    Автор: [ЗАСЕКРЕЧЕНО]. <b>Закрыто цензурой</b>.
                  </Box>
                ) : (
                  <>
                    Автор: {message.auth}, {message.time}
                  </>
                )}
              </i>
            }
            buttons={
              <>
                {!!admin_mode && (
                  <Button
                    icon="comment-slash"
                    tooltip="Закрыть статью цензурой"
                    disabled={!admin_mode}
                    onClick={() =>
                      act('storyCensor', {
                        messageID: message.ID,
                      })
                    }
                  />
                )}
                {!!admin_mode && (
                  <Button
                    icon="user-slash"
                    tooltip="Скрыть автора"
                    disabled={!admin_mode}
                    onClick={() =>
                      act('authorCensor', {
                        messageID: message.ID,
                      })
                    }
                  />
                )}
                <Button
                  icon="comment"
                  tooltip="Оставить комментарий"
                  disabled={
                    message.censored_author ||
                    message.censored_message ||
                    user.name === 'Unknown' ||
                    (!!channelLocked && channelAuthor !== user.name)
                  }
                  onClick={() =>
                    act('startComment', {
                      messageID: message.ID,
                    })
                  }
                />
              </>
            }
          >
            <BlockQuote>
              {message.censored_message ? (
                <Section textColor="red">
                  Это сообщение признано угрозой общественному порядку и{' '}
                  <b>закрыто цензурой</b>.
                </Section>
              ) : (
                <Section pl={1}>
                  <Box dangerouslySetInnerHTML={processedText(message.body)} />
                </Section>
              )}
              {message.photo !== null && !message.censored_message && (
                <Image src={message.photo} />
              )}
              {!!message.comments && (
                <Box>
                  {message.comments.map((comment) => (
                    <BlockQuote key={comment.index}>
                      <Box italic textColor="white">
                        Автор: {comment.auth}, {comment.time}
                      </Box>
                      <Section ml={2.5}>
                        <Box
                          dangerouslySetInnerHTML={processedText(comment.body)}
                        />
                      </Section>
                    </BlockQuote>
                  ))}
                </Box>
              )}
            </BlockQuote>
            <Divider />
          </Section>
        );
      })}
    </Section>
  );
};
