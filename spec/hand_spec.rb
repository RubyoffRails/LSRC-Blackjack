require_relative "../lib/hand"

describe Hand do
  let(:first) { double }
  let(:second) { double }
  let(:hand) {hand = Hand.new(first, second)}
  
  it "starts with two cards" do
    hand.cards.should eq([first, second])
  end
  
  it "gets a card from the deck when we hit" do    
    deck = Deck.build
    hand.hit! deck
    hand.cards.length.should eq(3)
  end
  
  it "gives me the value" do
    first = Card.build(suit: :clubs, value: 10)
    second = Card.build(suit: :clubs, value: 8)
    hand = Hand.new(first, second)
    hand.value.should eq(18)
  end
  
  it "know if it's busted" do
    hand.stub(:value) { 22 }
    hand.should be_busted
  end
  
  it "know if it's not busted" do
    (4..21).to_a.each do |value|
      hand.stub(:value) { value}
      hand.should_not be_busted
    end
  end

end