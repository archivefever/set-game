App.game = App.cable.subscriptions.create("GameChannel", {
  connected: function() {
    return this.printMessage("Waiting for opponent...")
  },
  printMessage: function(message) {
    console.log(message)
  },
  disconnected: function() {},
  received: function(data) {
    console.log(data);

    switch(data.action) {

      case "game_start":
      console.log("receiving game start flag...")
        Game.getInitialDeal();
      break;

      case "next_deal_info":
        $("#all-cards").append(data.next_deal);
        $("#response-bar").text("Nice Work!");
        $(".card-show").remove(".selected-cards");
        $('#remaining-cards').text(data.remaining_cards);
        $('#sets-made').text(data.sets_made);
        break;

      case "select_card":
        console.log("receiving select cards info...");
        var cardSelection = data.card;
        $("#" + cardSelection).closest('.card-show').removeClass("hint").toggleClass("selected-cards");
        break;

      case "initial_deal_info":
      console.log("data initial deal:")
      console.log(data.initial_deal);
      $("#all-cards").append(data.initial_deal);
      $('#remaining-cards').text(data.remaining_cards);
      break;

      case "bad_set":
        $(".card-show").removeClass("selected-cards");
        break;

    }
  },

  checkSets: function(cardArray) {
    gameId = $('#game-id').text();
    return this.perform('check_sets', {card_ids: cardArray, game_id: gameId})
  },

  selectCard: function(cardId) {
    gameId = $('#game-id').text();
    return this.perform('select_card', {card: cardId})
  },

  requestInitialDeal: function() {
    console.log("requesting initial deal...")
    gameId = $('#game-id').text();
    return this.perform('initial_deal', { game_id: gameId })
  },

  broadcastBadSet: function() {
    gameId = $('#game-id').text();
    return this.perform('bad_set')
  }
});
