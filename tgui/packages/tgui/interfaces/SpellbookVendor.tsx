//THIS IS A DARKPACK UI FILE
import { useBackend } from '../backend';
import { Box, Button, Section, Table, Dropdown, Collapsible, NumberInput, DmIcon } from 'tgui-core/components';
import { Window } from '../layouts';
import { useState } from 'react';

type Product = {
  name: string;
  path: string;
  price: number;
  stock: number;
  available: boolean;
  ref: string;
  icon: string;
  icon_state: string;
}

type TremereMember = {
  name: string;
  role: string;
  points: number;
  ref: string;
}

type User = {
  points: number;
  name: string;
  job: string;
  has_thaumaturgy: boolean;
  has_necromancy: boolean;
  is_regent: boolean;
  has_privileges: boolean;
}

type SpellbookVendorData = {
  product_records: Product[];
  tremere_members: TremereMember[];
  user: User | null;
}

const STYLE = {
  section: {
    backgroundColor: '#1a0000',
    borderColor: '#4d0000',
    color: '#cc3333',
  },
  tableDark: {
    backgroundColor: '#0d0000',
  },
  row: {
    backgroundColor: '#1a0000',
    borderColor: '#4d0000',
  },
};

const ProductRow = (props) => {
  const { product, user, onPurchase } = props;
  const inStock = product.stock > 0;
  const canAfford = user && product.price <= user.points;

  return (
    <Table.Row style={STYLE.row}>
      <Table.Cell style={{ color: '#cc3333' }}>
        <DmIcon
          icon={product.icon}
          icon_state={product.icon_state}
          style={{
            verticalAlign: 'middle',
            filter: inStock
              ? 'hue-rotate(0deg) saturate(1.2) brightness(0.9)'
              : 'grayscale(100%) brightness(0.5)',
          }}
        />{' '}
        <b style={{ color: inStock ? '#ff4444' : '#666666' }}>{product.name}</b>
        <br />
        <span style={{ fontSize: '0.8em', color: inStock ? '#996666' : '#555555' }}>
          В наличии: {product.stock || 0}
        </span>
      </Table.Cell>
      <Table.Cell>
        <Button
          disabled={!canAfford || !inStock}
          onClick={() => onPurchase(product.ref)}
          style={{ minWidth: '105px', textAlign: 'center' }}
        >
          {inStock ? `Очков исследований: ${product.price || 0}` : 'Нет в наличии!'}
        </Button>
      </Table.Cell>
    </Table.Row>
  );
};

export const SpellbookVendor = (props) => {
  const { act, data } = useBackend<SpellbookVendorData>();
  const [selectedTarget, setSelectedTarget] = useState(null);
  const [transferAmount, setTransferAmount] = useState(0);

  const { product_records = [], tremere_members = [], user } = data;
  const greeting = user?.has_thaumaturgy
    ? 'Приветствую, ученик крови...'
    : 'Приветствую, ищущий...';

  const selectedMember = tremere_members.find((m) => m.ref === selectedTarget);
  const amount = transferAmount || 0;
  const canTransfer = selectedMember && amount > 0 && user && amount <= user.points;
  const canSeize = selectedMember && amount > 0;

  return (
    <Window width={465} height={700} theme="blood_cult">
      <Window.Content scrollable>
        <Section title="Адепт" style={STYLE.section}>
          {user && (
            <Box style={{ color: '#cc3333' }}>
              {greeting}
              <br />
              Ваши очки исследований: <b style={{ color: '#ff4444' }}>{user.points}</b>
            </Box>
          )}
        </Section>

        <Section title="Архивы" style={STYLE.section}>
          <Table style={STYLE.tableDark}>
            {product_records.map((product) => (
              <ProductRow
                key={product.name}
                product={product}
                user={user}
                onPurchase={(ref) => act('purchase', { ref })}
              />
            ))}
          </Table>
        </Section>

        {tremere_members.length > 0 && (
          <Collapsible title="Сеть Тремер" style={STYLE.section}>
            <Section style={{ ...STYLE.section, backgroundColor: '#0d0000' }}>
              <Box style={{ marginBottom: '10px', color: '#cc3333' }}>
                <b style={{ color: '#ff4444' }}>Члены клана:</b>
              </Box>

              <Table style={{ ...STYLE.tableDark, marginBottom: '15px' }}>
                {tremere_members.map((member) => (
                  <Table.Row key={member.ref} style={STYLE.row}>
                    <Table.Cell style={{ color: '#cc3333' }}>
                      <b style={{ color: '#ff4444' }}>{member.name}</b>
                      <br />
                      <span style={{ fontSize: '0.9em', color: '#996666' }}>{member.role}</span>
                    </Table.Cell>
                    <Table.Cell style={{ color: '#cc3333', textAlign: 'right' }}>
                      <b style={{ color: '#ff6666' }}>Очков: {member.points}</b>
                    </Table.Cell>
                  </Table.Row>
                ))}
              </Table>

              <Box style={{ marginBottom: '10px' }}>
                <Box style={{ marginBottom: '5px', color: '#cc3333' }}>
                  <b style={{ color: '#ff4444' }}>Адресат:</b>
                </Box>
                <Dropdown
                  width="100%"
                  options={tremere_members.map((m) => ({
                    displayText: `${m.name} (${m.role}) - очков: ${m.points}`,
                    value: m.ref,
                  }))}
                  displayText={
                    selectedMember
                      ? `${selectedMember.name} (${selectedMember.role}) - очков: ${selectedMember.points}`
                      : 'Выберите члена клана...'
                  }
                  selected={selectedTarget || ''}
                  onSelected={(value) => setSelectedTarget(value)}
                  color="red"
                />
              </Box>

              <Box style={{ marginBottom: '10px' }}>
                <Box style={{ marginBottom: '5px', color: '#cc3333' }}>
                  <b style={{ color: '#ff4444' }}>Количество:</b>
                </Box>
                <NumberInput
                  width="100%"
                  minValue={0}
                  maxValue={selectedMember?.points || 1000}
                  step={1}
                  value={transferAmount}
                  onChange={(value) => setTransferAmount(value)}
                />
              </Box>

              <Box style={{ display: 'flex', gap: '10px' }}>
                <Button
                  disabled={!canTransfer}
                  onClick={() => {
                    act('transfer_points', { target_ref: selectedMember!.ref, amount });
                    setTransferAmount(0);
                  }}
                  style={{ flex: '1' }}
                >
                  Передать очки
                </Button>

                {user?.is_regent && (
                  <Button
                    disabled={!canSeize}
                    onClick={() => {
                      act('seize_points', { target_ref: selectedMember!.ref, amount });
                      setTransferAmount(0);
                    }}
                    style={{ flex: '1' }}
                  >
                    Изъять очки
                  </Button>
                )}
              </Box>

              {user?.is_regent && (
                <Box style={{ marginTop: '10px', fontSize: '0.9em', color: '#996666' }}>
                  <i>Как Регент, вы вправе изымать очки исследований у любого члена клана.</i>
                </Box>
              )}
            </Section>
          </Collapsible>
        )}
      </Window.Content>
    </Window>
  );
};
