import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../../backend';

export type BeakerReagent = {
  name: string;
  volume: number;
};

export type Beaker = {
  maxVolume: number;
  pH: number;
  currentVolume: number;
  contents: BeakerReagent[];
};

type BeakerProps = {
  beaker: Beaker;
  replace_contents?: BeakerReagent[];
  title_label?: string;
  showpH?: BooleanLike;
  showInsertButton?: boolean;
  hasBeakerInHand?: BooleanLike;
};

export const BeakerDisplay = (props: BeakerProps) => {
  const { act } = useBackend();
  const { beaker, replace_contents, title_label, showpH } = props;
  const beakerContents = replace_contents || beaker?.contents || [];

  return (
    <LabeledList>
      <LabeledList.Item
        label="Ёмкость"
        buttons={
          !!beaker && (
            <Button icon="eject" onClick={() => act('eject')}>
              Извлечь
            </Button>
          )
        }
      >
        {title_label ||
          (!!beaker && (
            <>
              <AnimatedNumber initial={0} value={beaker.currentVolume} />/
              {beaker.maxVolume} units
            </>
          )) ||
          'Ёмкости нет'}
      </LabeledList.Item>
      <LabeledList.Item label="Содержимое">
        <Box color="label">
          {(!title_label && !beaker && 'Н/Д') ||
            (beakerContents.length === 0 && 'Пусто')}
        </Box>
        {beakerContents.map((chemical) => (
          <Box key={chemical.name} color="label">
            <AnimatedNumber initial={0} value={chemical.volume} /> ед.{' '}
            {chemical.name}
          </Box>
        ))}
        {beakerContents.length > 0 && !!showpH && (
          <Box>
            pH:
            <AnimatedNumber value={beaker.pH} />
          </Box>
        )}
      </LabeledList.Item>
    </LabeledList>
  );
};

export const BeakerSectionDisplay = (props: BeakerProps) => {
  const { act } = useBackend();
  const {
    beaker,
    replace_contents,
    title_label,
    showpH,
    showInsertButton = false,
    hasBeakerInHand,
  } = props;

  const beakerContents = replace_contents || beaker?.contents || [];
  const isBeakerLoaded = !!beaker;

  return (
    <Section
      title={title_label || 'Ёмкость'}
      buttons={
        isBeakerLoaded ? (
          <>
            <Box inline color="label" mr={2}>
              {beaker.currentVolume} / {beaker.maxVolume} ед.
            </Box>
            <Button icon="eject" onClick={() => act('eject')}>
              Извлечь
            </Button>
          </>
        ) : (
          showInsertButton && (
            <Button
              icon="eject"
              onClick={() => act('insert')}
              style={{
                opacity: hasBeakerInHand ? 1 : 0.5,
              }}
              tooltip={!hasBeakerInHand && 'Возьмите ёмкость в руку'}
              tooltipPosition="bottom-start"
            >
              Вставить
            </Button>
          )
        )
      }
    >
      <Box color="label">
        {(!beaker && 'Ёмкость не вставлена') ||
          (beakerContents.length === 0 && 'Пусто')}
      </Box>
      {beakerContents.map((chemical) => (
        <Box key={chemical.name} color="label">
          <AnimatedNumber initial={0} value={chemical.volume} /> ед.{' '}
          {chemical.name}
        </Box>
      ))}
      {beakerContents.length > 0 && !!showpH && (
        <Box>
          pH:
          <AnimatedNumber value={beaker.pH} />
        </Box>
      )}
    </Section>
  );
};
