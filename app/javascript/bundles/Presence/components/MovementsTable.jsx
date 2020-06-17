import React from 'react';
import PropTypes from 'prop-types';
import { format } from 'date-fns';

import { firstCharCap } from '../../../utilities/utilities';

import Table from '../../../components/Table';

import { legacyParse, convertTokens } from "@date-fns/upgrade/v2";

export default class MovementsTable extends React.Component {
  static propTypes = {
    movements: PropTypes.array,
  };

  isIndefiniteVisa = movement => {
    if(movement !== 'null') {
      let indefinite_visas = ['P', 'A', 'R'];
      return indefinite_visas.indexOf(movement) === -1 ? 'movements-table-highlight--negative' : 'movements-table-highlight--positive';
    }
  }

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
              <tr key={`movement_${index}`} className={this.isIndefiniteVisa(item.visa_type)}>
                <td className="header-container has-bottom-border has-right-border">
                  <h3 className="is-dark">{firstCharCap(item.direction)}</h3>
                </td>
                <td className="has-bottom-border has-right-border">
                  {format(legacyParse(item.carrier_date_time), convertTokens('dd mm yyyy'))}
                </td>
                <td className="has-bottom-border">
                  {item.visa_type}
                </td>
              </tr>
            ))}
          </Table>
        </div>
      </section>
    );
  }
}
