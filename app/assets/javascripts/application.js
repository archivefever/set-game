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
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  var selectedCards = []
    $("ul").on("click", ".card-show", function(event) {
      event.preventDefault();
      if(selectedCards.length < 2){
        var card_id = $(this).find(".card-id").attr("id")
        selectedCards.push(card_id)
        $(this).css("border", "yellow").addClass("selected-cards");
       }
      else if(selectedCards.length === 2){
          var card_id = $(this).find(".card-id").attr("id")
          selectedCards.push(card_id)
          $(this).css("border", "yellow").addClass('selected-cards');

          $.ajax({
            url: '/games/check_cards',
            method: 'POST',
            data: { selectedCardIds: selectedCards },
          })
          .done(function(ajaxReturn) {
            $("#all-cards").append(ajaxReturn)
          })
          .always(function(ajaxReturn){
            $("div").remove(".selected-cards");
            selectedCards = []
          })
        }
      })

});


