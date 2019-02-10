import React from 'react';
import { configure, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import ShowClient from '../../../app/javascript/packs/application';

configure({ adapter: new Adapter() });

describe('<ShowClient />', () => {
  const props = {
    databaseId: 1,
    clientId: 1,
    movements: [],
    identities: [],
  };

  it('renders without error', () => {
    shallow(<ShowClient {...props} />);
  });

  describe('methods', () => {
    describe('componentDidMount', () => {
      const component = shallow(<ShowClient {...props} />);

      it('mounts properly', () => {
        const spy = jest.spyOn(component.instance(), 'checkSelectedDate');

        expect(spy).not.toHaveBeenCalled();
        expect(() => {
          component.instance().componentDidMount();
        }).not.toThrow();
        expect(spy).toHaveBeenCalled();
      });
    });

    describe('checkSelectedDate', () => {
      const component = shallow(<ShowClient {...props} />);
      const date = new Date();

      it('checks date passed', () => {
        const spy = jest.spyOn(component.instance(), 'setState');

        expect(spy).not.toHaveBeenCalled();
        expect(() => {
          component.instance().componentDidMount(date);
        }).not.toThrow();
        expect(spy).toHaveBeenCalledWith({ loading: true });
      });
    });

    describe('onDateChange', () => {
      const component = shallow(<ShowClient {...props} />);
      const date = new Date();

      it('sets state properly', () => {
        const spy = jest.spyOn(component.instance(), 'setState');

        expect(spy).not.toHaveBeenCalled();
        expect(() => {
          component.instance().onDateChange(date);
        }).not.toThrow();
        expect(spy).toHaveBeenCalledWith({
          selectedDate: date,
          meetsMinimumPresence: false,
        });
      });

      it('calls on "checkSelectedDate"', () => {
        const spy = jest.spyOn(component.instance(), 'checkSelectedDate');

        expect(spy).not.toHaveBeenCalled();
        expect(() => {
          component.instance().onDateChange(date);
        }).not.toThrow();
        expect(spy).toHaveBeenCalledWith(date);
      });
    });

    describe('onDataResponse', () => {
      const component = shallow(<ShowClient {...props} />);
      const response = {
        meetsMinimumPresence: true,
        daysInNZ: [],
        last5Years: [],
      };

      it('sets state properly', () => {
        const spy = jest.spyOn(component.instance(), 'setState');

        expect(spy).not.toHaveBeenCalled();
        expect(() => {
          component.instance().onDataResponse(response);
        }).not.toThrow();
        expect(spy).toHaveBeenCalledWith({
          loading: false,
          meetsMinimumPresence: response.meetsMinimumPresence,
          daysInNZ: response.daysInNZ,
          last5Years: response.last5Years,
        });
      });

      it('calls on "checkNextWeek"', () => {
        const spy = jest.spyOn(component.instance(), 'checkNextWeek');

        expect(spy).not.toHaveBeenCalled();
        expect(() => {
          component.instance().onDataResponse(response);
        }).not.toThrow();
        expect(spy).toHaveBeenCalled();
      });
    });

    describe('checkNextWeek', () => {
      const component = shallow(<ShowClient {...props} />);

      xit('', () => {});
    });

    describe('appendEligibleDay', () => {
      const component = shallow(<ShowClient {...props} />);
      const date = new Date();

      it('sets state properly', () => {
        const spy = jest.spyOn(component.instance(), 'setState');

        expect(spy).not.toHaveBeenCalled();
        expect(() => {
          component.instance().appendEligibleDay(date);
        }).not.toThrow();
        expect(spy).toHaveBeenCalledWith({
          futureEligibility: [date],
        });
      });
    });

    describe('highlightDates', () => {
      const component = shallow(<ShowClient {...props} />);

      it('returns dates in the correct format', () => {
        expect(() => {
          component.instance().highlightDates();
        }).not.toThrow();
        expect(component.instance().highlightDates()).toMatchObject([
          {
            'is-within-range': [],
          },
        ]);
      });
    });

    describe('render', () => {
      const component = shallow(<ShowClient {...props} />);

      it('contains a main tag with the proper role', () => {
        expect(component.find("main[role='main']")).toHaveLength(1);
      });

      it('contains a wrapper for identities', () => {
        expect(component.find('.identities-wrapper')).toHaveLength(1);
      });

      it('renders the Identity component', () => {
        expect(component.find('Identity')).toBeDefined();
      });

      it('contains a wrapper for dates', () => {
        expect(component.find('.dates-wrapper')).toHaveLength(1);
      });

      it('renders the PresenceDates component', () => {
        expect(component.find('PresenceDates')).toBeDefined();
      });

      it('renders the PresenceTable component', () => {
        expect(component.find('PresenceTable')).toBeDefined();
      });

      it('renders the MovementsTable component', () => {
        expect(component.find('MovementsTable')).toBeDefined();
      });
    });
  });
});
