App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    console.log(data);
    switch(data.action) {

      case "next_deal":
        $("#all-cards").append(data.next_deal);
        console.log(data);
        $("#response-bar").text("Nice Work!");
        $(".card-show").remove(".selected-cards");
        $('#sets-made').text(data.sets_made);
        $('#remaining-cards').text(data.remaining_cards);
        break;

      case "select_cards":
      console.log("receiving select cards info...");
      var cardSelection = data.card.card
        $("#" + cardSelection).closest('.card-show').removeClass("hint").toggleClass("selected-cards");
        break;
    }
  },
  speak: function() {
    return this.perform('speak');
  },
  checkCards: function(selectedCards) {
    gameId = $('#game-id').text();
    console.log("checking cards...")
    return this.perform('check_cards', {card_data: selectedCards, game_id: gameId })
  },
  selectCards: function(card) {
    gameId = $('#game-id').text();
    return this.perform('select_cards', {card: card})
  }
});