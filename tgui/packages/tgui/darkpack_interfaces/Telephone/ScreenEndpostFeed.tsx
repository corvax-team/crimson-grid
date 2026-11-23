// THIS IS A CRIMSON UI FILE
// Replaces the darkpack ScreenEndpost: comments, replies, likes, deleting what you wrote, phone numbers that open the dial pad
import { useEffect, useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Button, Icon, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { type Data, NavigableApps } from '.';

const MAX_LENGTH = 140;

export type EndpostComment = {
  id: number;
  author: string;
  /** Name of whoever this comment answers, null for a plain comment */
  reply_to: string | null;
  body: string;
  time: string;
  mine: BooleanLike;
};

export type EndpostPost = {
  id: number;
  author: string;
  body: string;
  date: string;
  time: string;
  mine: BooleanLike;
  likes: number;
  liked: BooleanLike;
  comments: EndpostComment[];
};

type SetApp = React.Dispatch<React.SetStateAction<NavigableApps | null>>;
type Dial = (number: string) => void;

// Written in a row or in groups split by spaces and dashes: a mobile number, ten digits 3-3-4, maybe with the country code 1 in front;
// or a landline, ten digits starting with 1, grouped 1-3-3-3
const PHONE_NUMBER =
  /(?:\+?1[ -]?)?\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}|1[ -]?\(?\d{3}\)?[ -]?\d{3}[ -]?\d{3}/g;
const DIGIT = /\d/;

/** Text as written, with the phone numbers in it made into links to the dial pad */
const TextWithNumbers = (props: { text: string; dial: Dial }) => {
  const { text, dial } = props;
  const parts: React.ReactNode[] = [];
  let plainFrom = 0;
  for (const match of text.matchAll(PHONE_NUMBER)) {
    const start = match.index;
    const end = start + match[0].length;
    // Part of a longer run of digits is not a phone number
    if (DIGIT.test(text.charAt(start - 1)) || DIGIT.test(text.charAt(end))) {
      continue;
    }
    // Every number in the game is ten digits; an eleventh in front is the country code of a mobile and is not dialled
    const digits = match[0].replace(/\D/g, '').slice(-10);
    parts.push(text.slice(plainFrom, start));
    parts.push(
      <Box
        as="span"
        key={start}
        color="#4a90e2"
        style={{ cursor: 'pointer', textDecoration: 'underline' }}
        onClick={() => dial(digits)}
      >
        {match[0]}
      </Box>,
    );
    plainFrom = end;
  }
  parts.push(text.slice(plainFrom));
  return <>{parts}</>;
};

const TextBox = (props: {
  value: string;
  setValue: (value: string) => void;
  placeholder: string;
}) => {
  const { value, setValue, placeholder } = props;
  return (
    <>
      <textarea
        placeholder={placeholder}
        value={value}
        onChange={(e) => setValue(e.target.value.slice(0, MAX_LENGTH))}
        maxLength={MAX_LENGTH}
        style={{
          width: '100%',
          padding: '0.5em',
          borderRadius: '4px',
          border: '1px solid #ccc',
          fontSize: '0.9em',
          boxSizing: 'border-box',
          minHeight: '40px',
          resize: 'vertical',
        }}
      />
      <Box fontSize="0.75em" color="#999" textAlign="right">
        {value.length}/{MAX_LENGTH}
      </Box>
    </>
  );
};

