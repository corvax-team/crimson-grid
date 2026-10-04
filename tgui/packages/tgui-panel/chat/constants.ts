/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const MAX_VISIBLE_MESSAGES = 2500;
export const MAX_PERSISTED_MESSAGES = 1000;
export const MESSAGE_SAVE_INTERVAL = 10000;
export const MESSAGE_PRUNE_INTERVAL = 60000;
export const COMBINE_MAX_MESSAGES = 5;
export const COMBINE_MAX_TIME_WINDOW = 5000;
export const IMAGE_RETRY_DELAY = 250;
export const IMAGE_RETRY_LIMIT = 10;
export const IMAGE_RETRY_MESSAGE_AGE = 60000;

// Default message type
export const MESSAGE_TYPE_UNKNOWN = 'unknown';

// Internal message type
export const MESSAGE_TYPE_INTERNAL = 'internal';

// Must match the set of defines in code/__DEFINES/chat.dm
export const MESSAGE_TYPE_SYSTEM = 'system';
export const MESSAGE_TYPE_LOCALCHAT = 'localchat';
export const MESSAGE_TYPE_RADIO = 'radio';
export const MESSAGE_TYPE_ENTERTAINMENT = 'entertainment';
export const MESSAGE_TYPE_INFO = 'info';
export const MESSAGE_TYPE_WARNING = 'warning';
export const MESSAGE_TYPE_DEADCHAT = 'deadchat';
export const MESSAGE_TYPE_OOC = 'ooc';
export const MESSAGE_TYPE_LOOC = 'looc'; // DARKPACK EDIT ADD
export const MESSAGE_TYPE_MENTOR = 'mentor'; // DARKPACK EDIT ADD - MENTOR
export const MESSAGE_TYPE_ADMINPM = 'adminpm';
export const MESSAGE_TYPE_COMBAT = 'combat';
export const MESSAGE_TYPE_ADMINCHAT = 'adminchat';
export const MESSAGE_TYPE_MODCHAT = 'modchat';
export const MESSAGE_TYPE_PRAYER = 'prayer';
export const MESSAGE_TYPE_EVENTCHAT = 'eventchat';
export const MESSAGE_TYPE_ADMINLOG = 'adminlog';
export const MESSAGE_TYPE_ATTACKLOG = 'attacklog';
export const MESSAGE_TYPE_DEBUG = 'debug';
export const MESSAGE_TYPE_SUBTLE = 'subtle'; // DARKPACK EDIT ADD

type MessageType = {
  type: string;
  name: string;
  description: string;
} & Partial<{
  selector: string;
  important: boolean;
  admin: boolean;
}>;

