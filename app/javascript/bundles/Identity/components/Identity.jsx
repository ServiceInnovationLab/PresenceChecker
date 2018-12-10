import PropTypes from "prop-types";
import React from "react";
import KnownIdentity from "./KnownIdentity";

export default class Identity extends React.Component {
  state = { isCollapsed: true };

  static propTypes = {
    id: PropTypes.number.isRequired
  };

  render() {
    const { id, identities } = this.props;
    const closedClassName = this.state.isCollapsed ? "isCollapsed" : "isOpen";
    return (
      <div className="results">
        <h2>Identity</h2>
        <div className="results-content">
          <h3>Client ID {id}</h3>
          <div>
            <button
              onClick={() =>
                this.setState({ isCollapsed: !this.state.isCollapsed })
              }
              className={`toggle-button u-clear-button-defaults u-use-pointer ${closedClassName}`}
            >
              <span>Known Identities</span>
              <i
                className={`fas fa-chevron-${
                  this.state.isCollapsed ? "down" : "up"
                }`}
              />
            </button>
            <div className={`results-items ${closedClassName}`}>
              {identities.map((details, index) => {
                return <KnownIdentity key={`identity-${index}`} {...details} />;
              })}
            </div>
          </div>
        </div>
      </div>
    );
  }
}
