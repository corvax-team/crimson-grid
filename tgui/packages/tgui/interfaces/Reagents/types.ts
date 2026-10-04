import type { Dispatch, SetStateAction } from 'react';
import type { BooleanLike } from 'tgui-core/react';

export type ReagentsData = {
  beakerSync: BooleanLike;
  bitflags: Record<string, number>;
  currentReagents: string[];
  linkedBeaker: string;
  master_reaction_list: Reaction[];
  reagent_mode_reagent: Reagent | null;
  reagent_mode_recipe: Recipe | null;
  selectedBitflags: number;
};

export type ReagentsProps = {
  pageState: [number, Dispatch<SetStateAction<number>>];
};

type Pairs = [
  [number, number],
  [number, number],
  [number, number],
  [number, number],
];

export type Recipe = {
  catalysts: Reagent[];
  explodeTemp: number;
  explosive: Pairs;
  hasProduct: BooleanLike;
  id: string;
  inversePurity: string;
  isColdRecipe: BooleanLike;
  lowerpH: number;
  minPurity: number;
  name: string;
  reactants: Reactant[];
  reagentCol: string;
  reqContainer: string | null;
  subReactIndex: number;
  subReactLen: number;
  tempMin: number;
  thermics: string;
  thermodynamics: Pairs;
  thermoUpper: number;
  upperpH: number;
};

type Reactant = {
  color: string;
  id: string;
  name: string;
  ratio: number;
  tooltip: string | null;
  tooltipBool: BooleanLike;
};

export type Reagent = {
  addictions: string[];
  desc: string;
  id: string;
  metaRate: number;
  name: string;
  OD: number;
  pH: number;
  pHCol: string;
  reagentCol: string;
};

type ReactionReagent = {
  id: string;
  name: string;
};

export type Reaction = {
  bitflags: number;
  id: string;
  name: string;
  reactants: ReactionReagent[];
};

export const bitflagInfo = [
  {
    flag: 'BRUTE',
    icon: 'gavel',
    tooltip: 'Даёт реагент, который лечит или наносит ушибы.',
    category: 'Влияние',
    toggle: 'toggle_tag_brute', // future todo : just make this use ui state
  },
  {
    flag: 'BURN',
    icon: 'burn',
    tooltip: 'Даёт реагент, который лечит или наносит ожоги.',
    category: 'Влияние',
    toggle: 'toggle_tag_burn',
  },
  {
    flag: 'TOXIN',
    icon: 'biohazard',
    tooltip: 'Даёт реагент, который лечит отравление или отравляет.',
    category: 'Влияние',
    toggle: 'toggle_tag_toxin',
  },
  {
    flag: 'OXY',
    icon: 'wind',
    tooltip: 'Даёт реагент, который лечит удушье или вызывает его.',
    category: 'Влияние',
    toggle: 'toggle_tag_oxy',
  },
  {
    flag: 'HEALING',
    icon: 'medkit',
    tooltip: 'Даёт лечебный реагент.',
    category: 'Тип',
    toggle: 'toggle_tag_healing',
  },
  {
    flag: 'DAMAGING',
    icon: 'skull-crossbones',
    tooltip: 'Даёт вредоносный реагент.',
    category: 'Тип',
    toggle: 'toggle_tag_damaging',
  },
  {
    flag: 'EXPLOSIVE',
    icon: 'bomb',
    tooltip: 'Даёт взрывчатый реагент или взрывается во время реакции.',
    category: 'Тип',
    toggle: 'toggle_tag_explosive',
  },
  {
    flag: 'OTHER',
    icon: 'question',
    tooltip: 'Даёт реагент с каким-то иным побочным эффектом.',
    category: 'Влияние',
    toggle: 'toggle_tag_other',
  },
  {
    flag: 'DANGEROUS',
    icon: 'exclamation-triangle',
    tooltip: 'Реакция может сразу привести к опасным последствиям.',
    category: 'Сложность',
    toggle: 'toggle_tag_dangerous',
  },
  {
    flag: 'EASY',
    icon: 'chess-pawn',
    tooltip: 'Простая реакция.',
    category: 'Сложность',
    toggle: 'toggle_tag_easy',
  },
  {
    flag: 'MODERATE',
    icon: 'chess-knight',
    tooltip: 'Реакция средней сложности.',
    category: 'Сложность',
    toggle: 'toggle_tag_moderate',
  },
  {
    flag: 'HARD',
    icon: 'chess-queen',
    tooltip: 'Сложная реакция.',
    category: 'Сложность',
    toggle: 'toggle_tag_hard',
  },
  {
    flag: 'ORGAN',
    icon: 'brain',
    tooltip: 'Даёт реагент, который лечит или повреждает органы.',
    category: 'Влияние',
    toggle: 'toggle_tag_organ',
  },
  {
    flag: 'DRINK',
    icon: 'cocktail',
    tooltip: 'Даёт напиток. Обычно готовится в баре.',
    category: 'Тип',
    toggle: 'toggle_tag_drink',
  },
  {
    flag: 'FOOD',
    icon: 'drumstick-bite',
    tooltip: 'Даёт еду. Обычно готовится на кухне.',
    category: 'Тип',
    toggle: 'toggle_tag_food',
  },
  {
    flag: 'SLIME',
    icon: 'microscope',
    tooltip: 'Реакция из ксенобиологии.',
    category: 'Тип',
    toggle: 'toggle_tag_slime',
  },
  {
    flag: 'DRUG',
    icon: 'pills',
    tooltip:
      'Даёт реагент, вызывающий зависимость, с полезными и вредными эффектами.',
    category: 'Тип',
    toggle: 'toggle_tag_drug',
  },
  {
    flag: 'UNIQUE',
    icon: 'puzzle-piece',
    tooltip: 'Уникальная или особая реакция.',
    category: 'Тип',
    toggle: 'toggle_tag_unique',
  },
  {
    flag: 'CHEMICAL',
    icon: 'flask',
    tooltip: 'Даёт реагент, который влияет на другие реакции.',
    category: 'Влияние',
    toggle: 'toggle_tag_chemical',
  },
  {
    flag: 'PLANT',
    icon: 'seedling',
    tooltip: 'Даёт реагент, полезный или вредный для растений.',
    category: 'Влияние',
    toggle: 'toggle_tag_plant',
  },
  {
    flag: 'COMPETITIVE',
    icon: 'recycle',
    tooltip: 'Реакция, которая конкурирует с другими.',
    category: 'Сложность',
    toggle: 'toggle_tag_competitive',
  },
  {
    flag: 'COMPONENT',
    icon: 'question',
    tooltip: 'Даёт реагент, который часто нужен в других реакциях.',
    category: 'Тип',
    toggle: 'toggle_tag_component',
  },
  {
    flag: 'ACTIVE',
    icon: 'question',
    tooltip: 'Реакция сразу даёт заметный эффект.',
    category: 'Тип',
    toggle: 'toggle_tag_active',
  },
];
