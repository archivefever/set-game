class GameCard < ApplicationRecord
  validates :game_id, :card_id, :status, presence: true

  belongs_to :game
  belongs_to :card
  belongs_to :player, foreign_key: :grouped_by_player, optional: true


end
