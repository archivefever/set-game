class Player < ApplicationRecord
    has_secure_password

    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true
    validates :password, length: {minimum: 3}

    has_and_belongs_to_many :games
    has_many :grouped_cards, through: :games, source: :game_cards


    def grouped_sets_by_game(game)
      self.grouped_cards.where("game_id" => game.id).where("grouped_by_player" => self.id).count/3
    end

end
