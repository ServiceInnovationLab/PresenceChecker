import PropTypes from "prop-types";
import React from "react";
import KnownIdentity from "./KnownIdentity";

export default class Identity extends React.Component {
  static propTypes = {
    id: PropTypes.string.isRequired
  };

  constructor(props) {
    super(props);
    this.state = { isCollapsed: true };
  }

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
