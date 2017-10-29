App.game = App.cable.subscriptions.create("GameChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    console.log(data);

    switch(data.action) {

      case "next_deal_info":
        $("#all-cards").append(data.next_deal);
        $("#response-bar").text("Nice Work!");
        $(".card-show").remove(".selected-cards");
        $('#remaining-cards').text(data.remaining_cards);
        $('#sets-made').text(data.sets_made);
        break;

      // case "something_else":
    }


  },

  checkSets: function(cardArray) {
    gameId = $('#game-id').text();
    return this.perform('check_sets', {card_ids: cardArray, game_id: gameId})
  }
});
