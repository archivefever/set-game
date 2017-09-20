class SetMatch < ApplicationRecord
  belongs_to :game
  has_many :cards
end
