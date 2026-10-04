# WoD EN -> RU glossary for crimson-grid

## Sources and how to read the "Source" column

| Tag | What it is | URL |
|---|---|---|
| S101-V20 | Official Studio 101 edition "Вампиры: Маскарад. Классические правила" (V20), 2019, "Перевод (c) ООО Студия 101", translator K. Smykov. I grepped the full text of this copy locally, so entries with this tag are checked against the actual book text | (product page: https://rpgbook.ru/STV2001) |
| wod.su | "Все Оттенки Тьмы" fan translations (VtM Revised, WtA Revised by WinterMute, Alex N-sky, Lian and others). Site refused connections, read through Wayback Machine | https://web.archive.org/web/2024/https://wod.su/vampire/book/book_of_nod/lexicon , https://web.archive.org/web/2024/https://wod.su/vampire/disciplines , https://web.archive.org/web/2024/https://wod.su/werewolf , https://web.archive.org/web/2024/https://wod.su/werewolf/book/werewolf_core/04 (also /05, /06) |
| fandom | Russian WoD wiki, page titles, redirects and lexicon pages (read through the MediaWiki API) | https://wod.fandom.com/ru/wiki/Гару , https://wod.fandom.com/ru/wiki/Словарь_гару , https://wod.fandom.com/ru/wiki/Лексикон_Камарильи , https://wod.fandom.com/ru/wiki/Пути_Просветления |
| wta5 | wta5.ru, a fan Russian reference for 5th edition (V5 and W5). Its V5 wording follows the Studio 101 V5 book closely, but it is not the book itself | https://wta5.ru/vampire , https://wta5.ru/vampire/clans , https://wta5.ru/werewolf , https://wta5.ru/werewolf/forms |
| V5-fan | A fan "V5 rus" translation (not Studio 101) | |
| dtf | DTF overview articles, used as evidence of everyday community wording | https://dtf.ru/games/45497-poveliteli-nochi-kak-ustroen-mir-vampire-the-masquerade , https://dtf.ru/games/77307-zashitniki-zemli-kak-ustroen-mir-werewolf-the-apocalypse |
| mirf | Mir Fantastiki article on the Russian V5 | https://www.mirf.ru/games/vampire-the-masquerade-5-redakciya |
| ruwiki | Russian Wikipedia, Werewolf: The Apocalypse | https://ru.wikipedia.org/wiki/Werewolf:_The_Apocalypse |
| INFERRED | No source found, my own suggestion. Treat as a draft | - |

Status of official editions, as far as I could establish:
- VtM V20 and V5 exist officially in Russian from Studio 101. V20 text was checked directly. The V5 book text was NOT checked directly, only through wta5 and shop blurbs
- No official Russian edition of Werewolf: The Apocalypse (W20 or W5) was found. Werewolf terms rest on the wod.su fan translation of WtA Revised, the fandom wiki and wta5
- The only werewolf words that have an official Studio 101 rendering are those mentioned in the V20 book: "Люпены" (Lupines), "оборотни", "Гнозис"

Repo terms were collected read-only from modular_darkpack/modules (jobs, splats, powers, paths, merits_flaws, storyteller_stats, sabbat, umbra, masquerade, werewolf_the_apocalypse, vampire_the_masquerade, ritual_*) and modular_vcg, plus the JOB_/TRIBE_/AUSPICE_/BREED_/DEPARTMENT_ defines.

## 1. Core vampire concepts

| English | Recommended Russian | Alternatives in use | Source / notes |
|---|---|---|---|
| Kindred | Сородич, мн. Сородичи | - | S101-V20, wod.su, fandom, wta5. Masc., declines. S101 capitalizes it |
| Cainite | каинит, мн. каиниты | - | S101-V20 (Sabbat word for vampire), wod.su |
| Vampire (slang "Lick") | вампир; сленг "упырь" | - | S101-V20 vulgar lexicon gives "Упырь: вампир" |
| Kine | люд | "скот" (wod.su), "смертные" | S101-V20 archaic lexicon: "Люд: пренебрежительное обозначение смертных" |
| Embrace | Становление | "Объятия/Объятья" (fandom page title), "Обращение" (V5-fan) | S101-V20, wod.su, wta5, dtf all use "Становление". Neuter. Verb: "даровать Становление", "получить Становление" |
| the Kiss | Поцелуй | - | S101-V20 |
| Vitae | витэ | - | S101-V20, fandom, wta5. Indeclinable, feminine in S101 ("чужой витэ", "Бесплодная витэ"), lowercase |
| Blood (lineage sense) | Кровь | - | S101-V20 capitalizes when it means heritage |
| the Beast | Зверь | - | S101-V20, wod.su, fandom |
| Hunger | Голод | - | S101-V20, wta5 |
| Frenzy | see contested list. Recommended: Безумие (verb "впасть в безумие") | "ярость / приступ ярости" (S101-V20, wod.su, mirf), "Безумие" (wta5, V5-fan, dtf, fandom redirect "Безумие"), "френзи" (colloquial, no written source found) | S101-V20 says "приступ ярости", but that collides with Garou Rage = "Ярость" in a build that has both splats |
| Rotschreck | Ротшрек | "Рётшрек", "Красный страх" (no source found) | S101-V20 (50 hits), fandom. Masc., declines: "в Ротшреке" |
| Torpor | торпор | "оцепенение" (V5-fan) | S101-V20, fandom, wta5. Masc., declines: "впасть в торпор" |
| Final Death | Окончательная смерть | - | S101-V20, fandom, wta5 |
| Diablerie | диаблери | "диаблеризация" | S101-V20, fandom, wta5. Indeclinable, neuter. Doer: "диаблерист" |
| Amaranth | Амарант | - | S101-V20 |
| Blood Bond | узы крови | "Кровавые узы", "Кровавая клятва" (wod.su), "кровный обет" (S101 archaic) | S101-V20, fandom, wta5. Plural only: "связан узами крови" |
| Regnant | сюзерен | "регнант" (fandom) | S101-V20 archaic lexicon |
| Thrall | вассал | "раб" | S101-V20 |
| Domitor | домитор | - | S101-V20 |
| Ghoul | гуль, мн. гули | - | S101-V20, fandom. Masc., soft declension: гуля, гулю, гулем, гулей |
| Revenant | ревенант | - | S101-V20 |
| Generation | поколение | - | S101-V20. Written "Восьмое поколение", ordinal capitalized in S101 |
| Antediluvian | see contested list. Recommended: Патриарх, мн. Патриархи | "предтеча / предтечи", "допотопные старцы" (S101-V20), "Допотопные" (fandom, wta5) | wod.su and V5-fan use "Патриарх"; dtf states it is the usual Russian rendering |
| Methuselah | мафусаил, мн. мафусаилы | - | S101-V20, fandom |
| Elder | старейшина | - | S101-V20. Declines like "мужчина", agrees as masculine |
| Ancilla | анцилла | - | S101-V20. Feminine form, declines |
| Neonate | неонат | - | S101-V20, wod.su |
| Fledgling | птенец | - | S101-V20 |
| Childe | дитя, мн. потомки | "чайльд" (S101 archaic), "потомок" | S101-V20 states plural is "потомки" |
| Sire | сир | - | S101-V20, wod.su. Used for both sexes |
| Caitiff | каитиф, мн. каитифы | "каитифф" (wod.su, fandom, V5-fan) | S101-V20 and wta5 spell with one "ф". Masc., declines |
| Thin-blooded | Слабокровные | "Тонкокровные" (wta5) | S101-V20, fandom, V5-fan |
| Clan | клан | - | all |
| Bloodline | линия крови | "родословная" (fandom) | S101-V20 |
| antitribu | антитрибу | - | S101-V20. Indeclinable. "антитрибу Вентру", "тореадоры-антитрибу" |
| Clan weakness | изъян | "слабость", "проклятие" (V5) | S101-V20 |
| Caine | Каин | - | all |
| Gehenna | Геенна | - | S101-V20, wod.su, fandom |
| Jyhad | Извечная Борьба | "Джихад" (wod.su, fandom) | S101-V20 |
| Golconda | Голконда | - | S101-V20, wod.su |
| Masquerade | Маскарад | - | all |
| Masquerade breach / violation | нарушение Маскарада | "брешь в Маскараде" | S101-V20 ("нарушения Маскарада"), fandom lexicon "Нарушение (Breach)" |
| Traditions | Традиции | - | S101-V20. "Первая Традиция: Маскарад", "Третья Традиция: Потомство", "Шестая Традиция: Умерщвление" |
| Blood Hunt | Кровавая Охота | - | S101-V20, fandom |
| Lextalionis | Лекс Талионис | "Лекс талион" (fandom) | S101-V20 |
| Elysium | Элизиум | - | S101-V20, fandom, wta5 |
| Domain | домен | - | S101-V20 |
| Haven | убежище | - | S101-V20 |
| Herd | стадо | - | S101-V20 |
| Vessel | сосуд | - | S101-V20 |
| Coterie | котерия | - | S101-V20, wta5 |
| Praxis | праксис | - | S101-V20 |
| Autarkis | автарх | "автарк" (fandom) | S101-V20 |
| True Faith | истинная вера | - | S101-V20 |
| Lupine | Люпен, мн. Люпены | "люпин(ы)" (fandom, V5-fan) | S101-V20 |
| Kuei-jin | гуй-дзин | "Куэй-дзин" (wod.su menu) | fandom. Not in S101-V20 |
| Wraith / ghost | призрак | - | S101-V20 |
| Changeling | подменыш | "фея" | S101-V20 |
| Shroud (between living and dead) | Завеса | - | S101-V20. Note the clash with the Garou "Veil" below |

## 2. Sects, titles, jobs

| English | Recommended Russian | Alternatives in use | Source / notes |
|---|---|---|---|
| Sect | секта | "фракция" (S101-V20) | wod.su, fandom, wta5 say "секта". See contested list |
| Camarilla | Камарилья | - | all. Fem., declines: Камарильи, Камарилье |
| Sabbat | Шабаш | "Саббат" (colloquial, no source found; fandom has no such page) | S101-V20 (430 hits), wod.su, fandom, wta5, dtf. Masc., declines: Шабаша |
| Anarchs / Anarch Movement | анархи / Движение анархов | "Мятежники" (wod.su, old) | S101-V20, fandom, wta5 |
| Inconnu | Инконну | "Инконню" (wod.su) | S101-V20. Indeclinable |
| Black Hand | Чёрная Рука | - | S101-V20 |
| Sword of Caine | Меч Каина | - | S101-V20 |
| Independents | независимые кланы | - | S101-V20, wod.su |
| Prince | Принц | "Князь" (wod.su, fandom) | S101-V20 has a translator's note choosing "Принц"; wta5 and dtf ("принц ЛаКруа") agree. See contested list |
| Seneschal | Сенешаль | - | fandom ("Сенешали Камарильи"). Not found in S101-V20 text. Masc., soft: Сенешаля |
| Sheriff | Шериф | - | S101-V20, fandom |
| Hound | Пёс, мн. Псы | "гончая" (no source found) | S101-V20: "помощников, которые называются Псами" |
| Scourge | Палач | "Бич" (fandom) | S101-V20. See contested list |
| Harpy | Гарпия | - | S101-V20, fandom |
| Keeper of Elysium | Хранитель Элизиума | - | S101-V20, fandom |
| Primogen | Примоген | - | S101-V20, fandom. Masc., declines. "Примоген клана Бруха" for "Primogen Brujah" |
| Primogen's whip / steward / myrmidon | кнут / распорядитель / мирмидон Примогена | - | INFERRED ("Whip" as "Кнут" is common fan usage but I did not verify it) |
| Justicar | Юстициар | - | S101-V20 |
| Archon | Архонт | - | S101-V20 |
| Inner Circle | Внутренний Круг | - | S101-V20 |
| Baron (Anarch) | Барон | - | S101-V20, fandom |
| Emissary / Sweeper / Bruiser / Tapster (Anarch jobs in this build) | Эмиссар / Чистильщик / Громила / Трактирщик | - | INFERRED. These are build-specific roles, no canon Russian term found |
| Archbishop / Bishop / Cardinal / Regent (Sabbat) | Архиепископ / Епископ / Кардинал / Регент | - | S101-V20 |
| Templar / Paladin | Храмовник | "Паладин" | S101-V20 |
| Ductus | вожак стаи | "дуктус" (fandom "Дуктусы Шабаша") | S101-V20 uses "вожак". See contested list |
| Pack Priest | духовник (стаи) | "священник стаи" (no source found) | S101-V20 |
| Pack (Sabbat) | стая | - | S101-V20 |
| Sabbatist (repo term) | шабашит | - | fandom category "Известные шабашиты"; otherwise "член Шабаша" (S101-V20) |
| Chantry | капелла | - | S101-V20, fandom ("Капеллы Тремеров") |
| Regent (Tremere) | Регент | - | fandom. S101-V20 text only shows the Sabbat Regent |
| Chantry Archivist | архивариус капеллы | - | INFERRED |
| Voivode | Воевода | - | fandom ("Воеводы Цимисхов"); S101-V20 lists "Воевода" as a title variant |
| Zadruga / Bogatyr | Задруга / Богатырь | - | INFERRED (plain Slavic words, back-transliterated) |
| szlachta / vozhd | шляхта / вождь | - | S101-V20 |
| Capo / La Famiglia / La Squadra / I Nonni (Giovanni jobs) | Капо / Семья / Отряд (Скуадра) / Нонни | keep Italian in Latin script | INFERRED |
| Society of Leopold | Общество Леопольда | "Общество святого Леопольда" (fandom) | S101-V20 |
| Inquisitor | инквизитор | - | S101-V20 |
| Abbe / Condottieri / Novice (hunter jobs) | Аббат / Кондотьер / Послушник | - | INFERRED |
| Hunter | охотник | - | S101-V20 |
| Pentex | "Пентекс" | - | S101-V20, wod.su, fandom, dtf, ruwiki |
| Endron | "Эндрон" | - | fandom ("Эндрон Интернейшнл"), dtf |
| Triad: Mountain Master / Deputy / Red Pole / Blue Lanterns | Хозяин Горы / Заместитель Хозяина Горы / Красный Шест / Синие Фонари | - | INFERRED |

## 3. Clans and bloodlines (with grammar)

Declension patterns below are taken from actual usage counts in S101-V20 (for example "Тремер" 99 times in clan-name position, "тремеры/тремеров" for members; "Бруха" and "бруха" never inflected).

| English | Recommended Russian | Member, sg / pl | Declines? | Alternatives | Source / notes |
|---|---|---|---|---|---|
| Brujah | Бруха | бруха / бруха | No | - | S101-V20. "клан Бруха", "двое бруха" |
| Ventrue | Вентру | вентру / вентру | No | - | S101-V20 |
| Toreador | Тореадор | тореадор / тореадоры | Members decline (тореадора, тореадоров). Clan name after "клан" stays "Тореадор" | - | S101-V20 |
| Tremere | Тремер | тремер / тремеры | Members decline (тремеров, тремерам). "клан Тремер", "проклятие Тремер" | - | S101-V20 |
| Malkavian | Малкавиан (клан), Малкавиане | малкавианин / малкавиане | Yes: малкавианина, малкавиан, малкавианам. Adj. "малкавианский" | - | S101-V20 |
| Nosferatu | Носферату | носферату / носферату | No | - | S101-V20 |
| Gangrel | Гангрел, Гангрелы | гангрел / гангрелы | Yes: гангрела, гангрелов | - | S101-V20 |
| City Gangrel | Городские Гангрелы | - | Yes | "Гангрелы-антитрибу" | S101-V20. The rural line is "Дикие Гангрелы" |
| Lasombra | Ласомбра | ласомбра / ласомбра | No | - | S101-V20 |
| Tzimisce | Цимисхи | цимисх / цимисхи | Yes: цимисха, цимисхов, цимисхам | "Тзимицу", "Тзимици" (dtf), "Зимисхи" | S101-V20 (explicitly notes the variants), fandom, wta5 |
| Old Clan Tzimisce | Старый клан (Цимисхов) | цимисх Старого клана | Yes | - | S101-V20 |
| Giovanni | Джованни | джованни | No | - | S101-V20 |
| Banu Haqim | Бану Хаким | - | No | "Ассамиты" (V20 name: ассамит / ассамиты, declines) | wta5, fandom for "Бану Хаким"; S101-V20 for "Ассамиты" |
| Banu Haqim Vizier / Warrior | визирь / воин Бану Хаким | визири / воины | Yes | "Визири Ассамитов" | S101-V20 has "Визири Ассамитов"; fandom lists castes "Воины, Чародеи, Визири" |
| Setite / Followers of Set | Последователи Сета | сетит / сетиты | Yes | "Сеттиты" (wod.su), "Министерство/Министри" (V5, wta5) | S101-V20 |
| Warrior Setite | сетит-воин | сетиты-воины | Yes | - | INFERRED |
| Tlacique | Тласике | - | No | "Тлацике" | INFERRED spelling. fandom has no page under either spelling |
| Ravnos | Равнос | равнос / равнос | No | "Равносы" (fandom) | S101-V20 |
| Salubri | Салюбри | салюбри / салюбри | No | - | S101-V20, fandom, wta5 |
| Warrior Salubri | салюбри-воин | салюбри-воины | First part no | "салюбри-антитрибу" | INFERRED. S101-V20 only says "отступники-салюбри из Шабаша" |
| Baali | Баали | баали | No | - | S101-V20 |
| Cappadocian | Каппадокийцы | каппадокиец / каппадокийцы | Yes | - | S101-V20 |
| Harbinger of Skulls | Предвестники Черепов | Предвестник / Предвестники | Yes | - | S101-V20, fandom |
| Samedi | Самеди | самеди | No | - | S101-V20 |
| Nagaraja | Нагараджа | нагараджа | Mostly not declined in S101 | - | S101-V20, fandom |
| Kiasyd | Киасиды | киасид / киасиды | Yes | "Каэсиды" (fandom) | S101-V20 |
| Daughters of Cacophony | Дочери Какофонии | Дочь Какофонии | Yes | - | S101-V20, fandom |
| Gargoyle | Горгульи | горгулья / горгульи | Yes, feminine: горгулью, горгулий | "Гаргульи" (no page on fandom) | S101-V20, fandom |
| True Brujah | Истинные Бруха | Истинный Бруха | Adjective declines, "Бруха" does not | - | S101-V20, fandom |
| Ventrue antitribu | Вентру-антитрибу | - | No | "антитрибу Вентру" | S101-V20 uses both orders |
| Hecata (start landmark) | Геката | - | Yes, fem. | - | fandom, wta5 |
| Kinfolk, Garou, Corax | see werewolf section | | | | |

## 4. Disciplines

Two complete naming traditions exist. S101 (official, V20 and continued in V5 per wta5) and the older wod.su set, which the fandom wiki also uses as page titles.

| English | Recommended (S101-V20) | wod.su / fandom tradition | Notes |
|---|---|---|---|
| Discipline | Дисциплина | Дисциплина | S101 capitalizes |
| Animalism | Анимализм | Анимализм | same everywhere |
| Auspex | Ясновидение | Прорицание | wta5 (V5): Ясновидение |
| Celerity | Стремительность | Стремительность | same |
| Dominate | Доминирование | Доминирование | same |
| Fortitude | Стойкость | Стойкость | same |
| Obfuscate | Сокрытие | Затемнение | wta5: Сокрытие; V5-fan: Затемнение |
| Obtenebration | Затмение | Власть над Тенью | |
| Potence | Мощь | Могущество | wta5 and V5-fan: Мощь |
| Presence | Величие | Присутствие | wta5: Величие; V5-fan: Внушительность |
| Protean | Метаморфозы | Превращение | wta5: Метаморфозы |
| Dementation | Помешательство | Помешательство | same |
| Quietus | Упокоение | Смертоносность | "Квиетус" has no page on fandom |
| Serpentis | Серпентис | Серпентис | same |
| Vicissitude | Преображение | Изменчивость | |
| Thaumaturgy | Тауматургия | Тауматургия | same |
| Necromancy | Некромантия | Некромантия | same |
| Chimerstry | Фантасмагория | Химерия | not in the repo list, included for completeness |
| Daimonion | Демонион | Демонизм | |
| Melpominee | Мельпомения | Мельпомения | same |
| Mytherceria | Мистификация | Мистерия | |
| Obeah | Обеа | Обеах | |
| Valeren | Валерен | Валерен | same |
| Temporis | Темпорис | Темпорис | same |
| Thanatosis | Танатозис | Танатозис | same |
| Visceratika | Висцератика | Висцератика | same |
| Flight (Gargoyle) | Полёт | Полёт Горгулий | |
| Koldunic Sorcery | Колдовство | Колдовство | S101-V20, wod.su |
| Abyss Mysticism | Мистицизм Бездны | - | INFERRED. "Бездна" itself is S101-V20 ("Руки Бездны") |
| Bloodheal / Blood Power (repo mechanics) | Исцеление кровью / Сила крови | - | INFERRED, build-specific |

### Thaumaturgy and Necromancy paths, rituals

| English | Recommended Russian | Alternatives | Source / notes |
|---|---|---|---|
| Path of Blood | Путь Крови | - | S101-V20, wod.su |
| Lure of Flames | Игра с Огнём | "Привлечение Огней" (wod.su), "Путь Огня" (fandom) | S101-V20. Levels in S101: Свеча, Факел, Костёр, Пожар, Пекло |
| Path of the Levinbolt | Путь Громовержца | - | wod.su only. Not in S101-V20 |
| Dark Thaumaturgy | Тёмная Тауматургия | - | wod.su |
| The Taking of the Spirit | Лишение Духа | - | wod.su |
| The Fires of the Inferno | Огни Преисподней | "Путь Адского Пламени" (fandom) | wod.su |
| Path of Pain | Путь Боли | - | wod.su |
| Thaumaturgical ritual | тауматургический ритуал | - | S101-V20 |
| Sepulchre Path / Bone Path / Ash Path | Путь Склепа / Путь Костей / Путь Пепла | "Путь Кости", "Путь Праха" (wod.su) | S101-V20 |
| Necromantic ritual | некромантический ритуал | - | S101-V20. "minestra di morte" is kept in Italian with a footnote "похлёбка смерти" |
| Obolus (repo item) | обол | - | INFERRED |

### Discipline powers (S101-V20 names, matched to repo names by discipline and dot level)

| Discipline | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Animalism | Feral Whispers = Язык животных | Beckoning = Зов | Quell the Beast = Усмирение Зверя | Subsume the Spirit = Поглощение духа | Drawing Out the Beast = Отчуждение Зверя |
| Auspex | Heightened Senses = Обострение чувств | Aura Perception = Чтение ауры | The Spirit's Touch = Психометрия | Telepathy = Телепатия | Psychic Projection = Психическая проекция |
| Dominate | Command = Приказ | Mesmerize = Внушение | The Forgetful Mind = Забвение | Conditioning = Порабощение | Possession = Вселение |
| Dementation | Passion = Страсть | The Haunting = Наваждение | Eyes of Chaos = Око хаоса | Voice of Madness = Голос безумия | Total Insanity = Помрачение рассудка |
| Obfuscate | Cloak of Shadows = Плащ теней | Unseen Presence = Незримое присутствие | Mask of a Thousand Faces = Маска тысячи лиц | Vanish from the Mind's Eye = Исчезновение из виду | Cloak the Gathering = Тайное собрание |
| Obtenebration | Shadow Play = Театр теней | Shroud of Night = Покрывало ночи | Arms of the Abyss = Руки Бездны | Black Metamorphosis = Чёрный метаморфоз | Tenebrous Form = Сумеречный облик |
| Presence | Awe = Благоговение | Dread Gaze = Устрашающий взор | Entrancement = Очарование | Summon = Приглашение | Majesty = Преклонение |
| Protean | Eyes of the Beast = Глаза Зверя | Feral Claws = Когти Зверя | Earth Meld = Слияние с землёй | Shape of the Beast = Облик Зверя | Mist Form = Превращение в туман |
| Quietus | Silence of Death = Безмолвие смерти | Scorpion's Touch = Касание скорпиона | Dagon's Call = Зов Дагона | Baal's Caress = Ласка Баала | Taste of Death = Вкус смерти |
| Serpentis | The Eyes of the Serpent = Глаза змеи | The Tongue of the Asp = Язык аспида | The Skin of the Adder = Шкура гадюки | The Form of the Cobra = Облик кобры | The Heart of Darkness = Сердце тьмы |
| Vicissitude | Malleable Visage = Изменчивый облик | Fleshcraft = Искусство тканей | Bonecraft = Искусство костей | Horrid Form = Чудовищный облик | Bloodform = Облик крови |
| Thaumaturgy, Path of Blood | A Taste for Blood = Вкус крови | Blood Rage = Неистовство крови | Blood of Potency = Могущество крови | Theft of Vitae = Хищение крови | Cauldron of Blood = Котёл крови |
| Daimonion | Sense the Sin = Запах греха | Fear of the Void Below = Низменный страх | Conflagration = Всесожжение | Psychomachia = Психомахия | Condemnation = Проклятие |
| Melpominee | The Missing Voice = Блуждающий голос | Phantom Speaker = Незримый собеседник | Madrigal = Мадригал | Siren's Beckoning = Зов сирены | Virtuosa = Виртуозность |
| Mytherceria | Folderol = Чепуха | Fey Sight = Зачарованное зрение | Aura Absorption = Поглощение ауры | Chanjelin Ward = Печать фей | Riddle Phantastique = Волшебная загадка |
| Obeah | Sense Vitality = Биение жизни | Anesthetic Touch = Обезболивающее касание | Corpore Sano = Корпоре сано | Shepherd's Watch = Око пастыря | Mens Sana = Менс сана |
| Valeren | Sense Vitality = Биение жизни | Anesthetic Touch = Обезболивающее касание | Burning Touch = Обжигающее касание | Armor of Caine's Fury = Броня гнева Каинова | Vengeance of Samiel = Месть Самиэля |
| Temporis | Hourglass of the Mind = Песочные часы разума | Recurring Contemplation = Ретроспектива | Leaden Moment = Замедление времени | Patience of the Norns = Терпение Норн | Clotho's Gift = Дар Клото |
| Thanatosis | Hag's Wrinkles = Ведьмины морщины | Putrefaction = Гниение | Ashes to Ashes = Пепел к пеплу | Withering = Омертвение | Necrosis = Некроз |
| Visceratika | Skin of the Chameleon = Шкура хамелеона | Scry the Hearthstone = Страж очага | Bond with the Mountain = Слияние с камнем | Armor of Terra = Доспех Терры | Flow Within the Mountain = Перемещение сквозь камень |
| Necromancy, Bone Path | Tremens = Судороги | Apprentice's Brooms = Зомби-слуги | Shambling Hordes = Гнилая орда | Soul Stealing = Изгнание души | Daemonic Possession = Потусторонняя одержимость |

Caveats: the pairing is by discipline and level order in the S101 text, which I extracted from a text dump with broken page layout. Presence 3/4 and "Зов сирены" (the dump shows only "Зов") should be eyeballed against the book. Repo powers "Darkling Trickery", "Goblinism", "Shroudsight", "Zulo", "Shattering Crescendo" (S101: "Пронзительное крещендо") and build-specific ones were not all matched.

## 5. Morality: Paths of Enlightenment

| English | Recommended Russian | Alternatives | Source / notes |
|---|---|---|---|
| Paths of Enlightenment | Пути Просветления | "Пути Просвещения" (wta5, inconsistent) | S101-V20, wod.su, fandom |
| Humanity | Человечность | - | all |
| Path of Humanity | Путь Человечности | - | S101-V20, fandom |
| Hierarchy of Sins | Иерархия грехов | - | S101-V20 |
| Path of Blood | Путь Крови | - | S101-V20 |
| Path of the Bones | Путь Костей | - | S101-V20 |
| Path of Caine | Путь Каина | - | S101-V20, wta5 |
| Path of Cathari | Путь Катаров | "Путь Катари" (fandom, wta5) | S101-V20 |
| Path of Death and the Soul | Путь Смерти и Души | - | S101-V20, fandom, wta5 |
| Path of the Feral Heart | Путь Дикого Сердца | - | S101-V20, fandom |
| Path of Honorable Accord | Путь Чести | "Путь Соглашения Чести" (fandom) | S101-V20 |
| Path of Lilith | Путь Лилит | - | S101-V20. Followers: "Бахари" |
| Path of Metamorphosis | Путь Преображения | "Путь Метаморфоз" (fandom) | S101-V20 |
| Path of Night | Путь Ночи | - | S101-V20 |
| Path of Paradox | Путь Парадокса | - | S101-V20 |
| Path of Power and the Inner Voice | Путь Власти и Внутреннего Голоса | - | S101-V20, fandom, wta5 |
| Path of Typhon | Путь Тифона | - | S101-V20, fandom |
| Path of Asakku | Путь Асакку | - | fandom |
| Path of Ecstasy | Путь Экстаза | - | fandom |
| Path of Entelechy | Путь Энтелехии | - | fandom |
| Path of Evil Revelations | Путь Откровений Зла | - | fandom |
| Path of Harmony | Путь Гармонии | - | fandom |
| Path of Redemption | Путь Искупления | - | fandom |
| Path of Self-Focus | Путь Внутреннего Фокуса | "Путь Самососредоточения" | fandom |
| Path of the Hive | Путь Улья | - | fandom |
| Path of the Scorched Heart | Путь Выжженного Сердца | - | fandom |
| Path of the Warrior | Путь Воина | - | fandom |
| Path of Heaven | Путь Небес | - | INFERRED |
| Path of the Lilin Witches | Путь Ведьм Лилин | - | INFERRED |
| Path of the Red Midwives | Путь Красных Повитух | - | INFERRED |
| Path of the Serpent's Seed | Путь Змеиного Семени | - | INFERRED |
| Path of the Thorn Garden | Путь Тернового Сада | - | INFERRED |
| Road of Kings | Дорога Королей | - | INFERRED from the fandom pattern for Dark Ages roads ("Дорога Ночи", "Дорога Метаморфоз" exist as pages); the exact page was not found |
| Road of Night | Дорога Ночи | - | fandom |
| Code of Samiel | Кодекс Самиэля | - | fandom |
| Sharia El-Sama | Шариа эль-Сама | - | fandom |
| Bearing (path aura) | Столп | - | S101-V20 character sheet |

## 6. Storyteller system terms

| English | Recommended Russian | Alternatives | Source / notes |
|---|---|---|---|
| Storyteller | рассказчик | "Мастер" | S101-V20 |
| Trait | параметр | "трайт" (wod.su) | S101-V20 |
| Attributes | характеристики | "атрибуты" (wta5, wod.su) | S101-V20 |
| Abilities | способности | - | S101-V20 |
| Talents / Skills / Knowledges | Таланты / Навыки / Знания | - | S101-V20 |
| Strength, Dexterity, Stamina | Сила, Ловкость, Выносливость | - | S101-V20 sheet |
| Charisma, Manipulation, Appearance | Обаяние, Манипуляция, Привлекательность | - | S101-V20 sheet |
| Perception, Intelligence, Wits | Восприятие, Интеллект, Смекалка | - | S101-V20 sheet |
| Alertness | Бдительность | - | S101-V20 sheet |
| Athletics | Атлетика | - | S101-V20 sheet |
| Awareness | Шестое чувство | - | S101-V20 sheet |
| Brawl | Драка | - | S101-V20 sheet |
| Empathy | Эмпатия | - | S101-V20 sheet |
| Expression | Красноречие | - | S101-V20 sheet |
| Intimidation | Запугивание | - | S101-V20 sheet |
| Leadership | Лидерство | - | S101-V20 sheet |
| Streetwise | Уличное чутьё | - | S101-V20 sheet |
| Subterfuge | Хитрость | - | S101-V20 sheet |
| Animal Ken | Обращение с животными | - | S101-V20 sheet |
| Crafts | Ремесло | - | S101-V20 sheet |
| Drive | Вождение | - | S101-V20 sheet |
| Etiquette | Этикет | - | S101-V20 sheet |
| Firearms | Стрельба | - | S101-V20 sheet |
| Larceny | Воровство | - | S101-V20 sheet |
| Melee | Фехтование | "Холодное оружие" | S101-V20 sheet |
| Performance | Исполнение | - | S101-V20 sheet |
| Stealth | Скрытность | - | S101-V20 sheet |
| Survival | Выживание | - | S101-V20 sheet |
| Academics | Гуманитарные науки | - | S101-V20 sheet |
| Computer | Информатика | - | S101-V20 sheet |
| Finance | Финансы | - | S101-V20 sheet |
| Investigation | Расследование | - | S101-V20 sheet |
| Law | Юриспруденция | - | S101-V20 sheet |
| Medicine | Медицина | - | S101-V20 sheet |
| Occult | Оккультизм | - | S101-V20 sheet |
| Politics | Политика | - | S101-V20 sheet |
| Science | Естественные науки | - | S101-V20 sheet |
| Technology | Электроника | - | S101-V20 sheet |
| Virtues | добродетели | - | S101-V20 |
| Conscience / Conviction | Совесть / Решимость | "Убеждённость" | S101-V20 sheet: "Совесть / решимость" |
| Self-Control / Instinct | Самоконтроль / Инстинкты | - | S101-V20 sheet |
| Courage | Смелость | - | S101-V20 sheet |
| Willpower | Воля | "Сила Воли" (wod.su; fandom redirects it to "Воля") | S101-V20, V5-fan. Points: "пункт воли", pool: "запас воли" |
| Permanent / Temporary Willpower | постоянная Воля / запас воли | - | S101-V20 wording |
| Blood pool | запас крови | "пул крови", "бладпул" | S101-V20 |
| Blood point | пункт крови | - | S101-V20 (375 hits) |
| Backgrounds | факты биографии | "дополнения" | S101-V20 |
| Merit / Flaw | достоинство / недостаток | "преимущество" | S101-V20 |
| Freebie points | свободные пункты | - | S101-V20 |
| Attribute / Ability / Virtue points | пункты характеристик / способностей / добродетелей | - | S101-V20 |
| Nature / Demeanor | натура / маска | - | S101-V20 |
| Dice pool | пул проверки | - | S101-V20 |
| Roll | проверка | "бросок" | S101-V20 |
| Difficulty | сложность | - | S101-V20 |
| Success | успех | - | S101-V20 |
| Failure | неудача | - | S101-V20 |
| Botch | провал | - | S101-V20 usage ("в случае провала"). I matched this from context, not from a definition line |
| Bashing damage | лёгкие повреждения | - | S101-V20 |
| Lethal damage | тяжёлые повреждения | - | S101-V20 |
| Aggravated damage | губительные повреждения | "аггравированный урон" (wta5), "аггравированные" | S101-V20. See contested list |
| Soak (unsoakable) | поглощение (S101: "неотвратимое" повреждение) | - | S101-V20 for "неотвратимое" |
| Health levels | Помят, Легко ранен, Ранен, Серьёзно ранен, Тяжело ранен, Совсем плох, Небоеспособен | - | S101-V20 sheet (Bruised ... Incapacitated) |
| Derangement | психическое расстройство | "психоз" (wod.su) | S101-V20 |
| Experience | опыт, пункты опыта | - | S101-V20 |
| Status | Статус | - | S101-V20 |
| Retainers / Allies / Contacts / Resources / Fame / Mentor / Influence | Подручные / Союзники / Информаторы / Богатство / Слава / Ментор / Влияние | - | S101-V20 |

## 7. Merits and flaws used in the repo

| English | Recommended Russian | Source / notes |
|---|---|---|
| Acute Sense | Чуткое восприятие | S101-V20 |
| Ambidextrous | Амбидекстр | S101-V20 |
| Eat Food | Железное нутро | S101-V20 (description matches: can eat human food) |
| Cast-Iron Stomach | Лужёный желудок | INFERRED. Do not reuse "Железное нутро", S101 uses that for Eat Food |
| Blush of Health | Здоровый вид | S101-V20 |
| Enchanting Voice | Чарующий голос | S101-V20 |
| Efficient Digestion | Эффективное пищеварение | S101-V20 |
| Huge Size | Гигант | S101-V20 |
| Short | Коротышка | S101-V20 |
| Coldly Logical | Холодная логика | S101-V20 |
| Time Sense | Чувство времени | S101-V20 |
| Iron Will | Железная воля | S101-V20 |
| Deceptive Aura | Обманчивая аура | S101-V20 |
| Smell of the Grave | Могильный запах | S101-V20 |
| Bad Sight | Плохое зрение | S101-V20 |
| Disfigured | Уродство | S101-V20 |
| Dulled Bite | Тупые клыки | S101-V20 |
| Glowing Eyes | Светящиеся глаза | S101-V20 |
| Permanent Fangs | Торчащие клыки | S101-V20 |
| Lame | Хромота | S101-V20 |
| Monstrous | Чудовищная внешность | S101-V20 |
| Deaf / Blind | Глухота / Слепота | S101-V20 |
| Speech Impediment | Дефект речи | S101-V20 |
| Amnesia | Амнезия | S101-V20 |
| Vengeful | Мстительность | S101-V20 |
| Territorial | Территориальность | S101-V20 |
| Cast No Reflection | Отсутствие отражения | S101-V20 |
| Beacon of the Unholy | Светоч тьмы | S101-V20 |
| Light-Sensitive | Светобоязнь | S101-V20 |
| Victim of the Masquerade | Жертва Маскарада | S101-V20 |
| Sterile Vitae | Бесплодная витэ | S101-V20 (flaw "Infertile Vitae") |
| Thin Blood ("Thick blood" in repo is a different thing) | Слабая кровь | S101-V20 |
| Organovore | Людоед | S101-V20, probable match (4-point flaw about needing flesh). Check the book |
| Permanent Wound | Незаживающая рана | INFERRED. S101 has "Увечье" (Deformity) and "Мёртвая плоть" (Flesh of the Corpse), neither is this flaw |
| Calm Heart | Спокойное сердце | INFERRED |
| Berserker | Берсерк | INFERRED |
| Unbondable | Невосприимчивость к узам крови | INFERRED |
| Hidden Diablerie | Скрытое диаблери | INFERRED |
| Pale Aura | Бледная аура | INFERRED |
| Stillness of Death | Неподвижность смерти | INFERRED |
| Pain Tolerance | Устойчивость к боли | INFERRED |
| Prey Exclusion | Запретная добыча | INFERRED |
| Weak-Willed | Слабоволие | INFERRED |
| Hemophiliac | Гемофилия | INFERRED |
| Thaumaturgically Inept | Неспособность к Тауматургии | INFERRED |
| Mage Blood | Кровь мага | INFERRED |
| Methuselah's Thirst | Жажда мафусаила | INFERRED |
| Betrayer's Mark | Клеймо предателя | INFERRED |
| Permanent Third Eye | Неисчезающий третий глаз | INFERRED |
| Uncontrollable / Untamable | Неуправляемый / Неукротимый | INFERRED |
| Metamorph, Fair Glabro, Wolf Sight, Touch of the Wyld, Pierced Veil, Banned Transformation, Animal Musk | Метаморф, Благообразный глабро, Волчье зрение, Касание Вильда, Прорванная Вуаль, Запретное превращение, Звериный мускус | INFERRED (werewolf merits and flaws, no Russian source found) |

## 8. Sabbat rites

| English | Recommended Russian | Alternatives | Source / notes |
|---|---|---|---|
| Rite / ritae | обряд | "ритуал" (S101 keeps "ритуал" for Thaumaturgy and Necromancy only) | S101-V20 |
| Auctoritas ritae | священные обряды | "аукторитас ритэ" | S101-V20 |
| The Vaulderie | обряд Братания | "Ваулдери", "Вольдери" (colloquial, no written source found) | S101-V20. See contested list |
| Vinculum | братские узы | "винкулум" | S101-V20 |
| Vaulderie Goblet | чаша Братания | - | INFERRED from S101 wording ("смешивают свою кровь в большой чаше") |
| Monomacy | Мономахия | - | S101-V20, fandom |
| Wild Hunt | Дикая охота | - | S101-V20, fandom |
| Blood Feast | Кровавый пир | - | S101-V20 |
| Blood Bath | Кровавая купель | - | S101-V20 |
| War Party | Боевой поход | - | S101-V20 |
| Creation Rites | Обряд Возведения | - | S101-V20 (the passage is about shovelhead Embraces, so the match is solid) |
| Fire Dance | Огненная пляска | - | S101-V20 |
| Pack Credo, Sabbat Priest's Tome, War Party Totem | Кредо стаи, Книга духовника, Тотем боевого похода | - | INFERRED |

## 9. Werewolf: The Apocalypse

No official Russian edition found, so "recommended" here means the dominant fan tradition (wod.su WtA Revised translation, mirrored by fandom), with W5-era wta5 variants listed.

| English | Recommended Russian | Alternatives in use | Source / notes |
|---|---|---|---|
| Garou | гару | - | wod.su, fandom, wta5, ruwiki. Indeclinable, same in plural. wod.su capitalizes ("Гару"), wta5 mostly lowercases |
| Werewolf | оборотень | "Люпен" (vampire word, S101-V20) | all |
| Fera / Changing Breeds | Фера / меняющие форму | "перевёртыши" | wod.su, fandom. Indeclinable |
| Corax | коракс, мн. кораксы | - | fandom ("Кораксы"). Declines |
| Kinfolk | Родня (collective), родич (one person) | "Кинфолк" (colloquial) | wod.su, fandom, dtf |
| Gaia | Гея | "Гайя" (wta5, ruwiki, dtf mentions both) | wod.su, fandom. See contested list |
| Triat | Триада | "Триат" (wta5) | wod.su, fandom, dtf |
| Wyrm | Вирм | "Змей" (dtf, fandom redirect, wod.su occasionally) | all sources. Masc., declines: Вирма, Вирму |
| Weaver | Ткачиха | "Ткач" (wta5), "Вивер" (ruwiki, dtf) | wod.su, fandom, dtf |
| Wyld | Вильд | "Вайлд" (wta5), "Буян" (seen only in a search snippet, unverified) | wod.su, fandom, dtf. Masc., declines |
| Rage | Ярость | - | wod.su, fandom, wta5, dtf |
| Gnosis | Гнозис | "Гносис" (wod.su, fandom) | S101-V20 spells it "Гнозис" in its Lupine rules, which is also the normal Russian word |
| Frenzy (Garou) | бешенство | "Ярость" would collide with Rage | wta5 |
| Renown | Известность | "Принципы" (wta5), "Реноме" | wod.su |
| Glory / Honor / Wisdom | Слава / Честь / Мудрость | - | wod.su, wta5 |
| Rank | ранг | - | wod.su |
| Cliath / Fostern / Adren / Athro / Elder | клиат / фостерн / адрен / атро / старейшина | - | wod.su, fandom |
| Cub | щенок | - | wod.su text |
| Tribe | племя | - | all |
| Auspice | покровительство | "судьба" (wta5 heading), "аусписий/ауспиция" (no source found) | wod.su, fandom; wta5 also uses "покровительство" in running text |
| Ahroun | Арун | "Ахрун" (wta5) | wod.su, fandom, dtf |
| Galliard | Галлиард | - | all |
| Philodox | Филодокс | - | all |
| Ragabash | Рагабаш | - | all |
| Theurge | Теург | - | all |
| Stolen Moon (repo AUSPICE_NONE) | Украденная Луна | - | INFERRED |
| Breed | порода | - | wod.su, fandom |
| Homid | хомид | - | all. Declines |
| Metis | метис | - | wod.su, fandom |
| Lupus | люпус | - | all. Declines |
| Corvid (Corax breed) | корвид | - | INFERRED |
| Forms: Homid, Glabro, Crinos, Hispo, Lupus | Хомид, Глабро, Кринос, Хиспо, Люпус | - | wod.su, fandom, wta5. Глабро and Хиспо are indeclinable; "в форме Кринос" is the usual construction |
| war form / dire form / feral form / bestial form (repo) | боевая форма / форма лютого волка / звериная форма | - | INFERRED, descriptive |
| Black Furies | Чёрные Фурии | - | wod.su, fandom, wta5 |
| Bone Gnawers | Грызущие Кости | "Костеглодатели" (wta5), "Костегрызы" | wod.su, fandom, dtf |
| Children of Gaia | Дети Геи | "Дети Гайи" (wta5) | wod.su, fandom |
| Fianna | Фианна | - | all. Indeclinable |
| Get of Fenris | Потомство Фенрира | "Потомки Фенриса" | wod.su, fandom, dtf |
| Glass Walkers | Ходящие по Стеклу | "Стеклоходы" (dtf), "Стеклоходцы" (wta5) | wod.su, fandom |
| Red Talons | Красные Когти | - | all |
| Shadow Lords | Теневые Владыки | "Владыки Теней" (wta5) | wod.su, fandom, dtf |
| Silent Striders | Безмолвные Странники | "Молчаливые Странники" (wod.su once) | wod.su, fandom, wta5 |
| Silver Fangs | Серебряные Клыки | - | all |
| Stargazers | Звездочёты | - | wod.su, fandom, dtf |
| Uktena | Уктена | - | wod.su, fandom. Indeclinable |
| Wendigo | Вендиго | - | wod.su, fandom |
| Galestalkers | Охотники Бури | - | wta5 (W5 name) |
| Black Spiral Dancers | Танцоры Чёрной Спирали | - | wod.su, fandom, dtf, ruwiki |
| Ronin | ронин | - | wod.su, fandom |
| Garou Nation | Нация Гару | - | fandom, wta5 |
| Pack | стая | - | all |
| Sept | септ | "септа" | wod.su, fandom, wta5. Masc.: "в септе", "септы" |
| Caern | каэрн | - | all. Masc., declines |
| Bawn | бон | "Укрепление" (wod.su lexicon) | "Укрепление" is wod.su, fandom; "бон" is INFERRED as a transliteration option. Area names: "Бон Детей Геи" |
| Moot | вече | "мут" (wta5) | wod.su, fandom |
| Litany | Литания | "Наставление" (wod.su once) | wod.su, fandom, wta5 |
| Umbra | Умбра | "Тень" | all. Decline as feminine ("в Умбре"); wod.su sometimes leaves it uninflected |
| Penumbra | Пенумбра | - | wod.su, fandom |
| umbral tether (repo) | умбральная привязь | - | INFERRED |
| Gauntlet | Барьер | "Пелена" (no source found) | wod.su, fandom, wta5 |
| Veil | Вуаль | "Завеса" (wod.su chapter text, wta5) | wod.su lexicon, fandom. "Завеса" is already the Shroud in S101-V20, so "Вуаль" avoids a clash. See contested list |
| Delirium | Делириум | "Делирий" (wod.su chapter heading) | wod.su lexicon, fandom, wta5 |
| Step sideways | шаг-в-сторону | - | wod.su, fandom |
| Gifts | Дары | - | all |
| Rites | обряды | "ритуалы" | wod.su, wta5 |
| Rite of Passage | Обряд Перехода | - | wod.su, fandom |
| Totem | тотем | - | all |
| Fetish | фетиш | - | wod.su, fandom |
| Klaive | клайв | "клейв" (wta5) | wod.su, fandom |
| Bane | Бейн, мн. Бейны | "Бэйн" (ruwiki, wod.su mixed) | wod.su lexicon, fandom |
| Fomori | фомори | "фоморы" (dtf) | wod.su, fandom, ruwiki. Indeclinable |
| Wyrm taint / Wyrm Corruption | порча Вирма | "зараза Вирма" (fandom) | INFERRED for "порча"; fandom has "Иерархия заразы Вирма" |
| Harano | Харано | - | wod.su, wta5 |
| Apocalypse | Апокалипсис | - | all |
| First Change | Первое Превращение | - | wta5 |
| Garou Tongue / Primal Tongue | язык гару / первобытный язык | "Высокая Речь" | INFERRED |
| glyph | глиф | - | fandom ("Глиф Фомори") |
| Sept jobs: Councillor, Sept Keeper, Guardian, Warder, Truthcatcher, Wyrmfoe | Советник, Хранитель септа, Защитник, Страж, Ловец Истины, Враг Вирма | - | INFERRED, except "Страж", which appears in the wod.su WtA text as a caern office |
| Gift names in the repo (Razor Claws, Mother's Touch, Sense Wyrm, Beast Speech, Spirit Speech, Resist Pain, Open Seal, Blur of the Milky Eye, Truth of Gaia, Visage of Fenris etc.) | not researched | - | wod.su has full gift lists but the site was down; I did not pull them from the archive |

## 10. Grammar cheat sheet for in-game text

- Indeclinable clan names (same in all cases and in plural): Бруха, Вентру, Носферату, Ласомбра, Джованни, Равнос, Салюбри, Самеди, Баали, Бану Хаким, антитрибу
- Declining member nouns: тореадор(ы), тремер(ы), гангрел(ы), цимисх(и), малкавианин / малкавиане, каитиф(ы), ассамит(ы), сетит(ы), киасид(ы), каппадокиец / каппадокийцы, горгулья / горгульи (fem.)
- S101 capitalization: clan as an institution is capitalized ("клан Тремер", "Гангрелы"), an individual member is lowercase ("один тремер", "двое бруха"). Titles are capitalized: Принц, Шериф, Примоген, Гарпия
- "Витэ" and "диаблери" never decline. "Витэ" is feminine in S101, "диаблери" neuter
- "Торпор", "Ротшрек", "Элизиум", "Шабаш", "каэрн", "септ", "Вирм", "Вильд" are masculine and decline normally. "Камарилья", "котерия", "Умбра", "Геенна" are feminine
- "Гару", "Фера", "фомори", "Фианна", "Уктена", "Вендиго", "Глабро", "Хиспо" do not decline
- "Старейшина" takes masculine agreement but first-declension endings
- "Дитя" has the irregular plural "потомки" in S101

## 11. Contested terms and the adopted variant

1. Frenzy. S101-V20: "ярость / приступ ярости". Community and V5-era: "Безумие". Colloquial: "френзи". Adopted: "Безумие" for vampires and "бешенство" for Garou frenzy, because this build also has Garou Rage, which is "Ярость" in every werewolf source. Downside: "безумие" also appears in Malkavian and Dementation flavor text
2. Antediluvians. S101-V20: "предтечи" (also "допотопные старцы"). wod.su, V5-fan, dtf: "Патриархи". fandom, wta5: "Допотопные". Adopted: "Патриархи", the form dtf calls the usual one; pick "Предтечи" if strict S101 fidelity matters more than recognition
3. Discipline names. S101 set (Ясновидение, Сокрытие, Затмение, Мощь, Величие, Метаморфозы, Преображение, Упокоение, Мистификация, Демонион, Обеа) versus the wod.su/fandom set (Прорицание, Затемнение, Власть над Тенью, Могущество, Присутствие, Превращение, Изменчивость, Смертоносность, Мистерия, Демонизм, Обеах). Adopted: S101 set as a whole, it is official for both V20 and V5. Do not mix the two
4. Prince. "Принц" (S101-V20, wta5, dtf) versus "Князь" (wod.su, fandom). Adopted: "Принц"
5. Scourge and Hound. "Палач" and "Пёс" (S101-V20) versus "Бич" (fandom) and "гончая" (unsourced). Adopted: S101
6. Sect. "фракция" (S101-V20) versus "секта" (wod.su, fandom, wta5). Adopted: "секта", it is what every other source and the V5-era reference use, and "фракция" is needed for generic game factions
7. Aggravated damage. "губительные повреждения" (S101-V20) versus "аггравированный урон" (wta5, common table slang). Adopted: "губительные", with bashing "лёгкие" and lethal "тяжёлые"
8. Sabbat terms. "обряд Братания / братские узы / вожак стаи / духовник" (S101-V20) versus transliterations "Ваулдери / Винкулум / Дуктус" (fandom has "Дуктусы Шабаша"). Adopted: S101 for rites, but consider "Дуктус" for the job title since "вожак" also fits Garou packs
9. Embrace. "Становление" (S101-V20, wod.su, wta5, dtf) versus "Объятия" (fandom). Adopted: "Становление"
10. Tzimisce. "Цимисхи" (S101-V20, fandom, wta5) versus "Тзимицу/Тзимици" (dtf, older game-fan usage). Adopted: "Цимисхи"
11. Sabbat. "Шабаш" in every written source; "Саббат" only as slang. Adopted: "Шабаш"
12. Caitiff spelling. "каитиф" (S101-V20, wta5) versus "каитифф" (wod.su, fandom). Adopted: "каитиф"
13. Banu Haqim versus Assamites. The repo uses the V5 name; S101-V20 only has "Ассамиты". Adopted: "Бану Хаким" to mirror the repo, with "ассамит" kept in the breach-word list
14. Willpower. "Воля" (S101-V20) versus "Сила Воли" (wod.su). Adopted: "Воля"
15. Jyhad. "Извечная Борьба" (S101-V20) versus "Джихад" (wod.su, fandom). Adopted: S101
16. Werewolf naming set. wod.su/fandom tradition (Гея, Вильд, Ткачиха, Арун, Грызущие Кости, Ходящие по Стеклу, Теневые Владыки, Потомство Фенрира, вече, клайв) versus wta5 W5 tradition (Гайя, Вайлд, Ткач, Ахрун, Костеглодатели, Стеклоходцы, Владыки Теней, мут, клейв). Adopted: wod.su/fandom set, it matches the W20-era content of this build
17. Veil. "Вуаль" (wod.su lexicon, fandom) versus "Завеса" (wod.su text, wta5). Adopted: "Вуаль", because S101-V20 already uses "Завеса" for the wraith Shroud
18. Gnosis. "Гнозис" (S101-V20) versus "Гносис" (wod.su, fandom). Adopted: "Гнозис"
19. Lupines. "Люпены" (S101-V20) versus "люпины" (fandom, V5-fan). Adopted: "Люпены"

## 12. Not verified

- Studio 101 V5 book text itself. V5 terms come from wta5 (fan reference) and shop blurbs. In particular the official V5 word for Frenzy is unconfirmed: mirf's summary suggested "Ярость", wta5 uses "Безумие"
- Russian localizations of Bloodlines and Bloodlines 2: no usable term list found. The only data point is dtf writing "принц ЛаКруа" and "Тзимици"
- Any official Russian edition of Werewolf (W20/W5): none found
- "Саббат", "френзи", "гончая", "Ваулдери", "священник стаи", "Кнут": widely repeated by players as far as I know, but I found no page to cite
- Seneschal is absent from the S101-V20 text I searched; "Сенешаль" comes from fandom
- Tlacique, Warrior Salubri, Warrior Setite, the five non-core Paths in section 5, most merits and flaws marked INFERRED, all build-specific job titles, all Garou gift names
- Power-name pairing in section 4 was done by level order from a text dump; Presence 3/4 and a few bloodline powers deserve a check against the printed book

## 13. Terms settled during translation of the vampire modules

None of these were found in a source; they follow the same tradition as the rest and are binding for consistency

| English | Russian | Notes |
|---|---|---|
| Fledgling / Neonate / Ancilla / Elder (discipline tiers) | Птенец / Неонат / Анцилла / Старейшина | |
| Clan weakness (label) | Изъян, клановый изъян | |
| Roleplay level: Beginner Friendly / Intermediate / Advanced | Для новичков / Средний / Высокий | |
| Rebels, Ferals, Lunatics, Divas, Sewer Rats, Fiends | Бунтари, Дикари, Безумцы, Дивы, Канализационные Крысы, Изверги | clan nicknames |
| Corpse Walkers, Flesh-Eaters, Furies | Ходячие Мертвецы, Пожиратели плоти, Фурии | |
| Madness Network | Сеть Безумия | |
| Great Prank | Великая Шутка | |
| Pyramid (Tremere) | Пирамида | |
| House Carna | Дом Карны | |
| Clans of Death | Кланы Смерти | |
| Feast of Folly | Пир Глупцов | |
| Final Nights | Последние Ночи | |
| Dark Father / Dark Mother | Тёмный Отец / Тёмная Мать | |
| True Black Hand | Истинная Чёрная Рука | |
| Anarch Free State | Свободное государство анархов | |
| Ashirra, Bahari, Lilins | Аширра, Бахари, Лилин | indeclinable |
| Noddists, Albigensians, Infernalists | ноддисты, альбигойцы, инферналисты | |
| Path followers: Unifiers, the Faithful, Scions, the Unforgiving, Corruptors, Gravediggers, Redeemers | Объединители, Верные, Наследники, Непрощающие, Растлители, Могильщики, Искупители | |
| Saulot, Troile, Ur-Shulgi | Саулот, Троиль, Ур-Шульги | |
| home soil | родная земля | |
| minor undead | малая нежить | |
| the Kiss | Поцелуй | |
| Masquerade breach / restored | Нарушение Маскарада / Маскарад восстановлен | |
| Veil breach / restored | Нарушение Вуали / Вуаль восстановлена | |
| lick | упырь | |
| Shadowlands, Drones, plasm, Passion (wraith) | Земли Теней, Трутни, плазма, Страсть | |
| Zulo form | Зуло, боевой облик Зуло | |
| Abomination (Tzimisce construct) | отродье | |
| Bloodheal tiers | Малое, Быстрое, Сильное, Большое, Великое, Божественное, Непревзойдённое, Высшее исцеление кровью | |
| Shroudsight | Взгляд за Завесу | check against the S101 book |
| Ethereal Horde / Shambling Horde | Призрачная орда / Гнилая орда | |
| Ashes to Ashes | Пепел к пеплу | |
| Cold of the Grave | Могильный холод | |
| Darkling Trickery / Goblinism | Тёмные проделки / Гоблинство | |
| Autonomic Mastery | Власть над телом | |
| Path of the Levinbolt: Spark, Illuminate, Power Array, Zeus' Fury, Eye of the Storm | Искра, Озарение, Силовой разряд, Ярость Зевса, Око бури | |
| Path of Pain: Numbing, Anguish, Shattering, Agony Within, Hundred Deaths | Онемение, Мука, Сокрушение, Внутренняя агония, Сотня смертей | |
| Fires of Inferno: Lighter, Stovetop, Blowtorch, Flame-thrower, Conflagration | Зажигалка, Конфорка, Паяльная лампа, Огнемёт, Пожарище | "Всесожжение" is reserved for Daimonion 3 |
| Garou ranks | щенок, клиат, фостерн, адрен, атро, старейшина, легенда | |
| Corax ranks | птенец, овикулум, неокорникс, алес, волукрис, корвус, серый кардинал | transliterated, no source |
| Lure of Flames 1-5 | Свеча, Факел, Костёр, Пожар, Пекло | S101 set; repo levels 2 and 4 are approximate matches |

To verify against the printed book: Presence 4 Summon ("Приглашение" reads oddly, "Призыв" is the natural word), Scry the Hearthstone ("Страж очага" does not match the effect), Shepherd's Watch ("Око пастыря", the power is a protective barrier)

## 14. Terms settled during translation of jobs, merits, rituals and the werewolf module

Translated by meaning unless a source is named; none of the gift, ritual or merit names were checked against a printed book

### Jobs and factions

| English | Russian | Notes |
|---|---|---|
| Sweeper | Дозорный | replaces the draft "Чистильщик", which reads as a hitman |
| Bruiser / Tapster / Emissary | Громила / Трактирщик / Эмиссар | |
| I Nonni / La Squadra / La Famiglia | И Нонни / Ла Скуадра / Ла Фамилья | titles keep the Italian form, "Семья" is for the Family itself |
| Sabbat Ductus / Priest / Pack | Дуктус Шабаша / Духовник Шабаша / Член стаи Шабаша | |
| Chantry Regent / Archivist / Gargoyle | Регент / Архивариус / Горгулья капеллы | |
| Dealer / Supply Technician | Делец / Кладовщик | |
| Truthcatcher / Warder / Wyrmfoe / Guardian / Sept Keeper | Ловец Истины / Страж / Враг Вирма / Защитник / Хранитель септа | |
| Mountain Master / Red Pole / Blue Lanterns | Хозяин Горы / Красный Шест / Синий Фонарь | |
| Abbe / Condottieri / Novice | Аббат / Кондотьер / Послушник | Society of Leopold |
| Millennium Tower | Башня Миллениум | |
| Sept of the Western Eye | септ Западного Ока | |
| Endron International | Эндрон Интернейшнл | |
| Court of Blood | Суд Крови | |
| shovelhead method | "метод лопаты" | the rite itself is Обряд Возведения |
| Sabbatist (antag) | Шабашит | |

### System

| English | Russian |
|---|---|
| dot | точка |
| automatic success | автоматический успех |
| dice pool | пул проверки |
| Permanent / Temporary Willpower | Постоянная Воля / Запас воли |
| Talents / Skills / Knowledges | Таланты / Навыки / Знания |
| Streetwise / Subterfuge / Awareness | Уличное чутьё / Хитрость / Шестое чувство |
| Wits / Appearance | Смекалка / Привлекательность |
| freebie points | свободные пункты |
| research points | очки исследований |
| breed form | родная форма |

Merit and flaw names are listed next to each quirk as `ru_name`; changed from the drafts in section 7: Permanent Third Eye = Незакрывающийся третий глаз, Stillness of Death = Мёртвая неподвижность

### Rituals and occult

| English | Russian | Notes |
|---|---|---|
| spellbook, tome | гримуар | |
| ward | охранный знак | |
| Blood Walk | Хождение по крови | not "Путь крови", that is the Path of Blood |
| Blackout | Гашение огней | not "Затемнение" |
| Pierce the Veil | Пронзая пелену | "Завеса" and "Вуаль" are reserved |
| Deflection of the Wooden Doom | Отвращение деревянной погибели | |
| Donning the Mask of Shadows | Облачение в маску теней | |
| Call the Hungry Dead | Зов голодных мертвецов | |
| Chill of Oblivion | Холод забвения | |
| Skinlands | Земли Плоти | |
| obolus | обол | |
| Inner Council (Tremere) | Внутренний Совет | |
| Odious Chalice, Weekapaug Thistle, Galdjum, Tarulfang | гнусная чаша, викапогский чертополох, галдьюм, тарулфанг | Bloodlines items, Russian game localization not checked |

### Werewolf

| English | Russian | Notes |
|---|---|---|
| auspice moons | Новолуние, Лунный Серп, Полулуние, Горбатая Луна, Полнолуние | |
| dire form | форма лютого зверя | "зверя" because Corax share the species |
| bestial form | полузвериная форма | |
| Triatic Wyrm | Триединый Вирм: Вирм-Осквернитель, Зверь Войны, Пожиратель Душ | |
| Hive / Malfeas | Улей / Малфеас | |
| Impergium / War of Rage | Импергиум / Война Ярости | |
| Ratkin, Bastet, Gurahl, Rokea, Ananasi, Nagah | Раткин, Бастет, Гурал, Рокеа, Ананаси, Нага | indeclinable |
| Garou Tongue syllables | transliterated to Cyrillic | as the base does for Draconic |
| Honor / Glory / Wisdom | Честь / Слава / Мудрость | |
| Gifts | see `name` on each gift datum | all drafts, to verify against the wod.su gift lists |
