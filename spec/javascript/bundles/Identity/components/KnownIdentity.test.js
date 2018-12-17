import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import KnownIdentity from '../../../../../app/javascript/bundles/Identity/components/KnownIdentity';

configure({ adapter: new Adapter() });

describe('<KnownIdentity />', () => {
  it('renders without error', () => {
    shallow(<KnownIdentity />);
  });
});
