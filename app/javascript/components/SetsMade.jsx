import React from 'react';

class SetsMade extends React.Component {
  constructor(props) {
    super(props);
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
