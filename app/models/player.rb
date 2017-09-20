class Player < ApplicationRecord
    has_secure_password

    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true
    validates :password, length: {minimum: 3}

    has_many :games

    has_many :game_cards

end
