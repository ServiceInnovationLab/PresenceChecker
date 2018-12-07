import PropTypes from "prop-types";
import React from "react";
import { format } from "date-fns";

import TimePeriod from "./TimePeriod";

export default class DaysPresent extends React.Component {
  static propTypes = { days_present: PropTypes.object };

  constructor(props) {
    super(props);
  }

  render() {
    const { days_present } = this.props;
    const totalDaysArray = Object.entries(days_present);
    const months = {};
    totalDaysArray.forEach(dateObject => {
      const dateString = dateObject[0];
      const wasInNZ = dateObject[1];
      const monthKey = dateString.substr(0, dateString.lastIndexOf("-")); //includes month and year
      if (!months[monthKey]) {
        months[monthKey] = [];
      }

      months[monthKey].push({ fullDate: dateString, inNZ: wasInNZ });
    });

    return (
      <div className={`results`}>
        {Object.entries(months).map(([key, days]) => {
          return (
            <TimePeriod
              key={key}
              periodName={format(key, "MMMM YYYY")}
              days={days}
            />
          );
        })}
      </div>
    );
  }
}