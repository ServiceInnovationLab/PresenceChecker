import PropTypes from 'prop-types';
import React from 'react';
import DatePicker from 'react-datepicker';
import { format } from 'date-fns';

export default class PresenceDates extends React.Component {
  static propTypes = {
    isEligible: PropTypes.bool,
    onDateChange: PropTypes.func,
    highlightDates: PropTypes.array
  };

  render() {
    const {
      isEligible,
      selectedDate,
      onDateChange,
      highlightDates
    } = this.props;
    const date = format(selectedDate, 'D MMMM YYYY');
    const isPassingClass = isEligible ? '' : 'has-error';

    return (
      <div className={`panel ${isPassingClass}`}>
        <header className={`has-icon ${isPassingClass}`}>
          {isEligible ? <h3>Eligible Now</h3> : <h3> Not eligible</h3>}
          <i className={`fas ${isEligible ? 'fa-check' : 'fa-times'}`} />
        </header>
        <div>
          <p>Selected date {date}</p>
          <DatePicker
            inline
            highlightDates={highlightDates}
            selected={selectedDate}
            onChange={onDateChange}
          />
        </div>
      </div>
    );
  }
}
