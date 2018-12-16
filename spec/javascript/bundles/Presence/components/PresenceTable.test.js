import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import PresenceTable from '../../../../../app/javascript/bundles/Presence/components/PresenceTable';

configure({ adapter: new Adapter() });

describe('<PresenceTable />', () => {
  let props = {
    isEligible: true,
    totalDays: [0],
    years: [true],
    loading: false
  };

  it('renders without error', () => {
    shallow(<PresenceTable {...props} />);
  });
});
