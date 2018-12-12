import React from 'react';
import { format } from 'date-fns';

import Table from '../../../components/Table';

class MovementsTable extends React.Component {
  render() {
    const { movements } = this.props;

    return (
      <section className="movements-table-area">
        <header className="movements-table-header">
          <h2>Movements</h2>
        </header>

        <div className="movements-table-wrapper">
          <Table
            className="presence-table movements-table"
            cellpadding="0"
            cellspacing="0"
          >
            {movements.map((item) => (
              <tr>
                <td className="header-container has-bottom-border has-right-border">
                  <h3 className="is-dark">
                    {item.direction.charAt(0).toUpperCase() +
                      item.direction.slice(1)}
                  </h3>
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

export default MovementsTable;
