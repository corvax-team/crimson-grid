// SPLIT_CHANGELOG
import yaml from 'js-yaml';
import { Component, Fragment } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Icon,
  Image,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { sendAct as act } from '../events/act';
import { Window } from '../layouts';

const icons = {
  add: { icon: 'check-circle', color: 'green' },
  admin: { icon: 'user-shield', color: 'purple' },
  balance: { icon: 'balance-scale-right', color: 'yellow' },
  bugfix: { icon: 'bug', color: 'green' },
  code_imp: { icon: 'code', color: 'green' },
  config: { icon: 'cogs', color: 'purple' },
  expansion: { icon: 'check-circle', color: 'green' },
  experiment: { icon: 'radiation', color: 'yellow' },
  image: { icon: 'image', color: 'green' },
  imageadd: { icon: 'tg-image-plus', color: 'green' },
  imagedel: { icon: 'tg-image-minus', color: 'red' },
  qol: { icon: 'hand-holding-heart', color: 'green' },
  refactor: { icon: 'tools', color: 'green' },
  rscadd: { icon: 'check-circle', color: 'green' },
  rscdel: { icon: 'times-circle', color: 'red' },
  server: { icon: 'server', color: 'purple' },
  sound: { icon: 'volume-high', color: 'green' },
  soundadd: { icon: 'tg-sound-plus', color: 'green' },
  sounddel: { icon: 'tg-sound-minus', color: 'red' },
  spellcheck: { icon: 'spell-check', color: 'green' },
  map: { icon: 'map', color: 'green' },
  tgs: { icon: 'toolbox', color: 'purple' },
  tweak: { icon: 'wrench', color: 'green' },
  unknown: { icon: 'info-circle', color: 'label' },
  wip: { icon: 'hammer', color: 'orange' },
};

type Change = Record<string, string>;
type AuthorChanges = Record<string, Change[]>;
type ChangelogYaml = Record<string, AuthorChanges>;

type ChangelogState = {
  loaded_text: ChangelogYaml | string;
  darkpack_text: ChangelogYaml | string;
  crimson_text: ChangelogYaml | string; // CRIMSON EDIT ADD - SPLIT_CHANGELOG
  selectedDate: string;
  selectedIndex: number;
};

type ChangelogData = {
  dates: string[];
};

export class ChangelogContent extends Component<any, ChangelogState> {
  dateChoices: string[];

  constructor(props) {
    super(props);
    this.dateChoices = [];
    this.state = {
      loaded_text: 'Загружаем список изменений...',
      darkpack_text: 'Загружаем список изменений...',
      crimson_text: 'Загружаем список изменений...', // CRIMSON EDIT ADD - SPLIT_CHANGELOG
      selectedDate: '',
      selectedIndex: 0,
    };
  }

  setData(loaded_text) {
    this.setState({ loaded_text });
  }

  setEffigyData(darkpack_text) {
    this.setState({ darkpack_text });
  }

  // CRIMSON EDIT ADD START - SPLIT_CHANGELOG
  setCrimsonData(crimson_text) {
    this.setState({ crimson_text });
  }
  // CRIMSON EDIT ADD END

  setSelectedDate(selectedDate) {
    this.setState({ selectedDate });
  }

  setSelectedIndex(selectedIndex) {
    this.setState({ selectedIndex });
  }

