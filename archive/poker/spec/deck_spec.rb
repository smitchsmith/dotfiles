require 'deck'
require 'rspec'

describe Deck do
  subject(:deck) { Deck.new }

  it "should have 52 cards when first created" do
    expect(deck.count).to eq(52)
  end

  it "should not have duplicate cards" do
    expect(deck.cards.uniq).to eq(deck.cards)
  end

  describe "#take" do
    let(:taken_cards) { deck.take(2) }

    it "returns an array containing the right number of cards" do
      expect(taken_cards.count).to eq(2)
    end

    it "should remove the cards from the deck" do
      deck.cards.should_not include(*taken_cards)
    end
  end
end