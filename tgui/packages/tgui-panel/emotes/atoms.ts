import { atom } from 'jotai';

export type ChatEmote = {
  name: string;
  type: 'emote' | 'custom' | 'me';
  key?: string;
  text?: string;
};

export const emotesAtom = atom<ChatEmote[]>([]);
export const emotesVisibleAtom = atom(false);
