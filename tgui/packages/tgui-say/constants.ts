/** Window sizes in pixels */
export enum WindowSize {
  Small = 30,
  Medium = 50,
  Large = 70,
  Width = 231,
}

/** Line lengths for autoexpand */
export enum LineLength {
  Small = 20,
  Medium = 39,
  Large = 59,
}

/**
 * Radio prefixes.
 * Displays the name in the left button, tags a css class.
 */
export const RADIO_PREFIXES = {
  /* // DARKPACK EDIT REMOVAL START
  ':a ': 'Hive',
  ':b ': 'io',
  ':c ': 'Cmd',
  ':e ': 'Engi',
  ':g ': 'Cling',
  ':m ': 'Med',
  ':n ': 'Sci',
  ':o ': 'AI',
  */ // DARKPACK EDIT REMOVAL END
  ':p ': 'Развл',
  /* // DARKPACK EDIT REMOVAL START
  ':s ': 'Sec',
  ':t ': 'Synd',
  ':u ': 'Supp',
  ':v ': 'Svc',
  ':y ': 'CCom',
  */ // DARKPACK EDIT REMOVAL END
  // DARKPACK EDIT ADD START
  ':s ': 'Полиц',
  ':m ': 'Клин',
  ':a ': 'Армия',
  ':t ': 'Башня',
  ':b ': 'Бар',

  ':з ': 'Развл',
  ':с ': 'Полиц',
  ':м ': 'Клин',
  ':т ': 'Армия',
  ':ь ': 'Башня',
  ':б ': 'Бар',
  // DARKPACK EDIT ADD END
} as const;
