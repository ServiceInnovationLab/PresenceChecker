import PropTypes from 'prop-types';
import React from 'react';
import { sum } from 'lodash';
import Year from './Year';
import Table from '../../../components/Table';
import { format, subYears, addDays } from 'date-fns';

export default class PresenceTable extends React.Component {
  static propTypes = {
    isEligible: PropTypes.bool,
    totalDays: PropTypes.arrayOf(PropTypes.number),
    years: PropTypes.arrayOf(PropTypes.bool),
    // selectedDate: PropTypes.array,
    loading: PropTypes.bool
  };

  header = () => {
    const { isEligible, loading, totalDays } = this.props;
    let iconClass = '';
    let stateClass = '';

    if (loading) {
      iconClass = 'spinner';
      stateClass = 'loading';
    } else if (isEligible) {
      iconClass = 'check';
    } else {
      iconClass = 'times';
      stateClass = 'has-error';
    }

    return (
      <header className={stateClass}>
        <span>Total days in NZ: {sum(totalDays)}</span>
        <i className={`fas fa-${iconClass}`} />
      </header>
    );
  };

  render() {
    const { years, selectedDate } = this.props;

    console.log(this.props);

    // const firstKey = Object.keys(rollingYearData)[0];
    // const yearData = rollingYearData[firstKey];
    // const isEligible = yearData.meetsMinimumPresence;
    // const totalDays = sum(yearData.daysInNZ);
    // create a 'years' array that combines the days and if the person was eligible for that period

    // const years = yearData.last5Years.map((isEligible, index) => {
    //   return {
    //     year: yearData.last5Years.length - index,
    //     daysPresent: yearData.daysInNZ[index],
    //     meetsAmountOfDaysInNZ: isEligible,
    //     //we need to get rid of the periodsAway, this is just to get it working
    //     periodsAway: []
    //   };
    // });

    return (
      <div className="results">
        {this.header()}
        {years && (
          <Table className="presence-table">
            {years.map((year, index) => {
              const startDate = format(
                addDays(subYears(selectedDate, index + 1), 1),
                'DD MMM YYYY'
              );
              const endingDate = format(
                subYears(selectedDate, index),
                'DD MMM YYYY'
              );
              return (
                <tr key={`year_${index}`}>
                  <td colSpan="2">
                    <Year
                      startDate={startDate}
                      endingDate={endingDate}
                      {...year}
                    />
                  </td>
                </tr>
              );
            })}
          </Table>
        )}
      </div>
    );
  }
}
