class SetMatcher

  def self.is_a_set?(cards, all_sets)
    p all_sets[0]
    attributes_for_set(cards, :color) && attributes_for_set(cards, :shading) && attributes_for_set(cards, :number) && attributes_for_set(cards, :shape)
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


  private

  def self.attributes_for_set(cards, attribute)
    card_1 = cards[0]
    card_2 = cards[1]
    card_3 = cards[2]

    (card_1.send(attribute) == card_2.send(attribute) && card_1.send(attribute) == card_3.send(attribute) && card_2.send(attribute) == card_3.send(attribute)) || (card_1.send(attribute) != card_2.send(attribute) && card_1.send(attribute) != card_3.send(attribute) && card_2.send(attribute) != card_3.send(attribute))
  end


end
