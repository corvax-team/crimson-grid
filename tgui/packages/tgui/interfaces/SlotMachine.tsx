import { useEffect, useMemo, useRef, useState } from 'react';
import { Blink, Box, Button, Section, Stack } from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';
import { classes } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  symbols: SlotSymbol[];
  reels: Reel[];
  balance: number;
  working: number;
  winning: number;
  money: number;
  cost: number;
  plays: number;
  jackpots: number;
  jackpot: number;
  paymode: number;
  jackpot_id: string;
  trap_id: string;
};

type SlotSymbol = {
  id: string;
  icon_id: string;
};

type Reel = {
  symbols: string[];
};

const pluralS = (amount: number) => {
  return amount === 1 ? '' : 's';
};

const pickRandomMany = <T,>(items: T[], n: number) => {
  const result: T[] = [];
  for (let i = 0; i < n; i += 1) {
    result.push(pickRandom(items));
  }
  return result;
};

const pickRandom = <T,>(items: T[]) => {
  return items[Math.floor(Math.random() * items.length)];
};

export const SlotMachine = () => {
  const { act, data } = useBackend<Data>();
  const { symbols, cost, reels, balance } = data;
  const spinning = data.working === 1;

  const symbolsById = useMemo(() => {
    const map: Record<string, SlotSymbol> = {};
    for (const symbol of symbols) {
      map[symbol.id] = symbol;
    }
    return map;
  }, [symbols]);

  const jackpotSymbol = symbolsById[data.jackpot_id];
  const trapSymbol = data.trap_id ? symbolsById[data.trap_id] : null;

  return (
    <Window width={300} height={445}>
      <Window.Content>
        <Banner />
        <Section>
          <div className={'SlotMachine__Reels'}>
            {reels.map((reel, i) => (
              <div key={i} className={'SlotMachine__Reel'}>
                <IconStrip
                  symbols={symbols}
                  symbolsById={symbolsById}
                  symbolsNeeded={reel.symbols}
                  spinning={spinning}
                />
              </div>
            ))}
          </div>
        </Section>
        <Stack vertical fill>
          <Stack.Item>
            <Section fill align={'center'}>
              <Box inline textAlign={'center'} color="good" bold>
                Джекпот:
              </Box>
              {jackpotSymbol && (
                <Box
                  className={classes([
                    'slotmachines32x32',
                    jackpotSymbol.icon_id,
                  ])}
                  style={{ verticalAlign: 'middle' }}
                />
              )}

              {trapSymbol && (
                <>
                  <Box inline color="bad" bold ml={5} mr={1}>
                    Проигрыш:
                  </Box>
                  <Box
                    className={classes([
                      'slotmachines32x32',
                      trapSymbol.icon_id,
                    ])}
                    style={{ verticalAlign: 'middle' }}
                  />
                </>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item grow={1}>
            <Stack align={'stretch'}>
              <Stack.Item grow={1}>
                <Section
                  fill
                  title="Balance"
                  buttons={
                    <Button
                      onClick={() => act('payout')}
                      disabled={balance <= 0}
                    >
                      Вывести
                    </Button>
                  }
                >
                  <Box textAlign={'center'} fontSize={2}>
                    {formatMoney(balance)} $
                  </Box>
                </Section>
              </Stack.Item>
              <Stack.Item grow={1}>
                <Section fill>
                  <Button
                    fluid
                    textAlign={'center'}
                    fontSize={3}
                    color={'green'}
                    onClick={() => act('spin')}
                    disabled={spinning || balance < cost}
                  >
                    Крутить!
                  </Button>
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const getBannerPages = () => [
  BannerTitle,
  BannerOnlyFewCreds,
  BannerPrizeMoney,
  BannerTitle,
  BannerJackpot,
  BannerStats,
];

const BANNER_TEXTS = [
  'КРУТИ! КРУТИ!',
  'РАЗМИНОЧНЫЙ!',
  'HOT SLOTS',
  'КРУТИ И ВЫИГРАЙ!',
  'ВЕРЬ!',
  'ИЗ ГРЯЗИ В КНЯЗИ!',
  'ЕЩЁ ОДИН',
  'КРУТКА СУДЬБЫ',
  'ДОДЕП!',
  'КРУТИ!',
  'ЕЩЁ ДОДЕП!',
  'НЕ КРУТИЛ НЕ ВЫИГРАЛ',
  'ПОЛОЖИ И ЗАБУДЬ',
  'ДОДЕЕЕЕЕП!',
  'ПОДЗАРАБОТАЙ',
  'ЕЩЁ НЕМНОГО!',
  'ПОБЕДИ!',
  'УДАЧА ЗОВЁТ',
  'БЕЗ ДОДЕПА НЕ РАЗОБРАТЬСЯ',
  'МОЛНЕНОСНЫЕ НАЧИСЛЕНИЯ!',
  'ДОДЕП? ДА!',
];

const WINNING_TEXTS = [
  null,
  'ХАЛЯВНЫЙ СПИН!',
  'ПРИЗ!',
  'ОГРОМНЫЙ ПРИЗ!',
  'ДЖЕКПОТ!!!',
];

const Banner = () => {
  const { data } = useBackend<Data>();
  const [page, setPage] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setPage((page) => (page + 1) % getBannerPages().length);
    }, 5000);
    return () => clearInterval(interval);
  }, []);

  const winningText = WINNING_TEXTS[data.winning];
  if (winningText) {
    return (
      <Section className={'SlotMachine__Banner SlotMachine__Banner--winning'}>
        <BannerTitle text={winningText} />
      </Section>
    );
  }

  const Component = getBannerPages()[page];

  return (
    <Section className={'SlotMachine__Banner'}>
      <Component />
    </Section>
  );
};