// Metadata for each message type
export const MESSAGE_TYPES: MessageType[] = [
  // Always-on types
  {
    type: MESSAGE_TYPE_SYSTEM,
    name: 'Системные сообщения',
    description: 'Сообщения вашего клиента, всегда включены',
    selector: '.boldannounce',
    important: true,
  },
  // Basic types
  {
    type: MESSAGE_TYPE_LOCALCHAT,
    name: 'Локальный чат',
    description: 'Игровые сообщения рядом с вами (речь, эмоции и т. п.)',
    selector: '.say, .emote, .do', // DARKPACK EDIT CHANGE - DO - ORIGINAL: selector: '.say, .emote',
  },
  // DARKPACK EDIT ADD START - SUBTLE
  {
    type: MESSAGE_TYPE_SUBTLE,
    name: 'Скрытые действия',
    description: 'Действия через Subtle и Subtler',
    selector: '.subtle, .subtler',
  },
  // DARKPACK EDIT ADD END
  {
    type: MESSAGE_TYPE_RADIO,
    name: 'Радио',
    description: 'Сообщения всех радиоканалов',
    selector:
      '.alert, .minorannounce, .syndradio, .centcomradio, .aiprivradio, .comradio, .secradio, .gangradio, .engradio, .medradio, .sciradio, .suppradio, .servradio, .radio, .deptradio, .binarysay, .resonate, .abductor, .alien, .changeling, .policeradio, .clinicradio, .militaryradio, .camarillaradio, .anarchradio, .endronradio', // DARKPACK EDIT CHANGE - ORIGINAL: '.alert, .minorannounce, .syndradio, .centcomradio, .aiprivradio, .comradio, .secradio, .gangradio, .engradio, .medradio, .sciradio, .suppradio, .servradio, .radio, .deptradio, .binarysay, .resonate, .abductor, .alien, .changeling',
  },
  {
    type: MESSAGE_TYPE_ENTERTAINMENT,
    name: 'Развлечения',
    description: 'Развлекательный канал и выпуски новостей',
    selector: '.enteradio, .newscaster',
  },
  {
    type: MESSAGE_TYPE_INFO,
    name: 'Информация',
    description: 'Несрочные сообщения от игры и предметов',
    selector:
      '.notice:not(.pm), .adminnotice, .info, .sinister, .cult, .infoplain, .announce, .hear, .smallnotice, .holoparasite, .boldnotice',
  },
  {
    type: MESSAGE_TYPE_WARNING,
    name: 'Предупреждения',
    description: 'Срочные сообщения от игры и предметов',
    selector:
      '.warning:not(.pm), .critical, .userdanger, .italics, .alertsyndie, .warningplain',
  },
  {
    type: MESSAGE_TYPE_DEADCHAT,
    name: 'Чат мёртвых',
    description: 'Все сообщения чата мёртвых',
    selector: '.deadsay, .ghostalert',
  },
  {
    type: MESSAGE_TYPE_OOC,
    name: 'OOC',
    description: 'Синяя стена общего OOC-чата',
    selector: '.ooc, .adminooc, .adminobserverooc, .oocplain',
  },
  // DARKPACK EDIT ADD START - LOOC
  {
    type: MESSAGE_TYPE_LOOC,
    name: 'LOOC',
    description: 'Все сообщения локального OOC',
    selector: '.looc, .rlooc',
  },
  // DARKPACK EDIT ADD END
  {
    type: MESSAGE_TYPE_ADMINPM,
    name: 'ЛС админов',
    description: 'Переписка с администрацией (adminhelp)',
    selector: '.pm, .adminhelp',
  },
  {
    type: MESSAGE_TYPE_COMBAT,
    name: 'Журнал боя',
    description: 'Джон Доу ударил вас ножом!',
    selector: '.danger',
  },
  // DARKPACK EDIT ADD START - MENTOR
  {
    type: MESSAGE_TYPE_MENTOR,
    name: 'Менторы',
    description: 'Личные сообщения менторов и всё, что с ними связано',
    selector: '.mentor, .mentornotice',
  },
  // DARKPACK EDIT ADD END
  {
    type: MESSAGE_TYPE_UNKNOWN,
    name: 'Прочее',
    description: 'Всё, что не удалось отнести к другим типам, всегда включено',
  },
  // Admin stuff
  {
    type: MESSAGE_TYPE_ADMINCHAT,
    name: 'Админ-чат',
    description: 'Сообщения ASAY',
    selector: '.admin_channel, .adminsay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_MODCHAT,
    name: 'Мод-чат',
    description: 'Сообщения MSAY',
    selector: '.mod_channel',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_PRAYER,
    name: 'Молитвы',
    description: 'Молитвы игроков',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ADMINLOG,
    name: 'Журнал админов',
    description: 'ADMIN LOG: Urist McAdmin has jumped to coordinates X, Y, Z',
    selector: '.log_message',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ATTACKLOG,
    name: 'Журнал атак',
    description: 'Urist McTraitor has shot John Doe',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_DEBUG,
    name: 'Журнал отладки',
    description: 'DEBUG: SSPlanets subsystem Recover().',
    admin: true,
  },
];
