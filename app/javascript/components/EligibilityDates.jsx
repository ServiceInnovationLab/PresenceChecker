import PropTypes from 'prop-types';
import React from 'react';
import { format } from 'date-fns';

import PresenceDates from '../bundles/Presence/components/PresenceDates';

export default class EligibilityDates extends React.Component {
  render() {
    const {
      eligibleDateRanges,
      selectedDate,
      isEligible,
      onDateChange,
      highlightWithRanges
    } = this.props;

    return (
      <div className="results">
        <h2>Presence Data</h2>
        <div>
          <PresenceDates
            isEligible={isEligible}
            selectedDate={selectedDate}
            onDateChange={onDateChange}
            highlightDates={highlightWithRanges}
          />

          <div className="panel is-wide">
            <header>
              <h3>Dates eligible to apply</h3>
            </header>
            <div>
              <ul className="list-stripped u-padding-left-small">
                {eligibleDateRanges.map((range, index) => {
                  return (
                    <li key={index}>
                      {format(range.start, 'D MMMM YYYY')}
                      {' - '}
                      {format(range.end, 'D MMMM YYYY')}
                    </li>
                  );
                })}
              </ul>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
