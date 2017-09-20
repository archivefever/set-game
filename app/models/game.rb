class Game < ApplicationRecord
  belongs_to :player
  has_many :grids
  has_many :set_matches

  has_many :cards, through: :grids
  has_many :unplayed_cards, ->{ where ""}, through: :grids, source: :cards

  #game logic
  # unplayed cards are 1.) not on the grid, 2.) do not belong to a set

  def unplayed_cards
    not_in_a_set_match = []
    self
  end


end
