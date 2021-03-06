import PropTypes from 'prop-types';
import { format } from 'date-fns';
import React from 'react';

import Table from '../../../components/Table';

export default class Year extends React.Component {
  state = { isCollapsed: true };

  static propTypes = {
    yearNumber: PropTypes.number,
    daysPresent: PropTypes.number,
    isEligible: PropTypes.bool,
  };

  render() {
    const {
      startDate,
      endingDate,
      yearNumber,
      daysPresent,
      isEligible,
    } = this.props;
    const errorClass = isEligible ? '' : 'has-error';
    const iconClass = isEligible ? 'check' : 'times';

    return (
      <Table className={`year-table is-text-center ${errorClass}`}>
        <tr>
          <td className="header-container has-bottom-border has-right-border">
            <h3>Yr {yearNumber}</h3>
          </td>
          <td className="has-bottom-border">
            {startDate} - {endingDate}
            <button
              onClick={() =>
                this.setState({
                  isCollapsed: !this.state.isCollapsed,
                })
              }
              className={`toggle-button__details u-clear-button-defaults u-use-pointer`}
            >
              Details
              <i
                className={`fas fa-chevron-${
                  this.state.isCollapsed ? 'down' : 'up'
                }`}
              />
            </button>
          </td>
          <td className={`icon-container has-bottom-border ${errorClass}`}>
            <i className={`fas fa-${iconClass}`} />
          </td>
        </tr>
        {!this.state.isCollapsed && (
          <tr>
            <th
              colSpan="3"
              className="has-bottom-border is-light year-table__summary"
            >
              Days in New Zealand: {daysPresent}
            </th>
          </tr>
        )}
      </Table>
    );
  }
}
