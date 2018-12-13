import React from 'react';
import ReactOnRails from 'react-on-rails';
import { format, eachDay, addDays } from 'date-fns';

import { getCSRF } from '../utilities/utilities';

import Identity from '../bundles/Identity/components/Identity';
import PresenceDates from '../bundles/Presence/components/PresenceDates';
import PresenceTable from '../bundles/Presence/components/PresenceTable';
import MovementsTable from '../bundles/Presence/components/MovementsTable';

class ShowClient extends React.Component {
  state = {
    loading: false,
    backgroundLoading: false,
    selectedDate: new Date(),
    meetsMinimumPresence: false,
    daysInNZ: [],
    last5Years: [],
    futureEligibility: []
  };

  componentDidMount = () => {
    this.checkSelectedDate(this.state.selectedDate);
  };

  checkSelectedDate = selectedDate => {
    const { futureEligibility } = this.state;
    const formattedDate = format(selectedDate, 'YYYY-MM-DD');
    let alreadyChecked = false;
    let checkedIndex = -1;

    for (let day = 0, l = futureEligibility.length; day < l; day++) {
      if (Object.keys(futureEligibility[day])[0] == formattedDate) {
        alreadyChecked = true;
        checkedIndex = day;
        break;
      }
    }

    if (!alreadyChecked) {
      const { databaseId } = this.props;
      const url = `/clients/${databaseId}/eligibility/${formattedDate}`;

      this.setState({
        loading: true
      });

      fetch(url, {
        method: 'GET',
        mode: 'same-origin',
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': getCSRF()
        }
      })
        .then(result => {
          return result.json();
        })
        .then(response => this.onDataResponse(response[formattedDate]))
        .catch(error => {
          console.error('Server error:', error);
          this.setState({
            loading: false
          });
        });
    } else {
      if (checkedIndex > 0) {
        const newDay = Object.keys(futureEligibility[checkedIndex])[0];
        const newState = futureEligibility[checkedIndex][newDay];

        this.setState({
          loading: false,
          meetsMinimumPresence: newState.meetsMinimumPresence,
          daysInNZ: newState.daysInNZ,
          last5Years: newState.last5Years
        });
      } else {
        this.setState({
          loading: false
        });
      }

      this.checkNextWeek();
    }
  };

  onDateChange = date => {
    let newDate = new Date(date);

    this.setState({
      selectedDate: newDate,
      meetsMinimumPresence: false
    });

    this.checkSelectedDate(newDate);
  };

  onDataResponse = response => {
    this.setState({
      loading: false,
      meetsMinimumPresence: response.meetsMinimumPresence,
      daysInNZ: response.daysInNZ,
      last5Years: response.last5Years
    });

    this.checkNextWeek();
  };

  checkNextWeek = () => {
    const { databaseId } = this.props;
    const { selectedDate, futureEligibility } = this.state;
    const nextWeek = eachDay(
      addDays(selectedDate, 1),
      addDays(selectedDate, 7)
    );
    let loadingNumber = nextWeek.length;

    this.setState({
      backgroundLoading: true
    });

    for (let day = 0, l = loadingNumber; day < l; day++) {
      const formattedDate = format(nextWeek[day], 'YYYY-MM-DD');
      let alreadyChecked = false;

      for (
        let futureDay = 0;
        futureDay < futureEligibility.length;
        futureDay++
      ) {
        if (Object.keys(futureEligibility[futureDay])[0] == formattedDate) {
          alreadyChecked = true;
          break;
        }
      }

      if (!alreadyChecked) {
        const url = `/clients/${databaseId}/eligibility/${formattedDate}`;

        fetch(url, {
          method: 'GET',
          mode: 'same-origin',
          credentials: 'same-origin',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': getCSRF()
          }
        })
          .then(result => {
            return result.json();
          })
          .then(response => {
            loadingNumber--;
            if (loadingNumber === 0) {
              this.setState({
                backgroundLoading: false
              });
            }
            this.appendEligibleDay(response);
          })
          .catch(error => {
            console.error('Server error:', error);

            loadingNumber--;
            if (loadingNumber === 0) {
              this.setState({
                backgroundLoading: false
              });
            }
          });
      }
    }
  };

  appendEligibleDay = day => {
    const futureEligibility = [ ...this.state.futureEligibility ];
    futureEligibility.push(day);
    this.setState({ futureEligibility });
  };

  highlightDates = () => {
    const { futureEligibility } = this.state;
    let eligibleDates = [];

    for (let day = 0, l = futureEligibility.length; day < l; day++) {
      let date = Object.keys(futureEligibility[day])[0];
      let values = futureEligibility[day][date];
      let allYears = values.last5Years.every(year => year);

      if (values.meetsMinimumPresence && allYears) eligibleDates.push(date);
    }

    return [
      {
        'is-within-range': eligibleDates
      }
    ];
  };

  render() {
    const {
      selectedDate,
      meetsMinimumPresence,
      daysInNZ,
      last5Years,
      loading
    } = this.state;
    const { clientId, identities, movements } = this.props;

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
              isEligible={meetsMinimumPresence}
              highlightDates={this.highlightDates()}
              loading={loading}
            />
          </div>
          <div className="results dates-wrapper-right">
            <PresenceTable
              isEligible={meetsMinimumPresence}
              totalDays={daysInNZ}
              years={last5Years}
              selectedDate={selectedDate}
              // rollingYearData={rollingYearData}
              loading={loading}
            />
            <MovementsTable movements={movements} />
          </div>
        </section>
      </main>
    );
  }
}

ReactOnRails.register({
  ShowClient
});
