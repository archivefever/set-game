import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    console.log('Landing on the Header page');
  }

  render() {
    return (
      <div>
        <h1 id="page-header">SET</h1>
        <span id="response-bar" />
      </div>
    );
  }
}

export default Header;
