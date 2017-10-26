require_relative 'sets'

class Game < ApplicationRecord
  include All_Sets
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
   return next_deal if !possible_sets?(all_sets) || showing_cards.length < 9
    []
    # Somewhere in here, there needs to be some logic that finishes the game if there are no new cards and no possible sets.
  end





  def game_over?
    undrawn_cards == 0 && !possible_sets(all_sets)
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
      if SetMatcher.is_a_set?(card_ary, self::ALL_SETS)
        condition = true
      end
    end
    condition
  end

######################
# Dan's work October 26:

  #DI: board_position needs to be made dynamic
  def place_card
    card = self.undrawn_cards.sample(1)[0]
    GameCard.find_by(game_id: self.id, card_id: card.id).update_attributes(status: "showing", board_position: 1)
    card
  end

  #DI: We need a new way of checking whether there are possible sets in an initial deal, because trying to pass in all_sets an an argument here would ruin everything.
  def initial_deal
    deal = []
    9.times do deal << place_card end
    deal
  end

  def next_deal
      deal = []
      3.times do deal << place_card end
      while !possible_sets?(all_sets)
        3.times do deal << place_card end
      end
    deal
  end

  def calculate_game_state


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


