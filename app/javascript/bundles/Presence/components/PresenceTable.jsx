import PropTypes from 'prop-types';
import React from 'react';
import { sum, map } from 'lodash';
import Year from './Year';
import { format, subYears, addDays } from 'date-fns';

import { legacyParse, convertTokens } from "@date-fns/upgrade/v2";

export default class PresenceTable extends React.Component {
  static propTypes = {
    isEligible: PropTypes.bool,
    totalDays: PropTypes.object,
    years: PropTypes.object,
    loading: PropTypes.bool,
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
        <span>
          Total days in New Zealand: {sum(map(totalDays, eachYear => eachYear))}
        </span>
        <i className={`fas fa-${iconClass}`} />
      </header>
    );
  };

  startDate = yearNum => {
    const { endOfRollingYear } = this.props;
    return format(
      legacyParse(addDays(legacyParse(subYears(legacyParse(endOfRollingYear), yearNum)), 1)),
      convertTokens('dd mm yyyy')
    );
  };

  endingDate = yearNum => {
    const { endOfRollingYear } = this.props;
    return format(
      legacyParse(subYears(legacyParse(endOfRollingYear), yearNum - 1)),
      convertTokens('dd mm yyyy')
    );
  };

  render() {
    const { years, totalDays, loading } = this.props;
    let yearNum = 6;
    let formattedYears = map(years, (isEligible, yearEndDate) => {
      yearNum--;
      return {
        yearNum,
        isEligible,
        yearNumber: yearNum,
        daysPresent: totalDays[yearEndDate],
        startDate: this.startDate(yearNum),
        endingDate: this.endingDate(yearNum),
      };
    }).reverse();

    return (
      <div className="results">
        {this.header()}
        {formattedYears && !loading && (
          <div className="presence-table">
            {formattedYears.map(year => (
              <Year key={`year_${year.yearNum}`} {...year} />
            ))}
          </div>
        )}
      </div>
    );
  }
}
