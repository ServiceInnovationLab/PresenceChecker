import React from 'react';
import ReactOnRails from 'react-on-rails';
import { format, isWithinRange, eachDay } from 'date-fns';

import Identity from '../bundles/Identity/components/Identity';
import PresenceDates from '../bundles/Presence/components/PresenceDates';
import PresenceTable from '../bundles/Presence/components/PresenceTable';

const checkEligibility = (eligibleDateRanges, date = new Date()) => {
  let eligible = false;

  for (let index = 0; index < eligibleDateRanges.length; index++) {
    const { start, end } = eligibleDateRanges[index];
    if (isWithinRange(date, start, end)) {
      eligible = true;
      break;
    }
  }

  return eligible;
};

class ShowClient extends React.Component {
  state = {
    selectedDate: new Date(),
    isEligible: checkEligibility(this.props.eligibleDateRanges)
  };

  allDaysInRange = () => {
    const { eligibleDateRanges } = this.props;
    const allDaysInRange = eligibleDateRanges.map(({ start, end }) => {
      return eachDay(start, end, 1);
    });
    return allDaysInRange.reduce((acc, val) => acc.concat(val));
  };

  onDateChange = (date) => {
    const { eligibleDateRanges } = this.props;
    let newDate = new Date(date);

    this.setState({
      selectedDate: newDate,
      isEligible: checkEligibility(eligibleDateRanges, newDate)
    });

    // This is where we'll call the service with a fetch request
  };

  render() {
    const { selectedDate, isEligible } = this.state;
    const { clientId, identities, totalDays, years } = this.props;

    const highlightWithRanges = [
      {
        'is-within-range': this.allDaysInRange()
      }
    ];

    return (
      <main role="main">
        <section className="identities-wrapper">
          <Identity id={clientId} identities={identities} />
        </section>
        <section className="dates-wrapper">
          <h2>Presence Data</h2>
          <div className="results dates-wrapper-left">
            <PresenceDates
              onDateChange={this.onDateChange}
              selectedDate={selectedDate}
              isEligible={isEligible}
              highlightWithRanges={highlightWithRanges}
            />
          </div>
          <div className="results dates-wrapper-right">
            <PresenceTable
              isEligible={isEligible}
              totalDays={totalDays}
              years={years}
            />
          </div>
        </section>
      </main>
    );
  }
}

ReactOnRails.register({
  ShowClient
});
