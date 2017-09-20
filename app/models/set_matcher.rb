class SetMatcher


  def self.colors_for_set(cards)
    card_1 = cards[0]
    card_2 = cards[1]
    card_3 = cards[2]

    (card_1.color == card_2.color && card_1.color == card_3.color && card_2.color == card_3.color) || (card_1.color != card_2.color && card_1.color != card_3.color && card_2.color != card_3.color)
  end

  def self.shapes_for_set(cards)
    card_1 = cards[0]
    card_2 = cards[1]
    card_3 = cards[2]

    (card_1.shape == card_2.shape && card_1.shape == card_3.shape && card_2.shape == card_3.shape) || (card_1.shape != card_2.shape && card_1.shape != card_3.shape && card_2.shape != card_3.shape)
  end

  def self.shadings_for_set(cards)
    card_1 = cards[0]
    card_2 = cards[1]
    card_3 = cards[2]

    (card_1.shading == card_2.shading && card_1.shading == card_3.shading && card_2.shading == card_3.shading) || (card_1.shading != card_2.shading && card_1.shading != card_3.shading && card_2.shading != card_3.shading)
  end

  def self.numbers_for_set(cards)
    card_1 = cards[0]
    card_2 = cards[1]
    card_3 = cards[2]

    (card_1.number == card_2.number && card_1.number == card_3.number && card_2.number == card_3.number) || (card_1.number != card_2.number && card_1.number != card_3.number && card_2.number != card_3.number)
  end


  # does this logic belong here?
  def self.is_a_set?(cards)
    colors_for_set(cards) && shadings_for_set(cards) && numbers_for_set(cards) && shapes_for_set(cards)
  end

  def self.find_cards(id_ary)
    found_cards = []
    id_ary.each do |id|
     found_cards << Card.find(id)
    end
    found_cards
  end

end
