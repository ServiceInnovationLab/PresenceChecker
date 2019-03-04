import React from 'react';
import { configure, mount } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import renderer from 'react-test-renderer';

import MovementsTable from '../../../../../app/javascript/bundles/Presence/components/MovementsTable';

configure({ adapter: new Adapter() });

describe('<MovementsTable />', () => {
  let props = {
    movements: [
      {
        carrier_date_time: '2018-02-12T00:00:00.000Z',
        created_at: '2019-03-03T22:55:25.179Z',
        direction: 'arrival',
        id: 93,
        identity_id: 13,
        updated_at: '2019-03-03T22:55:25.179Z',
        visa_type: 'R'
      },
      {
        carrier_date_time: '2018-01-20T00:00:00.000Z',
        created_at: '2019-03-03T22:55:25.177Z',
        direction: 'departure',
        id: 92,
        identity_id: 13,
        updated_at: '2019-03-03T22:55:25.177Z',
        visa_type: null
      }
    ],
  };

  it('renders without error', () => {
    mount(<MovementsTable {...props} />);
  });

  it('renders correctly without failing', () => {
    const tree = renderer
      .create(<MovementsTable {...props} />)
      .toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('should show indefinite visa type if positive class name exists', () => {
    const wrapper = mount(<MovementsTable {...props} />);
    expect(wrapper.find('.movements-table-highlight--positive').childAt(2).text()).toBe('R');
  });

  it('should show no visa type if negative class name exists', () => {
    const wrapper = mount(<MovementsTable {...props} />);
    expect(wrapper.find('.movements-table-highlight--negative').childAt(2).text()).toBe('');
  });

});
