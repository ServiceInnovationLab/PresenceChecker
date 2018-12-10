import PropTypes from "prop-types";
import React from "react";

import Year from "./Year";

export default class PresenceTable extends React.Component {
  static propTypes = { years: PropTypes.array };

  constructor(props) {
    super(props);
  }

  render() {
    const { years, isEligible, totalDays } = this.props;

    return (
      <div className={`results`}>
        <table className="presence-table" cellPadding="0" cellSpacing="0">
          <tbody>
            <tr colSpan="4">
              <th>
                <header className={isEligible ? "" : "has-error"}>
                  <span>Total days: {totalDays}</span>
                  <i
                    className={`fas ${isEligible ? "fa-check" : "fa-times"}`}
                  />
                </header>
              </th>
            </tr>
            {years.map((year,index) => {
              return (
                <tr key={index} className="">
                  <td >
                    <Year {...year} />
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    );
  }
}
