https://github.com/ss220club/BandaStation (modular_bandastation/communication/code/whisper.dm)

## Whisper Channel

Module ID: WHISPER_CHANNEL

### Description:

Adds a whisper channel to the tgui-say input window and a keybind that opens it (Shift+T by default). Text sent in the channel goes through the regular whisper verb, with a leading "#" stripped so it cannot double into plain speech. A whisper cut short by a forced say does not blurt out the half-typed text. With the tgui input preference off, the keybind opens the plain Whisper verb.

### TG Proc/File Changes:

- `tgui/packages/tgui-say/ChannelIterator.ts`: `Whis` channel after `Say`.
- `tgui/packages/tgui-say/ChannelIterator.test.ts`: channel order.
- `tgui/packages/tgui-say/styles/colors.scss`: `Whis` color.
- `tgstation.dme`: includes.

### Modular Overrides:

- `modular_corvax/modules/whisper_channel/code/whisper_channel.dm`: `/datum/tgui_say/alter_entry`, `/datum/tgui_say/delegate_speech`.

### Defines:

- `code/__DEFINES/~~~corvax/whisper_channel.dm`: `WHISPER_CHANNEL`, `COMSIG_KB_CLIENT_WHISPER_DOWN`.

### Credits:

Ported from ss220club/BandaStation, commit `a46edb08426f32707bb29b346d99b1a14252a0d7` (AGPL-3.0).
