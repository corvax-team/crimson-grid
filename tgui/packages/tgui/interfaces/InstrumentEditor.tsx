import {
  Box,
  Button,
  Collapsible,
  Divider,
  Dropdown,
  NumberInput,
  Section,
  Stack,
  Input,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  id: string;
  using_instrument: string;
  note_shift_min: number;
  note_shift_max: number;
  note_shift: number;
  octaves: number;
  sustain_modes: string[];
  sustain_mode: string;
  sustain_mode_button: string;
  sustain_mode_duration: number;
  instrument_ready: BooleanLike;
  volume: number;
  volume_dropoff_threshold: number;
  min_volume: number;
  max_volume: number;
  sustain_indefinitely: BooleanLike;
  sustain_mode_min: number;
  sustain_mode_max: number;
  playing: BooleanLike;
  max_repeats: number;
  repeat: number;
  bpm: number;
  lines: LineData[];
  can_switch_instrument: BooleanLike;
  possible_instruments: InstrumentData[];
  max_line_chars: number;
  max_lines: number;
};

type InstrumentData = {
  name: string;
  id: string;
};

type LineData = {
  line_count: number;
  line_text: string;
};

export const InstrumentEditor = (props) => {
  const { data } = useBackend<Data>();

  return (
    <Window width={750} height={500}>
      <Window.Content scrollable>
        <InstrumentSettings />
        <Collapsible open title="Редактор мелодии" icon="pencil">
          <EditingSettings />
        </Collapsible>
        <Collapsible title="Справка" icon="question">
          <HelpSection />
        </Collapsible>
      </Window.Content>
    </Window>
  );
};

