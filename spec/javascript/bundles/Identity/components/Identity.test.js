import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import Identity from '../../../../../app/javascript/bundles/Identity/components/Identity';

configure({ adapter: new Adapter() });

describe('<Identity />', () => {
  let props = {
    id: 1,
    identities: []
  }

  it('renders without error', () => {
    shallow(<Identity {...props} />);
  });
});
