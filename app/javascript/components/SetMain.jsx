import React from 'react';
import CardCount from './CardCount';
import SetsMade from './SetsMade';
import AllCards from './AllCards';
import Header from './Header';

class SetMain extends React.Component {
  constructor(props) {
    super(props);
    console.log('Landing on the Set Main page');
    // console.log(props);
    this.state = props;
    console.log(this.state);
    console.log(this);
  }

  // logMessage() {
  //   // this magically works because React.createClass autobinds.
  //   console.log(this.state.message);
  // }

  updateGameState(data) {
    this.setState(data);
  }

  render() {
    const myData = this;
    App.game = App.cable.subscriptions.create(
      { channel: 'GameChannel' },
      {
        connected: function() {
          console.log('Subscribed to the Game Channel');
          // console.log(this.state.message);
        },
        disconnected: function() {},
        received: function(data) {
          console.log('And the data should appear...');
          console.log(data);
          propState.updateGameState(data);
          console.log(this.state);
        }
      }
    );

    return (
      <div>
        <div>
          <h1>This is the Set Main Page</h1>
          <h4>xxxx</h4>
        </div>
        <div>
          <Header />
          <CardCount {...this.state} />
          <SetsMade />
          <AllCards />
          <span>GAME ID HERE</span>
        </div>
      </div>
    );
  }
}

export default SetMain;
