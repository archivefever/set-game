require 'rails_helper'
require 'pry'

describe SetMatcher do
  # let(:set_matcher) { SetMatcher.new }

  describe "SetMatcher" do
    it "can identify a correct set" do
      set_of_cards = []
      set_of_cards << Card.find(1)
      set_of_cards << Card.find(41)
      set_of_cards << Card.find(81)
      condition = SetMatcher.is_a_set?(set_of_cards, all_sets)
      expect(condition).to eq true
    end

    it "can identify a incorrect set" do
      set_of_cards = []
      set_of_cards << Card.find(1)
      set_of_cards << Card.find(40)
      set_of_cards << Card.find(81)
      condition = SetMatcher.is_a_set?(set_of_cards, all_sets)
      expect(condition).to eq false
    end
  end

end
