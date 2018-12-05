import ReactOnRails from "react-on-rails";

import Identity from "../bundles/Identity/components/Identity";
import EligibilityDates from "../bundles/Presence/components/EligibilityDates";
import DaysPresent from "../bundles/Presence/components/DaysPresent";

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Identity,
  EligibilityDates,
  DaysPresent
});
