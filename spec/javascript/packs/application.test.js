import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import ShowClient from '../../../app/javascript/packs/application';

configure({ adapter: new Adapter() });

describe('<ShowClient />', () => {
  it('renders without error', () => {
    shallow(<ShowClient />);
  });
});
