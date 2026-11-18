import { storage } from 'common/storage';
import { store } from '../events/store';
import { type ChatEmote, emotesAtom } from './atoms';

const EMOTES_STORAGE_KEY = 'tgui-chat-emotes';
/** Keep in sync with CHAT_EMOTES_MAX in chat_emotes.dm */
const MAX_EMOTES = 45;

function isEmote(value: unknown): value is ChatEmote {
  const emote = value as ChatEmote;
  return (
    !!emote &&
    typeof emote.name === 'string' &&
    ['emote', 'custom', 'me'].includes(emote.type)
  );
}

function setEmotes(emotes: ChatEmote[]) {
  store.set(emotesAtom, emotes);
  storage.set(EMOTES_STORAGE_KEY, emotes);
}

export async function loadEmotes() {
  const stored = await storage.get(EMOTES_STORAGE_KEY);
  if (Array.isArray(stored)) {
    store.set(emotesAtom, stored.filter(isEmote));
  }
}

export function handleEmotesAdd(payload: { emote: ChatEmote }) {
  const emotes = store.get(emotesAtom);
  const { emote } = payload;
  if (
    !isEmote(emote) ||
    emotes.length >= MAX_EMOTES ||
    emotes.some((e) => e.name === emote.name)
  ) {
    return;
  }
  setEmotes([...emotes, emote]);
}

export function handleEmotesUpdate(payload: {
  name: string;
  emote: ChatEmote;
}) {
  const emotes = store.get(emotesAtom);
  const { name, emote } = payload;
  if (
    !isEmote(emote) ||
    (emote.name !== name && emotes.some((e) => e.name === emote.name))
  ) {
    return;
  }
  setEmotes(emotes.map((e) => (e.name === name ? emote : e)));
}

export function handleEmotesRemove(payload: { name: string }) {
  setEmotes(store.get(emotesAtom).filter((e) => e.name !== payload.name));
}

export function handleEmotesMoveLeft(payload: { name: string }) {
  const emotes = [...store.get(emotesAtom)];
  const index = emotes.findIndex((e) => e.name === payload.name);
  if (index < 1) return;
  [emotes[index - 1], emotes[index]] = [emotes[index], emotes[index - 1]];
  setEmotes(emotes);
}
