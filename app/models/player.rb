class Player < ApplicationRecord
    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true

    has_many :games
    has_many :set_matches, through: games
end