const Post = (props: {
  post: EndpostPost;
  canModerate: boolean;
  dial: Dial;
}) => {
  const { post, canModerate, dial } = props;
  const { act, data } = useBackend<Data>();
  const { endpost_username } = data;
  const [open, setOpen] = useState(false);
  const [reply, setReply] = useState('');
  /** Id of the comment being answered, null when writing a plain comment */
  const [replyTo, setReplyTo] = useState<number | null>(null);
  // The comment may be deleted while the answer is being written; then it goes out as a plain comment
  const answered = post.comments.find((comment) => comment.id === replyTo);

  const sendReply = () => {
    if (!reply.trim()) {
      return;
    }
    act('endpost_comment', {
      post: post.id,
      body: reply,
      reply_to: answered?.id,
    });
    setReply('');
    setReplyTo(null);
  };

  return (
    <Box p={1.5} style={{ borderBottom: '1px solid #e0e0e0' }}>
      <Stack align="center" mb={0.5}>
        <Stack.Item grow bold color="#4a90e2">
          {post.author}
        </Stack.Item>
        <Stack.Item fontSize="0.8em" color="#999" textAlign="right">
          {post.date}
          <br />
          {post.time}
        </Stack.Item>
        {(!!post.mine || canModerate) && (
          <Stack.Item>
            <Button
              icon="trash"
              color="transparent"
              textColor="#999"
              onClick={() => act('endpost_delete', { post: post.id })}
            />
          </Stack.Item>
        )}
      </Stack>
      <Box style={{ whiteSpace: 'pre-wrap', wordBreak: 'break-word' }}>
        <TextWithNumbers text={post.body} dial={dial} />
      </Box>
      <Stack mt={0.5} color="#888" fontSize="0.85em">
        <Stack.Item
          mr={1.5}
          color={post.liked ? '#e0245e' : undefined}
          style={{ cursor: 'pointer' }}
          onClick={() => act('endpost_like', { post: post.id })}
        >
          <Icon name="heart" mr={0.5} />
          {post.likes}
        </Stack.Item>
        <Stack.Item
          style={{ cursor: 'pointer' }}
          onClick={() => setOpen(!open)}
        >
          <Icon name="comment" mr={0.5} />
          {post.comments.length}
        </Stack.Item>
      </Stack>
      {open && (
        <Box mt={0.5} pl={1} style={{ borderLeft: '2px solid #e0e0e0' }}>
          {post.comments.map((comment) => (
            <Box key={comment.id} mb={0.5}>
              <Stack align="center">
                <Stack.Item grow bold fontSize="0.85em" color="#4a90e2">
                  {comment.author}
                </Stack.Item>
                <Stack.Item fontSize="0.75em" color="#999">
                  {comment.time}
                </Stack.Item>
                {!!endpost_username && (
                  <Stack.Item>
                    <Button
                      icon="reply"
                      color="transparent"
                      textColor={comment.id === replyTo ? '#4a90e2' : '#999'}
                      onClick={() =>
                        setReplyTo(comment.id === replyTo ? null : comment.id)
                      }
                    />
                  </Stack.Item>
                )}
                {(!!comment.mine || canModerate) && (
                  <Stack.Item>
                    <Button
                      icon="trash"
                      color="transparent"
                      textColor="#999"
                      onClick={() =>
                        act('endpost_delete_comment', {
                          post: post.id,
                          comment: comment.id,
                        })
                      }
                    />
                  </Stack.Item>
                )}
              </Stack>
              <Box
                fontSize="0.9em"
                style={{ whiteSpace: 'pre-wrap', wordBreak: 'break-word' }}
              >
                {!!comment.reply_to && (
                  <Box as="span" bold color="#4a90e2" mr={0.5}>
                    @{comment.reply_to}
                  </Box>
                )}
                <TextWithNumbers text={comment.body} dial={dial} />
              </Box>
            </Box>
          ))}
          {endpost_username ? (
            <>
              {!!answered && (
                <Box fontSize="0.85em" mb={0.5}>
                  <Box as="span" bold color="#4a90e2">
                    @{answered.author}
                  </Box>
                  <Button
                    icon="times"
                    ml={0.5}
                    color="transparent"
                    textColor="#999"
                    onClick={() => setReplyTo(null)}
                  />
                </Box>
              )}
              <TextBox
                value={reply}
                setValue={setReply}
                placeholder="Ответить..."
              />
              <Button color="blue" disabled={!reply.trim()} onClick={sendReply}>
                Ответить
              </Button>
            </>
          ) : (
            <Box fontSize="0.85em" color="#999">
              Чтобы отвечать, нужно зарегистрироваться.
            </Box>
          )}
        </Box>
      )}
    </Box>
  );
};