  getData = (date, attemptNumber = 1) => {
    const maxAttempts = 6;

    if (attemptNumber > maxAttempts) {
      this.setData(`Не удалось загрузить данные после ${maxAttempts} попыток`);
      this.setEffigyData(`Не удалось загрузить данные после ${maxAttempts} попыток`);
      this.setCrimsonData(`Не удалось загрузить данные после ${maxAttempts} попыток`); // CRIMSON EDIT ADD - SPLIT_CHANGELOG
      return;
    }

    act('get_month', { date });

    Promise.all([
      fetch(resolveAsset(`${date}.yml`)),
      fetch(resolveAsset(`darkpack_${date}.yml`)),
      fetch(resolveAsset(`crimson_${date}.yml`)), // CRIMSON EDIT ADD - SPLIT_CHANGELOG
    ]).then(async ([changelogData, darkpackData, crimsonData]) => {
      // CRIMSON EDIT CHANGE - SPLIT_CHANGELOG
      if (!changelogData.ok && !darkpackData.ok && !crimsonData.ok) {
        // CRIMSON EDIT CHANGE - SPLIT_CHANGELOG
        const timeout = 50 + attemptNumber * 50;

        this.setData(`Загружаем список изменений${'.'.repeat(attemptNumber + 3)}`);
        this.setEffigyData(
          `Загружаем список изменений${'.'.repeat(attemptNumber + 3)}`,
        );
        this.setCrimsonData(
          `Загружаем список изменений${'.'.repeat(attemptNumber + 3)}`,
        ); // CRIMSON EDIT ADD - SPLIT_CHANGELOG

        setTimeout(() => {
          this.getData(date, attemptNumber + 1);
        }, timeout);

        return;
      }

      if (changelogData.ok) {
        const result = await changelogData.text();

        this.setData(
          yaml.load(result, {
            schema: yaml.CORE_SCHEMA,
          }) as ChangelogYaml,
        );
      }

      if (darkpackData.ok) {
        const result = await darkpackData.text();

        this.setEffigyData(
          yaml.load(result, {
            schema: yaml.CORE_SCHEMA,
          }) as ChangelogYaml,
        );
      }
     // CRIMSON EDIT ADD START - SPLIT_CHANGELOG
      if (crimsonData.ok) {
        const result = await crimsonData.text();

        this.setCrimsonData(
          yaml.load(result, {
            schema: yaml.CORE_SCHEMA,
          }) as ChangelogYaml,
        );
      }
      // CRIMSON EDIT ADD END

    });
  };

  componentDidMount() {
    const { data } = useBackend<ChangelogData>();
    const { dates = [] } = data;

    this.dateChoices = dates.map((date) => monthTitle(date));

    if (dates.length > 0) {
      this.setSelectedDate(this.dateChoices[0]);
      this.getData(dates[0]);
    }
  }