const InstrumentSettings = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    id,
    playing,
    repeat,
    max_repeats,
    can_switch_instrument,
    possible_instruments = [],
    instrument_ready,
    using_instrument,
    note_shift_min,
    note_shift_max,
    note_shift,
    octaves,
    sustain_modes,
    sustain_mode,
    sustain_mode_button,
    sustain_mode_duration,
    sustain_indefinitely,
    sustain_mode_min,
    sustain_mode_max,
    volume,
    min_volume,
    max_volume,
    volume_dropoff_threshold,
    lines,
  } = data;

  const instrument_id_by_name = (name) => {
    return possible_instruments.find((instrument) => instrument.name === name)
      ?.id;
  };

  return (
    <Section title="Настройки">
      {lines.length > 0 && (
        <Box fontSize="16px" mb={1}>
          <Button onClick={() => act('play_music')}>
            {playing ? 'Остановить' : 'Играть'}
          </Button>
        </Box>
      )}
      <Box>
        <Box
          inline
          style={{
            borderBottom: '2px dotted rgba(255, 255, 255, 0.8)',
          }}
          mr={1}
        >
          <Tooltip
            content="Все инструменты поблизости с тем же ID начнут играть
               ту же мелодию, как только заиграет любой из них."
          >
            ID:
          </Tooltip>
        </Box>
        <Input
          value={id}
          maxLength={20}
          onChange={(value) => act('set_instrument_id', { id: value })}
        />
      </Box>
      <Box>
        Осталось повторов:
        <NumberInput
          ml={1}
          step={1}
          minValue={0}
          disabled={!!playing}
          maxValue={max_repeats}
          value={repeat}
          onChange={(value) =>
            act('set_repeat_amount', {
              amount: value,
            })
          }
        />
      </Box>
      <Box>
        {!!can_switch_instrument && (
          <Stack fill>
            <Stack.Item mt={0.5}>Инструмент</Stack.Item>
            <Stack.Item grow>
              <Dropdown
                width="40%"
                selected={using_instrument}
                disabled={!can_switch_instrument}
                options={possible_instruments.map(
                  (instrument) => instrument.name,
                )}
                onSelected={(value) =>
                  act('change_instrument', {
                    new_instrument: instrument_id_by_name(value),
                  })
                }
              />
            </Stack.Item>
          </Stack>
        )}
      </Box>
      <Stack mt={1}>
        <Stack.Item>
          Настройки воспроизведения:
          <Box>
            <NumberInput
              minValue={note_shift_min}
              maxValue={note_shift_max}
              step={1}
              value={note_shift}
              onChange={(value) =>
                act('set_note_shift', {
                  amount: value,
                })
              }
            />
            клавиш / октав: {octaves}
          </Box>
          <Stack>
            <Stack.Item mt={0.5}>Режим:</Stack.Item>
            <Stack.Item grow>
              <Dropdown
                width="100%"
                selected={sustain_mode}
                options={sustain_modes}
                onSelected={(value) =>
                  act('set_sustain_mode', {
                    new_mode: value,
                  })
                }
              />
            </Stack.Item>
          </Stack>
          <Box>
            {sustain_mode_button}:
            <NumberInput
              ml={1}
              step={1}
              minValue={sustain_mode_min}
              maxValue={sustain_mode_max}
              value={sustain_mode_duration}
              onChange={(value) =>
                act('edit_sustain_mode', {
                  amount: value,
                })
              }
            />
          </Box>
        </Stack.Item>
        <Divider vertical />
        <Stack.Item>
          <Box>
            Состояние:
            {instrument_ready ? (
              <span style={{ color: '#5EFB6E' }}> Готов</span>
            ) : (
              <span style={{ color: '#FF0000' }}>
                {' '}
                Ошибка в описании инструмента!
              </span>
            )}
          </Box>
          <Box>
            Громкость:
            <NumberInput
              step={1}
              minValue={min_volume}
              maxValue={max_volume}
              value={volume}
              onChange={(value) =>
                act('set_volume', {
                  amount: value,
                })
              }
            />
          </Box>
          <Box>
            Порог затухания громкости:
            <NumberInput
              step={1}
              minValue={1}
              maxValue={100}
              value={volume_dropoff_threshold}
              onChange={(value) =>
                act('set_dropoff_volume', {
                  amount: value,
                })
              }
            />
          </Box>
          <Box>
            <Button onClick={() => act('toggle_sustain_hold_indefinitely')}>
              {sustain_indefinitely
                ? 'Последняя нота тянется без конца'
                : 'Последняя нота затихает'}
            </Button>
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const EditingSettings = (props) => {
  const { act, data } = useBackend<Data>();
  const { bpm, lines } = data;

  return (
    <Section>
      <Box>
        <Button onClick={() => act('start_new_song')}>Новая мелодия</Button>
        <Button onClick={() => act('import_song')}>Импорт мелодии</Button>
      </Box>
      <Box>
        Темп:{' '}
        <Button
          onClick={() => act('tempo', { tempo_change: 'increase_speed' })}
        >
          -
        </Button>{' '}
        {bpm} BPM{' '}
        <Button
          onClick={() => act('tempo', { tempo_change: 'decrease_speed' })}
        >
          +
        </Button>
      </Box>
      <Box>
        {lines.map((line, index) => (
          <Box key={index} fontSize="11px">
            Строка {index}:
            <Button
              onClick={() =>
                act('modify_line', { line_editing: line.line_count })
              }
            >
              Изменить
            </Button>
            <Button
              onClick={() =>
                act('delete_line', { line_deleted: line.line_count })
              }
            >
              X
            </Button>
            {line.line_text}
          </Box>
        ))}
      </Box>
      <Box>
        <Button onClick={() => act('add_new_line')}>Добавить строку</Button>
      </Box>
    </Section>
  );
};

const HelpSection = (props) => {
  const { data } = useBackend<Data>();
  const { max_line_chars, max_lines } = data;

  return (
    <Section>
      <Box>
        Строка - это последовательность аккордов через запятую (,), а ноты в
        аккорде разделяются дефисом (-).
        <br />
        Все ноты аккорда звучат одновременно, длительность аккорда задаёт темп.
        <br />
        Нота записывается своим названием, к которому можно добавить знак
        альтерации и номер октавы.
        <br />
        По умолчанию все ноты без знаков и в 3-й октаве. Если указать другое,
        это запоминается для каждой ноты.
        <br />
        Пример: <i>C,D,E,F,G,A,B</i> сыграет гамму до мажор.
        <br />
        Знак альтерации и октава запоминаются за нотой: <i>C,C4,C,C3</i> - это{' '}
        <i>C3,C4,C4,C3</i>
        <br />
        Чтобы сыграть аккорд, запишите его ноты через дефис:{' '}
        <i>A-C#,Cn-E,E-G#,Gn-B</i>
        <br />
        Пауза обозначается пустым аккордом: <i>C,E,,C,G</i>
        <br />
        Чтобы изменить длительность аккорда, допишите в конце /x: аккорд будет
        длиться
        <br />
        темп / x: <i>C,G/2,E/4</i>
        <br />
        Всё вместе: <i>E-E4/4,F#/2,G#/8,B/8,E3-E4/4</i>
        <br />
        Длина строки - до {max_line_chars} символов.
        <br />В мелодии может быть не больше {max_lines} строк.
        <br />
      </Box>
    </Section>
  );
};
