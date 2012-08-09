require_relative "../lib/hand"

describe Hand do
  
  it "gets a card from the deck when we hit" do    
    deck = Deck.build
    3.times { subject.hit! deck }
    subject.cards.length.should eq(3)
  end
  
  it "gives me the value" do
    first = Card.build(suit: :clubs, value: 10)
    second = Card.build(suit: :clubs, value: 8)
    subject.stub(:cards) { [first, second]}
    subject.value.should eq(18)
  end
  
  it "know if it's busted" do
    subject.stub(:value) { 22 }
    subject.should be_busted
  end
  
  it "know if it's not busted" do
    (4..21).to_a.each do |value|
      subject.stub(:value) { value}
      subject.should_not be_busted
    end
  end
  
  it "should be playable if I have cards" do
    subject.stub(:value) { 5 }
    subject.should be_playable
  end
  
  it "should not be playable if busted" do
    subject.stub(:busted?) { true }
    subject.should_not be_playable
  end
  
  it "should not be playable without cards" do
    Hand.new.should_not be_playable
  end

end