import React from 'react';
import ReactOnRails from 'react-on-rails';
import { format } from 'date-fns';

import { getCSRF } from '../utilities/utilities';

import Identity from '../bundles/Identity/components/Identity';
import PresenceDates from '../bundles/Presence/components/PresenceDates';
import PresenceTable from '../bundles/Presence/components/PresenceTable';
import MovementsTable from '../bundles/Presence/components/MovementsTable';

class ShowClient extends React.Component {
  state = {
    loading: false,
    selectedDate: new Date(),
    meetsMinimumPresence: false,
    daysInNZ: [],
    last5Years: []
  };

  componentDidMount = () => {
    this.checkSelectedDate(this.state.selectedDate);
  };

  checkSelectedDate = selectedDate => {
    const { databaseId } = this.props;
    let url = `/clients/${databaseId}/eligibility/${format(
      selectedDate,
      'YYYY-MM-DD'
    )}`;

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
      .then(response =>
        this.onDataResponse(response[format(selectedDate, 'YYYY-MM-DD')])
      )
      .catch(error => {
        console.error('Server error:', error);
        this.setState({
          loading: false
        });
      });
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
  };

  highlightDates = () => {
    // This doesn't work right now because we're only taking in one day.
    let eligibleDates = [];

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
