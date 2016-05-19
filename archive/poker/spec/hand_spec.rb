require 'hand'
require 'rspec'
require 'card'

describe Hand do
  subject(:hand) { Hand.new(deck) }
  let(:deck) { double("deck") }

  let(:ace_spades) { double("card", :value => :ace, :suit => :spades) }
  let(:king_spades) { double("card", :value => :king, :suit => :spades) }
  let(:queen_spades) { double("card", :value => :queen, :suit => :spades) }
  let(:jack_spades) { double("card", :value => :jack, :suit => :spades) }
  let(:ten_spades) { double("card", :value => :ten, :suit => :spades) }
  let(:nine_spades) { double("card", :value => :nine, :suit => :spades) }
  let(:king_clubs) { double("card", :value => :king, :suit => :clubs) }
  let(:king_diamonds) { double("card", :value => :king, :suit => :diamonds) }
  let(:king_hearts) { double("card", :value => :king, :suit => :hearts) }
  let(:ten_clubs) { double("card", :value => :ten, :suit => :clubs) }

  let(:flush) { [ace_spades, king_spades, queen_spades, jack_spades, ten_spades] }
  let(:straight_flush) { [ace_spades, king_spades, queen_spades, jack_spades, ten_spades] }
  let(:straight) { [ace_spades, king_spades, queen_spades, jack_spades, ten_clubs] }
  let(:four_of_a_kind) { [king_clubs, king_spades, king_hearts, king_diamonds, ten_spades] }
  let(:three_of_a_kind) { [king_clubs, jack_spades, king_hearts, king_diamonds, ten_spades] }
  let(:full_house) { [king_clubs, ten_clubs, king_hearts, king_diamonds, ten_spades] }
  let(:two_pair) { [ace_spades, ten_clubs, king_hearts, king_diamonds, ten_spades] }
  let(:one_pair) { [ace_spades, jack_spades, king_hearts, king_diamonds, ten_spades] }
  let(:lower_straight_flush) { [nine_spades, king_spades, queen_spades, jack_spades, ten_spades] }

  it "should hold five cards" do
    deck.should_receive(:take).with(5).and_return(flush)
    expect(hand.cards.count).to eq(5)
  end

  it "should recognize a flush" do
    deck.should_receive(:take).with(5).and_return(flush)
    expect(hand.flush?).to be_true
  end

  it "should recognize a straight flush" do
    deck.should_receive(:take).with(5).and_return(straight_flush)
    expect(hand.straight_flush?).to be_true
  end

  it "should recognize a straight" do
    deck.should_receive(:take).with(5).and_return(straight)
    expect(hand.straight?).to be_true
  end

  it "should recognize four of a kind" do
    deck.should_receive(:take).with(5).and_return(four_of_a_kind)
    expect(hand.four_of_a_kind?).to be_true
  end

  it "should recognize three of a kind" do
    deck.should_receive(:take).with(5).and_return(three_of_a_kind)
    expect(hand.three_of_a_kind?).to be_true
  end

  it "should recognize a full house" do
    deck.should_receive(:take).with(5).and_return(full_house)
    expect(hand.full_house?).to be_true
  end

  it "should recognize two pair" do
    deck.should_receive(:take).with(5).and_return(two_pair)
    expect(hand.two_pair?).to be_true
  end

  it "should recognize one pair" do
    deck.should_receive(:take).with(5).and_return(one_pair)
    expect(hand.one_pair?).to be_true
  end

  context "with a straight flush" do
    let(:deck2) { double("deck") }
    before { deck.should_receive(:take).with(5).and_return(straight_flush) }
    let(:hand2) { Hand.new(deck2)}

    it "should beat all other hands" do
      deck2.should_receive(:take).with(5).and_return(four_of_a_kind)
      expect(hand.beats?(hand2)).to be_true
    end
  end

end