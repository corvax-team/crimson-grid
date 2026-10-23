import { createContext, useContext } from 'react';

import type { ServerData } from './types';

export const ServerPrefs = createContext<ServerData | undefined>({
  jobs: {
    departments: {},
    jobs: {},
    jobs_sorted: [],
  },
  names: {
    types: {},
  },
  quirks: {
    max_positive_quirks: -1,
    quirk_info: {},
    quirk_blacklist: [],
    points_enabled: false,
  },
  personality: {
    personalities: [],
    personality_incompatibilities: {},
  },
  random: {
    randomizable: [],
  },
  loadout: {
    loadout_tabs: [],
  },
  species: {},
   // DARKPACK EDIT START
  splats: {},
  disciplines: {},
  // DARKPACK EDIT END
  // CORVAX EDIT ADD START - TTS
  text_to_speech: {
    providers: [],
    seeds: [],
    phrases: [],
  },
  // CORVAX EDIT ADD END
});

export function useServerPrefs() {
  return useContext(ServerPrefs);
}
