import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import PresenceDebugger from '../../../app/javascript/components/PresenceDebugger';

configure({ adapter: new Adapter() });

describe('<PresenceDebugger />', () => {
  let props = {
    days_present: {}
  }

  it('renders without error', () => {
    shallow(<PresenceDebugger {...props} />);
  });
});
