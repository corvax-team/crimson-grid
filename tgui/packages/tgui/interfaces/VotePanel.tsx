import {
  BlockQuote,
  Box,
  Button,
  Dimmer,
  Icon,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

enum VoteConfig {
  None = -1,
  Disabled = 0,
  Enabled = 1,
}

type Vote = {
  name: string;
  displayName?: string;
  canBeInitiated: BooleanLike;
  config: VoteConfig;
  message: string;
};

type Option = {
  name: string;
  label?: string;
  votes: number;
};

type ActiveVote = {
  vote: Vote;
  question: string | null;
  timeRemaining: number;
  displayStatistics: boolean;
  choices: Option[];
  countMethod: number;
};

type UserData = {
  ckey: string;
  isGhost: BooleanLike;
  isLowerAdmin: BooleanLike;
  isUpperAdmin: BooleanLike;
  singleSelection: string | null;
  multiSelection: string[] | null;
  countMethod: VoteSystem;
};

enum VoteSystem {
  VOTE_SINGLE = 1,
  VOTE_MULTI = 2,
}

type Data = {
  currentVote: ActiveVote;
  possibleVotes: Vote[];
  user: UserData;
  LastVoteTime: number;
  VoteCD: number;
  deadVoteEnabled: BooleanLike;
};

export const VotePanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user, LastVoteTime, VoteCD } = data;

  let windowTitle = 'Голосование';
  if (currentVote) {
    windowTitle +=
      ': ' +
      (
        currentVote.question ||
        currentVote.vote.displayName ||
        currentVote.vote.name
      ).replace(/^\w/, (c) =>
        c.toUpperCase(),
      );
  }

  return (
    <Window title={windowTitle} width={400} height={500}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section
              title="Новое голосование"
              buttons={
                !!user.isLowerAdmin && (
                  <Stack>
                    <Stack.Item>
                      <Button
                        icon="refresh"
                        disabled={LastVoteTime + VoteCD <= 0}
                        onClick={() => act('resetCooldown')}
                      >
                        Сбросить перезарядку
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <Button.Checkbox
                        disabled={!user.isUpperAdmin}
                        onClick={() => act('toggleDeadVote')}
                        checked={!data.deadVoteEnabled}
                        color="primary"
                      >
                        Голоса мёртвых
                      </Button.Checkbox>
                    </Stack.Item>
                  </Stack>
                )
              }
            >
              <VoteOptions />
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section fill scrollable title="Текущее голосование">
              <ChoicesPanel />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section>
              <TimePanel />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const VoteOptionDimmer = (props) => {
  const { data } = useBackend<Data>();
  const { LastVoteTime, VoteCD } = data;

  return (
    <Dimmer>
      <Box textAlign="center">
        <Box fontSize={2} bold>
          Перезарядка голосования
        </Box>
        <Box fontSize={1.5}>{Math.floor((VoteCD + LastVoteTime) / 10)} с</Box>
      </Box>
    </Dimmer>
  );
};

const VoteOptions = (props) => {
  const { act, data } = useBackend<Data>();
  const { possibleVotes, user, LastVoteTime, VoteCD } = data;

  return (
    <Stack.Item>
      {LastVoteTime + VoteCD > 0 && <VoteOptionDimmer />}
      <Stack vertical justify="space-between">
        {possibleVotes.map((option) => (
          <Stack.Item key={option.name}>
            <Stack>
              {!!user.isLowerAdmin && (
                <Stack.Item>
                  <Button.Checkbox
                    color="primary"
                    checked={
                      option.config === VoteConfig.Enabled ||
                      option.config === VoteConfig.None
                    }
                    disabled={
                      !user.isUpperAdmin || option.config === VoteConfig.None
                    }
                    tooltip={
                      option.config === VoteConfig.None
                        ? 'Это голосование нельзя отключить.'
                        : null
                    }
                    onClick={() =>
                      act('toggleVote', {
                        voteName: option.name,
                      })
                    }
                  >
                    Включено
                  </Button.Checkbox>
                </Stack.Item>
              )}
              <Stack.Item>
                <Button
                  disabled={!option.canBeInitiated}
                  onClick={() =>
                    act('callVote', {
                      voteName: option.name,
                    })
                  }
                  icon="play"
                />
              </Stack.Item>
              <Stack.Item>
                <Tooltip content={option.message}>
                  <BlockQuote style={{ lineHeight: '1.7em' }}>
                    Голосование: {option.displayName || option.name}
                  </BlockQuote>
                </Tooltip>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        ))}
      </Stack>
    </Stack.Item>
  );
};

const ChoicesPanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user } = data;

  return (
    <>
      {currentVote && currentVote.countMethod === VoteSystem.VOTE_SINGLE ? (
        <NoticeBox success>Выберите один вариант</NoticeBox>
      ) : null}
      {currentVote &&
      currentVote.choices.length !== 0 &&
      currentVote.countMethod === VoteSystem.VOTE_SINGLE ? (
        <LabeledList>
          {currentVote.choices.map((choice) => (
            <Box key={choice.name}>
              <LabeledList.Item
                label={(choice.label || choice.name).replace(/^\w/, (c) =>
                  c.toUpperCase(),
                )}
                textAlign="right"
                buttons={
                  <Button
                    tooltip={
                      user.isGhost && 'Администратор запретил призракам голосовать.'
                    }
                    disabled={
                      user.singleSelection === choice.name || user.isGhost
                    }
                    onClick={() => {
                      act('voteSingle', { voteOption: choice.name });
                    }}
                  >
                    Голосовать
                  </Button>
                }
              >
                {user.singleSelection &&
                  choice.name === user.singleSelection && (
                    <Icon align="right" mr={2} color="green" name="vote-yea" />
                  )}
                {(currentVote.displayStatistics || user.isLowerAdmin) ? `${choice.votes} Votes` : null}
              </LabeledList.Item>
              <LabeledList.Divider />
            </Box>
          ))}
        </LabeledList>
      ) : null}
      {currentVote && currentVote.countMethod === VoteSystem.VOTE_MULTI ? (
        <NoticeBox success>Выберите сколько угодно вариантов</NoticeBox>
      ) : null}
      {currentVote &&
      currentVote.choices.length !== 0 &&
      currentVote.countMethod === VoteSystem.VOTE_MULTI ? (
        <LabeledList>
          {currentVote.choices.map((choice) => (
            <Box key={choice.name}>
              <LabeledList.Item
                label={(choice.label || choice.name).replace(/^\w/, (c) =>
                  c.toUpperCase(),
                )}
                textAlign="right"
                buttons={
                  <Button
                    tooltip={
                      user.isGhost && 'Администратор запретил призракам голосовать.'
                    }
                    disabled={user.isGhost}
                    onClick={() => {
                      act('voteMulti', { voteOption: choice.name });
                    }}
                  >
                    Голосовать
                  </Button>
                }
              >
                {user.multiSelection &&
                user.multiSelection[user.ckey.concat(choice.name)] === 1 ? (
                  <Icon align="right" mr={2} color="blue" name="vote-yea" />
                ) : null}
                {choice.votes} Votes
              </LabeledList.Item>
              <LabeledList.Divider />
            </Box>
          ))}
        </LabeledList>
      ) : null}
      {currentVote ? null : <NoticeBox>Голосование не идёт!</NoticeBox>}
    </>
  );
};

const TimePanel = (props) => {
  const { act, data } = useBackend<Data>();
  const { currentVote, user } = data;

  return (
    <Stack.Item>
      <Stack justify="space-between">
        <Box fontSize={1.5}>
          {currentVote
            ? `Осталось времени: ${currentVote.timeRemaining} с`
            : 'Голосование не идёт'}
        </Box>
        {!!user.isLowerAdmin && (
          <Stack>
            <Stack.Item>
              <Button
                color="green"
                disabled={!user.isLowerAdmin || !currentVote}
                onClick={() => act('endNow')}
                style={{ lineHeight: '1.8em' }}
              >
                Завершить сейчас
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                color="red"
                disabled={!user.isLowerAdmin || !currentVote}
                onClick={() => act('cancel')}
                style={{ lineHeight: '1.8em' }}
              >
                Отменить
              </Button>
            </Stack.Item>
          </Stack>
        )}
      </Stack>
    </Stack.Item>
  );
};
