import { useState } from 'react';
import { Button, Input, LabeledList, Section } from 'tgui-core/components';
import { useBackend } from '../../backend';

import type { ATMData } from './types';

export const AtmLogin = (props) => {
  const { act, data } = useBackend<ATMData>();
  const [entered_code, setEnteredCode] = useState('');

  const handleLogin = () => {
    act('login', { bank_pin: entered_code });
  };
  return (
    <Section title="Введите ПИН-код">
      <LabeledList>
        <LabeledList.Item label="ПИН-код">
          <Input
            value={entered_code}
            placeholder="Введите ПИН-код"
            onChange={setEnteredCode}
          />
        </LabeledList.Item>
        <LabeledList.Item>
          <Button onClick={handleLogin}>Войти</Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
