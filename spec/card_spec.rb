require_relative "../lib/card"

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