import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import TimePeriod from '../../../app/javascript/components/TimePeriod';

configure({ adapter: new Adapter() });

describe('<TimePeriod />', () => {
  let props = {
    periodName: '',
    days: [],
  };

  it('renders without error', () => {
    shallow(<TimePeriod {...props} />);
  });
});
