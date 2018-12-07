import PropTypes from "prop-types";
import React from "react";

export default class KnownIdentity extends React.Component {
  static propTypes = {
    identities: PropTypes.array
  };

  render() {
    const {
      id,
      family_name,
      first_name,
      second_name = "",
      third_name = "",
      country_of_birth,
      nationality,
      gender
    } = this.props;
    return (
      <div className="parent identities">
        <div className="left">
          <table>
            <tbody>
              <tr>
                <th scope="row">
                  <b>ID No.</b>
                </th>
                <td>
                  <b>{id}</b>
                </td>
              </tr>
              <tr>
                <th scope="row">Surname</th>
                <td>{family_name}</td>
              </tr>
              <tr>
                <th scope="row">First name</th>
                <td>{firstName}</td>
              </tr>
              <tr>
                <th scope="row">Second name</th>
                <td>{second_name}</td>
              </tr>
              <tr>
                <th scope="row">Third name</th>
                <td>{thirdName}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <div className="right">
          <table>
            <tbody>
              <tr>
                <th scope="row">Country of birth</th>
                <td>{country_of_birth}</td>
              </tr>
              <tr>
                <th scope="row">Nationality</th>
                <td>{nationality}</td>
              </tr>
              <tr>
                <th scope="row">Gender</th>
                <td>{gender}</td>
              </tr>
              <tr>
                <th scope="row">&nbsp;</th>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <th scope="row">&nbsp;</th>
                <td>&nbsp;</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}
