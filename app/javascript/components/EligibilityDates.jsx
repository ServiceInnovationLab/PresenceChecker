import PropTypes from "prop-types";
import React from "react";
import DatePicker from "react-datepicker";
import { format, isWithinRange, eachDay } from "date-fns";

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

export default class EligibilityDates extends React.Component {
  state = {
    selectedDate: new Date(),
    isEligible: checkEligibility(this.props.eligibleDateRanges)
  };

  static propTypes = {
    eligibleDateRanges: PropTypes.array.isRequired
  };

  allDaysInRange = () => {
    const { eligibleDateRanges } = this.props;
    const allDaysInRange = eligibleDateRanges.map(({ start, end }) => {
      return eachDay(start, end, 1);
    });
    return allDaysInRange.reduce((acc, val) => acc.concat(val));
  };

  onDateChange = date => {
    const { eligibleDateRanges } = this.props;
    let newDate = new Date(date);

    this.setState({
      selectedDate: newDate,
      isEligible: checkEligibility(eligibleDateRanges, newDate)
    });
  };

  render() {
    const { selectedDate, isEligible } = this.state;
    const { eligibleDateRanges } = this.props;
    const date = format(selectedDate, "D MMMM YYYY");
    const isPassingClass = isEligible ? "" : "has-error";

    const highlightWithRanges = [
      {
        "is-within-range": this.allDaysInRange()
      }
    ];

    return (
      <div className={`results`}>
        <h2>Presence Data</h2>
        <div>
          <div className={`panel ${isPassingClass}`}>
            <header className="has-icon ">
              {isEligible ? <h3>Eligible Now</h3> : <h3> Not eligible</h3>}
              <i className={`fas ${isEligible ? "fa-check" : "fa-times"}`} />
            </header>
            <div>
              <p>Selected date {date}</p>
              <DatePicker
                inline
                highlightDates={highlightWithRanges}
                selected={selectedDate}
                onChange={this.onDateChange}
              />
            </div>
          </div>

          <div className="panel is-wide">
            <header>
              <h3>Dates eligible to apply</h3>
            </header>
            <div>
              <ul className="list-stripped">
                {eligibleDateRanges.map((range, index) => {
                  return (
                    <li key={index}>
                      {format(range.start, "D MMMM YYYY")}
                      {" - "}
                      {format(range.end, "D MMMM YYYY")}
                    </li>
                  );
                })}
              </ul>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
