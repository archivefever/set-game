class Game < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :player, optional: true
  has_many :game_cards
  has_many :cards, through: :game_cards

  has_many :undrawn_cards, ->{ where("game_cards.status" => "undrawn")}, through: :game_cards, source: :card
  has_many :showing_cards, ->{ where("game_cards.status" => "showing")}, through: :game_cards, source: :card
  has_many :grouped_cards, ->{ where("game_cards.status" => "grouped")}, through: :game_cards, source: :card


  def load_deck
    81.times { |n| GameCard.create(game_id: self.id, card_id: n + 1) }
  end

  def duct_tape
   return next_deal if !possible_sets? || showing_cards.length < 9
    []
  end

  def next_deal
    new_cards = self.undrawn_cards.sample(3)
    new_cards.each do |card|
      GameCard.find_by(game_id: self.id, card_id: card.id).update_attributes(status: "showing")
    end
    new_cards << next_deal if !possible_sets?
    new_cards.flatten
  end

  def initial_deal
    deal = self.undrawn_cards.sample(9)
    deal.each do |card|
      GameCard.find_by(game_id: self.id, card_id: card.id).update_attributes(status: "showing")
    end
    if !possible_sets?
      deal << next_deal
    end
    deal.flatten
  end

  def game_over?
    undrawn_cards == 0 && !possible_sets
  end

  def cheat
    true_sets = []
    showing_cards.to_a.combination(3).to_a.each do |card_ary|
      if SetMatcher.is_a_set?(card_ary)
        true_sets << card_ary
      end
    end
    true_sets
  end

  def possible_sets?
    reload
    condition = false
    showing_cards.to_a.combination(3).to_a.each do |card_ary|
      if SetMatcher.is_a_set?(card_ary)
        condition = true
      end
    end
    condition
  end

#######################

  def game_time
    last_updated_card = GameCard.where(game_id: self.id).order(:updated_at).last
    TimeDifference.between(last_updated_card.created_at, last_updated_card.updated_at).in_minutes.round
  end

  def sets_made
    GameCard.where(game_id: self.id, status: "grouped").count/3
  end


end


