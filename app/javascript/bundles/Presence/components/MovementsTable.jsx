import React from 'react';
// import propTypes from 'prop-types';

class MovementsTable extends React.Component {
  // static propTypes = {

  // };

  render() {
    return (
      <div>
        <table className="presence-table" cellpadding="0" cellspacing="0" style={{margin: '20px 0'}}>
          <tbody>
            <tr colspan="4">
              <th>
                <header>
                  <span>Movements</span>
                </header>
              </th>
            </tr>
            <tr>
              <td>
                <table className="year-table is-text-center" cellpadding="0" cellspacing="0">
                  <tbody>
                    <tr>
                      <td style={{width: '20%'}} className="header-container has-bottom-border has-right-border">
                        <h3 className="is-dark">Arrival</h3>
                      </td>
                      <td className="has-bottom-border">365</td>
                    </tr>
                  </tbody>
                </table>
              </td>

            </tr>
          </tbody>
        </table>
      </div>
    );
  }
}

export default MovementsTable;
