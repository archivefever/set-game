import React from 'react';
import CardCount from './CardCount';
import SetsMade from './SetsMade';
import AllCards from './AllCards';
import Header from './Header';

class SetMain extends React.Component {
  constructor(props) {
    super(props);
    console.log('Landing on the Set Main page');
  }

  render() {
    App.comments = App.cable.subscriptions.create(
      { channel: 'GameChannel' },
      {
        connected: function() {
          console.log('Message in a bottle.');
        }
      }
    );

    return (
      <div>
        <div>
          <h1>This is the Set Main Page</h1>
          <h2>Adding something new...</h2>
          <h3>And another thing</h3>
        </div>
        <div>
          <Header />
          <CardCount />
          <SetsMade />
          <AllCards />
          <span>GAME ID HERE</span>
        </div>
      </div>
    );
  }
}

export default SetMain;
