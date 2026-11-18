import { storage } from 'common/storage';
import { useAtom, useAtomValue } from 'jotai';
import { useEffect } from 'react';
import { focusMap } from 'tgui/focus';
import { Button, Flex, Section } from 'tgui-core/components';
import { hotkeysAtom } from '../verbs/atoms';
import { handleFocusCommandBar } from '../verbs/handlers';
import { type ChatEmote, emotesAtom, emotesVisibleAtom } from './atoms';
import { loadEmotes } from './handlers';

const VISIBLE_STORAGE_KEY = 'tgui-emotes-visible';

/** Loads saved buttons; returns bar visibility, persisted across sessions. */
export function useEmoteBar(): [boolean, () => void] {
  const [visible, setVisible] = useAtom(emotesVisibleAtom);

  useEffect(() => {
    loadEmotes();
    storage.get(VISIBLE_STORAGE_KEY).then((stored) => {
      if (stored !== undefined) setVisible(!!stored);
    });
  }, []);

  const toggle = () => {
    setVisible(!visible);
    storage.set(VISIBLE_STORAGE_KEY, !visible);
  };

  return [visible, toggle];
}

const EMOTE_COLORS: Record<ChatEmote['type'], string> = {
  emote: 'blue',
  custom: 'purple',
  me: 'orange',
};

function emoteTooltip(emote: ChatEmote): string {
  switch (emote.type) {
    case 'emote':
      return `*${emote.key}`;
    case 'custom':
      return `*${emote.key} | "${emote.text}"`;
    case 'me':
      return `"${emote.text}"`;
  }
}

/** Emote shortcut buttons above the chat. LMB runs, RMB opens the button menu. */
export function EmoteBar() {
  const emotes = useAtomValue(emotesAtom);
  const hotkeys = useAtomValue(hotkeysAtom);

  // panelFocus.ts leaves focus on a clicked Button, so the first WASD press
  // would go to the chat instead of the map. Return focus where it belongs.
  const executeEmote = (emote: ChatEmote) => {
    Byond.sendMessage('emotes/execute', { emote });
    (document.activeElement as HTMLElement | null)?.blur();
    if (hotkeys) {
      focusMap();
    } else {
      handleFocusCommandBar();
    }
  };

  // Server checks name uniqueness in its dialogs, but keeps no state
  const names = emotes.map((emote) => emote.name);

  return (
    <Section>
      <Flex wrap="wrap" align="center">
        {emotes.map((emote, index) => (
          <Flex.Item key={emote.name} mr={0.5} mb={0.5}>
            <Button
              color={EMOTE_COLORS[emote.type]}
              tooltip={emoteTooltip(emote)}
              tooltipPosition="bottom"
              onClick={() => executeEmote(emote)}
              onContextMenu={(event) => {
                event.preventDefault();
                Byond.sendMessage('emotes/contextAction', {
                  emote,
                  names,
                  canMoveLeft: index > 0,
                });
              }}
            >
              {emote.name}
            </Button>
          </Flex.Item>
        ))}
        <Flex.Item mb={0.5}>
          <Button
            icon="plus"
            color="green"
            tooltip={
              emotes.length > 0
                ? 'Добавить эмоцию (ПКМ по кнопке — изменить/удалить)'
                : 'Добавить эмоцию'
            }
            tooltipPosition="bottom"
            onClick={() =>
              Byond.sendMessage('emotes/create', {
                names,
              })
            }
          />
        </Flex.Item>
      </Flex>
    </Section>
  );
}
