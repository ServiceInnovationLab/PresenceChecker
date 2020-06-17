import React from 'react';
import ReactOnRails from 'react-on-rails';
import { format, eachDayOfInterval, addDays, subDays } from 'date-fns';
import 'isomorphic-fetch';

import { getCSRF, databaseURL } from '../utilities/utilities';

import Identity from '../bundles/Identity/components/Identity';
import PresenceDates from '../bundles/Presence/components/PresenceDates';
import PresenceTable from '../bundles/Presence/components/PresenceTable';
import MovementsTable from '../bundles/Presence/components/MovementsTable';

import { legacyParse, convertTokens } from "@date-fns/upgrade/v2";

export default class ShowClient extends React.Component {
  state = {
    loading: false,
    backgroundLoading: false,
    endOfRollingYear: subDays(legacyParse(new Date()), 1),
    meetsMinimumPresence: false,
    meetsFiveYearPresence: false,
    daysInNZ: {},
    last5Years: {},
    futureEligibility: [],
  };

  componentDidMount = () => {
    this.checkEndOfRollingYear(this.state.endOfRollingYear);
  };

  checkEndOfRollingYear = endOfRollingYear => {
    const { databaseId } = this.props;
    const formattedDate = format(legacyParse(endOfRollingYear), convertTokens('yyyy-mm-dd'));
    const url = `${databaseURL()}/clients/${databaseId}/eligibility/${formattedDate}`;

    this.setState({
      loading: true,
    });

    fetch(url, {
      method: 'GET',
      mode: 'same-origin',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': getCSRF(),
      },
    })
      .then(result => {
        return result.json();
      })
      .then(response =>
        this.onDataResponse(response[format(legacyParse(endOfRollingYear), convertTokens('yyyy-mm-dd'))])
      )
      .catch(error => {
        console.error('Server error:', error);
        this.setState({
          loading: false,
        });
      });
  };

  onDateChange = date => {
    let endOfRollingYear = subDays(legacyParse(new Date(date)), 1)

    this.setState({
      endOfRollingYear,
      meetsMinimumPresence: false,
    });

    this.checkEndOfRollingYear(endOfRollingYear);
  };

  onDataResponse = response => {
    this.setState({
      loading: false,
      meetsMinimumPresence: response.meetsMinimumPresence,
      daysInNZ: response.daysInNZ,
      last5Years: response.last5Years,
      meetsFiveYearPresence: response.meetsFiveYearPresence,
    });

    this.checkNextWeek();
  };

  checkNextWeek = () => {
    const { databaseId } = this.props;
    const { endOfRollingYear } = this.state;
    const nextWeek = eachDayOfInterval({
      start: addDays(legacyParse(endOfRollingYear), 1),
      end: addDays(legacyParse(endOfRollingYear), 8)
    });
    let loadingNumber = nextWeek.length;

    this.setState({
      backgroundLoading: true,
    });

    for (let day = 0, l = loadingNumber; day < l; day++) {
      const formattedDate = format(legacyParse(nextWeek[day]), convertTokens('yyyy-mm-dd'));
      const url = `${databaseURL()}/clients/${databaseId}/eligibility/${formattedDate}`;

      fetch(url, {
        method: 'GET',
        mode: 'same-origin',
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': getCSRF(),
        },
      })
        .then(result => {
          return result.json();
        })
        .then(response => {
          loadingNumber--;
          if (loadingNumber === 0) {
            this.setState({
              backgroundLoading: false,
            });
          }
          this.appendEligibleDay(response);
        })
        .catch(error => {
          console.error('Server error:', error);

          loadingNumber--;
          if (loadingNumber === 0) {
            this.setState({
              backgroundLoading: false,
            });
          }
        });
    }
  };

  appendEligibleDay = day => {
    const futureEligibility = [...this.state.futureEligibility];
    futureEligibility.push(day);
    this.setState({ futureEligibility });
  };

  highlightDates = () => {
    // This doesn't work right now because we're only taking in one day.
    let eligibleDates = [];

    return [
      {
        'is-within-range': eligibleDates,
      },
    ];
  };

  render() {
    const {
      endOfRollingYear,
      meetsMinimumPresence,
      meetsFiveYearPresence,
      daysInNZ,
      last5Years,
      loading,
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
              endOfRollingYear={endOfRollingYear}
              isEligible={meetsMinimumPresence}
              highlightDates={this.highlightDates()}
              loading={loading}
            />
          </div>
          <div className="results dates-wrapper-right">
            <PresenceTable
              isEligible={meetsFiveYearPresence}
              totalDays={daysInNZ}
              years={last5Years}
              endOfRollingYear={endOfRollingYear}
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
  ShowClient,
});
