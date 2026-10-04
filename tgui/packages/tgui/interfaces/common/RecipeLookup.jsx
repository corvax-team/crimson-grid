import {
  Box,
  Button,
  Chart,
  Flex,
  Icon,
  LabeledList,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

export const RecipeLookup = (props) => {
  const { recipe, bookmarkedReactions } = props;
  const { act, data } = useBackend();
  if (!recipe) {
    return <Box>Реакция не выбрана!</Box>;
  }

  const getReaction = (id) => {
    return data.master_reaction_list.filter((reaction) => reaction.id === id);
  };

  const addBookmark = (bookmark) => {
    bookmarkedReactions.add(bookmark);
  };

  return (
    <LabeledList>
      <LabeledList.Item bold label="Рецепт">
        <Icon name="circle" mr={1} color={recipe.reagentCol} />
        {recipe.name}
        <Button
          icon="arrow-left"
          ml={3}
          disabled={recipe.subReactIndex === 1}
          onClick={() =>
            act('reduce_index', {
              id: recipe.name,
            })
          }
        />
        <Button
          icon="arrow-right"
          disabled={recipe.subReactIndex === recipe.subReactLen}
          onClick={() =>
            act('increment_index', {
              id: recipe.name,
            })
          }
        />
        {bookmarkedReactions && (
          <Button
            icon="book"
            color="green"
            disabled={bookmarkedReactions.has(getReaction(recipe.id)[0])}
            onClick={() => {
              addBookmark(getReaction(recipe.id)[0]);
              act('update_ui');
            }}
          />
        )}
      </LabeledList.Item>
      {recipe.products && (
        <LabeledList.Item bold label="Продукты">
          {recipe.products.map((product) => (
            <Button
              key={product.name}
              icon="vial"
              disabled={product.hasProduct}
              content={`${product.ratio} ед. ${product.name}`}
              onClick={() =>
                act('reagent_click', {
                  id: product.id,
                })
              }
            />
          ))}
        </LabeledList.Item>
      )}
      <LabeledList.Item bold label="Реагенты">
        {recipe.reactants.map((reactant) => (
          <Box key={reactant.id}>
            <Button
              icon="vial"
              color={reactant.color}
              content={`${reactant.ratio} ед. ${reactant.name}`}
              onClick={() =>
                act('reagent_click', {
                  id: reactant.id,
                })
              }
            />
            {!!reactant.tooltipBool && (
              <Button
                icon="flask"
                color="purple"
                tooltip={reactant.tooltip}
                tooltipPosition="right"
                onClick={() =>
                  act('find_reagent_reaction', {
                    id: reactant.id,
                  })
                }
              />
            )}
          </Box>
        ))}
      </LabeledList.Item>
      {recipe.catalysts && (
        <LabeledList.Item bold label="Катализаторы">
          {recipe.catalysts.map((catalyst) => (
            <Box key={catalyst.id}>
              {(catalyst.tooltipBool && (
                <Button
                  icon="vial"
                  color={catalyst.color}
                  content={`${catalyst.ratio} ед. ${catalyst.name}`}
                  tooltip={catalyst.tooltip}
                  tooltipPosition={'right'}
                  onClick={() =>
                    act('reagent_click', {
                      id: catalyst.id,
                    })
                  }
                />
              )) || (
                <Button
                  icon="vial"
                  color={catalyst.color}
                  content={`${catalyst.ratio} ед. ${catalyst.name}`}
                  onClick={() =>
                    act('reagent_click', {
                      id: catalyst.id,
                    })
                  }
                />
              )}
            </Box>
          ))}
        </LabeledList.Item>
      )}
      {recipe.reqContainer && (
        <LabeledList.Item bold label="Ёмкость">
          <Button
            color="transparent"
            textColor="white"
            tooltipPosition="right"
            content={recipe.reqContainer}
            tooltip="Ёмкость, в которой должна идти эта реакция."
          />
        </LabeledList.Item>
      )}
      <LabeledList.Item bold label="Чистота">
        <LabeledList>
          <LabeledList.Item label="Оптимальный диапазон pH">
            <Box position="relative">
              <Tooltip content="Если удерживать реакцию в этих пределах, чистота продукта будет 100%">
                {`${recipe.lowerpH}-${recipe.upperpH}`}
              </Tooltip>
            </Box>
          </LabeledList.Item>
          {!!recipe.inversePurity && (
            <LabeledList.Item label="Обратная чистота">
              <Box position="relative">
                <Tooltip content="Если чистота ниже этого значения, при употреблении продукт полностью превратится в свой обратный реагент.">
                  {`<${recipe.inversePurity * 100}%`}
                </Tooltip>
              </Box>
            </LabeledList.Item>
          )}
          {!!recipe.minPurity && (
            <LabeledList.Item label="Минимальная чистота">
              <Box position="relative">
                <Tooltip content="Если во время реакции чистота упадёт ниже этого значения, начнутся негативные эффекты, а если она останется такой до конца, продукт превратится в свой неудавшийся реагент.">
                  {`<${recipe.minPurity * 100}%`}
                </Tooltip>
              </Box>
            </LabeledList.Item>
          )}
        </LabeledList>
      </LabeledList.Item>
      <LabeledList.Item bold label="Профиль скорости" width="10px">
        <Box
          height="50px"
          position="relative"
          style={{
            backgroundColor: 'black',
          }}
        >
          <Chart.Line
            fillPositionedParent
            data={recipe.thermodynamics}
            strokeWidth={0}
            fillColor={'#3cf072'}
          />
          {recipe.explosive && (
            <Chart.Line
              position="absolute"
              justify="right"
              top={0.01}
              bottom={0}
              right={recipe.isColdRecipe ? null : 0}
              width="28px"
              data={recipe.explosive}
              strokeWidth={0}
              fillColor={'#d92727'}
            />
          )}
        </Box>
        <Flex justify="space-between">
          <Tooltip
            content={
              recipe.isColdRecipe
                ? 'Температура, ниже которой реакция переохлаждается и начинаются негативные эффекты.'
                : 'Минимальная температура, при которой реакция начинается. Дальнейший нагрев её ускоряет.'
            }
          >
            <Flex.Item
              position="relative"
              textColor={recipe.isColdRecipe && 'red'}
            >
              {recipe.isColdRecipe
                ? `${recipe.explodeTemp}K`
                : `${recipe.tempMin}K`}
            </Flex.Item>
          </Tooltip>

          {recipe.explosive && (
            <Tooltip
              content={
                recipe.isColdRecipe
                  ? 'Минимальная температура, при которой реакция начинается. Дальнейший нагрев её ускоряет.'
                  : 'Температура, выше которой реакция перегревается и начинаются негативные эффекты.'
              }
            >
              <Flex.Item
                position="relative"
                textColor={!recipe.isColdRecipe && 'red'}
              >
                {recipe.isColdRecipe
                  ? `${recipe.tempMin}K`
                  : `${recipe.explodeTemp}K`}
              </Flex.Item>
            </Tooltip>
          )}
        </Flex>
      </LabeledList.Item>
      <LabeledList.Item bold label="Динамика">
        <LabeledList>
          <LabeledList.Item label="Оптимальная скорость">
            <Tooltip content="Наибольшая скорость реакции в единицах в секунду. На профиле скорости выше это участок плато.">
              <Box position="relative">{`${recipe.thermoUpper} ед./с`}</Box>
            </Tooltip>
          </LabeledList.Item>
        </LabeledList>
        <Tooltip content="Тепло реакции: экзотермическая выделяет тепло, эндотермическая поглощает.">
          <Box position="relative">{recipe.thermics}</Box>
        </Tooltip>
      </LabeledList.Item>
    </LabeledList>
  );
};
