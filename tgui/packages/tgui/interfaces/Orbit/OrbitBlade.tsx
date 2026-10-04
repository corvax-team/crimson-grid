import { useContext } from 'react';
import {
  Button,
  Icon,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { capitalizeFirst, toTitleCase } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { DEPARTMENTS_RU, JOBS_RU } from '../../corvax/ru_jobs'; // CORVAX EDIT ADD
import { OrbitContext } from '.';
import { HEALTH, VIEWMODE, VIEWMODE_RU } from './constants';
import { getDepartmentByJob, getDisplayName } from './helpers';
import { JobIcon } from './JobIcon';
import type { OrbitData } from './types';

/** Slide open menu with more info about the current observable */
export function OrbitBlade(props) {
  const { data } = useBackend<OrbitData>();
  const { orbiting } = data;

  const { setBladeOpen, realNameDisplay, setRealNameDisplay } =
    useContext(OrbitContext);

  return (
    <Stack vertical width="244px">
      <Stack.Item>
        <Section
          buttons={
            <Button
              color="bad"
              icon="times"
              onClick={() => setBladeOpen(false)}
            />
          }
          color="label"
          title="Настройки наблюдения"
        >
          Учтите: список не обновляется сам. Чтобы увидеть свежие данные,
          нажмите кнопку &quot;Обновить&quot;.
        </Section>
      </Stack.Item>
      <Stack.Item>
        <ViewModeSelector />
      </Stack.Item>
      <Stack.Item>
        <Section
          buttons={
            <Button
              color="transparent"
              icon="passport"
              selected={realNameDisplay}
              onClick={() => setRealNameDisplay(!realNameDisplay)}
            />
          }
          color="label"
          title="Настоящие имена"
        >
          В этом режиме показываются настоящие имена персонажей и их должности
          на начало раунда, а не данные с надетого удостоверения. Если должности
          на начало раунда нет, останется значок с удостоверения.
        </Section>
      </Stack.Item>
      {!!orbiting && (
        <Stack.Item>
          <OrbitInfo />
        </Stack.Item>
      )}
    </Stack>
  );
}

function ViewModeSelector(props) {
  const { viewMode, setViewMode } = useContext(OrbitContext);

  return (
    <Section title="Режим отображения">
      <Stack fill vertical>
        <Stack.Item color="label">
          Меняет цвета и порядок сортировки списка.
        </Stack.Item>

        {Object.entries(VIEWMODE).map(([key, value]) => (
          <Button
            align="center"
            color="transparent"
            fluid
            icon={value}
            key={key}
            onClick={() => setViewMode(value)}
            selected={value === viewMode}
          >
            {VIEWMODE_RU[key]}
          </Button>
        ))}
      </Stack>
    </Section>
  );
}

function OrbitInfo(props) {
  const { data } = useBackend<OrbitData>();

  const { orbiting } = data;
  if (!orbiting) return;

  const { name, full_name, health, job } = orbiting;

  let department;
  if ('job' in orbiting && job) {
    department = getDepartmentByJob(job);
  }

  let showAFK;
  if ('client' in orbiting && !orbiting.client) {
    showAFK = true;
  }

  return (
    <Section title="Вы наблюдаете за">
      <Stack fill vertical>
        <Stack.Item>
          {toTitleCase(getDisplayName(full_name, name))}
          {showAFK && (
            <Tooltip content="Отошёл от клавиатуры" position="bottom-start">
              <Icon ml={1} color="grey" name="bed" />
            </Tooltip>
          )}
        </Stack.Item>

        {!!job && (
          <Stack.Item>
            <Stack>
              <Stack.Item>
                <JobIcon item={orbiting} realNameDisplay={false} />
              </Stack.Item>
              <Stack.Item color="label" grow>
                {JOBS_RU[job] || job /* CORVAX EDIT CHANGE - ORIGINAL: {job} */}
              </Stack.Item>
              {!!department && (
                <Stack.Item color="grey">
                  {/* CORVAX EDIT CHANGE - ORIGINAL: {capitalizeFirst(department)} */}
                  {DEPARTMENTS_RU[capitalizeFirst(department)] ||
                    capitalizeFirst(department)}
                </Stack.Item>
              )}
            </Stack>
          </Stack.Item>
        )}
        {health !== undefined && (
          <Stack.Item>
            <HealthDisplay health={health} />
          </Stack.Item>
        )}

        <Stack.Item />
      </Stack>
    </Section>
  );
}

function HealthDisplay(props: { health: number }) {
  const { health } = props;

  let icon = 'heart';
  let howDead;
  switch (true) {
    case health <= HEALTH.Ruined:
      howDead = `Мертвее некуда: ${health}`;
      icon = 'skull';
      break;
    case health <= HEALTH.Dead:
      howDead = `Мёртв: ${health}`;
      icon = 'heart-broken';
      break;
    case health <= HEALTH.Crit:
      howDead = `Критическое состояние: ${health}`;
      icon = 'tired';
      break;
    case health <= HEALTH.Bad:
      howDead = `Плохо: ${health}`;
      icon = 'heartbeat';
      break;
  }

  return (
    <Stack align="center">
      <Stack.Item>
        <Icon color="grey" name={icon} />
      </Stack.Item>
      <Stack.Item color={howDead && 'bad'} grow>
        {howDead || (
          <ProgressBar
            maxValue={100}
            minValue={0}
            ranges={{
              good: [70, Infinity],
              average: [20, HEALTH.Good],
              bad: [0, HEALTH.Average],
            }}
            value={health}
          />
        )}
      </Stack.Item>
    </Stack>
  );
}
