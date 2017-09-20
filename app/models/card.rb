class Card < ApplicationRecord
  belongs_to :set_match, optional: true
  has_many :grids
end
