//THIS IS A DARKPACK UI FILE
import { classes } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Box, Button, Section, Table } from 'tgui-core/components';
import { Window } from '../layouts';

export const NecromancyVendor = (props) => {
  const { act, data } = useBackend();

  const inventory = data.product_records || [];

  const getGreeting = () => {
    if (data.user?.has_necromancy){
      return "Приветствую вас, повелитель смерти и тени...";
    } else {
      return "Мёртвые шепчут о вашем приходе, смертный...";
    }
  };

  return (
    <Window width={465} height={500} resizable theme="blood_cult">
      <Window.Content scrollable>
        <Section
          title="Жнец душ"
          style={{
            'background-color': '#0d0d0d',
            'border-color': '#333333',
            'color': '#cccccc'
          }}
        >
          {data.user && (
            <Box style={{ 'color': '#cccccc' }}>
              {getGreeting()}
              <br />
              Душ, собранных вами у живых:{' '}
              <b style={{ 'color': '#9966cc' }}>{data.user.souls}</b>
            </Box>
          )}
        </Section>

        <Section
          title="Костяной кодекс"
          style={{
            'background-color': '#0d0d0d',
            'border-color': '#333333',
            'color': '#cccccc'
          }}
        >
          <Table style={{ 'background-color': '#000000' }}>
            {inventory.map((product) => {
              const canAfford = data.user && product.price <= data.user.souls;

              return (
                <Table.Row
                  key={product.name}
                  style={{
                    'background-color': '#0d0d0d',
                    'border-color': '#333333'
                  }}
                >
                  <Table.Cell style={{ 'color': '#cccccc' }}>
                    <span
                      className={classes(['vending32x32', product.path])}
                      style={{
                        'vertical-align': 'middle',
                        'filter': 'hue-rotate(270deg) saturate(1.5) brightness(0.8)'
                      }}
                    />{' '}
                    <b style={{ 'color': '#9966cc' }}>{product.name}</b>
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      style={{
                        'min-width': '105px',
                        'text-align': 'center',
                        'background-color': canAfford ? '#2d1a4d' : '#1a1a1a',
                        'border-color': '#4d2d66',
                        'color': canAfford ? '#ddccff' : '#666666',
                        'transition': 'all 0.2s ease',
                        'cursor': canAfford ? 'pointer' : 'not-allowed'
                      }}
                      onMouseEnter={(e) => {
                        if (canAfford) {
                          e.target.style.backgroundColor = '#4d2d66';
                          e.target.style.color = '#ffffff';
                          e.target.style.borderColor = '#6640a0';
                          e.target.style.boxShadow = '0 0 8px rgba(153, 102, 204, 0.5)';
                        }
                      }}
                      onMouseLeave={(e) => {
                        if (canAfford) {
                          e.target.style.backgroundColor = '#2d1a4d';
                          e.target.style.color = '#ddccff';
                          e.target.style.borderColor = '#4d2d66';
                          e.target.style.boxShadow = 'none';
                        }
                      }}
                      disabled={!canAfford}
                      content={`Душ: ${product.price}`}
                      onClick={() =>
                        act('purchase', {
                          ref: product.ref,
                        })
                      }
                    />
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>

          {inventory.length === 0 && (
            <Box style={{
              'color': '#666666',
              'text-align': 'center',
              'padding': '20px',
              'font-style': 'italic'
            }}>
              Кодекс пуст... и ждёт тёмных знаний, которые заполнят его страницы.
            </Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
