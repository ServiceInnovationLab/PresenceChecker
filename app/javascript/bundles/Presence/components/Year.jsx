import PropTypes from 'prop-types';
import { format } from 'date-fns';
import React from 'react';

import Table from '../../../components/Table';

export default class Year extends React.Component {
  state = { isCollapsed: true };

  static propTypes = {
    year: PropTypes.number,
    daysPresent: PropTypes.number,
    meetsAmountOfDaysInNZ: PropTypes.bool,
    periodsAway: PropTypes.array
  };

  render() {
    const {
      year,
      daysPresent,
      meetsAmountOfDaysInNZ,
      periodsAway
    } = this.props;
    const { isCollapsed } = this.state;
    return (
      <Table
        className={`year-table is-text-center ${meetsAmountOfDaysInNZ
          ? ''
          : 'has-error'}`}
        cellPadding="0"
        cellSpacing="0"
      >
        <tr >
          <td className="header-container has-bottom-border has-right-border">
            <h3>Yr {year}</h3>
          </td>
          <td className="has-bottom-border">add dates here</td>
          <td
            className={`icon-container has-bottom-border ${meetsAmountOfDaysInNZ
              ? ''
              : 'has-error'}`}
          >
            <i
              className={`fas  ${meetsAmountOfDaysInNZ
                ? 'fa-check'
                : 'fa-times'}`}
            />
          </td>
        </tr>
        <tr >
          <th colSpan="3" className="has-bottom-border is-light year-table__summary" >Days in NZ: {daysPresent}</th>
        </tr>

      </Table>
    );
  }
}
