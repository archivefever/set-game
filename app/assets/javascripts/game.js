var Game = function(){
  this.finished = false
}

Game.checkSetArray = function(array) {
  for(var i=0; i < allSets.length; i++) {
    if (allSets[i].toString() === array.toString()) {
      return true;
    }
  }
  return false;
};

Game.getRemainingCards = function() {
    $.ajax({
      url: '/games/check_remaining_cards',
      method: 'POST',
    })
    .done(function(ajaxReturn) {
      $('#remaining-cards').text(ajaxReturn);
    });
};

Game.setCount = function() {
    $.ajax({
      url: '/games/set_count',
      method: 'POST',
    })
    .done(function(ajaxReturn) {
      $('#sets-made').text(ajaxReturn);
    });
};

Game.checkForSets = function(cardsOnBoard) {
  var possibleSets = [];
  Util.getAllPossibleCombinations(cardsOnBoard, 3, possibleSets);
  var foundSet = [];
  possibleSets.forEach(function(element) {
    if(Game.checkSetArray(element)) {
      foundSet = element;
    }
  });
  return foundSet;
};

Game.getCardsOnBoard = function() {
  var ids = $('.card-id').map(function(){
    return $(this).attr('id');
  }).get();
  return ids;
};

Game.showHints = function() {
  var idArray = Game.checkForSets(Game.getCardsOnBoard());
  idArray.forEach(function(cardId) {
    $("#" + cardId).closest('.card-show').toggleClass("hint");
  });
};

Game.displayBadSet = function() {
  $("#response-bar").text("Bad Set, Try Again");
  $(".card-show").removeClass("selected-cards");
};

Game.sendSet = function(selectedCards) {
    $.ajax({
      url: '/games/update_game_state',
      method: 'POST',
      data: { selectedCardIds: selectedCards },
    })
    .done(function(ajaxReturn) {
      $("#all-cards").append(ajaxReturn);
      $("#response-bar").text("Nice Work!");
    })
    .always(function(ajaxReturn){
      $(".card-show").remove(".selected-cards");
    Game.getRemainingCards();
    Game.setCount();
    });
};

Game.setHintListener = function() {
  $(this).on('keypress', function(event) {
    if (event.keyCode == 13) {
       Game.showHints();
    }
  });
};


Game.handleSelectedCards = function() {
  var selectedCards = [];
  $("ul").on("click", ".card-show", function(event) {
    event.preventDefault();

    if(selectedCards.length < 2){
      var card_id = $(this).find(".card-id").attr("id");
      $(this).removeClass("hint").toggleClass("selected-cards");
      if(selectedCards[0] === card_id) {
        selectedCards.splice(0,1);
      }
      else {
        selectedCards.push(card_id);
      }
     }
    else if(selectedCards.length === 2){
      var card_id = $(this).find(".card-id").attr("id");
      $(this).removeClass("hint").toggleClass("selected-cards");
      if(selectedCards[0] === card_id) {
        selectedCards.splice(0, 1);
      }
      else if (selectedCards[1] === card_id) {
        selectedCards.splice(1, 1);
      }
      else {
        selectedCards.push(card_id);
        if (Game.checkSetArray(selectedCards)) {
          Game.sendSet(selectedCards);
          selectedCards = [];
        }
        else {
          Game.displayBadSet();
          selectedCards = [];
        }
      }
    }
  });
};