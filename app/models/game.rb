class Game < ApplicationRecord
  belongs_to :player
  has_many :grids
  has_many :sets

  has_many :cards, through: :grids
end
