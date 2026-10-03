import { Box, Button, Icon, LabeledList } from 'tgui-core/components';

import { useBackend } from '../../backend';

export const ReagentLookup = (props) => {
  const { reagent } = props;
  const { act } = useBackend();
  if (!reagent) {
    return <Box>Реагент не выбран!</Box>;
  }

  return (
    <LabeledList>
      <LabeledList.Item label="Реагент">
        <Icon name="circle" mr={1} color={reagent.reagentCol} />
        {reagent.name}
        <Button
          ml={1}
          icon="wifi"
          color="teal"
          tooltip="Открыть статью об этом реагенте в вики."
          tooltipPosition="left"
          onClick={() => {
            Byond.command(`wiki Guide_to_chemistry#${reagent.name}`);
          }}
        />
      </LabeledList.Item>
      <LabeledList.Item label="Описание">{reagent.desc}</LabeledList.Item>
      <LabeledList.Item label="pH">
        <Icon name="circle" mr={1} color={reagent.pHCol} />
        {reagent.pH}
      </LabeledList.Item>
      <LabeledList.Item label="Свойства">
        <LabeledList>
          {!!reagent.OD && (
            <LabeledList.Item label="Передозировка">
              {reagent.OD} ед.
            </LabeledList.Item>
          )}
          {reagent.addictions[0] && (
            <LabeledList.Item label="Зависимость">
              {reagent.addictions.map((addiction) => (
                <Box key={addiction}>{addiction}</Box>
              ))}
            </LabeledList.Item>
          )}
          <LabeledList.Item label="Скорость метаболизма">
            {reagent.metaRate} ед./с
          </LabeledList.Item>
        </LabeledList>
      </LabeledList.Item>
      <LabeledList.Item label="Примеси">
        <LabeledList>
          {reagent.impureReagent && (
            <LabeledList.Item label="Реагент с примесями">
              <Button
                icon="vial"
                tooltip="При употреблении реагент частично превращается в этот, если его чистота выше обратной чистоты."
                tooltipPosition="left"
                content={reagent.impureReagent}
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.impureId,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {reagent.inverseReagent && (
            <LabeledList.Item label="Обратный реагент">
              <Button
                icon="vial"
                content={reagent.inverseReagent}
                tooltip="При употреблении реагент превращается в этот, если его чистота ниже обратной чистоты."
                tooltipPosition="left"
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.inverseId,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {reagent.failedReagent && (
            <LabeledList.Item label="Неудавшийся реагент">
              <Button
                icon="vial"
                tooltip="Реагент превратится в этот, если к концу реакции чистота окажется ниже минимальной."
                tooltipPosition="left"
                content={reagent.failedReagent}
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.failedId,
                  })
                }
              />
            </LabeledList.Item>
          )}
        </LabeledList>
        {reagent.isImpure && <Box>Этот реагент получается из-за примесей.</Box>}
        {reagent.deadProcess && <Box>Этот реагент действует и на мёртвых.</Box>}
        {!reagent.failedReagent &&
          !reagent.inverseReagent &&
          !reagent.impureReagent && (
            <Box>У этого реагента нет вариантов с примесями.</Box>
          )}
      </LabeledList.Item>
      <LabeledList.Item>
        <Button
          icon="flask"
          mt={2}
          content={'Найти реакцию'}
          color="purple"
          onClick={() =>
            act('find_reagent_reaction', {
              id: reagent.id,
            })
          }
        />
      </LabeledList.Item>
    </LabeledList>
  );
};
