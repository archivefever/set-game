class Player < ApplicationRecord
    has_secure_password

    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true
    validates :password, length: {minimum: 3}

    has_and_belongs_to_many :games
    has_many :grouped_cards, through: :games, class_name: "GameCards", foreign_key: :grouped_by_player

end
