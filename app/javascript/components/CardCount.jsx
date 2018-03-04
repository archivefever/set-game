import React from 'react';

class CardCount extends React.Component {
  constructor(props) {
    super(props);
    console.log('Landing on the CardCount page');
  }

  render() {
    return (
      <div>
        <span>There are</span>
        <strong>
          <span id="remaining-cards">REMAINING CARDS GO HERE</span>
        </strong>
        <span>cards in the draw deck.</span>
      </div>
    );
  }
}

export default CardCount;
