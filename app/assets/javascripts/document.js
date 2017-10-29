$(document).ready(function() {

  $(this).on('keypress', function(event) {
    if (event.keyCode == 13) {
       Game.showHints();
    }
  });

  Game.getRemainingCards();
  Game.handleSelectedCards();

});
