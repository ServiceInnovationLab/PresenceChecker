import ReactOnRails from 'react-on-rails';

import Identity from '../bundles/Identity/components/Identity';
import EligibilityDates from '../bundles/Presence/components/EligibilityDates';
import PresenceDebugger from '../bundles/PresenceDebugger/components/PresenceDebugger';
import PresenceTable from '../bundles/Presence/components/PresenceTable';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Identity,
  EligibilityDates,
  PresenceDebugger,
  PresenceTable
});