export const ScreenEndpostFeed = (props: {
  setApp: SetApp;
  setEnteredNumber: React.Dispatch<React.SetStateAction<string>>;
}) => {
  const { setApp, setEnteredNumber } = props;
  const { act, data } = useBackend<Data>();
  const {
    endpost_username,
    show_endpost_registration,
    endpost_notifications,
    is_admin,
    posts,
  } = data;
  const [composing, setComposing] = useState(false);
  const [body, setBody] = useState('');

  // The feed comes only while this screen is open: phones on other apps are not sent it
  useEffect(() => {
    act('endpost_open');
    return () => act('endpost_close');
  }, []);

  const submit = () => {
    if (!body.trim()) {
      return;
    }
    act('submit_post', { body });
    setBody('');
    setComposing(false);
  };

  const dial: Dial = (number) => {
    setEnteredNumber(number);
    setApp(NavigableApps.Phone);
  };

  return (
    <Stack vertical fill backgroundColor="#fff" textColor="#000">
      <Stack.Item backgroundColor="#4a90e2" textColor="#fff" p={1}>
        <Stack align="center">
          <Stack.Item
            onClick={() => setApp(null)}
            style={{ cursor: 'pointer' }}
          >
            <Icon name="arrow-left" />
          </Stack.Item>
          <Stack.Item grow>EndPost</Stack.Item>
          <Stack.Item>
            <Button
              color="transparent"
              textColor="#fff"
              tooltip={
                endpost_notifications
                  ? 'Выключить уведомления о новых постах'
                  : 'Включить уведомления о новых постах'
              }
              onClick={() => act('toggle_endpost_notifications')}
            >
              <Icon name={endpost_notifications ? 'bell' : 'bell-slash'} />
            </Button>
          </Stack.Item>
          <Stack.Item>
            {show_endpost_registration ? (
              <Button
                color="transparent"
                textColor="#fff"
                onClick={() => act('endpost_registration')}
              >
                {endpost_username ? 'Сменить имя' : 'Регистрация'}
              </Button>
            ) : (
              endpost_username
            )}
          </Stack.Item>
          {!composing && !!endpost_username && (
            <Stack.Item>
              <Button
                icon="plus"
                color="transparent"
                textColor="#fff"
                onClick={() => setComposing(true)}
              />
            </Stack.Item>
          )}
        </Stack>
      </Stack.Item>
      {composing && (
        <Stack.Item
          backgroundColor="#f5f5f5"
          p={1}
          style={{ borderBottom: '1px solid #ddd' }}
        >
          {endpost_username ? (
            <>
              <TextBox
                value={body}
                setValue={setBody}
                placeholder="Что у вас нового?"
              />
              <Stack>
                <Stack.Item>
                  <Button color="blue" disabled={!body.trim()} onClick={submit}>
                    Опубликовать
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button color="gray" onClick={() => setComposing(false)}>
                    Отмена
                  </Button>
                </Stack.Item>
              </Stack>
            </>
          ) : (
            <Box color="#d32f2f">
              Чтобы писать посты, нужно зарегистрироваться.
            </Box>
          )}
        </Stack.Item>
      )}
      <Stack.Item grow mb={6} style={{ overflowY: 'auto' }}>
        {posts.length === 0 ? (
          <Box p={2} textAlign="center" color="#999">
            Постов пока нет.
          </Box>
        ) : (
          [...posts]
            .reverse()
            .map((post) => (
              <Post
                key={post.id}
                post={post}
                canModerate={!!is_admin}
                dial={dial}
              />
            ))
        )}
      </Stack.Item>
    </Stack>
  );
};
