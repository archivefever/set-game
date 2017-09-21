class Game < ApplicationRecord
  belongs_to :player, optional: true
  has_many :game_cards
  has_many :cards, through: :game_cards

  has_many :undrawn_cards, ->{ where("game_cards.status" => "undrawn")}, through: :game_cards, source: :card
  has_many :showing_cards, ->{ where("game_cards.status" => "showing")}, through: :game_cards, source: :card
  has_many :grouped_cards, ->{ where("game_cards.status" => "grouped")}, through: :game_cards, source: :card


  def load_deck
    81.times { |n| GameCard.create(game_id: self.id, card_id: n + 1) }
  end

  def next_deal
    new_cards = self.undrawn_cards.sample(3)
    new_cards.each do |card|
      GameCard.find_by(game_id: Game.last.id, card_id: card.id).update_attributes(status: "showing")
    end
  end

  def initial_deal
    deal = self.undrawn_cards.sample(9)
    deal.each do |card|
      GameCard.find_by(game_id: Game.last.id, card_id: card.id).update_attributes(status: "showing")
    end
    if !possible_sets?
      deal << next_deal
    end
    deal.flatten
  end

  def game_time
    last_updated_card = GameCard.where("game_id = ?", self.id).where('updated_at != created_at').order('updated_at DESC').first
    last_updated_card.updated_at - last_updated_card.created_at
  end

  def game_over?
    self.undrawn_cards == 0 && !possible_sets
  end

  def find_true_sets
    true_sets = []
    showing_cards.to_a.combination(3).to_a.each do |card_ary|
      if SetMatcher.is_a_set?(card_ary)
        true_sets << card_ary
      end
    end
    true_sets
  end

  def possible_sets?
    condition = false
    showing_cards.to_a.combination(3).to_a.each do |card_ary|
      if SetMatcher.is_a_set?(card_ary)
        condition = true
      end
    end
    condition
  end

end

# new_cards.each do |card|
#       GameCard.find_by(game_id: Game.last.id, card_id: card.id).update_attributes(status: "showing")
#     end
#     card_hash =
#      {card_1:
#         {shape: new_cards[0].shape, shading: new_cards[0].shading, color: new_cards[0].color, number: new_cards[0].number},
#       card_2:
#         {shape: new_cards[1].shape, shading: new_cards[1].shading, color: new_cards[1].color, number: new_cards[1].number},
#       card_3:
#         {shape: new_cards[2].shape, shading: new_cards[2].shading, color: new_cards[2].color, number: new_cards[2].number}
#       }