  renderChangelogEntries(authors: AuthorChanges, server) {
    return Object.entries(authors).map(([name, changes]) => (
      <Fragment key={name}>
        <h4>
          <Image
            verticalAlign="bottom"
            src={resolveAsset(`${server}_16.png`)}
          />
          {name}:
        </h4>

        <Box ml={3}>
          <Table>
            {changes.map((change) => {
              const changeType = Object.keys(change)[0];

              return (
                <Table.Row key={changeType + change[changeType]}>
                  <Table.Cell
                    className={classes([
                      'Changelog__Cell',
                      'Changelog__Cell--Icon',
                    ])}
                  >
                    <Icon
                      color={
                        icons[changeType]
                          ? icons[changeType].color
                          : icons.unknown.color
                      }
                      name={
                        icons[changeType]
                          ? icons[changeType].icon
                          : icons.unknown.icon
                      }
                    />
                  </Table.Cell>

                  <Table.Cell className="Changelog__Cell">
                    {change[changeType]}
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Box>
      </Fragment>
    ));
  }

  render() {
    const { data } = useBackend<ChangelogData>();
    const { dates = [] } = data;

    const {
      loaded_text,
      darkpack_text,
      crimson_text,
      selectedIndex,
      selectedDate,
    } = this.state; // CRIMSON EDIT CHANGE - SPLIT_CHANGELOG

    const { dateChoices } = this;

    const dateDropdown = dateChoices.length > 0 && (
      <Stack>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === 0}
            icon="chevron-left"
            onClick={() => {
              const index = selectedIndex - 1;

              this.setData('Загружаем список изменений...');
              this.setEffigyData('Загружаем список изменений...');
              this.setCrimsonData('Загружаем список изменений...'); // CRIMSON EDIT CHANGE - SPLIT_CHANGELOG
              this.setSelectedIndex(index);
              this.setSelectedDate(dateChoices[index]);

              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(dates[index]);
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            autoScroll={false}
            options={dateChoices}
            onSelected={(value) => {
              const index = dateChoices.indexOf(value);

              this.setData('Загружаем список изменений...');
              this.setEffigyData('Загружаем список изменений...');
              this.setCrimsonData('Загружаем список изменений...'); // CRIMSON EDIT CHANGE - SPLIT_CHANGELOG
              this.setSelectedIndex(index);
              this.setSelectedDate(value);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(dates[index]);
            }}
            selected={selectedDate}
            width="150px"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === dateChoices.length - 1}
            icon={'chevron-right'}
            onClick={() => {
              const index = selectedIndex + 1;

              this.setData('Загружаем список изменений...');
              this.setEffigyData('Загружаем список изменений...');
              this.setCrimsonData('Загружаем список изменений...'); // CRIMSON EDIT CHANGE - SPLIT_CHANGELOG
              this.setSelectedIndex(index);
              this.setSelectedDate(dateChoices[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(dates[index]);
            }}
          />
        </Stack.Item>
      </Stack>
    );
    // CRIMSON EDIT ADD BELOW - Original <h1>Darkpack: Second City</h1> and adds Darkpack: Second City to Thanks To
    const header = (
      <Section>
        <h1>Crimson Grid</h1>
        <p>
          <b>Спасибо: </b>
          Darkpack: Second City, The Final Nights, World of Darkness 13, RequiemSS13, TGstation,
          Baystation 12, /vg/station, NTstation, разработчикам CDK Station,
          FacepunchStation, разработчикам GoonStation, первым разработчикам
          Space Station 13, Invisty за заглавное изображение и всем тем, кто
          годами помогал игре, баг-трекеру и вики.
        </p>
        <p>
          {'Нынешние участники организации перечислены '}
          <a href="https://github.com/orgs/DarkPack13/people">здесь</a>
          {', а недавние контрибьюторы на GitHub - '}
          <a href="https://github.com/DarkPack13/SecondCity/pulse/monthly">
            здесь
          </a>
          .
        </p>
        <p>
          {'А ещё у нас есть Discord: заходите '}
          <a href="https://discord.gg/wT95uK8VZj">сюда</a>.
        </p>
        {dateDropdown}
      </Section>
    );

    const footer = (
      <Section>
        {dateDropdown}
        <h3>GoonStation 13 Development Team</h3>
        <p>
          <b>Программисты: </b>
          Stuntwaffle, Showtime, Pantaloons, Nannek, Keelin, Exadv1, hobnob,
          Justicefries, 0staf, sniperchance, AngriestIBM, BrianOBlivion
        </p>
        <p>
          <b>Спрайтеры: </b>
          Supernorn, Haruhi, Stuntwaffle, Pantaloons, Rho, SynthOrange, I Said
          No
        </p>
        <p>
          Traditional Games Space Station 13 благодарит GoonStation 13
          Development Team за работу над игрой вплоть до
          {' релиза r4407. Список изменений до r4407 можно посмотреть '}
          <a href="https://wiki.ss13.co/Pre-2016_Changelog#April_2010">здесь</a>.
        </p>
        <p>
          {'Если не указано иное, Goon Station 13 распространяется по лицензии '}
          <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/">
            Creative Commons Attribution-Noncommercial-Share Alike 3.0 License
          </a>
          {'. Сейчас права предоставлены только '}
          <a href="http://forums.somethingawful.com/">SomethingAwful Goons</a>
          {'.'}
        </p>
        <h3>Лицензия Traditional Games Space Station 13</h3>
        <p>
          {'Весь код после '}
          <a
            href={
              'https://github.com/tgstation/tgstation/commit/' +
              '333c566b88108de218d882840e61928a9b759d8f'
            }
          >
            коммита 333c566b88108de218d882840e61928a9b759d8f от 31.12.2014,
            16:38 PST
          </a>
          {' распространяется по лицензии '}
          <a href="https://www.gnu.org/licenses/agpl-3.0.html">GNU AGPL v3</a>
          {'. Весь код до этого коммита распространяется по лицензии '}
          <a href="https://www.gnu.org/licenses/gpl-3.0.html">GNU GPL v3</a>
          {', включая инструменты, если в их readme не сказано иное. Подробности в '}
          <a href="https://github.com/tgstation/tgstation/blob/master/LICENSE">
            LICENSE
          </a>
          {' и '}
          <a href="https://github.com/tgstation/tgstation/blob/master/GPLv3.txt">
            GPLv3.txt
          </a>
          {'.'}
        </p>
        <p>
          TGS DMAPI API лицензируется как отдельный подпроект по лицензии MIT.
          {' Текст лицензии MIT приведён в конце '}
          <a
            href={
              'https://github.com/tgstation/tgstation/blob/master' +
              '/code/__DEFINES/tgs.dm'
            }
          >
            code/__DEFINES/tgs.dm
          </a>
          {' и в '}
          <a
            href={
              'https://github.com/tgstation/tgstation/blob/master' +
              '/code/modules/tgs/LICENSE'
            }
          >
            code/modules/tgs/LICENSE
          </a>
          {'.'}
        </p>
        <p>
          {'Все ассеты, включая иконки и звуки, распространяются по лицензии '}
          <a href="https://creativecommons.org/licenses/by-sa/3.0/">
            Creative Commons 3.0 BY-SA license
          </a>
          {', если не указано иное.'}
        </p>
      </Section>
    );

    const changelog = typeof loaded_text === 'object' ? loaded_text : null;

    const darkpackChangelog =
      typeof darkpack_text === 'object' ? darkpack_text : null;

    const crimsonChangelog = typeof crimson_text === 'object' ? crimson_text : null; // CRIMSON EDIT ADD - SPLIT_CHANGELOG

    const combinedDates = new Set([
      ...(changelog ? Object.keys(changelog) : []),
      ...(darkpackChangelog ? Object.keys(darkpackChangelog) : []),
      ...(crimsonChangelog ? Object.keys(crimsonChangelog) : []), // CRIMSON EDIT ADD - SPLIT_CHANGELOG
    ]);

    const changes = [...combinedDates]
      .sort()
      .reverse()
      .map((date) => (
        <Section key={date} title={dayTitle(date)}>
          <Box ml={3}>
            {/* CRIMSON EDIT ADD START - SPLIT_CHANGELOG */}
            {crimsonChangelog?.[date] && (
              <Section>
                {this.renderChangelogEntries(crimsonChangelog[date], 'crimson')}
              </Section>
            )}
            {/* CRIMSON EDIT ADD END */}
            {darkpackChangelog?.[date] && (
              <Section>
                {this.renderChangelogEntries(
                  darkpackChangelog[date],
                  'darkpack',
                )}
              </Section>
            )}

            {changelog?.[date] && (
              <Section mt="-20px">
                {this.renderChangelogEntries(changelog[date], 'tg')}
              </Section>
            )}
          </Box>
        </Section>
      ));

    return (
      <>
        {header}
        {changes}
        {typeof loaded_text === 'string' && <p>{loaded_text}</p>}
        {footer}
      </>
    );
  }
}

export const Changelog = () => {
  return (
    <Window title="Список изменений" width={675} height={650}>
      <Window.Content scrollable>
        <ChangelogContent />
      </Window.Content>
    </Window>
  );
};

const MONTHS_NOMINATIVE = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];

const MONTHS_GENITIVE = [
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

function monthTitle(date: string) {
  const parsed = new Date(date);
  return `${MONTHS_NOMINATIVE[parsed.getUTCMonth()]} ${parsed.getUTCFullYear()}`;
}

function dayTitle(date: string) {
  const parsed = new Date(date);
  return `${parsed.getUTCDate()} ${MONTHS_GENITIVE[parsed.getUTCMonth()]} ${parsed.getUTCFullYear()}`;
}
