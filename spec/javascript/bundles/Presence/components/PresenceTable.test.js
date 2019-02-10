import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import PresenceTable from '../../../../../app/javascript/bundles/Presence/components/PresenceTable';

configure({ adapter: new Adapter() });

describe('<PresenceTable />', () => {
  const props = {
    isEligible: true,
    totalDays: {},
    years: {},
    loading: false,
  };

  it('renders without error', () => {
    shallow(<PresenceTable {...props} />);
  });
});
