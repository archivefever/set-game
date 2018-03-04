class GameSerializer < ActiveModel::Serializer
  attributes :id, :finished, :winner, :board, :created_at, :updated_at
  has_and_belongs_to_many :players, optional: true
  has_many :game_cards
  has_many :cards, through: :game_cards

  has_many :undrawn_cards, ->{ where("game_cards.status" => "undrawn")}, through: :game_cards, source: :card
  has_many :showing_cards, ->{ where("game_cards.status" => "showing")}, through: :game_cards, source: :card
  has_many :grouped_cards, ->{ where("game_cards.status" => "grouped")}, through: :game_cards, source: :card

end
