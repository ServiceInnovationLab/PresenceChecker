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

const fakeData = {
  "2018-01-01": {
    meetsMinimumPresence: true,
    last5Years: [true, false, true, true, true],
    daysInNZ: [143, 10, 122, 121, 120]
  },
  "2018-01-02": {
    meetsMinimumPresence: true,
    last5Years: [true, true, true, true, true],
    daysInNZ: [143, 123, 122, 121, 120]
  },
  "2018-01-03": {
    meetsMinimumPresence: true,
    last5Years: [true, true, true, true, true],
    daysInNZ: [143, 123, 122, 121, 120]
  },
  "2018-01-04": {
    meetsMinimumPresence: true,
    last5Years: [true, true, true, true, true],
    daysInNZ: [143, 123, 122, 121, 120]
  },
  "2018-01-05": {
    meetsMinimumPresence: true,
    last5Years: [true, true, true, true, true],
    daysInNZ: [143, 123, 122, 121, 120]
  },
  "2018-01-06": {
    meetsMinimumPresence: true,
    last5Years: [true, true, true, true, true],
    daysInNZ: [143, 123, 122, 121, 120]
  },
  "2018-01-07": {
    meetsMinimumPresence: true,
    last5Years: [true, true, true, true, true],
    daysInNZ: [143, 123, 122, 121, 120]
  }
}

const getCSRF = () => {
  let element = document.querySelector("meta[name=\"csrf-token\"]");
  if (element) { return element.getAttribute("content"); }
  return "";
};

class ShowClient extends React.Component {
  state = {
    selectedDate: new Date(),
    isEligible: checkEligibility(this.props.eligibleDateRanges),
    rollingYearData: this.props.rollingYearData
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
    this.checkSelectedDate(newDate);
  };

  onDataResponse = (response) => {
    // isEligible needs some logic, I don't think it can come from props?

    this.setState({ rollingYearData: response })
  }

  checkSelectedDate = selectedDate => {
    const { clientId } = this.props;
    this.onDataResponse(fakeData);

    return;

    fetch(`/clients/eligibility?id=${clientId}&date=${selectedDate}`, {
      method: "GET",
      mode: "same-origin",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": getCSRF()
      }
    })
      .then(result => {
        return result.json();
      })
      .then(response => {
        debugger;
        // This response should be the EligibilityService object
        this.onDataResponse(response);
      })
      .catch(error => {
        console.error("Server error:", error);
      });
  }

  render() {
    const { selectedDate,isEligible, rollingYearData } = this.state;
    const { clientId, identities } = this.props;

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
              highlightDates={highlightWithRanges}
            />
          </div>
          <div className="results dates-wrapper-right">
            {rollingYearData && <PresenceTable
              // isEligible={isEligible}
              // totalDays={totalDays}
              // years={years}
              selectedDate={selectedDate}
              rollingYearData={rollingYearData}
            />}
          </div>
        </section>
      </main>
    );
  }
}

ReactOnRails.register({
  ShowClient
});
