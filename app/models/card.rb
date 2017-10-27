class Card < ApplicationRecord
  has_many :game_cards
  has_many :games, through: :game_cards

end
