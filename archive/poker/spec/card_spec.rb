require 'card'
require 'rspec'

describe Card do
  subject(:card) { Card.new(:ace, :spades) }

  it "should have suit of spades" do
    expect(card.suit).to eq(:spades)
  end

  it "should have value of ace" do
    expect(card.value).to eq(:ace)
  end
end