import { LabeledList, NoticeBox } from 'tgui-core/components';

import { JOBS_RU } from '../../corvax/ru_jobs'; // CORVAX EDIT ADD
import type { Antagonist, Observable } from './types';

type Props = {
  item: Observable | Antagonist;
  realNameDisplay: boolean;
};

/** Displays some info on the mob as a tooltip. */
export function OrbitTooltip(props: Props) {
  const { item, realNameDisplay } = props;
  const { extra, full_name, health, job, mind_job } = item;

  let antag;
  if ('antag' in item) {
    antag = item.antag;
  }

  const extraInfo = extra?.split(':');
  const displayHealth = health && health >= 0 ? `${health}%` : 'Критическое';
  const showAFK = 'client' in item && !item.client;
  const displayJob = realNameDisplay ? mind_job : job;

  return (
    <>
      <NoticeBox textAlign="center" nowrap info={showAFK}>
        Последние известные данные
      </NoticeBox>
      <LabeledList>
        {extraInfo ? (
          <LabeledList.Item label={extraInfo[0]}>
            {extraInfo[1]}
          </LabeledList.Item>
        ) : (
          <>
            {!!full_name && (
              <LabeledList.Item label="Настоящее имя">
                {full_name}
              </LabeledList.Item>
            )}
            {!!displayJob && (
              <LabeledList.Item label="Должность">
                {/* CORVAX EDIT CHANGE - ORIGINAL: {displayJob} */}
                {JOBS_RU[displayJob] || displayJob}
              </LabeledList.Item>
            )}
            {!!antag && (
              <LabeledList.Item label="Угроза">{antag}</LabeledList.Item>
            )}
            {!!health && (
              <LabeledList.Item label="Здоровье">
                {displayHealth}
              </LabeledList.Item>
            )}
          </>
        )}
        {showAFK && <LabeledList.Item label="Статус">Отошёл</LabeledList.Item>}
      </LabeledList>
    </>
  );
}
