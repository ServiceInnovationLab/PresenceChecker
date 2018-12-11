import React from 'react';
import ReactOnRails from 'react-on-rails';
import { format, eachDay } from 'date-fns';

import Identity from '../bundles/Identity/components/Identity';
import PresenceDates from '../bundles/Presence/components/PresenceDates';
import PresenceTable from '../bundles/Presence/components/PresenceTable';

const checkEligibility = (dateEligibility, date = new Date()) => {
  let formattedDate = format(date, 'YYYY-MM-DD');
  return dateEligibility[formattedDate];
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
  let element = document.querySelector('meta[name="csrf-token"]');
  if (element) {
    return element.getAttribute('content');
  }
  return '';
};

class ShowClient extends React.Component {
  state = {
    selectedDate: new Date(),
    isEligible: checkEligibility(this.props.dateEligibility),
    rollingYearData: this.props.rollingYearData
  };

  componentDidMount = () => {
    this.checkSelectedDate()
  }

  onDateChange = (date) => {
    const { dateEligibility } = this.props;
    let newDate = new Date(date);

    this.setState({
      selectedDate: newDate,
      isEligible: checkEligibility(dateEligibility, newDate)
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
    const url = `/clients/eligibility?id=${clientId}&date=${format(
      selectedDate,
      'YYYY-MM-DD'
    )}`;
    this.onDataResponse(fakeData);

    // fetch(`/clients/eligibility?id=${clientId}&date=${selectedDate}`, {
    //   method: "GET",
    //   mode: "same-origin",
    //   credentials: "same-origin",
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'X-CSRF-Token': getCSRF()
    //   }
    // })
    //   .then((result) => {
    //     return result.json();
    //   })
    //   .then((response) => {
    //     debugger;
    //     // This response should be the EligibilityService object
    //     this.onDataResponse(response);
    //   })
    //   .catch((error) => {
    //     console.error('Server error:', error);
    //   });
  };

  highlightDates = () => {
    const { dateEligibility } = this.props;

    let eligibleDates = [];

    for (let date in dateEligibility) {
      if (dateEligibility[date]) eligibleDates.push(date);
    }

    return [
      {
        'is-within-range': eligibleDates
      }
    ];
  };

  render() {
    const { selectedDate, isEligible } = this.state;
    const { clientId, identities } = this.props;

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
              highlightDates={this.highlightDates()}
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
