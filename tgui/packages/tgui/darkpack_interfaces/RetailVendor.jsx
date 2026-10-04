// THIS IS A DARKPACK UI FILE

import {
  Box,
  Button,
  DmIcon,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

/** Displays user details if an ID is present and the user is on the station */
export const UserDetails = (props) => {
  const { data } = useBackend();
  const { user } = data;

  return (
    <NoticeBox m={0} color={user && 'blue'}>
      {(data.user &&
        (data.user.money > 0 || data.user.is_card === 1) &&
        ((data.user.is_card === 0 && (
          <Box>
            Вижу, у вас при себе $<b>{data.user.money}</b>.
          </Box>
        )) ||
          (data.user.is_card === 1 && (
            <Box>
              Вижу, вы платите <b>картой</b>. Для покупок дороже $20
              понадобится ПИН-код. Что будете брать?
            </Box>
          )))) || <Box color="light-gray">Нет ни налички, ни карты - нет и обслуживания!</Box>}
    </NoticeBox>
  );
};

export const RetailVendor = (props) => {
  const { act, data } = useBackend();
  const inventory = [...data.product_records];
  return (
    <Window width={431} height={635} resizable>
      <Window.Content scrollable>
        <Stack fill vertical>
          <Stack.Item>
            <UserDetails />
          </Stack.Item>
          <Section title="Товары">
            <Table>
              {inventory.map((product) => {
                return (
                  <Table.Row key={product.name}>
                    <Table.Cell>
                      <DmIcon
                        icon={product.icon}
                        icon_state={product.icon_state}
                        style={{
                          'vertical-align': 'middle',
                        }}
                      />{' '}
                      <b>{product.name}</b>
                    </Table.Cell>
                    <Table.Cell>
                      <Button
                        style={{
                          'min-width': '60px',
                          'text-align': 'center',
                        }}
                        disabled={
                          !data.user ||
                          (product.price > data.user.money &&
                            data.user.is_card === 0) ||
                          product.stock === 0
                        }
                        content={`${data.money_symbol}${product.price}`}
                        onClick={() =>
                          act('purchase', {
                            ref: product.ref,
                            payment_item: data.user.payment_item,
                          })
                        }
                      />
                    </Table.Cell>
                    <Table.Cell>
                      {product.stock > -1 && <b>В наличии: {product.stock}</b>}
                    </Table.Cell>
                  </Table.Row>
                );
              })}
            </Table>
          </Section>
        </Stack>
      </Window.Content>
    </Window>
  );
};
