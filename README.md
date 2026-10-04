## Сборка The Second City

[![resentment](.github/images/badges/built-with-resentment.svg)](.github/images/comics/131-bug-free.png) [![technical debt](.github/images/badges/contains-technical-debt.svg)](.github/images/comics/106-tech-debt-modified.png) [![forinfinityandbyond](.github/images/badges/made-in-byond.gif)](https://www.reddit.com/r/SS13/comments/5oplxp/what_is_the_main_problem_with_byond_as_an_engine/dclbu1a)

| Ресурс                  | Ссылка                                   |
| ----------------------- | -----------------------------------------|
| Код                     | https://github.com/DarkPack13/SecondCity |
| Discord The Second City | https://discord.gg/rmAbJcuChD            |
| Discord Coderbus        | https://discord.gg/Vh8TJp9               |
| С чего начать разработку | https://hackmd.io/@tgstation/HJ8OdjNBc#tgstation-Development-Guide |

Это сборка проекта Darkpack13, форка TGstation 2025. Она служит апстримом для The Final Nights, Apocrypha, Requiem и World of Darkness 13.

В основе лежат игровые линейки World of Darkness(c) от Paradox Interactive. Что именно попадает в игру, решает администрация проекта.

## Загрузка

[Загрузка](.github/guides/DOWNLOADING.md)

[Запуск сервера](.github/guides/RUNNING_A_SERVER.md)

## Компиляция

**Быстрый способ**. Найдите `bin/server.cmd` в этой папке и дважды щёлкните по нему: сервер соберётся и запустится на порту 1337.

**Долгий способ**. Найдите `bin/build.cmd` в этой папке и дважды щёлкните по нему, чтобы начать сборку. Она состоит из нескольких шагов и занимает около 1-5 минут. Если окно закрылось, значит, сборка завершена. После этого можно [настроить сервер](.github/guides/RUNNING_A_SERVER.md) как обычно, открыв `tgstation.dmb` в DreamDaemon.

**Сборка tgstation напрямую в DreamMaker устарела и может приводить к ошибкам**, например `'tgui.bundle.js': cannot find file`.

**[Как компилировать в VSCode и другие варианты сборки](tools/build/README.md).**

## Лицензия

Весь код после [коммита 333c566b88108de218d882840e61928a9b759d8f от 31.12.2014, 16:38 PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) распространяется по лицензии [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.html).

Весь код до [коммита 333c566b88108de218d882840e61928a9b759d8f от 31.12.2014, 16:38 PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) распространяется по лицензии [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Включая инструменты, если в их readme не указано иное.)

Подробности в файлах LICENSE и GPLv3.txt.

TGS DMAPI лицензирован как подпроект по лицензии MIT.

Текст лицензии MIT приведён в конце файла [code/\_\_DEFINES/tgs.dm](./code/__DEFINES/tgs.dm) и в [code/modules/tgs/LICENSE](./code/modules/tgs/LICENSE).

Все ассеты, включая иконки и звуки, распространяются по лицензии [Creative Commons 3.0 BY-SA](https://creativecommons.org/licenses/by-sa/3.0/), если не указано иное.

Darkpack13 is not official World of Darkness material. Portions of the materials are the copyrights and trademarks of Paradox Interactive AB, and are used with permission. All rights reserved. For more information please visit worldofdarkness.com.

Darkpack13 не является официальным материалом World of Darkness. Часть материалов защищена авторскими правами и товарными знаками Paradox Interactive AB и используется с разрешения. Все права защищены. Подробнее на worldofdarkness.com

![darkpack_logo2](https://github.com/user-attachments/assets/643ce14e-066c-4c81-998f-2e7881f0518d)
