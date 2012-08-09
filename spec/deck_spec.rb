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
  
  describe "#deal!" do
    
    it "should give me the top/first card" do
      deck = Deck.build
      first_card = deck.cards.first
      card = deck.deal!
      card.should eq(first_card)
    end
    
    it "should have one less card" do
      deck = Deck.build
      expect{
        deck.deal!
      }.to change(deck.cards, :count).by(-1)
    end
  end

end
