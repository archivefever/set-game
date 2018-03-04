import React from 'react';
import CardCount from './CardCount';

class SetMain extends React.Component {
  constructor(props) {
    super(props);
    console.log('Landing on the Set Main page');
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
