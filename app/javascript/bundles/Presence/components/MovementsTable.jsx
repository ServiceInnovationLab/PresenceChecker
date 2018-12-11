import React from 'react';
import { format } from 'date-fns';

class MovementsTable extends React.Component {

  render() {
    const {movements} = this.props;
    return (
      <div>
        <table className="presence-table movements-table" cellpadding="0" cellspacing="0">
          <tbody>
            <tr colSpan="4">
              <th>
                <header>
                  <span>Movements</span>
                </header>
              </th>
            </tr>
            {movements.map(item => <tr>
              <td>
                <table className="year-table is-text-center" cellpadding="0" cellspacing="0">
                  <tbody>
                    <tr>
                      <td style={{width: '20%'}} className="header-container has-bottom-border has-right-border">
                        <h3 className="is-dark">{item.direction.charAt(0).toUpperCase() + item.direction.slice(1)}</h3>
                      </td>
                      <td className="has-bottom-border">{format(item.carrier_date_time, 'DD MMM YYYY')}</td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>)}
          </tbody>
        </table>
      </div>
    );
  }
}

export default MovementsTable;
