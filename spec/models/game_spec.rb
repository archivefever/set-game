require 'rails_helper'
require 'pry'

describe Game do
  let(:game) { Game.create }

  describe "new game" do
    it "can generate a new deck of 81 GameCards" do
      expect { game.load_deck}.to change { GameCard.count}.by(81)
    end

    it "is associated with 81 undrawn_cards" do
      game.load_deck
      expect(game.undrawn_cards.count).to eq 81
    end

    it "has no showing cards before deal" do
      game.load_deck
      expect(game.showing_cards.count).to eq 0
    end

    it "has no grouped cards before deal" do
      game.load_deck
      expect(game.grouped_cards.count).to eq 0
    end
  end

  describe "game after first deal" do
    it "has at least 9 showing cards" do
      game.load_deck
      game.initial_deal
      expect(game.showing_cards.count).to be >= 9
    end

    it "has a max of 72 undrawn cards" do
      game.load_deck
      game.initial_deal
      expect(game.undrawn_cards.count).to be <= 72
    end

    it "has 0 grouped cards" do
      game.load_deck
      game.initial_deal
      expect(game.grouped_cards.count).to eq 0
    end
  end

  describe "game after second deal" do
    it "deals three or more cards until there is a valid set on the board" do
      game.load_deck
      game.initial_deal
      game.next_deal
      expect(game.showing_cards.count).to be >= 12
    end

    it "updates undrawn cards when dealing additional ones" do
      game.load_deck
      game.initial_deal
      game.next_deal
      expect(game.undrawn_cards.count).to be <= 69
    end

    it "has 0 grouped cards when user hasn't made any sets" do
      game.load_deck
      game.initial_deal
      game.next_deal
      expect(game.grouped_cards.count).to eq 0
    end

  end

end
