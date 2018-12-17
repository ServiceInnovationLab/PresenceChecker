import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import Table from '../../../app/javascript/components/Table';

configure({ adapter: new Adapter() });

describe('<Table />', () => {
  it('renders without error', () => {
    shallow(<Table />);
  });
});
