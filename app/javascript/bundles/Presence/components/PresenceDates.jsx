import PropTypes from 'prop-types';
import React from 'react';
import DatePicker from 'react-datepicker';
import { format } from 'date-fns';

export default class PresenceDates extends React.Component {
  static propTypes = {
    isEligible: PropTypes.bool,
    onDateChange: PropTypes.func,
    highlightDates: PropTypes.array,
    loading: PropTypes.bool
  };

  header = stateClass => {
    const { isEligible, loading } = this.props;
    let iconClass = '';
    let headerText = '';

    if (loading) {
      iconClass = 'spinner';
      headerText = 'Loading...';
    } else if (isEligible) {
      iconClass = 'check';
      headerText = 'Eligible Now';
    } else {
      iconClass = 'times';
      headerText = 'Not eligible';
    }

    return (
      <header className={`has-icon ${stateClass}`}>
        <h3>{headerText}</h3>
        <i className={`fas fa-${iconClass}`} />
      </header>
    );
  };

  render() {
    const {
      isEligible,
      selectedDate,
      onDateChange,
      highlightDates,
      loading
    } = this.props;
    const date = format(selectedDate, 'D MMMM YYYY');
    let stateClass = '';

    if (loading) {
      stateClass = 'loading';
    } else if (!isEligible) {
      stateClass = 'has-error';
    }

    return (
      <div className={`panel ${stateClass}`}>
        {this.header(stateClass)}
        <p>Selected date {date}</p>
        <DatePicker
          inline
          highlightDates={highlightDates}
          selected={selectedDate}
          onChange={onDateChange}
        />
      </div>
    );
  }
}
