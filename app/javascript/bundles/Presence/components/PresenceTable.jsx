import PropTypes from 'prop-types';
import React from 'react';
import { sum } from 'lodash'
import Year from './Year';
import Table from '../../../components/Table';

export default class PresenceTable extends React.Component {
  static propTypes = { rollingYearData: PropTypes.object };

  render() {
    const { rollingYearData } = this.props;
    const firstKey = Object.keys(rollingYearData)[0];
    const yearData = rollingYearData[firstKey];
    const isEligible = yearData.meetsMinimumPresence;
    const totalDays = sum(yearData.daysInNZ);
    // create a 'years' array that combines the days and if the person was eligible for that period

    const years = yearData.last5Years.map((isEligible, index) => {
      return {
        year: yearData.last5Years.length - index,
        daysPresent: yearData.daysInNZ[index],
        meetsAmountOfDaysInNZ: isEligible,
        //we need to get rid of the periodsAway, this is just to get it working
        periodsAway: []
      }
    })

    return (
      <div className="results">
        <Table className="presence-table" cellPadding="0" cellSpacing="0">
          <tr>
            <th className="is-header">
              <header className={isEligible ? '' : 'has-error'}>
                <span>Total days in NZ: {totalDays}</span>
                <i className={`fas ${isEligible ? 'fa-check' : 'fa-times'}`} />
              </header>
            </th>
            <th>&nbsp;</th>
          </tr>
          {years.map((year, index) => {
            return (
              <tr key={index}  className="">
                <td colSpan="2">
                  <Year {...year} />
                </td>
              </tr>
            );
          })}
        </Table>
      </div>
    );
  }
}
