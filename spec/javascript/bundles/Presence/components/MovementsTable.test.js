import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import MovementsTable from '../../../../../app/javascript/bundles/Presence/components/MovementsTable';

configure({ adapter: new Adapter() });

describe('<MovementsTable />', () => {
  const props = {
    movements: [],
  };

  it('renders without error', () => {
    shallow(<MovementsTable {...props} />);
  });
});
