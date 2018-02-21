class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    has_and_belongs_to_many :games
    has_many :grouped_cards, through: :games, source: :game_cards


    def grouped_sets_by_game(game)
      self.grouped_cards.where("game_id" => game.id).where("grouped_by_player" => self.id).count/3
    end

end