type BannerTitleProps = {
  text?: string;
};

const BannerTitle = (props: BannerTitleProps) => {
  const { data } = useBackend<Data>();
  const defaultText = useRef(pickRandom(BANNER_TEXTS));
  let text = props.text;
  if (!text) {
    if (data.balance <= 0) {
      text = 'ВСТАВЬТЕ МОНЕТУ';
    } else if (data.balance <= 5) {
      text = 'ПОСЛЕДНЯЯ КРУТКА';
    } else {
      text = defaultText.current;
    }
  }
  const letters = text.split('');
  return (
    <div className={'SlotMachine__BannerTitle'}>
      {letters.map((letter, i) => (
        <span key={i}>{letter}</span>
      ))}
    </div>
  );
};

const BannerOnlyFewCreds = () => {
  const { data } = useBackend<Data>();
  const variant = useRef(pickRandom([0, 1]));

  if (variant.current === 1) {
    return (
      <div>
        Только{' '}
        <Blink interval={200} time={200}>
          <b>{data.cost}</b>
        </Blink>{' '}
        баксов{pluralS(data.cost)}!
        <br />
        <Box inline fontSize={'12px'}>
          И ты решишь все свои проблемы!
        </Box>
      </div>
    );
  }

  return (
    <div>
      Только{' '}
      <Blink interval={200} time={200}>
        <b>{data.cost}</b>
      </Blink>{' '}
      баксов{pluralS(data.cost)} за шанс
      <br />
      выиграть <b>больше</b>!
    </div>
  );
};

const BannerPrizeMoney = () => {
  const { data } = useBackend<Data>();
  return (
    <div>
      Текущий приз:
      <br />
      <b>
        {data.money} баксов{pluralS(data.money)}
      </b>
    </div>
  );
};

const BannerJackpot = () => {
  const { data } = useBackend<Data>();
  return (
    <div>
      Джекпот составляет:
      <br />
      <b>
        {data.money + data.jackpot} баксов{pluralS(data.money + data.jackpot)}!
      </b>
    </div>
  );
};

const BannerStats = () => {
  const { data } = useBackend<Data>();
  return (
    <div>
      <Box inline fontSize={'13px'}>
        Люди крутили {' '}
        <b>
          {data.plays} раз{pluralS(data.plays)}
        </b>
      </Box>
      <br />
      и получали{' '}
      <b>
        {data.jackpots} баксов{pluralS(data.jackpots)}!
      </b>
    </div>
  );
};

const ICON_STRIP_LENGTH = 30;

type IconStripProps = {
  symbols: SlotSymbol[];
  symbolsById: Record<string, SlotSymbol>;
  symbolsNeeded: string[];
  spinning?: boolean;
};

const IconStrip = (props: IconStripProps) => {
  const { symbols, symbolsById, symbolsNeeded, spinning } = props;
  const symbolIds = useMemo(() => symbols.map((s) => s.id), [symbols]);

  const [drawnSymbols, setDrawnSymbols] = useState<string[]>([
    ...pickRandomMany(symbolIds, ICON_STRIP_LENGTH - 3),
    ...symbolsNeeded,
  ]);

  useEffect(() => {
    if (spinning) {
      setDrawnSymbols((drawn) => [
        ...drawn.slice(-3),
        ...pickRandomMany(symbolIds, ICON_STRIP_LENGTH - 6),
        ...symbolsNeeded,
      ]);
    } else {
      setDrawnSymbols([
        ...pickRandomMany(symbolIds, ICON_STRIP_LENGTH - 3),
        ...symbolsNeeded,
      ]);
    }
  }, [spinning]);

  return (
    <div
      className={classes([
        'SlotMachine__IconStrip',
        spinning && 'SlotMachine__IconStrip--spinning',
      ])}
    >
      {drawnSymbols.map((symbolId, i) => {
        const symbol = symbolsById[symbolId];
        return (
          <div key={i} className="SlotMachine__Symbol">
            {symbol && (
              <Box className={classes(['slotmachines32x32', symbol.icon_id])} />
            )}
          </div>
        );
      })}
    </div>
  );
};
