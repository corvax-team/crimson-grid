// THIS IS A CORVAX UI FILE
import { expect, it } from 'bun:test';
import { act, render } from '@testing-library/react';
import { gameDataAtom, store } from '../../events/store';
import { TicketMessage } from './TicketMessage';

it('keeps escaped player markup as text while rendering staff attachments', async () => {
  const previousData = store.get(gameDataAtom);
  store.set(gameDataAtom, { userKey: 'admin' });
  const view = render(
    <TicketMessage
      hasStaffAccess
      messageHolder={{
        sender: 'player',
        message: '&lt;img src=x&gt; &lt;b&gt;text&lt;/b&gt;',
        time: 'Fri Nov 20 16:00:00 2026',
      }}
    />,
  );
  try {
    expect(view.container.querySelector('img')).toBeNull();
    expect(view.container.querySelector('b')).toBeNull();
    expect(view.container.textContent).toContain('<img src=x> <b>text</b>');

    await act(async () => {
      view.rerender(
        <TicketMessage
          hasStaffAccess
          messageHolder={{
            sender: 'admin',
            message: 'attachment<img src="https://example.com/a.png">',
            time: 'Fri Nov 20 16:00:00 2026',
          }}
        />,
      );
    });
    expect(view.container.querySelector('img')?.getAttribute('src')).toBe(
      'https://example.com/a.png',
    );
  } finally {
    view.unmount();
    store.set(gameDataAtom, previousData);
  }
});
