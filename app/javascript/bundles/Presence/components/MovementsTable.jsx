import React from 'react';
import PropTypes from 'prop-types';
import { format } from 'date-fns';

import { firstCharCap } from '../../../utilities/utilities';

import Table from '../../../components/Table';

export default class MovementsTable extends React.Component {
  static propTypes = {
    movements: PropTypes.array
  };

  render() {
    const { movements } = this.props;

    return (
      <section className="movements-table-area">
        <header className="movements-table-header">
          <h2>Movements</h2>
        </header>

        <div className="movements-table-wrapper">
          <Table className="presence-table movements-table">
            {movements.map((item, index) => (
              <tr key={`movement_${index}`}>
                <td className="header-container has-bottom-border has-right-border">
                  <h3 className="is-dark">{firstCharCap(item.direction)}</h3>
                </td>
                <td className="has-bottom-border">
                  {format(item.carrier_date_time, 'DD MMM YYYY')}
                </td>
              </tr>
            ))}
          </Table>
        </div>
      </section>
    );
  }
}
