require_relative 'sets'

class Game < ApplicationRecord
  include ActionView::Helpers::DateHelper

  has_and_belongs_to_many :players, optional: true
  has_many :game_cards
  has_many :cards, through: :game_cards

  has_many :undrawn_cards, ->{ where("game_cards.status" => "undrawn")}, through: :game_cards, source: :card
  has_many :showing_cards, ->{ where("game_cards.status" => "showing")}, through: :game_cards, source: :card
  has_many :grouped_cards, ->{ where("game_cards.status" => "grouped")}, through: :game_cards, source: :card

  # serialize :board


  def load_deck
    81.times { |n| GameCard.create(game_id: self.id, card_id: n + 1) }
  end

  def duct_tape
    if game_over?
      SetMatcher.reset_set_counter
      []
    elsif !possible_sets? || showing_cards.length < 9
      next_deal
    else
      []
    end

    # Somewhere in here, there needs to be some logic that finishes the game if there are no new cards and no possible sets.
  end

  def game_over?
    undrawn_cards.count == 0 && !possible_sets?
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
    card_ids = []
    showing_cards.each do |card|
      card_ids << card.id
    end
    card_ids.combination(3).to_a.each do |three_card_ids|
      if SetMatcher.is_a_set?(three_card_ids)
        condition = true
      end
    end
    condition
  end

######################
# Dan's work October 26:
# MOVED to SetMatcher by dan & clint
  #DI: board_position needs to be made dynamic

  def set_board_position(card)
      new_position = self.board.index("0")
      self.board[new_position] = card.id.to_s
      self.update_attributes(board: self.board)
      new_position
  end

  def place_card
    card = undrawn_cards.sample
    new_position = set_board_position(card)
    GameCard.find_by(game_id: self.id, card_id: card.id).update_attributes(status: "showing", board_position: new_position)
    reload
    card
  end

  def remove_card(card)
    slot = self.board.index(card)
    self.board[slot] = "0"
    self.update_attributes(board: self.board)
  end

  def initial_deal
    if showing_cards.count == 0
      deal = []
      9.times do deal << self.place_card end
      while !possible_sets?
        3.times do deal << self.place_card end
      end
      init_deal = deal
    else
      init_deal = showing_cards
    end

    render_init_deal = ApplicationController.renderer.render(partial: '/partials/card_show_next_deal', locals:{player_selection: init_deal})

    ActionCable.server.broadcast "game_channel", {action: "initial_deal_info", initial_deal: render_init_deal, remaining_cards: self.undrawn_cards.count}

  end

  def next_deal
    if !game_over?
      deal = []
      3.times do
        deal << self.place_card
      end
      while !possible_sets?
        3.times do deal << self.place_card end
      end
      deal
    else
      self.finished = true
      undrawn_cards.count.times do deal << self.place_card end
      deal
    end
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
