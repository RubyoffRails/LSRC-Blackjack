require_relative "../lib/game"

describe Game do
  subject { Game.new(Deck.build)}
  before { subject.start }
  
  it "should have a player hand" do
    subject.player_hand.should be_playable
    subject.player_hand.cards.count.should eq(2)
  end
  it "should have a dealers hand" do
    subject.dealer_hand.should be_playable
    subject.dealer_hand.cards.count.should eq(2)
  end
  it "all the cards should equal 52" do
    total_count = subject.dealer_hand.cards.count + 
                  subject.player_hand.cards.count +
                  subject.remaining_card_count
    total_count.should eq(52)
  end

  it "should create and shuffle a deck on start" do
    mock_deck = mock(:deck)
    mock_deck.should_receive(:shuffle!)
    Game.new(mock_deck)
  end

  it "should allow player to hit"
  it "should play the dealers hand"
  it "should know who won"
end