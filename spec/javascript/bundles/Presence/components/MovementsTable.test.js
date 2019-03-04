import React from 'react';
import { configure, mount, shallow } from 'enzyme';
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
        direction: 'arrival',
        id: 91,
        identity_id: 13,
        updated_at: '2019-03-03T22:55:25.177Z',
        visa_type: 'X'
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

  /* The table doesn't have any headers so we're testing that there are 3 columns and the
     third column should be the visa type column */
  it('should have a visa type column', () => {
    const wrapper = mount(<MovementsTable {...props} />);
    expect(wrapper.find('.movements-table tr').length).toEqual(3);
  });

  it('should highlight the table if it has an indefinite visa', () => {
    const wrapper = mount(<MovementsTable {...props} />);
    expect(wrapper.find('.movements-table .movements-table-highlight--positive td').last().text()).toBe('R');
  });

  it('should not highlight the table if it does not have an indefinite visa', () => {
    const wrapper = mount(<MovementsTable {...props} />);
    expect(wrapper.find('.movements-table .movements-table-highlight--negative td').last().text()).toBe('');
  });

  it('should not highlight a row at all if the visa type is nil', () => {
    const wrapper = shallow(<MovementsTable {...props} />);
    expect(wrapper.find('.movements-table').children().last().contains(<td
      className="has-bottom-border"
    />)).toEqual(true);
    expect(wrapper.find('.movements-table').children().last().hasClass('movements-table-highlight--positive')).toEqual(false);
  });

});
