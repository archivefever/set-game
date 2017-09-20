class GameCard < ApplicationRecord
  validates :game_id, :card_id, :status, presence: true

  belongs_to :game
  belongs_to :card

end
