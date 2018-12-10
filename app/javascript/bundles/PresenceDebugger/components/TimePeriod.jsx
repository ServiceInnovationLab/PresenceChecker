import PropTypes from 'prop-types';
import { format } from 'date-fns';
import { sumBy } from 'lodash';
import React from 'react';

import Table from '../../../components/Table';

export default class TimePeriod extends React.Component {
	static propTypes = {
		periodName: PropTypes.string,
		days: PropTypes.number
	};

	render() {
		const { periodName, days } = this.props;
		return (
			<Table className="timetable">
				<tr>
					<th colSpan={days.length}>{periodName}</th>
					<th className="total total__header">total days in NZ</th>
				</tr>
				<tr className="days-row">
					{days.map(({ fullDate, inNZ }) => {
						return (
							<td key={fullDate} className={inNZ ? 'is-in-country' : ''}>
								{format(fullDate, 'DD')}
							</td>
						);
					})}
					<td className="total total__item">
						{sumBy(days, ({ inNZ }) => {
							return inNZ ? 1 : 0;
						})}
					</td>
				</tr>
			</Table>
		);
	}
}
