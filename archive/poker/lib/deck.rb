require 'card'

class Deck

  attr_accessor :cards

  def initialize
    @cards = build_deck
  end

  def build_deck
    cards = []
    Card::SUITS.keys.each do |suit|
      Card::VALUES.keys.each do |value|
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  def count
    @cards.count
  end

  def shuffle
    @cards.shuffle!
  end

  def take(num)
    @cards.shift(num)
  end
end