class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    has_and_belongs_to_many :games
    has_many :grouped_cards, through: :games, class_name: "GameCards", foreign_key: :grouped_by_player

end
