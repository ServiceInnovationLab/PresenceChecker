import PropTypes from 'prop-types';
import React from 'react';

const Table = props => (
  <table className={props.className}>
    <tbody>{props.children}</tbody>
  </table>
);

export default Table;
