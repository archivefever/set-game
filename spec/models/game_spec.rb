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
    it "has 9 showing cards" do
      game.initial_deal
      expect(game.showing_cards.count).to eq 9
    end
  end

end
