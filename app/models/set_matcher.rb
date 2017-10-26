class SetMatcher

  def self.is_a_set?(cards)
    All_sets::ALL_SETS.include?(cards)
  end


  def self.find_cards(id_ary)
    found_cards = []
    id_ary.each do |id|
     found_cards << Card.find(id)
    end
    found_cards
  end

  #DI: grouped_in_set needs to be made dynamic
  def self.make_group(cards, game_id)
    cards.each do |card|
      GameCard.find_by(game_id: game_id, card_id: card.id).update_attributes(status: "grouped", board_position: nil, grouped_in_set: 1)
    end
  end


end
