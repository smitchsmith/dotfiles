class Hand

  HANDS = {
      :straight_flush? => 9,
      :four_of_a_kind? => 8,
      :full_house? => 7,
      :flush? => 6,
      :straight? => 5,
      :three_of_a_kind? => 4,
      :two_pair? => 3,
      :one_pair? => 2
    }

  attr_accessor :cards

  def initialize(deck)
    @cards = deck.take(5)
  end

  def flush?
    @cards.all? { |card| card.suit == @cards[0].suit }
  end

  def straight?
    low_card = card_values.min
    ((low_card)..(low_card + 4)).to_a.sort == card_values.sort
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    card_value_counts.sort == [1,4,4,4,4]
  end

  def three_of_a_kind?
    card_value_counts.sort == [1,1,3,3,3]
  end

  def two_pair?
    card_value_counts.sort == [1,2,2,2,2]
  end

  def one_pair?
    card_value_counts.sort == [1,1,1,2,2]
  end

  def full_house?
    card_value_counts.sort == [2,2,3,3,3]
  end

  def card_values
    @cards.map { |card| Card::VALUES[card.value]}
  end

  def card_value_counts
    card_values.map { |value| card_values.count(value) }
  end

  def determine_hand
    HANDS.each do |hand, value|
      return value if self.send(hand)
    end
    1
  end

  def beats?(other_hand)
    hand_val = self.determine_hand
    other_hand_val = other_hand.determine_hand
    case hand_val <=> other_hand_val
    when -1
      return false
    when 0
      nil
    when 1
      return true
    end
  end

  def beats_helper(arg, arg2)

  end
end