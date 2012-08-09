require_relative "../lib/deck"

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
    mock_cards.should_receive(:shuffle!)
    deck.stub(:cards) {mock_cards}
    deck.shuffle!
  end

end
