import PropTypes from 'prop-types';
import { format } from 'date-fns';
import React from 'react';

import Table from '../../../components/Table';

export default class Year extends React.Component {
	state = { isCollapsed: true };

	static propTypes = {
		year: PropTypes.number,
		daysPresent: PropTypes.number,
		meetsAmountOfDaysInNZ: PropTypes.bool,
		periodsAway: PropTypes.array
	};

	render() {
		const {
			year,
			daysPresent,
			meetsAmountOfDaysInNZ,
			periodsAway
		} = this.props;
		const { isCollapsed } = this.state;
		return (
			<Table
				className={`year-table is-text-center`}
				cellPadding="0"
				cellSpacing="0"
			>
				<tr>
					<td className="header-container has-bottom-border has-right-border">
						<h3 className="is-dark">{year}</h3>
					</td>
					<td className="has-bottom-border">{daysPresent}</td>
					<td className="has-bottom-border">
						<button
							className="btn light"
							onClick={() =>
								this.setState({
									isCollapsed: !this.state.isCollapsed
								})}
						>
							<span>details</span>
							<i
								className={`fas fa-chevron-${isCollapsed
									? 'down'
									: 'up'} `}
							/>
						</button>
					</td>
					<td
						className={`icon-container has-bottom-border ${meetsAmountOfDaysInNZ
							? ''
							: 'has-error'}`}
					>
						<i
							className={`fas  ${meetsAmountOfDaysInNZ
								? 'fa-check'
								: 'fa-times'}`}
						/>
					</td>
				</tr>
				<tr>
					<td colSpan="4">
						<Table className="details-table">
							<tr
								className={`is-light ${isCollapsed
									? 'u-hide'
									: ''}`}
							>
								<td
									colSpan="2"
									className="secondary-header has-bottom-border has-border--light"
								>
									<h3 className="is-dark">Travel Days</h3>
								</td>
							</tr>
							{periodsAway.map(({ start, end, total }, index) => {
								return (
									<tr
										key={index}
										className={`is-light is-text-left date-range ${isCollapsed
											? 'u-hide'
											: ''}`}
									>
										<td className="date-range__dates">
											<h3 className="is-dark">
												{start} - {end}
											</h3>{' '}
										</td>
										<td className="date-range__total">
											{total} days
										</td>
									</tr>
								);
							})}
						</Table>
					</td>
				</tr>
			</Table>
		);
	}
}
