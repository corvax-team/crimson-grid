import { useState } from 'react';
import { useBackend, useLocalState } from 'tgui/backend';
import {
  Box,
  Button,
  Dropdown,
  Input,
  LabeledList,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { capitalize } from 'tgui-core/string';
import { CharacterPreview } from '../common/CharacterPreview';
import { EditableText } from '../common/EditableText';
import { CrimeWatcher } from './CrimeWatcher';
import { CRIMESTATUS2COLOR, CRIMESTATUS2DESC } from './constants';
import { getSecurityRecord } from './helpers';
import { RecordPrint } from './RecordPrint';
import type { SecurityRecordsData } from './types';

/** Views a selected record. */
export const SecurityRecordView = (props) => {
  const foundRecord = getSecurityRecord();
  if (!foundRecord) return <NoticeBox>Ничего не выбрано.</NoticeBox>;

  const { data } = useBackend<SecurityRecordsData>();
  const { assigned_view } = data;

  const [open] = useLocalState<boolean>('printOpen', false);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <CharacterPreview height="100%" id={assigned_view} />
          </Stack.Item>
          <Stack.Item grow>
            <CrimeWatcher />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>{open ? <RecordPrint /> : <RecordInfo />}</Stack.Item>
    </Stack>
  );
};

const RecordInfo = (props) => {
  const foundRecord = getSecurityRecord();
  if (!foundRecord) return <NoticeBox>Ничего не выбрано.</NoticeBox>;

  const { act, data } = useBackend<SecurityRecordsData>();
  const { available_statuses } = data;
  const [open, setOpen] = useLocalState<boolean>('printOpen', false);

  const { min_age, max_age } = data;

  const {
    age,
    crew_ref,
    crimes,
    fingerprint,
    gender,
    name,
    note,
    recorded_rank, // CRIMSON KEEP EDIT START - Security console and records
    species,
    wanted_status,
    voice,
    // DARKPACK EDIT START - Flavor Text
    past_criminal_records,
    // DARKPACK EDIT END
  } = foundRecord;

  const [isValid, setIsValid] = useState(true);

  const hasValidCrimes = !!crimes.find((crime) => !!crime.valid);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section
          buttons={
            <Stack>
              <Stack.Item>
                <Button
                  height="1.7rem"
                  icon="print"
                  onClick={() => setOpen(true)}
                  tooltip="Распечатать уголовное дело или постер."
                >
                  Распечатать
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button.Confirm
                  icon="trash"
                  onClick={() => act('delete_record', { crew_ref: crew_ref })}
                  tooltip="Удаляет запись."
                >
                  Удалить
                </Button.Confirm>
              </Stack.Item>
            </Stack>
          }
          fill
          title={
            <Table.Cell color={CRIMESTATUS2COLOR[wanted_status]}>
              {name}
            </Table.Cell>
          }
        >
          <LabeledList>
            <LabeledList.Item
              buttons={available_statuses.map((button, index) => {
                const isSelected = button === wanted_status;
                return (
                  <Button
                    color={isSelected ? CRIMESTATUS2COLOR[button] : 'grey'}
                    disabled={button === 'Arrest' && !hasValidCrimes}
                    icon={isSelected ? 'check' : ''}
                    key={index}
                    onClick={() =>
                      act('set_wanted', {
                        crew_ref: crew_ref,
                        status: button,
                      })
                    }
                    pl={!isSelected ? '1.8rem' : 1}
                    tooltip={CRIMESTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                  >
                    {button[0]}
                  </Button>
                );
              })}
              label="Статус"
            >
              <Box color={CRIMESTATUS2COLOR[wanted_status]}>
                {wanted_status}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow={2}>
        <Section fill scrollable>
          <LabeledList>
            <LabeledList.Item label="Имя">
              <EditableText field="name" target_ref={crew_ref} text={name} />
            </LabeledList.Item>
            {/* CRIMSON KEEP EDIT START - Security console and records */}
            <LabeledList.Item label="Должность">
              <EditableText
                field="recorded_rank"
                target_ref={crew_ref}
                text={recorded_rank}
              />
            </LabeledList.Item>
            {/* CRIMSON KEEP EDIT END */}
            <LabeledList.Item label="Возраст">
              <RestrictedInput
                minValue={min_age}
                maxValue={max_age}
                onEnter={(value) =>
                  isValid &&
                  act('edit_field', {
                    crew_ref: crew_ref,
                    field: 'age',
                    value: value,
                  })
                }
                onValidationChange={setIsValid}
                value={age}
              />
            </LabeledList.Item>
            {/* DARKPACK EDIT REMOVAL START */}
            {/* <LabeledList.Item label="Species">
              <EditableText
                field="species"
                target_ref={crew_ref}
                text={species}
              />
            </LabeledList.Item> */}
            {/* DARKPACK EDIT REMOVAL END */}
            {/* CRIMSON KEEP EDIT START - Security console and records */}
            <LabeledList.Item label="Пол">
              {/* <EditableText
                field="gender"
                target_ref={crew_ref}
                text={gender}
              /> */}
              <Dropdown
                selected={capitalize(gender)}
                options={['male', 'female', 'plural', 'neuter']}
                width="6rem"
                color="#666"
                onSelected={(value) =>
                  act('edit_field', {
                    field: 'gender',
                    ref: crew_ref,
                    value: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item color="good" label="Отпечатки">
              <Box
                as="span"
                color={!fingerprint ? 'grey' : 'good'}
                style={{
                  textDecoration: 'underline',
                  textDecorationColor: 'white',
                  textDecorationThickness: '1px',
                  textUnderlineOffset: '1px',
                }}
              >
                {!fingerprint ? '(нет)' : fingerprint}
              </Box>
            </LabeledList.Item>
            {/* <LabeledList.Item label="Voice">
              <EditableText field="voice" target_ref={crew_ref} text={voice} />
            </LabeledList.Item> */}
            <LabeledList.Item label="Примечание">
              {/* <EditableText
                field="security_note"
                target_ref={crew_ref}
                text={note}
              /> */}
              <Input
                as="span"
                style={{
                  textDecorationColor: 'white',
                  textDecorationThickness: '1px',
                  textUnderlineOffset: '1px',
                }}
                fluid={true}
                value={note}
                placeholder="Нет."
                onChange={(value) =>
                  act('set_note', {
                    note: value,
                    crew_ref: crew_ref,
                  })
                }
              />
            </LabeledList.Item>
            {/* CRIMSON KEEP EDIT END */}
            {/* DARKPACK EDIT START - Flavor Text */}
            <LabeledList.Item label="Прошлые судимости">
              <Box maxWidth="100%" preserveWhitespace>
                {past_criminal_records || 'Нет данных'}
              </Box>
            </LabeledList.Item>
            {/* DARKPACK EDIT END */}
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
