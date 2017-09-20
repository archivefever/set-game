class Game < ApplicationRecord
  belongs_to :player, optional: true
  has_many :game_cards
  has_many :cards, through: :game_cards

  has_many :undrawn_cards, ->{ where("game_cards.status" => "undrawn")}, through: :game_cards, source: :cards
  has_many :showing_cards, ->{ where("game_cards.status" => "showing")}, through: :game_cards, source: :cards
  has_many :grouped_cards, ->{ where("game_cards.status" => "grouped")}, through: :game_cards, source: :cards


  def next_deal
    self.undrawn_cards.sample(3)
  end

  def initial_deal
    GameCards.all.sample(9)
  end

  def game_time
    (self.updated_at - self.created_at).time_in_words
  end


  def game_over?
    undrawn_cards == 0 && !possible_sets
  end


  def possible_sets?
    condition = false
    showing_cards.permutation(3).to_a.each do |card_ary|
      if is_a_set?(card_ary)
        condtion = true
      end
    end
    condition
  end

end


# shapes: squiggle, oval, diamond
# shading: solid, hatched, empty
# colors: red, green, purple
# number: 1, 2, 3



