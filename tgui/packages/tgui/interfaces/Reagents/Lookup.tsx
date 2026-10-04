import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { ReagentLookup } from '../common/ReagentLookup';
import { RecipeLookup } from '../common/RecipeLookup';
import { bookmarkedReactions } from '.';
import type { ReagentsData } from './types';

export function Lookup() {
  const { act, data } = useBackend<ReagentsData>();
  const { beakerSync, reagent_mode_recipe, reagent_mode_reagent } = data;

  return (
    <Stack fill>
      <Stack.Item grow basis={0}>
        <Section
          title="Поиск рецепта"
          minWidth="353px"
          buttons={
            <>
              <Button
                icon="atom"
                color={beakerSync ? 'green' : 'red'}
                tooltip="Если включено, здесь автоматически показываются реакции, идущие в подключённой ёмкости."
                onClick={() => act('beaker_sync')}
              >
                Синхронизация с ёмкостью
              </Button>
              <Button
                icon="search"
                color="purple"
                tooltip="Найти рецепт по названию продукта"
                onClick={() => act('search_recipe')}
              >
                Поиск
              </Button>
              <Button
                icon="times"
                color="red"
                disabled={!reagent_mode_recipe}
                onClick={() =>
                  act('recipe_click', {
                    id: null,
                  })
                }
              />
            </>
          }
        >
          <RecipeLookup
            recipe={reagent_mode_recipe}
            bookmarkedReactions={bookmarkedReactions}
          />
        </Section>
      </Stack.Item>
      <Stack.Item grow basis={0}>
        <Section
          title="Поиск реагента"
          minWidth="300px"
          buttons={
            <>
              <Button
                icon="search"
                tooltip="Найти реагент по названию"
                tooltipPosition="left"
                onClick={() => act('search_reagents')}
              >
                Поиск
              </Button>
              <Button
                icon="times"
                color="red"
                disabled={!reagent_mode_reagent}
                onClick={() =>
                  act('reagent_click', {
                    id: null,
                  })
                }
              />
            </>
          }
        >
          <ReagentLookup reagent={reagent_mode_reagent} />
        </Section>
      </Stack.Item>
    </Stack>
  );
}
