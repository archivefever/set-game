import React from 'react';

class SetMain extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <div>
          <h1>This is the Set Main Page</h1>
        </div>
        <div>
          <CardCount />
        </div>
      </div>
    );
  }
}

export default SetMain;
