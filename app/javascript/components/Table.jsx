import PropTypes from 'prop-types';
import React from 'react';

const Table = props => (
	<table
		className={props.className}
		cellPadding={props.cellPadding}
		cellSpacing={props.cellSpacing}
	>
		<tbody>{props.children}</tbody>
	</table>
);

export default Table;
