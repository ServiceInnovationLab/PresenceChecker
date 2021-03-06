import PropTypes from 'prop-types';
import React from 'react';

import Table from '../../../components/Table';

export default class KnownIdentity extends React.Component {
  render() {
    const {
      serial_number,
      family_name,
      first_name,
      second_name,
      third_name,
      country_of_birth_name,
      issuing_state_name,
      nationality,
      gender,
    } = this.props;
    return (
      <div className="parent identities">
        <div className="left">
          <Table>
            <TableRow headerLabel="Passport  No.">
              <b>{serial_number}</b>
            </TableRow>
            <TableRow headerLabel="Surname">{family_name}</TableRow>
            <TableRow headerLabel="First name">{first_name}</TableRow>
            <TableRow headerLabel="Second name">{second_name || ''}</TableRow>
            <TableRow headerLabel="Third name">{third_name || ''}</TableRow>
          </Table>
        </div>
        <div className="right">
          <Table>
            <TableRow headerLabel="Gender">{gender}</TableRow>
            <TableRow headerLabel="Country of birth">
              {country_of_birth_name}
            </TableRow>
            <TableRow headerLabel="Nationality">{nationality}</TableRow>
            <TableRow headerLabel="Issuing state">
              {issuing_state_name}
            </TableRow>
            <TableRow headerLabel="&nbsp;">&nbsp;</TableRow>
          </Table>
        </div>
      </div>
    );
  }
}

const TableRow = props => (
  <tr>
    <th scope="row">{props.headerLabel}</th>
    <td>{props.children}</td>
  </tr>
);
