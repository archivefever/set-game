import React from 'react';

class SetsMade extends React.Component {
  constructor(props) {
    super(props);
    console.log('Landing on the SetsMade page');
  }

  render() {
    return (
      <div>
        <span>You've made</span>
        <strong>
          <span id="sets-made">NUMBER OF SETS MADE</span>
        </strong>
        <span>sets!</span>
      </div>
    );
  }
}

export default SetsMade;
