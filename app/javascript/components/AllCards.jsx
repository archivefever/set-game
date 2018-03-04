import React from 'react';

class AllCards extends React.Component {
  constructor(props) {
    super(props);
    console.log('Landing on the AllCards page');
  }

  render() {
    return (
      <div id="card-grid">
        {/*  <ul id="all-cards">
    <% @game.showing_cards.each do |card| %>
      <%= render partial: "partials/card_show", locals: {card: card } %>
    <% end %>
  </ul>*/}
        <h2>Iterate through the showing cards list using React</h2>
      </div>
    );
  }
}

export default AllCards;
