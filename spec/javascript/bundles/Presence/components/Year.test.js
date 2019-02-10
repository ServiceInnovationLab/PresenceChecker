import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import Year from '../../../../../app/javascript/bundles/Presence/components/Year';

configure({ adapter: new Adapter() });

describe('<Year />', () => {
  const props = {
    yearNumber: 0,
    daysPresent: 0,
    isEligible: true,
  };

  it('renders without error', () => {
    shallow(<Year {...props} />);
  });
});
