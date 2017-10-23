// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .

checkSetArray = function(array) {
  for(var i=0; i < allSets.length; i++) {

    if (allSets[i].toString() === array.toString()) {
      return true;
    }
  }
  return false;
}

getRemainingCards = function() {
    $.ajax({
      url: '/games/check_remaining_cards',
      method: 'POST',
    })
    .done(function(ajaxReturn) {
      console.log(ajaxReturn);
      $('#remaining-cards').text(ajaxReturn);
    });
};

var setCount = function() {
    $.ajax({
      url: '/games/set_count',
      method: 'POST',
    })

    .done(function(ajaxReturn) {
      console.log(ajaxReturn);
      $('#sets-made').text(ajaxReturn);
    });
};

var checkForSets = function(cardsOnBoard) {
  var possibleSets = [];
  Util.getAllPossibleCombinations(cardsOnBoard, 3, possibleSets);
  console.log(possibleSets);
  possibleSets.forEach(function(element) {
    if(checkSetArray(element)) {
      console.log(element);
      break;
    }
    console.log("Can't find matching set.")
  })
};


$(document).ready(function() {

  $(this).on('keypress', function(event) {
    if (event.keyCode == 13) {
        alert('hi.')
    }
})

  getRemainingCards();

  var selectedCards = []
    $("ul").on("click", ".card-show", function(event) {
      event.preventDefault();
      if(selectedCards.length < 2){
        var card_id = $(this).find(".card-id").attr("id")
        $(this).toggleClass("selected-cards");
        if(selectedCards[0] === card_id) {
          selectedCards.splice(0,1);
        }
        else {
          selectedCards.push(card_id);
        }
       }
      else if(selectedCards.length === 2){
        var card_id = $(this).find(".card-id").attr("id")
        $(this).toggleClass("selected-cards");
        if(selectedCards[0] === card_id) {
          selectedCards.splice(0, 1)
        }
        else if (selectedCards[1] === card_id) {
          selectedCards.splice(1, 1)
        }
        else {
          selectedCards.push(card_id);
          if (checkSetArray(selectedCards)) {
            $.ajax({
              url: '/games/check_cards',
              method: 'POST',
              data: { selectedCardIds: selectedCards },
            })
            .done(function(ajaxReturn) {
              $("#all-cards").append(ajaxReturn);
              $("#response-bar").text("Nice Work!");
            })
            .always(function(ajaxReturn){
              $(".card-show").remove(".selected-cards");
              selectedCards = []
            getRemainingCards();
            setCount();
            });
          }
          else {
            console.log("Bad Set");
            $("#response-bar").text("Bad Set, Try Again");
            $(".card-show").removeClass("selected-cards");
              selectedCards = []
          }

        }
      }
    })

});


