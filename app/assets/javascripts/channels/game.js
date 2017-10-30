App.game = App.cable.subscriptions.create("GameChannel", {
  connected: function() {
    return this.printMessage("Waiting for opponent...")
  },
  printMessage: function(message) {
    $('#opponent').text("WAITING...");
  },
  disconnected: function() {},
  received: function(data) {
    console.log(data);

    switch(data.action) {

      case "game_start":
      console.log("receiving game start flag...")
      if(data.player === "1") {
        Game.getInitialDeal();
      } else if (data.player === "2") {
        console.log("player2 reload page")
      };
      $('#opponent').text(data.msg);
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

  sendSet: function(cardArray) {
    gameId = $('#game-id').text();
    playerId = $('#player-id').text();
    return this.perform('group_set', {card_ids: cardArray, game_id: gameId, player_id: playerId})
  },

  selectCard: function(cardId) {
    gameId = $('#game-id').text();
    playerId = $('#player-id').text();
    return this.perform('select_card', {card: cardId, player_id: playerId})
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
