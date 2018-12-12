import PropTypes from 'prop-types';
import React from 'react';
import { sum } from 'lodash';
import Year from './Year';
import { format, subYears, addDays } from 'date-fns';

export default class PresenceTable extends React.Component {
  static propTypes = {
    isEligible: PropTypes.bool,
    totalDays: PropTypes.arrayOf(PropTypes.number),
    years: PropTypes.arrayOf(PropTypes.bool),
    loading: PropTypes.bool
  };

  header = () => {
    const { isEligible, loading, totalDays } = this.props;
    let iconClass = '';
    let stateClass = '';

    if (loading) {
      iconClass = 'spinner';
      stateClass = 'loading';
    } else if (isEligible) {
      iconClass = 'check';
    } else {
      iconClass = 'times';
      stateClass = 'has-error';
    }

    return (
      <header className={`presence-table-header ${stateClass}`}>
        <span>Total days in NZ: {sum(totalDays)}</span>
        <i className={`fas fa-${iconClass}`} />
      </header>
    );
  };

  startDate = index => {
    const { selectedDate } = this.props;
    return format(addDays(subYears(selectedDate, index + 1), 1), 'DD MMM YYYY');
  };

  endingDate = index => {
    const { selectedDate } = this.props;
    return format(subYears(selectedDate, index), 'DD MMM YYYY');
  };

  render() {
    const { years, totalDays, loading } = this.props;
    let formattedYears = years.map((isEligible, index) => {
      return {
        index,
        isEligible,
        yearNumber: years.length - index,
        daysPresent: totalDays[index],
        startDate: this.startDate(index),
        endingDate: this.endingDate(index)
      };
    });

    return (
      <div className="results">
        {this.header()}
        {formattedYears && !loading && (
          <div className="presence-table">
            {formattedYears.map(year => (
              <Year key={`year_${year.index}`} {...year} />
            ))}
          </div>
        )}
      </div>
    );
  }
}
