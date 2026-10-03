// THIS IS A DARKPACK UI FILE
import {
  type Feature,
  FeatureTextInput,
} from '../base';

export const flavor_text: Feature<string> = {
  name: 'Описание персонажа',
  description: 'Показывается при осмотре персонажа, но только если его можно узнать: маска на лице скроет описание.',
  component: FeatureTextInput,
};

export const war_form_flavor_text: Feature<string> = {
  name: 'Описание персонажа (боевая форма)',
  description: 'Показывается при осмотре персонажа-Фера в боевой форме (Кринос) вместо основного описания.',
  component: FeatureTextInput,
};

export const feral_form_flavor_text: Feature<string> = {
  name: 'Описание персонажа (звериная форма)',
  description: 'Показывается при осмотре персонажа-Фера в звериной форме и в форме лютого волка (Люпус и Хиспо) вместо основного описания.',
  component: FeatureTextInput,
};

export const nsfw_flavor_text: Feature<string> = {
  name: 'Описание персонажа (NSFW)',
  description: 'Показывается при осмотре персонажа, но только если его можно узнать: маска на лице скроет описание.',
  component: FeatureTextInput,
};

export const character_notes: Feature<string> = {
  name: 'Заметки о персонаже',
  description:
    'OOC-сведения именно об этом персонаже. Например, хотите ли вы, чтобы его сделали гулем или дали ему Становление.',
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: 'OOC-заметки (NSFW)',
  description: 'Всё, что другим игрокам стоит о вас знать: отношение к антагонистам, OOC-триггеры и тому подобное.',
  component: FeatureTextInput,
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const criminal_record: Feature<string> = {
  name: 'Досье (криминальное)',
  description: 'Доступно тем, у кого есть доступ службы безопасности. Судимости, история арестов и тому подобное.',
  component: FeatureTextInput,
};

export const medical_record: Feature<string> = {
  name: 'Досье (медицинское)',
  description: 'Доступно тем, у кого есть медицинский доступ. История болезней, рецепты, отказ от реанимации и тому подобное.',
  component: FeatureTextInput,
};

export const exploitable_info: Feature<string> = {
  name: 'Досье (компромат)',
  description:
    'Может быть как IC, так и OOC. Доступно некоторым антагонистам и призракам. Обычно здесь \
  указывают слабые и сильные стороны, важные факты из прошлого, слова-триггеры и тому подобное. Сюда же можно вписать \
  пожелания к антагонистам: хотите ли вы стать их целью, чьей именно, каким образом и так далее.',
  component: FeatureTextInput,
};

export const background_info: Feature<string> = {
  name: 'Досье (биография)',
  description: 'Доступно только вам и призракам. Писать можно что угодно: это пригодится, чтобы самому не забыть, что представляет собой ваш персонаж.',
  component: FeatureTextInput,
};
