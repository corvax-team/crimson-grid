// THIS IS A DARKPACK UI FILE
import { type Feature, FeatureShortTextInput } from '../base';

const description =
  'Нужна ссылка, которая начинается с https://, заканчивается на .png, .jpeg или .jpg \
  и ведёт на Gyazo, Imgbox или Catbox.moe. Изображение показывается под превью \
  персонажа в окне подробного осмотра. \
  Изображения больше 250x250 будут уменьшены до 250x250, \
  так что лучше сразу подобрать такой размер.';

export const headshot: Feature<string> = {
  name: 'Портрет',
  description: description,
  component: FeatureShortTextInput,
};
