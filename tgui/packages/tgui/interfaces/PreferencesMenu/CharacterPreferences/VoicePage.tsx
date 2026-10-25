import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import {
  Button,
  Dropdown,
  Icon,
  LabeledList,
  Section,
  Stack,
  VirtualList,
} from 'tgui-core/components';

import { LoadingScreen } from '../../common/LoadingScreen';
import { SearchBar } from '../../common/SearchBar';
import type { PreferencesMenuData, TtsData, TtsSeed } from '../types';
import { useServerPrefs } from '../useServerPrefs';

const genderIcons: Record<string, { icon: string; color: string }> = {
  Мужской: { icon: 'mars', color: 'blue' },
  Женский: { icon: 'venus', color: 'purple' },
  Любой: { icon: 'venus-mars', color: 'white' },
};

function uniqueValues(values: string[]): string[] {
  return values.filter((value, index, all) => all.indexOf(value) === index);
}

type CheckboxGroupProps = {
  items: string[];
  selected: string[];
  setSelected: (selected: string[]) => void;
};

function CheckboxGroup(props: CheckboxGroupProps) {
  const { items, selected, setSelected } = props;

  return (
    <>
      {items.map((item) => (
        <Button.Checkbox
          key={item}
          checked={selected.includes(item)}
          onClick={() =>
            setSelected(
              selected.includes(item)
                ? selected.filter((other) => other !== item)
                : [item, ...selected],
            )
          }
        >
          {item}
        </Button.Checkbox>
      ))}
    </>
  );
}

export function VoicePage() {
  const serverData = useServerPrefs();
  if (!serverData?.text_to_speech) {
    return <LoadingScreen />;
  }

  return <VoicePageInner textToSpeech={serverData.text_to_speech} />;
}

function VoicePageInner(props: { textToSpeech: TtsData }) {
  const { data } = useBackend<PreferencesMenuData>();
  const { tts_seed } = data;
  const { providers, seeds, phrases } = props.textToSpeech;

  const providerNames = providers.map((provider) => provider.name);
  const categories = uniqueValues(seeds.map((seed) => seed.category));
  const genders = uniqueValues(seeds.map((seed) => seed.gender));

  const [selectedProviders, setSelectedProviders] = useState(providerNames);
  const [selectedGenders, setSelectedGenders] = useState(genders);
  const [selectedCategories, setSelectedCategories] = useState(categories);
  const [selectedPhrase, setSelectedPhrase] = useState(phrases[0]);
  const [searchText, setSearchText] = useState('');

  const availableSeeds = [...seeds]
    .sort((a, b) => a.name.toLowerCase().localeCompare(b.name.toLowerCase()))
    .filter(
      (seed) =>
        selectedProviders.includes(seed.provider) &&
        selectedGenders.includes(seed.gender) &&
        selectedCategories.includes(seed.category) &&
        seed.name.toLowerCase().includes(searchText.toLowerCase()),
    );
  const currentSeed = seeds.find((seed) => seed.name === tts_seed);

  return (
    <Stack fill>
      <Stack.Item basis="40%">
        <Stack fill vertical>
          <Stack.Item>
            <Section title="Фильтры">
              <LabeledList>
                <LabeledList.Item label="Провайдеры">
                  <CheckboxGroup
                    items={providerNames}
                    selected={selectedProviders}
                    setSelected={setSelectedProviders}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Пол">
                  <CheckboxGroup
                    items={genders}
                    selected={selectedGenders}
                    setSelected={setSelectedGenders}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Фраза">
                  <Dropdown
                    options={phrases}
                    selected={selectedPhrase}
                    onSelected={(value) => setSelectedPhrase(value)}
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section
              fill
              scrollable
              title="Категории"
              buttons={
                <>
                  <Button
                    icon="times"
                    color="bad"
                    disabled={selectedCategories.length === 0}
                    onClick={() => setSelectedCategories([])}
                  >
                    Убрать всё
                  </Button>
                  <Button
                    icon="check"
                    color="good"
                    disabled={selectedCategories.length === categories.length}
                    onClick={() => setSelectedCategories(categories)}
                  >
                    Выбрать всё
                  </Button>
                </>
              }
            >
              <CheckboxGroup
                items={categories}
                selected={selectedCategories}
                setSelected={setSelectedCategories}
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Section
          fill
          scrollable
          title={`Голоса (${availableSeeds.length}/${seeds.length})`}
          buttons={
            <SearchBar
              placeholder="Название..."
              query={searchText}
              onSearch={setSearchText}
            />
          }
        >
          {currentSeed && (
            <Section title="Текущий голос">
              <SeedRow
                seed={currentSeed}
                selectedSeed={tts_seed}
                selectedPhrase={selectedPhrase}
              />
            </Section>
          )}
          <VirtualList>
            {availableSeeds.map((seed) => (
              <SeedRow
                key={seed.name}
                seed={seed}
                selectedSeed={tts_seed}
                selectedPhrase={selectedPhrase}
              />
            ))}
          </VirtualList>
        </Section>
      </Stack.Item>
    </Stack>
  );
}

type SeedRowProps = {
  seed: TtsSeed;
  selectedSeed: string;
  selectedPhrase: string;
};

function SeedRow(props: SeedRowProps) {
  const { seed, selectedSeed, selectedPhrase } = props;
  const { act } = useBackend();
  const isSelected = selectedSeed === seed.name;
  const genderIcon = genderIcons[seed.gender] || genderIcons.Любой;

  return (
    <Stack align="center" mb={0.5}>
      <Stack.Item>
        <Button
          icon="music"
          tooltip="Прослушать пример"
          onClick={() =>
            act('listen', { seed: seed.name, phrase: selectedPhrase })
          }
        />
      </Stack.Item>
      <Stack.Item grow>
        <Button
          fluid
          selected={isSelected}
          onClick={() => !isSelected && act('select_voice', { seed: seed.name })}
        >
          {seed.name}
        </Button>
      </Stack.Item>
      <Stack.Item width="12em" textAlign="right" opacity={0.5}>
        {seed.category}
      </Stack.Item>
      <Stack.Item width="1.5em" textAlign="center">
        <Icon name={genderIcon.icon} color={genderIcon.color} />
      </Stack.Item>
    </Stack>
  );
}
