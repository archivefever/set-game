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

//closest here should be find since it is searching for a descendant rather than an ancestor
// this function needs to run 3 times??


  if(selectedCards.length < 2){
    $(".card-show").on("click", function(event){
      event.preventDefault();
      var card_id = $(this).find(".card-id").attr("id")
      selectedCards.push(card_id)
      $(this).css("border", "yellow").addClass("selected-cards");
    })
  }
    else if(selectedCards.length === 2){
      $(".card-show").on("click", function(event){
      event.preventDefault();
      var card_id = $(this).find(".card-id").attr("id")
      selectedCards.push(card_id)
      $(this).css("border", "yellow").addClass('selected-cards');
    })
      $.ajax({
        url: '/games/check_cards',
        data: { selectedCardIds: selectedCards },
        dataType: 'json'
      })
      .done(function(ajaxReturn) {
        console.log("success");

      })
    }


});


