require 'rspec'

class Card

  attr_reader :suit, :value
  
  def self.build(args)
    suit = args.fetch(:suit)
    value = args.fetch(:value)
    card_map = card_map(args.fetch(:card_map, {}))
    klass = card_map.fetch(value, Card)
    klass.new(args)
  end
  
  def self.card_map(extra_params)
    defaults = {:jack => FaceCard,
      :queen => FaceCard, 
      :king => FaceCard, 
      :ace => Ace}
    defaults.merge(extra_params)
  end
  
  def initialize(args)
    @suit = args.fetch(:suit)
    @value = args.fetch(:value)
  end
  
  def to_s
    "#{@value}-#{@suit}"
  end

end

class FaceCard < Card
  def value
    10
  end
  def to_s
    "#{@value[0].upcase}-#{@suit}"
  end
end

class Ace < FaceCard
  def value
    11
  end
end

class Deck
  class BadInputError < StandardError; end
  
  attr_reader:cards
  
  def initialize
    @cards = []
  end

  def << (card)
    raise BadInputError.new("YOU HAVE FAILED") unless valid_card?(card)
    @cards << card
  end
  
  def valid_card?(card)
    card.respond_to?(:suit) && card.respond_to?(:value)
  end
  
  def self.build
    deck = new
    [:club, :diamond, :heart, :spade].each do |suit|
      possibles = [2,3,4,5,6,7,8,9,10,:jack, :queen, :king, :ace]
      possibles.each do |value|
        deck << Card.build(suit: suit, value: value)
      end
    end
    deck
  end
  
  def shuffle!
    cards.shuffle
  end
end

describe Card do

  let(:card) { Card.build(suit: :clubs, value: 9) }
  
  it "should have a suit" do
    card.suit.should eq(:clubs)
  end
  it "should have a value" do
    card.value.should eq(9)
  end
  
  it "should have a value of 10 if Jack, Queen, or King" do
    [:jack, :queen, :king].each do |facecard|
      card = Card.build(suit: :clubs, value: facecard)
      card.value.should eq(10)  
    end
  end
  it "should have a value of 11 if Ace" do
    card = Card.build(suit: :clubs, value: :ace)
    card.value.should eq(11)
  end
  
  it "should treat 2 as facecard" do
    card = Card.build(suit: :clubs, value: 2, card_map: {2 => FaceCard})
    card.value.should eq(10)
  end
  
  it "should tell me what it is" do
    Card.build(suit: :clubs, value: 5).to_s.should eq("5-clubs")
  end

  it "should tell me what it is when facecard or ace" do
    Card.build(suit: :clubs, value: :queen).to_s.should eq("Q-clubs")
    Card.build(suit: :clubs, value: :ace).to_s.should eq("A-clubs")
  end

end


describe Deck do
  it "should build be 52 cards" do
    deck = Deck.build
    deck.cards.length.should eq(52)
  end
  it "should have 4 suits" do
    cards = Deck.build.cards
    suits = cards.map{|card| card.suit}.uniq
    suits.length.should eq(4)
    [:heart, :club, :spade, :diamond].all?{|suit| suits.include?(suit)}
  end
  it "should not let in integers" do
    deck = Deck.new
    expect{
      deck << 5
    }.to raise_error(Deck::BadInputError)
  end
  it "should not let in integers" do
    deck = Deck.new
    expect{
      deck << FaceCard.new(suit: :club, value: 5)
    }.to change(deck.cards, :count).by(1)
  end
  
  it "should shuffle when told to" do
    deck = Deck.new
    mock_cards = mock
    mock_cards.should_receive(:shuffle)
    deck.stub(:cards) {mock_cards}
    deck.shuffle!
  end

end


