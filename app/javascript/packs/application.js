import React from 'react';
import ReactOnRails from 'react-on-rails';

import Identity from '../bundles/Identity/components/Identity';
import EligibilityDates from '../components/EligibilityDates';
import PresenceTable from '../bundles/Presence/components/PresenceTable';

class ShowClient extends React.Component {
  render() {
    const { clientId, identities, eligibleDateRanges, isEligible, totalDays, years } = this.props;

    return (
      <main role="main">
        <section className="identities-wrapper">
          <Identity id={clientId} identities={identities} />
        </section>
        <section className="dates-wrapper">
          <EligibilityDates eligibleDateRanges={eligibleDateRanges} />
          <PresenceTable isEligible={isEligible} totalDays={totalDays} years={years} />
        </section>
      </main>
    );
  }
}

ReactOnRails.register({
  ShowClient
});
