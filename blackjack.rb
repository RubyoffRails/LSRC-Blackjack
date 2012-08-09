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
  
  attr_reader:cards
  
  def initialize(cards)
    @cards = cards
  end
  
  def self.build
    cards = []
    [:club, :diamond, :heart, :spade].each do |suit|
      possibles = [2,3,4,5,6,7,8,9,10,:jack, :queen, :king, :ace]
      possibles.each do |value|
        cards << Card.build(suit: suit, value: value)
      end
    end
    new(cards)
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
  end
end

describe Deck do
  it "should build be 52 cards" do
    deck = Deck.build
    deck.cards.length.should eq(52)
    puts deck.cards
  end
end