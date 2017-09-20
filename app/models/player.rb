class Player < ApplicationRecord
    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true

    has_many :games
    has_many :game_cards
end
