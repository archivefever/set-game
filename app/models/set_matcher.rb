class SetMatcher
  include ActionView::Helpers

  def self.is_a_set?(cards)
    attributes_for_set(cards, :color) && attributes_for_set(cards, :shading) && attributes_for_set(cards, :number) && attributes_for_set(cards, :shape)
  end

  def self.find_cards(id_ary)
    found_cards = []
    id_ary.each do |id|
     found_cards << Card.find(id)
    end
    found_cards
  end

  def self.make_group(cards, game_id)
    current_game = Game.find(game_id)
    cards.each do |card|
      GameCard.find_by(game_id: game_id, card_id: card.id).update_attributes(status: "grouped")
    end
    render_next_deal = ApplicationController.renderer.render(partial: '/partials/card_show_next_deal', locals:{player_selection: current_game.duct_tape})

    ActionCable.server.broadcast "room_channel", {action: "next_deal", next_deal: render_next_deal, sets_made: current_game.sets_made, remaining_cards: current_game.undrawn_cards.count}
  end


  private

  # def render_next_deal
  #   ApplicationController.renderer.render(partial: '/partials/card_show_next_deal', locals:{player_selection: current_game.duct_tape})
  # end

  def self.attributes_for_set(cards, attribute)
    card_1 = cards[0]
    card_2 = cards[1]
    card_3 = cards[2]

    (card_1.send(attribute) == card_2.send(attribute) && card_1.send(attribute) == card_3.send(attribute) && card_2.send(attribute) == card_3.send(attribute)) || (card_1.send(attribute) != card_2.send(attribute) && card_1.send(attribute) != card_3.send(attribute) && card_2.send(attribute) != card_3.send(attribute))
  end

end
