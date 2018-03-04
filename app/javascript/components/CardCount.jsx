import React from 'react';

class CardCount extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <span>There are</span>
        <strong>
          <span id="remaining-cards" />
        </strong>
        <span>cards in the draw deck.</span>
      </div>
    );
  }
}
