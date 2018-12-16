import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import PresenceDates from '../../../../../app/javascript/bundles/Presence/components/PresenceDates';

configure({ adapter: new Adapter() });

describe('<PresenceDates />', () => {
  let props = {
    isEligible: true,
    onDateChange: jest.fn(),
    highlightDates: [],
    loading: false
  };

  it('renders without error', () => {
    shallow(<PresenceDates {...props} />);
  });
});
