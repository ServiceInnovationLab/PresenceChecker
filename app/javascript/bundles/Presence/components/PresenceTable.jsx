import PropTypes from 'prop-types';
import React from 'react';
import { sum, map } from 'lodash';
import Year from './Year';
import { format, subYears, addDays } from 'date-fns';

export default class PresenceTable extends React.Component {
  static propTypes = {
    isEligible: PropTypes.bool,
    totalDays: PropTypes.object,
    years: PropTypes.object,
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
      <span>Total days in New Zealand: {sum(map(totalDays, eachYear => eachYear))}</span>
        <i className={`fas fa-${iconClass}`} />
      </header>
    );
  };

  startDate = yrNumber => {
    const { selectedDate } = this.props;
    return format(addDays(subYears(selectedDate, yrNumber), 1), 'DD MMM YYYY');
  };

  endingDate = yrNumber => {
    const { selectedDate } = this.props;
    return format(subYears(selectedDate, yrNumber - 1), 'DD MMM YYYY');
  };

  render() {
    const { years, totalDays, loading } = this.props;
    let yrNumber = 6
    let formattedYears = map(years, (isEligible, yearEndDate) => {
      yrNumber --
      return {
        yrNumber,
        isEligible,
        yearNumber: yrNumber,
        daysPresent: totalDays[yearEndDate],
        startDate: this.startDate(yrNumber),
        endingDate: this.endingDate(yrNumber)
      };
    }).reverse()

    return (
      <div className="results">
        {this.header()}
        {formattedYears && !loading && (
          <div className="presence-table">
            {formattedYears.map(year => (
              <Year key={`year_${year.yrNumber}`} {...year} />
            ))}
          </div>
        )}
      </div>
    );
  }
}
