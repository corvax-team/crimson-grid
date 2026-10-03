// THIS IS AN CRIMSON UI FILE
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
} from 'tgui-core/components';
import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

enum CkeyPollEnum {
  PLEXORA_DOWN = -1,
  PLEXORA_CKEYPOLL_FAILED = 0,
  PLEXORA_CKEYPOLL_NOTLINKED,
  PLEXORA_CKEYPOLL_RECORDNOTVALID,
  PLEXORA_CKEYPOLL_LINKED,
  PLEXORA_CKEYPOLL_LINKED_ABSENT,
  PLEXORA_CKEYPOLL_LINKED_BANNED,
  PLEXORA_CKEYPOLL_LINKED_DELETED,
}
interface DiscordVerificationData {
  verification_code: string;
  discord_invite: string;
  discord_details: {
    status: CkeyPollEnum;
    id?: string;
    username?: string;
    displayname?: string;
  };
}

export const DiscordVerification = (props) => {
  const { data } = useBackend<DiscordVerificationData>();
  const { verification_code, discord_invite } = data;

  const getNoticeBox = () => {
    if (typeof data?.discord_details?.status !== 'number') {
      return (
        <NoticeBox danger>
          {`Сервис Plexora недоступен, либо окно не получило данные о статусе.`}
        </NoticeBox>
      );
    }

    const formatDiscordDetails = (
      details: DiscordVerificationData['discord_details'],
    ) => {
      if (details?.username && details?.displayname) {
        return `${details.username} (${details.displayname}) - ID: ${details.id}`;
      } else if (details?.username) {
        return `${details.username} (${details.displayname}) - ID: ${details.id}`;
      } else {
        return `ID в Discord: ${details.id}`;
      }
    };

    switch (data?.discord_details?.status) {
      case CkeyPollEnum.PLEXORA_DOWN:
        return (
          <NoticeBox danger>
            {`Сервис Plexora сейчас недоступен, получить данные о привязке не удалось.`}
          </NoticeBox>
        );
      case CkeyPollEnum.PLEXORA_CKEYPOLL_FAILED:
        return (
          <NoticeBox danger>
            Plexora не смогла получить данные.{' '}
            {formatDiscordDetails(data.discord_details)}
          </NoticeBox>
        );
      case CkeyPollEnum.PLEXORA_CKEYPOLL_NOTLINKED:
        return (
          <NoticeBox>Ваш ckey не привязан к аккаунту Discord.</NoticeBox>
        );
      case CkeyPollEnum.PLEXORA_CKEYPOLL_RECORDNOTVALID:
        return <NoticeBox>Запись о привязке ckey недействительна.</NoticeBox>;
      case CkeyPollEnum.PLEXORA_CKEYPOLL_LINKED:
        return (
          <NoticeBox success>
            Ваш ckey привязан к аккаунту Discord:{' '}
            {formatDiscordDetails(data.discord_details)}
          </NoticeBox>
        );
      case CkeyPollEnum.PLEXORA_CKEYPOLL_LINKED_ABSENT:
        return (
          <NoticeBox>
            Привязанного аккаунта Discord больше нет на сервере:{' '}
            {formatDiscordDetails(data.discord_details)}
          </NoticeBox>
        );
      case CkeyPollEnum.PLEXORA_CKEYPOLL_LINKED_BANNED:
        return (
          <NoticeBox danger>
            Привязанный аккаунт Discord забанен:{' '}
            {formatDiscordDetails(data.discord_details)}
          </NoticeBox>
        );
      case CkeyPollEnum.PLEXORA_CKEYPOLL_LINKED_DELETED:
        return (
          <NoticeBox danger>
            Привязанный аккаунт Discord числится удалённым:{' '}
            {formatDiscordDetails(data.discord_details)}
          </NoticeBox>
        );
      default:
        return (
          <NoticeBox>
            Неизвестный статус. Данные Discord:{' '}
            {formatDiscordDetails(data.discord_details)}
          </NoticeBox>
        );
    }
  };
  return (
    <Window title="Привязка Discord" width={700} height={800}>
      <Window.Content scrollable>
        {getNoticeBox()}
        <Section title="Ваш код подтверждения">
          <Box>
            <Button
              icon="copy"
              onClick={() => navigator.clipboard.writeText(verification_code)}
            >
              Скопировать в буфер обмена
            </Button>
          </Box>
          <Box
            mt={1}
            p={1}
            style={{
              wordBreak: 'break-word',
              background: '#444',
              padding: '5px',
            }}
          >
            {verification_code}
          </Box>
        </Section>
        <Section title="Зайдите на сервер Discord">
          <Button
            icon="paperclip"
            as="a"
            // @ts-ignore
            href={discord_invite}
            target="_blank"
          >
            Открыть в браузере
          </Button>
          <Box
            mt={1}
            p={1}
            style={{
              wordBreak: 'break-word',
              background: '#444',
              padding: '5px',
            }}
          >
            <a href={discord_invite}>{discord_invite}</a>
          </Box>
        </Section>

        <Section title="Как привязать аккаунт">
          <LabeledList>
            <LabeledList.Item label="Шаг 1">
              {`Нажмите "Скопировать в буфер обмена" или скопируйте код выше вручную.`}
            </LabeledList.Item>
            <LabeledList.Item label="Шаг 2">
              Зайдите на сервер Discord по приглашению выше.
            </LabeledList.Item>
            <LabeledList.Item label="Шаг 3">
              Прочитайте правила и инструкции на сервере Discord.
            </LabeledList.Item>
            <LabeledList.Item label="Шаг 4">
              Откройте канал <b>#bot-dump</b> и введите <b>/verifydiscord</b>.
              <Box mt={1}>
                <img
                  src={resolveAsset('dverify_image1.png')}
                  style={{ maxWidth: '100%' }}
                />
              </Box>
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item label="Шаг 5">
              Вставьте код подтверждения в поле code и нажмите Enter.
              <Box mt={1}>
                <img
                  src={resolveAsset('dverify_image2.png')}
                  style={{ maxWidth: '100%' }}
                />
              </Box>
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item label="Шаг 6">
              {`Выберите `}
              <b>Crimson Grid</b>
              {` в выпадающем списке серверов. `}
              {/* TODO: Image below needs to be updated */}
              <Box mt={1}>
                <img
                  src={resolveAsset('dverify_image3.png')}
                  style={{ maxWidth: '100%' }}
                />
              </Box>
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item label="Шаг 7">
              Как только вы выберете сервер, аккаунт будет привязан, а вас
              переподключит к игре.
              <Box mt={1}>
                <img
                  src={resolveAsset('dverify_image4.png')}
                  style={{ maxWidth: '100%' }}
                />
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
